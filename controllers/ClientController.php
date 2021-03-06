<?php
namespace app\controllers;

use Yii;
use yii\base\InvalidParamException;
use yii\data\SqlDataProvider;
use yii\helpers\Url;
use yii\web\HttpException;
use yii\web\Session;
use yii\web\BadRequestHttpException;
use yii\web\ForbiddenHttpException;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use yii\data\ActiveDataProvider;
use yii\web\UploadedFile;

use app\models\LoginClientForm;
use app\models\SignupClientForm;
use app\models\PasswordResetRequestFormClient;
use app\models\ResetPasswordFormClient;
use app\models\Invoice;
use app\models\Client;
use app\models\Invoice_item;

use yii\widgets\ListView;

/**
 * Site controller
 */
class ClientController extends Controller
{
    public $layout='client';
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['login', 'invoice', 'tcpdf', 'logout', 'update', 'delete', 'index','seach_ajax'],
                'rules' => [
                    [
                        'actions' => ['login', 'invoice', 'tcpdf'],
                        'allow' => true,
                        'roles' => ['?'],
                    ],
                    [
                        'actions' => ['logout', 'update', 'special-callback'],
                        'allow' => true,
                        'matchCallback' => function ($rule, $action) {
                                return $this->isClient();
                            }
                    ],
                    [
                        'actions' => ['delete', 'index', 'ajax', 'update','seach_ajax'],
                        'allow' => true,
                        'roles' => ['@']
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function actionRequestPasswordReset()
    {
        $model = new PasswordResetRequestFormClient();
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if ($model->sendEmail()) {
                Yii::$app->getSession()->setFlash('success', 'Check your email for further instructions.');

                return $this->goHome();
            } else {
                Yii::$app->getSession()->setFlash('error', 'Sorry, we are unable to reset password for email provided.');
            }
        }

        return $this->render('requestPasswordResetToken', [
            'model' => $model,
        ]);
    }

        public function actionResetPassword($token)
    {
        try {
            $model = new ResetPasswordFormClient($token);
        } catch (InvalidParamException $e) {
            throw new BadRequestHttpException($e->getMessage());
        }

        if ($model->load(Yii::$app->request->post()) && $model->validate() && $model->resetPassword()) {
            Yii::$app->getSession()->setFlash('success', 'New password was saved.');

            return $this->goHome();
        }

        return $this->render('resetPassword', [
            'model' => $model,
        ]);
    }

    public function actionLogin()
    {
        $model = new LoginClientForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            $session = Yii::$app->session;
            $session['client_id'] = $model->id;
            return $this->redirect(array('invoice'));
        } else {
            return $this->render('login', [ 'model' => $model, ]);
        }
    }

    public function actionLogout()
    {
        unset(Yii::$app->session['client_id']);
        Yii::$app->user->logout();

        return $this->goHome();
    }

    public function actionSeach_ajax()
    {
        if( Yii::$app->request->isAjax ){
            $name_seach = ( isset($_POST['name'])) ? $_POST['name'] : '';
            $pageSize = ( isset($_POST['count_search'])) ? $_POST['count_search'] : 5;
            $sort = ( isset($_GET['sort'])) ? $_GET['sort'] : '';
            $dir = ( isset($_GET['sort'])) ? $_GET['dir'] : SORT_ASC;

            $orderBy = ( $sort ) ? [$sort => $dir] :  ['is_pay'=>SORT_ASC, 'id'=>SORT_DESC];

            $query = Client::find()->select('client.id, client.name, client.vat_number, count(i.id) as invoice, SUM(i.total_price) as total');
            $query->leftJoin('`invoice` i','client.id = i.client_id');
            $query->where(['client.user_id'=>Yii::$app->user->id])->groupBy('i.client_id')->orderBy( $orderBy );
            if( $name_seach )  $query->andWhere(['like','client.name', $name_seach.'%',false]);

            $dataProvider = new ActiveDataProvider([
                'query' => $query,
                'pagination' => [ 'pageSize' => $pageSize,  ],
            ]);

            $t_page =  (isset(Yii::$app->request->queryParams['page']))?(Yii::$app->request->queryParams['page']-1)*$dataProvider->pagination->pageSize:0;
            if( $dataProvider->models )
                foreach ($dataProvider->models as $key=>$model) {
                    echo $this->renderPartial('_view', ['model'=>$model, 'number'=>$t_page+$key+1]);
                }
        }
    }


