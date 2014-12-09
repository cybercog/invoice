<?php
use yii\widgets\ListView;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\bootstrap\ActiveForm;


$this->title = Yii::$app->name . ' - Payment credit';
$this->params['breadcrumbs'][] = $this->title;

?>

<h1><?php  echo 'Payment credit';  ?></h1>
<?php $form = ActiveForm::begin([
	'id'=>'invoice-form',
	'enableAjaxValidation'=>false,
	'options'=>['enctype'=>'multipart/form-data', 'role'=>'form'],
]); ?>
    <div class="form-group">
          <?php echo $form->field($model, 'credit')->textInput()->hint('You family, credit ')->label('count credit') ; ?>
          <?php echo Html::error($model, 'credit'); ?>
    </div>
<?= Html::submitButton('Send', ['class' => 'btn btn-primary', 'name' => 'send']) ?>
<?php ActiveForm::end(); ?>
