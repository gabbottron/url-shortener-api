# Log In

Log in and get JWT credentials.

**URL** : `/users/login`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

## Success Response

**Code** : `200 OK`

**Content examples**

```json
{
    "email": "test1@test.com",
    "password": "abc123"
}
```

## Notes

* You will need to provide the JWT in the HTTP headers of any request to an endpoint requiring authorization. Authorization: Bearer {{token}}. This is done in a macro in the provided Postman collection referenced in README.md.
