# user_app_task
---------------------------------------------
- flutter --version
- Flutter 3.38.5
--------------------------
Api request response documentation -

1 - login - 
- post - https://dummyjson.com/auth/login
request - {
"username": "emilys",
"password": "emilyspass"
}

2 - register
- post - https://dummyjson.com/users/add
- request - {
  "username": "emilys",
  "email": "a@gmail.com",
  "password": "emilyspass"
}

3 - getUserList
- get - https://dummyjson.com/users?limit=0

4 - updateUser
- put - https://dummyjson.com/users/1
- request - {
  "firstName": "Yogesh",
  "lastName": "Dhakane"
  }

5 - deleteUser
- delete - https://dummyjson.com/users/1
-------------------------------------------------------------------------------------------

