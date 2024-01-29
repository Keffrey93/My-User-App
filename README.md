# My-User-App

Description
In this project we will implement a very famous architecture: MVC (Model View Controller).

Part I
Create a class User, it will be your interface in order to

create user
find user
get all users
update user
destroy user in sqlite.
You will use the gem sqlite3.
The sqlite filename will be named db.sql.

Your table will be name users and will have multiple attributes:

firstname as string
lastname as string
age as integer
password as string
email as string
Your class will have the following methods:

def create(user_info)
It will create a user. User info will be: firstname, lastname, age, password and email
And it will return a unique ID (a positive integer)

def find(user_id)
It will retrieve the associated user and return all information contained in the database.

def all
It will retrieve all users and return a hash of users.

def update(user_id, attribute, value)
It will retrieve the associated user, update the attribute send as parameter with the value and return the user hash.

def destroy(user_id)
It will retrieve the associated user and destroy it from your database.

Part II
Create a controller. You will use your User class from Part I. Your route will return a JSON.

It will have multiple routes:

GET on /users. This action will return all users (without their passwords).

POST on /users. Receiving firstname, lastname, age, password and email. It will create a user and store in your database and returns the user created (without password).

POST on /sign_in. Receiving email and password. It will add a session containing the user_id in order to be logged in and returns the user created (without password).

PUT on /users. This action require a user to be logged in. It will receive a new password and will update it. It returns the user created (without password).

DELETE on /sign_out. This action require a user to be logged in. It will sign_out the current user. It returns nothing (code 204 in HTTP).

DELETE on /users. This action require a user to be logged in. It will sign_out the current user and it will destroy the current user. It returns nothing (code 204 in HTTP).

For the signed in method, we will be using session & cookies
In order to perform a request with curl and save cookies
(Be aware it's not the same flags to save & load)

Example00

$>curl -X POST -i http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -d "firstname=value1" -d "lastname=value2"
...
$>
Part III
Add a route /. This one will respond with HTML.
Create subdirectory views and inside, create a file named: index.html (you will have to submit it)

$>cat views/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Users index page</title>
    </head>
    <body>
        <h1>Users</h1>
        <table>
            <tr>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Age</th>
                <th>Email</th>
            </tr>
            <tr>
                <td>XXXX</td>
                <td>XXXX</td>
                <td>XXXX</td>
                <td>XXXX</td>
            </tr>
        </table>
    </body>
</html>
$>
-- tr are for line in the table
-- th are for header row (you should only have one of them)
-- td are for content row (you should have a lot of them)

# set('views', './views')
Tips
To run a server locally you need to use port: 8080
and if you want to access it from your browser, you need to change the binding address to: 0.0.0.0

It will have a route GET on /. This action will render the template in index.html.

Tips
Google: Sql syntax
Google Create a sql table
