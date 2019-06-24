# yii1-test

To deploy example Yii application:
```
$ vagrant up
```

Go to http://localhost:9170/yii/requirements/index.php to show requirements 
checker tool.

Then go to http://localhost:9170/testdrive/index.php to see the example skeleton
Yii 1 application. Contains 4 functional pages:
* Home page
* About page
* Contact page
* Login page

`/var/www/testdrive/index.php` is the entry script and is the only script that
Web users can directly access. It includes the Yii bootstrap file `yii.php` and 
then creates an application instance with specified configuration and executes
the application.

`protected` is the base application directory where the majority of the
code and data is placed, and should be protected from being accessed by Web 
users. How to do this in NGINX server?

To create the mysql database:
```
$ mysql -u root -p  # hello is password
mysql> CREATE DATABASE testdrive;
mysql> USE testdrive;
mysql> source /var/www/testdrive/protected/data/schema.mysql.sql;
```

In database.php, uncomment the following:
```
'connectionString' => 'mysql:host=localhost;dbname=testdrive',
'emulatePrepare' => true,
'username' => 'root',
'password' => 'hello',
'charset' => 'utf8',
```

Code to test database:
```
Yii::app()->db->active=true;
$row=Yii::app()->db->createCommand('SELECT * FROM tbl_user')->query();

    echo "<h1>No. rows ";
    print_r($row->rowCount);
    echo " No. cols ";
    print_r($row->columnCount);
    echo "</h1>";
```

To apply database migration to create director table,
```
$ vagrant ssh
$ cd /vagrant/testdrive/protected
$ ./yiic migrate
```

## Working with forms

https://www.yiiframework.com/doc/guide/1.1/en/form.overview

To create forms un Yii:

1. Create model class representing the data fields to be collected
2. Create controller action with code that responds to form submission
3. Create a form in the view script file associated with controller action

