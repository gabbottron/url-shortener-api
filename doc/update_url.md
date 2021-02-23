# Update URL

Update an existing URL.

**URL** : `/urls/:url_id`

**Method** : `PUT`

**Auth required** : YES

**Permissions required** : Must own URL being updated

## Success Response

**Code** : `200 OK`

**Response examples**

```json
{
    "id": 1,
    "original_url": "http://www.hackaday.com",
    "active": true,
    "slug": "4a5ohzgv",
    "user_id": 1,
    "created_at": "2021-02-23T22:36:36.607Z",
    "updated_at": "2021-02-23T22:37:10.806Z"
}
```

## Notes

*  Body of the request should be JSON.
