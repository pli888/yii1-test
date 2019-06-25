<?php
/* @var $this FilmController */
/* @var $model Film */

$this->breadcrumbs=array(
	'Films'=>array('index'),
	$model->title=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Film', 'url'=>array('index')),
	array('label'=>'Create Film', 'url'=>array('create')),
	array('label'=>'View Film', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Film', 'url'=>array('admin')),
);
?>

<h1>Update Film <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>