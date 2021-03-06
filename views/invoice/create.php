<?php
use yii\helpers\Html;
use yii\widgets\Breadcrumbs;
use yii\helpers\Url;


/* @var $this yii\web\View */
/* @var $model app\models\Invoice */

$this->title = Yii::t('app', 'Create {modelClass}', [ 'modelClass' => 'Invoice',]);
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Invoices'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<?php echo Html::a('Список сервисов', Url::toRoute('index'),['class'=>'btn-lg btn btn-primary']) ?>

<h1 class="title"><?= Html::encode($this->title) ?></h1>

<?php  echo $this->context->renderPartial('_form', ['model' => $model,  'model_item' => $model_item,
     'itog'=>$itog, 'items' => $items, 'items_error'=>$items_error, 'is_add'=>true]); ?>
