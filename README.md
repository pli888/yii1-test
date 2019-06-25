# yii1-test application

To deploy example Yii application on VirtualBox VM:
```
$ vagrant up
```

A Ubuntu VM is deployed and then bootstrap.sh is executed to install MySQL, PHP,
Apache and Yii version 1 on the VM. The testdrive database is installed in the
MySQL RDBMS. A database migration script is applied to create a new `tbl_film` 
table.

Access to the testdrive database is configured in 
`protected/config/database.php`

To delete application:
```
$ vagrant destroy -f
```

## Requirements checker tool

Go to http://localhost:9170/yii/requirements/index.php to show requirements 
checker tool.


## Use

Go to http://localhost:9170/testdrive/index.php to see the example skeleton
Yii 1 application. Contains 4 functional pages:
* Home page
* About page
* Contact page
* Login page

The [index.php](http://localhost:9170/testdrive/index.php) script at the root of 
application directory is the entry script and is the only script that Web users 
can directly access. It includes the Yii bootstrap file `yii.php` and then 
creates an application instance with specified configuration and executes the 
application.

The `protected` base application directory is where the majority of the code and 
data is placed, and should be protected from being accessed by Web users.

>How to do this in NGINX server?

## Gii code generator

Yii comes with a web-based application for generating code called Gii which has
been activated in `testdrive/protected/config/main.php`. Gii can be accessed 
with `hello` as the password at 
http://localhost:9170/testdrive/index.php/gii/default/login.

### Generating models

After login, click on the link Model Generator to go the model generation page.
In the Table Name field, enter `tbl_user`. In the Model Class field, enter `User`. 
Then press the Preview button. This will show us the new code file to be 
generated. Now press the Generate button. A new file named `User.php` will be 
generated under `testdrive/protected/models`. This `User` model class allows us 
to talk to the underlying database `tbl_user` table in an object-oriented 
fashion.

These model classes represent in the information and business rules about 
entities associated with applications.

>Describe what the User.php class is and does in terms of ActiveRecord

### Generating CRUD code

Clicking on the CRUD Generator link will generate code to implement the database 
CRUD operations. These are mostly view classes which display information about
entities such as Users and provides access to operations for their creation, 
update and deletion. A `*Controller` class is also generated for performing the
actual CRUD operations with actionCreate(), actionUpdate() and actionDelete()
functions.

### Accessing CRUD Pages

The list of users stored in the database can be accessed at: 
http://localhost:9170/testdrive/index.php/user/index which displays user entries
in a HTML table. On the user list page, there are links to operations for 
creating and managing users.

## Working with forms

https://www.yiiframework.com/doc/guide/1.1/en/form.overview

To create forms un Yii:

1. Create model class representing the data fields to be collected
2. Create controller action with code that responds to form submission
3. Create a form in the view script file associated with controller action

