<?php
/* @var $this FilmController */
/* @var $model Film */

$this->breadcrumbs=array(
	'Films'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Film', 'url'=>array('index')),
	array('label'=>'Manage Film', 'url'=>array('admin')),
);
?>

<h1>Create Film</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>