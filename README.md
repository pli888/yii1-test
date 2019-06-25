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

These model classes represent the data and business rules about entities 
associated with applications. A model represents a single data object such as a
row in a database table or an HTML form. Each field of the data object 
represents an attribute of the model.

There are Form models used to store user input and active records that represent
a row from a database table.

>Describe what the User.php class is and does in terms of ActiveRecord

### Generating CRUD code

Clicking on the CRUD Generator link will generate code to implement the database 
CRUD operations.

A `*Controller` class is also generated. When a controller runs, it performs
the requested action by bringing in the needed models and renders a view. The
Controller class contains functions whose names starts with `action`, e.g. CRUD 
operations like actionCreate(), actionUpdate() and actionDelete() functions. The
default function in a Controller is `actionIndex()`.
```
class SiteController extends CController
{
    public function actionIndex()
    {
        // ...
    }
 
    public function actionContact()
    {
        // ...
    }
}
```

The CRUD code are mostly view classes which display information about
entities such as Users and provides access to operations for their creation, 
update and deletion. Controller classes render views by calling the `render()`
function. The view script can access the controller instance using `$this` and
can pull in any property of the controller by evaluating `$this->propertyName` 
in the view.

#### Routes

Controllers and their actions are identified by IDs, e.g. `post/edit` refers to
the `actionEdit` function in the `PostController` class. Routes are 
case-sensitive.

### Accessing CRUD Pages

The list of users stored in the database can be accessed at: 
http://localhost:9170/testdrive/index.php/user/index which displays user entries
in a HTML table. On the user list page, there are links to operations for 
creating and managing users.

## Testing

https://www.yiiframework.com/doc/guide/1.1/en/test.overview



