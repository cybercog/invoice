<?php
use yii\widgets\ListView;
use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this VatController */
/* @var $dataProvider CActiveDataProvider */

$this->title=Yii::$app->name . ' - Vat';
$this->params['breadcrumbs'][] = $this->title;

?>

<h1 class="title"><?php echo Yii::t('app', 'Vat'); ?></h1>

<table class="table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Percent</th>
    </tr>
    </thead>
    <tbody>
<?php echo ListView::widget([
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
]); ?>
    </tbody>
</table>
