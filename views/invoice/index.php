<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ListView;
use yii\helpers\Url;
use yii\bootstrap\Modal;

/* @var $this yii\web\View */
/* @var $searchModel app\models\InvoiceSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Invoices');
$this->params['breadcrumbs'][] = $this->title;
$options_page_size = [20,50,100,200,500];
?>
<div class="invoice-index">

    <h1 class="title"><?= Html::encode($this->title) ?>
        <?= Html::a(Yii::t('app', 'Create Invoice'),['create'],['class'=>'btn btn-yellow pull-right']) ?>
    </h1>
    <div class="clearfix"></div>
    <div class="form-search">
        <?php echo Html::beginForm(['index'],'get',['id'=>'form-client-search', 'class'=>"form-inline"]); ?>
        <div class="form-group">
            <div class="input-group hint-container">
                <div class="hint-content" id="hint-search">
                    Each user can filter invoices per ID, per name, per company, per date  by pressing the button <span class="triangl">&#9660;</span> next to <br />
                    the field’s title <br />
                    or search through a live search.
                </div>
                <div class="input-group-addon"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></div>
                <input name="name" id='name_search' type="text" placeholder="Search... "
                       data-url="<?php echo Url::toRoute(['invoice/ajax','sort'=>$sort,'dir'=>$dir])?>"
                       value="<?php if(isset($name_search)) echo $name_search; ?>" class="form-control" />
            </div>
        </div>
<!--        <input type="submit" value="Поиск" class="btn btn-primary" />-->
        <div class="form-group pull-right">
            <div class="form-group">
                <label for="count_search" class="control-label">Show</label>
                <select class="form-control" name="count_search" id="count_search" onchange="$('#form-client-search').submit()">
                    <?php foreach ($options_page_size as $opt) {
                        if ($opt == $pageSize) {
                            echo '<option selected>'.$opt.'</option>';
                            }
                        else {
                            echo '<option>'.$opt.'</option>';
                        }
                    }
                    ?>
                </select>
            </div>
        </div>
        <?php echo Html::endForm(); ?>
    </div>
    <p>&nbsp;</p>
    <?php
/*    echo GridView::widget([
        'dataProvider' => $dataProvider,
        'options'=>['id'=>'table-result-search'],
        'headerRowOptions'=>[
            'class'=>'table_header',
        ],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'date',
            'name',
        [
            'attribute' => 'company_id',
            'label' => 'Company',
                'format' => 'html',
                'value' => function ($data) {
                         return $data->getCompany()->asArray()->one()['name'];
                   }

            ],
            [
                'class' => 'yii\grid\ActionColumn',
                'template' => '{update} {delete}',
                'buttons'=>[
                    'delete'=>function($url, $model, $key){
                            return "<a href='#' data-id='$key' onclick='return false;' data-rmu='$url' data-message='Are you sure delete $model->name' class='rm-btn'><span class='glyphicon glyphicon-trash'></span></a>";
                        }
                ]
            ],
        ],
    ]);*/


    Modal::begin([
        'header' => '&nbsp;',
        'options'=>['id'=>'modal-pdf'],
        'size' => 'modal-lg',
 //       'toggleButton' => ['tag'=>'a', 'label' => '<img src="/images/invoice_pdf.png" />',
 //           'style'=>'cursor:pointer;', 'title'=>'View in Pdf'],
    ]);
    echo '<div style="width:auto; height:600px;"> <iframe id="iframe-pdf" src="" width="860" height="600" align="left">
    Ваш браузер не поддерживает плавающие фреймы!
 </iframe></div>';
    Modal::end();
    ?>

    <table class="table" id="table-result-search">
        <thead>
        <tr>
            <th>#</th>
            <th>ID
                <?php
                if ($sort=='id' && $dir==SORT_ASC) {
                    echo Html::a('<span class="triangl">&#9650;</span>',
                        Url::toRoute(['invoice/index','sort'=>'-id']));
                }
                else {
                    echo '<a href="'.Url::toRoute(['invoice/index','sort'=>'id']).'" ><span class="triangl">&#9660;</span></a>';
                }
                ?>
            </th>
            <th>Date
                <?php
                if ($sort=='date' && $dir==SORT_ASC) {
                    echo Html::a('<span class="triangl">&#9650;</span>',
                        Url::toRoute(['invoice/index','sort'=>'-date']));
                }
                else {
                    echo '<a href="'.Url::toRoute(['invoice/index','sort'=>'date']).'" ><span class="triangl">&#9660;</span></a>';
                }
                ?>
            </th>
            <th>Name
                <?php
                if ($sort=='client_name' && $dir==SORT_ASC) {
                    echo Html::a('<span class="triangl">&#9650;</span>',
                        Url::toRoute(['invoice/index','sort'=>'-client_name']));
                }
                else {
                    echo '<a href="'.Url::toRoute(['invoice/index','sort'=>'client_name']).'" ><span class="triangl">&#9660;</span></a>';
                }
                ?>
            </th>
            <th>Company
                <?php
                if ($sort=='company_id' && $dir==SORT_ASC) {
                    echo Html::a('<span class="triangl">&#9650;</span>',
                        Url::toRoute(['invoice/index','sort'=>'-company_id']));
                }
                else {
                    echo '<a href="'.Url::toRoute(['invoice/index','sort'=>'company_id']).'" ><span class="triangl">&#9660;</span></a>';
                }
                ?>
            </th>
            <th>Net Total</th>
            <th>Grand Total</th>
            <th>Valid
                <?php
                if ($sort=='is_pay' && $dir==SORT_ASC) {
                    echo Html::a('<span class="triangl">&#9650;</span>',
                        Url::toRoute(['invoice/index','sort'=>'-is_pay']));
                }
                else {
                    echo '<a href="'.Url::toRoute(['invoice/index','sort'=>'is_pay']).'" ><span class="triangl">&#9660;</span></a>';
                }
                ?>
            </th>
            <th>&nbsp;</th>
        </tr>
        </thead>
        <tbody id="invoice_view">
        <?php
            $t_page =  (isset(Yii::$app->request->queryParams['page']))?(Yii::$app->request->queryParams['page']-1)*$dataProvider->pagination->pageSize:0;
            foreach ($dataProvider->models as $key=>$model) {
                echo $this->render('_view', ['model'=>$model, 'number'=>$t_page+$key+1]);
            }
/*        echo ListView::widget([
            'dataProvider'=>$dataProvider,
            'itemView'=>'_view',
            'layout'=>'{items}'
        ])*/
        ?>
        </tbody>
    </table>
    <?php
    echo ListView::widget([
        'dataProvider'=>$dataProvider,
        'itemView'=>'_view',
        'pager'=>[
            'prevPageLabel'=>'Prev',
            'nextPageLabel'=>'Next'
        ],
        'layout'=>'{pager}'
    ])
    ?>
</div>
<?php
/** @var \yii\data\ActiveDataProvider $dataProvider */
Yii::$app->view->registerJsFile('@web/js/invoice.js');
?>
