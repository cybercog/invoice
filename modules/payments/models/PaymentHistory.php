<?php

/**
 * This is the model class for table "tbl_payment_history".
 *
 * The followings are the available columns in table 'tbl_payment_history':
 * @property string $id
 * @property string $user_id
 * @property string $operator_id
 * @property double $amount
 * @property string $currency
 * @property double $curs
 * @property double $equivalent
 * @property string $description
 * @property string $date
 * @property string $payment_system_id
 * @property integer $complete
 * @property integer $type
 * The followings are the available model relations:
 * @property paymentSystem $paymentSystem
 * @property user $user
 * @property user $operator
 * @property paymentOutput $paymentOutput
 */
class PaymentHistory extends MyActiveRecord {

    const PT_MANUAL = 10;    
    const PT_MONEY_TRANSFER = 20;
   

    public function init() {
        $this->type = self::PT_MANUAL;
        $this->complete = 0;
        $this->bonus = 0;
        parent::init();
    }

    public function tableName() {
        return 'payment_history';
    }

    public function rules() {
        return array(
            array('amount, payment_system_id', 'required'),
            array('user_id, payment_system_id, complete, type, operator_id', 'numerical', 'integerOnly' => true),
            array('amount', 'numerical'),
            array('user_id, payment_system_id', 'length', 'max' => 11),
            array('description', 'length', 'max' => 128),
            array('id, user_id, amount, description, date, payment_system_id, complete, type', 'safe', 'on' => 'searchLast, search'),
        );
    }

    public function relations() {
        return array(
            'paymentSystem' => array(self::BELONGS_TO, 'PaymentSystem', 'payment_system_id'),
            'user' => array(self::BELONGS_TO, 'User', 'user_id'),
            'operator' => array(self::BELONGS_TO, 'User', 'operator_id'),
        );
    }

    public function attributeLabels() {
        return array(
            'id' => Yii::t('mypurse', 'ID'),
            'user_id' => Yii::t('mypurse', 'User'),
            'operator_id' => Yii::t('mypurse', 'Operator'),
            'amount' => Yii::t('mypurse', 'Amount'),
            'description' => Yii::t('mypurse', 'Description'),
            'date' => Yii::t('mypurse', 'Date'),
            'complete' => Yii::t('mypurse', 'Status'),
            'type' => Yii::t('mypurse', 'Payment Type'),
        );
    }

    public function search() {
        $criteria = new CDbCriteria;

        $criteria->compare('t.id', $this->id, false);
        $criteria->compare('user_id', $this->user_id);
        $criteria->compare('amount', $this->amount, true);
        $criteria->compare('description', $this->description, true);
        $criteria->compare('date', $this->date, true);
        $criteria->compare('complete', $this->complete);
        $criteria->compare('type', $this->type);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
            'sort' => array(
                'defaultOrder' => 't.date DESC, t.type ASC',
                'attributes' => array(
                    'userEmail' => array(
                        'asc' => 'user.email ASC',
                        'desc' => 'user.email DESC',
                    ),
                    '*', // add all of the other columns as sortable
                ),
            ),
            'pagination' => array(
                'pageSize' => Yii::app()->user->getState('pageSize', Yii::app()->params['defaultPageSize']),
            ),
        ));
    }
    

    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

    protected function beforeSave() {
        $this->_setSecretKey('payment_key');
        if (empty($this->description) && $this->payment_system_id) {
            $this->description = 'Top-up through {model}. To the amount of ${amount}';
        }
        return parent::beforeSave();
    }

    public function getDate($format = 'd M Y') {
        return date($format, strtotime($this->date));
    }

    public function getStatus() {
            return ($this->complete) ? Yii::t('mypurse', 'Complete') : Yii::t('mypurse', 'Not Complete');
    }

    public function getCssClass() {
        return ($this->complete) ? 'complete' : 'complete fail';
    }


    public function getType() {
        switch ($this->type) {
            case self::PT_MANUAL:
                return 'Пополнение';
                break;
            case self::PT_MONEY_TRANSFER:
                return 'Перевод средств внутри системы';
                break;
          
        }
    }

    protected function afterSave() {
        //send email about payment
        parent::afterSave();
    }


    protected function beforeDelete() {
        return parent::beforeDelete();
    }
    

    public static function balanceToDay($uid, $date) {
        return Yii::app()->db->createCommand()
                        ->select('ROUND(SUM(`amount`),2) AS `amount`')
                        ->from('payment_history')
                        ->where('user_id = :uid AND complete = 1 AND DATE(`date`) <= :date', array(':uid' => $uid, ':date' => $date))
                        ->queryScalar();
    }

}
