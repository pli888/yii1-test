<?php

class m190624_034231_create_film_table extends CDbMigration
{
	public function up()
	{
        $this->createTable('tbl_film', array(
            'id' => 'pk',
            'title' => 'string NOT NULL',
            'director' => 'string NOT NULL',
        ));

        $this->insert('tbl_film',array(
            'title'=>'Interstellar',
            'director' =>'Christopher Nolan',
        ));
	}

	public function down()
	{
        $this->dropTable('tbl_film');
	}
}