    public function actionIndex() {
        $this->layout='main';
    /*    $q = new Query();
        $q->select('c.id, c.name, c.vat_number, count(i.id) as invoice, SUM(i.total_price) as total ');
        $q->from('client as c');
        $q->leftJoin('`invoice` i','c.id = i.client_id');
        $q->where(['c.user_id'=>$user]);
        $q->groupBy('i.client_id');
*/

        $pageSize = ( isset($_GET['count_search'])) ? $_GET['count_search'] : 20;
        $name_seach = ( isset($_GET['name'])) ? $_GET['name'] : '';

        $sort = ( isset($_GET['sort'])) ? $_GET['sort'] : '';
        if( $sort && $sort[0] == '-') {
            $sort = substr($sort,1);
            $dir = SORT_DESC;
        }
        else  $dir = SORT_ASC;

        $orderBy = ( $sort ) ? [$sort => $dir] :  ['id'=>SORT_ASC];

        $query = Client::find()->select('client.id, client.name, client.vat_number, count(i.id) as invoice, SUM(i.total_price) as total');
        $query->leftJoin('`invoice` i','client.id = i.client_id');
        $query->where(['client.user_id'=>Yii::$app->user->id])->groupBy('i.client_id')->orderBy( $orderBy );
        if( $name_seach )  $query->andWhere(['like','client.name', $name_seach.'%',false]);

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [ 'pageSize' => $pageSize ],
        ]);
       // var_dump($dataProvider->models[0]['invoice']); var_dump($dataProvider->models[0]['total']); exit;
        return $this->render('index', ['dataProvider' => $dataProvider,'pageSize' => $pageSize, 'sort'=>$sort, 'dir'=>$dir,
            'name_search' => $name_seach]);
    }

    public function actionAjax() {
        if(!Yii::$app->request->isAjax) throw new ForbiddenHttpException('Url should be requested via ajax only');
        $dataProvider = new ActiveDataProvider([
            'query' => Client::queryProvider(Yii::$app->request->queryParams),
            'pagination' => [
                'pageSize' => 20,
            ],
        ]);
        return $this->renderPartial('ajax', ['dataProvider' => $dataProvider]);
    }

    public function actionAjax_invoice($id) {
        if(!Yii::$app->request->isAjax) throw new ForbiddenHttpException('Url should be requested via ajax only');

        $query = Invoice::find()->select(['invoice.*', 'cl.name as client_name' ])->leftJoin('client as cl','invoice.client_id = cl.id');
        $query->where(['invoice.client_id'=> $id ])->orderBy(['date'=>SORT_DESC] );
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [ 'pageSize' => 100,  ],
        ]);
        return $this->renderPartial('ajax_invoice', ['dataProvider' => $dataProvider]);
    }

    public function actionInvoice()
    {
        $client_id = $this->isClient();
        $pageSize = ( isset($_GET['count_search'])) ? $_GET['count_search'] : 5;
        $sort = ( isset($_GET['sort'])) ? $_GET['sort'] : '';
        if( $sort && $sort[0] == '-') {
            $sort = substr($sort,1);
            $dir = SORT_DESC;
        }
        else  $dir = SORT_ASC;

        $orderBy = ( $sort ) ? [$sort => $dir] :  ['is_pay'=>SORT_ASC, 'id'=>SORT_DESC];

        $query = Invoice::find()->select(['invoice.*', 'cl.name as client_name' ])->leftJoin('client as cl','invoice.client_id = cl.id');
        $query->where(['invoice.client_id'=> $client_id ])->orderBy( $orderBy );

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [ 'pageSize' => $pageSize,  ],
        ]);
        return $this->render('invoice',['dataProvider'=>$dataProvider, 'pageSize' => $pageSize, 'sort'=>$sort, 'dir'=>$dir,
            ]);
    }

    public function actionTcpdf($id, $isTranslit = 0)
    {
        $model = Invoice::findOne(['id'=>$id]);
        $items = Invoice_item::findAll(['invoice_id'=>$id]);
        if ($model->client_id == $this->isClient()) {
            $template = empty($model->type) ? 'basic' : $model->type;
            return $this->render('/invoice/tcpdf', [
                'model' => $model,
                'template'=>$template,
                'isTranslit'=>$isTranslit,
                'items'=>$items
            ]);
        } else {
            throw new ForbiddenHttpException('Access to the invoice is forbidden. You are not the owner of the invoice');
        }
    }

    public function actionCreate() {
        $this->layout='main';
//        $model = new SignupClientForm();
        $model = new Client();

        $file = UploadedFile::getInstance($model,'file');
        if ($file)
            $model->avatar = $file->name;

        if ($model->load(Yii::$app->request->post())) {
            $password_ = SignupClientForm::generateRandomPassword();
            $model->setPassword($password_);
            $model->generateAuthKey();
            $model->passw = $password_;

            $model->user_id = Yii::$app->user->id;
            if($model->save() ){
                if ($file){
                    $uploaded = $file->saveAs(Yii::$app->params['avatarPath'].$file->name);
                    $image=Yii::$app->image->load(Yii::$app->params['avatarPath'].$file);
                    $image->resize(100);
                    $image->save();
                }
                Yii::$app->getSession()->setFlash('success', 'Клиент успешно зарегистрирован ');
                if (!Yii::$app->user->isGuest)
                    return $this->redirect(['index']);
            }
        }

        return $this->render('create', ['model' => $model,]);
//        return $this->render('signup_client', ['model' => $model,]);
    }

    public function actionUpdate($id=0)
    {
        if (Yii::$app->user->isGuest) {
            $client_id = $this->isClient();
            $model = $this->loadModel($client_id);
        }
        else {
            $this->layout='main';
            $model = $this->loadModel($id);
            if( $model->user_id != Yii::$app->user->id ){
               throw new ForbiddenHttpException('Client not found');
            }
        }
	// Uncomment the following line if AJAX validation is needed
	// $this->performAjaxValidation($model);
        $model->password_ = '';
        $file = UploadedFile::getInstance($model,'file');
        if ($file)
            $model->avatar = $file->name;

        if ( $model->load(Yii::$app->request->post()) ){
            $password_ = $_POST['Client']['password_'];
            if( strlen($password_ ) > 0){
                $model->setPassword($password_);
                $model->generateAuthKey();
                $model->passw = $password_;
            }
            if($model->save() ){
                if ($file){
                    $uploaded = $file->saveAs(Yii::$app->params['avatarPath'].$file->name);
                    $image=Yii::$app->image->load(Yii::$app->params['avatarPath'].$file);
                    $image->resize(100);
                    $image->save();
                }
                Yii::$app->getSession()->setFlash('success', 'Клиент успешно обновлен ');
                if (!Yii::$app->user->isGuest)
                    return $this->redirect(['index']);
            }
        }
       return $this->render('update', ['model' => $model,]);
    }

    public function actionDelete()
    {
        $this->layout='main';
        $id = Yii::$app->request->post();
        if(!Yii::$app->request->isAjax) throw new BadRequestHttpException('Invalid request');

        $model = $this->loadModel($id['id']);
        if($model->user_id!=Yii::$app->user->getId()){
            throw new ForbiddenHttpException('Client not found');
        }

        return $model->delete();


    }

    public function isClient() 
    {
        return ( isset(Yii::$app->session['client_id'])) ? Yii::$app->session['client_id'] : 0;
    }

    // Match callback called! This page can be accessed only each October 31st
    public function actionSpecialCallback()
    {
        echo 'Работает!';
//        return $this->render('happy-halloween');
    }


    public function loadModel($id) 
    {
	    $model= Client::findOne(['id' => $id]);
        if($model===null) throw new HttpException(404,'The requested page does not exist.');
        return $model;
    }


}
