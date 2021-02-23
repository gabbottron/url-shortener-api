# New User

Create a new user.

**URL** : `/users/new`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

## Success Response

**Code** : `200 OK`

**Content examples**

Creates a new user.

```json
{
    "email": "test1@test.com",
    "password": "abc123"
}
```

## Notes

*  Note, password must be a minimum of 6 characters.
