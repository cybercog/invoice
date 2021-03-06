<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sellers".
 *
 * @property integer $id
 * @property string $name
 * @property string $address
 * @property string $inn
 */
class Sellers extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sellers';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name', 'address', 'inn'], 'required'],
            [['name', 'address'], 'string', 'max' => 128],
            [['inn'], 'string', 'max' => 12]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('app', 'ID'),
            'name' => Yii::t('app', 'Name'),
            'address' => Yii::t('app', 'Address'),
            'inn' => Yii::t('app', 'Inn'),
        ];
    }
}
