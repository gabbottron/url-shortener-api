# url-shortener-api
A challenge project to implement a URL shortener API

## Local dev setup
#### Dependencies
1. Ruby 2.6.3
2. Rails 6.0.3
3. Valid credentials files with JWT secret

**IMPORTANT:** Before running this project locally, you MUST have credentials set up for development (see steps below!)

### Project Setup
```
1. Pull the repository
2. bundle install
3. bundle exec rails db:migrate
4. bundle exec rails credentials:edit --environment development
5. bundle exec rails credentials:edit --environment test
### Your credentials files should look like this:
jwt:
  secret: mysecretkeygoeshere
```

### Testing
```
Tests are comprehensive, so be sure all setup steps above were followed. They will require the JWT secret!
bundle exec rspec
```

### Running the server
```
Be sure to follow project setup tasks above before running:
bundle exec rails s
```

**DEFAULT URI:** http://localhost:3000

**SHORTENED URI:** http://localhost:3000/l/:slug

**POSTMAN COLLECTION:** https://www.getpostman.com/collections/33421854529feb307462  
The above link will load all of the requests and macros for authentication into Postman for you.

## Open Endpoints

Open endpoints require no Authentication.
* [Login](doc/login.md)                                 : `POST /users/login`
* [New User](doc/new_user.md)                           : `POST /users/new`

## Endpoints that require Authentication

Closed endpoints require a valid Token to be included in the header of the
request. A Token can be acquired from the Login view above.
* [Create URL](doc/new_url.md)    : `POST    /urls`
* [Update URL](doc/update_url.md) : `PUT     /urls/:url_id`
* [Delete URL](doc/delete_url.md) : `DELETE  /urls/:url_id`
