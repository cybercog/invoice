<?php
use yii\helpers\Html;
use yii\helpers\Url;

$view_element = 'settax_id'.$model->id;
$view_element_td = 'td_settax_id'.$model->id;
?>
<tr id="<?php echo Html::encode($view_element); ?>">
    <td><?php echo Html::encode($model->id); ?></td>
    <td><?php echo Html::encode($model->name); ?></td>
    <td><?php echo Html::encode($model->email); ?></td>
    <td><?php echo Html::textInput('surtax', $model->setting->surtax, ['id'=>$view_element_td]); ?></td>
    <td>
       <?php 
            $url = Url::toRoute(['tax/update_surtax','id'=>$model->id]);
            echo Html::a('save',Url::toRoute(['tax/update_surtax','id'=>$model->id]),
            [
             'title' => Yii::t('yii', 'Save'),
             'class' => 'btn btn-primary btn-xs',
             'onclick'=>"{  var tax = $('#".$view_element_td." ').val();
               $.ajax({
               url  : '".$url."',
               type :'POST',
               data: {'tax': tax},
               success  : function(response) { $('#".$view_element_td."').empty().html(response).focus();   }
             })}; return false; ",
           ]);
       ?>
     
   </td>
</tr>