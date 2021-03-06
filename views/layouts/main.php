<?php
/* @var $this Controller */

use yii\helpers\Html;
use yii\widgets\Menu;
use yii\bootstrap\NavBar;
use kartik\nav\NavX;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;
use app\components\LanguageSelector;
use app\models\Lang;
use app\components\widgets\Alert;

/* @var $this \yii\web\View */
/* @var $content string */

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
    <head>
        <meta charset="<?= Yii::$app->charset ?>"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <?= Html::csrfMetaTags() ?>
        <title><?= Html::encode($this->title) ?></title>
        <?php $this->head() ?>
    </head>

    <body>

        <?php $this->beginBody() ?>
        <div class="wrap">
            <?php
            NavBar::begin([
                'brandLabel' => Yii::$app->name,
                'brandUrl' => Yii::$app->homeUrl,
                'options' => [
                    'class' => 'navbar-inverse navbar-fixed-top',
                ],
            ]);
            ?>
            <div  id="language-selector" style="float:right; margin:5px;">
                <?= LanguageSelector::widget([]) ?>
                <?php
                //$this->widget('application.components.widgets.LanguageSelector');
                ?>
            </div>
            <?php
            echo NavX::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => Yii::t('app', 'Home'), 'url' => ['/site/index'], 'visible' => !Yii::$app->user->isGuest],
                    ['label' => Yii::t('app', 'Users'), 'url' => '#', 'visible' => Yii::$app->user->can('manager'),
                        'items' => [
                            ['label' => Yii::t('app', 'My Users'), 'url' => ['/user/index', 'type_user' => 1], 'visible' => Yii::$app->user->can('manager')],
                            ['label' => Yii::t('app', 'My Managers'), 'url' => ['/user/index', 'type_user' => 2], 'visible' => Yii::$app->user->can('admin')],
                            ['label' => Yii::t('app', 'My Admins'), 'url' => ['/user/index', 'type_user' => 3], 'visible' => Yii::$app->user->can('superadmin')],
                            ['label' => Yii::t('app', 'All Users'), 'url' => ['/user/index', 'type_user' => 4], 'visible' => Yii::$app->user->can('superadmin')],
                            ['label' => Yii::t('app', 'Profit'), 'url' => ['/user/profit'], 'visible' => Yii::$app->user->can('admin')],
                        ],
                    ],
                    ['label' => Yii::t('app', 'Clients'), 'url' => ['/client/index'], 'visible' => !Yii::$app->user->isGuest],
                    ['label' => Yii::t('app', 'Invoice'), 'url' => ['/invoice/index'], 'visible' => !Yii::$app->user->isGuest],
                    ['label' => Yii::t('app', 'Companies'), 'url' => ['/company/index'], 'visible' => !Yii::$app->user->isGuest],
                    ['label' => Yii::t('app', 'Services'), 'url' => ['/service/index'], 'visible' => !Yii::$app->user->isGuest],
                    ['label' => Yii::t('app', 'Taxes'), 'url' => '#', 'visible' => !Yii::$app->user->isGuest,
                        'items' => [
//                        ['label' => 'Подоходный', 'url' => ['/tax/index'], 'visible' => !Yii::$app->user->isGuest],
                            ['label' => Yii::t('app', 'Tax'), 'url' => ['/user/set_tax'], 'visible' => Yii::$app->user->can('superadmin')],
                            ['label' => Yii::t('app', 'Vat'), 'url' => ['/vat/index'], 'visible' => !Yii::$app->user->isGuest],
                        ],
                    ],
                    ['label' => Yii::t('app', 'Settings'), 'url' => '#', 'visible' => !Yii::$app->user->isGuest,
                        'items' => [
                            ['label' => Yii::t('app', 'Payment'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest,
//							'items' => [
//								['label' => Yii::t('app', 'Pay Pal'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest],
//								['label' => Yii::t('app', 'Card payment'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest],
//								['label' => Yii::t('app', 'Bank transfer'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest],
//							],
                            ],
                            ['label' => Yii::t('app', 'Languages'), 'url' => ['/lang/index'], 'visible' => !Yii::$app->user->isGuest],
                            ['label' => Yii::t('app', 'Incomes'), 'url' => ['/income/index'], 'visible' => !Yii::$app->user->isGuest],
                            ['label' => Yii::t('app', 'Transactions BT'), 'url' => ['/transactionbanktrans/index'], 'visible' => Yii::$app->user->can('superadmin')],
                        ],
                    ],
                    ['label' => Yii::t('app', 'Account'), 'url' => ['/setting/update'], 'visible' => !Yii::$app->user->isGuest,
                        'items' => [
                            ['label' => Yii::t('app', 'Account'), 'url' => ['/setting/update'], 'visible' => !Yii::$app->user->isGuest],
                            ['label' => Yii::t('app', 'History'), 'url' => ['/invoice/history'], 'visible' => ( !Yii::$app->user->isGuest && !Yii::$app->user->can('superadmin')),
                                'items' => [
                                    ['label' => Yii::t('app', 'History credit'), 'url' => ['/invoice/history'], 'visible' => !Yii::$app->user->isGuest],
                                    ['label' => Yii::t('app', 'History Bank transfer'), 'url' => ['/paymentbanktrans/history'], 'visible' => !Yii::$app->user->isGuest],
                                ],
                            ],
                            ['label' => Yii::t('app', 'Payment'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest,
                                'items' => [
                                    ['label' => Yii::t('app', 'Pay Pal'), 'url' => ['/user/payment_credit', 'payment_id' => 2, 'id' => Yii::$app->user->id], 'visible' => !Yii::$app->user->isGuest],
                                    ['label' => Yii::t('app', 'Card payment'), 'url' => ['/payment/index'], 'visible' => !Yii::$app->user->isGuest],
                                    ['label' => Yii::t('app', 'Bank transfer'), 'url' => ['/paymentbanktrans/index'], 'visible' => !Yii::$app->user->isGuest],
                                ],
                            ],
                        ],
                    ],
                    ['label' => Yii::t('app', 'Register'), 'url' => ['/site/signup'], 'visible' => Yii::$app->user->isGuest],
                    Yii::$app->user->isGuest ?
                            ['label' => Yii::t('app', 'Login'), 'url' => ['/site/login']] :
                            ['label' => Yii::t('app', 'Logout') . ' (' . Yii::$app->user->identity->username . ')',
                        'url' => ['/site/logout'],
                        'linkOptions' => ['data-method' => 'post']],
                ],
            ]);
            NavBar::end();
            ?>

            <div class="container">
                <?=
                Breadcrumbs::widget([
                    'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
                ])
                ?>
                <?= Alert::widget() ?>

                <div class="col-lg-12">
                    <?php
                    foreach (Yii::$app->session->getAllFlashes() as $key => $message) {
                        echo '<div class="alert alert-' . $key . '">' . $message . '</div>';
                    }
                    ?>
                </div>
                <?= $content ?>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <p class="pull-left">&copy; My Company <?= date('Y') ?></p>
                <p class="pull-right"><?= Yii::powered() ?></p>
            </div>
        </footer>

        <?php $this->endBody() ?>
    </body>
</html>
<?php
$this->registerJsFile(Yii::getAlias('@web/js/app.js'), [\yii\web\View::POS_READY]);
?>
<?php $this->endPage() ?>
