# DataHub API

The DataHub API provides a range of endpoints to interact with the platform. All endpoints live under the URL `https://api.datahub.io` where our API is divided into the following sections: **auth, rawstore, sources** 



## Auth

A generic OAuth2 authentication service and user permission manager. 

### Check an authentication token's validity

`/auth/check`

**Method:** `GET`

**Query Parameters:**

 - `jwt` - authentication token
 - `next` - URL to redirect to when finished authentication

**Returns:**

If authenticated:

```javascript
{
    "authenticated": true,
    "profile": {
        "id": "<user-id>",
        "name": "<user-name>",
        "email": "<user-email>",
        "avatar_url": "<url-for-user's-profile-photo>",
        "idhash": "<unique-id-of-the-user>",
        "username": "<user-selected-id>" // If user has a username
    }
}
```

If not:

```javascript
{
    "authenticated": false,
    "providers": {
        "google": {
            "url": "<url-for-logging-in-with-the-Google-provider>"
        },
        "github": {
            "url": "<url-for-logging-in-with-the-Github-provider>"
        },
    }
}
```

When the authentication flow is finished, the caller will be redirected to the `next` URL with an extra query parameter
`jwt` which contains the authentication token. The caller should cache this token for further interactions with the API.

### Get permission for a service
`/user/authorize`

**Method:** `GET`

**Query Parameters:**

 - `jwt` - user token (received from `/user/check`)
 - `service` - the relevant service (e.g. `storage-service`)

**Returns:**

```json
{
    "token": "<token-for-the-relevant-service>"
    "userid": "<unique-id-of-the-user>",
    "permissions": {
        "permission-x": true,
        "permission-y": false
    },
    "service": "<relevant-service>"
}
```

### Change the username
`/user/update`

**Method:** `POST`

**Query Parameters:**

 - `jwt` - authentication token (received from `/user/check`)
 - `username` - A new username for the user profile (this action is only allowed once)

**Returns:**

```json
{
    "success": true,
    "error": "<error-message-if-applicable>"
}
```
**Note**: trying to update other user profile fields like `email` will fail silently and return

```json
{ 
    "success": true
}
```

### Receive authorization public key
`/user/public-key`

**Method:** `GET`

**Returns:**

The service's public key in PEM format.

Can be used by services to validate that the permission token is authentic.


## Rawstore

### Get authorized upload URL(s)

`/rawstore/authorize`

**Method:** `POST`

**Query Parameters:**

**Headers:**

* `Auth-Token` - permission token (received from conductor)

**Body:**

```javascript
{
  "metadata": {
        "owner": "<user-id-of-uploader>",
        "name": "<data-set-unique-id>"
    },
  "filedata": {
      "<relative-path-to-file-in-package-1>": {
          "size": 1234,
          "md5": "<md5-hash-of-the-data>",
          "type": "<content-type-of-the-data>",
          "name": "<file-name>"
      },
      "<relative-path-to-file-in-package-2>": {
          "size": 4321,
          "md5": "<md5-hash-of-the-data>",
          "type": "<content-type-of-the-data>",
          "name": "<file-name>"
      }
      ...
  }
}
```

**Returns:**

Signed urls to upload into S3:

```javascript
{
  fileData: {
    "<file-name-1>": {
      "md5-hash": "...",
      "name": "<file-name>",
      "type": "<file-type>",
      "upload_query": {
        'Content-MD5': '...',
        'Content-Type': '...',
        'acl': 'public-read',
        'key': '<path>',
        'policy': '...',
        'x-amz-algorithm': 'AWS4-HMAC-SHA256',
        'x-amz-credential': '...',
        'x-amz-date': '<date-time-in-ISO',
        'x-amz-signature': '...'
      },
      "upload_url": "<s3-url>"
    },
    "<file-name-2>": ...,
    ...
  }
}

```

### Get information regarding the datastore

`/info`

**Method:** `GET`

**Query Parameters:**

 - `jwt` - permission token (received from `/user/authorize`)

**Headers:**

 - `Auth-Token` - permission token (can be used instead of the `jwt` query parameter)

**Returns:**

JSON content with the following structure:
```json
{
    "prefixes": [
        "https://api.datahub.io/rawstore/123456789",
        ...
    ]
}
```

`prefixes` is the list of possible prefixes for an uploaded file for this user.

## Sources

### Get status 

`/source/{identifier}/status`

**Method:** `GET`

**Returns:**

```javascript
{
   'state': 'queued/running/errored',
   'errors': [
       'error-message', // ...
   ],
   'logs': [
              'log-line', 
              'log-line', // ...
           ],
   'history': [
      {
       'execution-time': 'iso-time',
       'success': true or false,
       'termination-time': 'iso-time' or null
      }, // ...   
   ],
   'outputs': [
       {
        'kind': '<kind>', 
        'url': '<url>', 
        'created-at': '<iso-time>',
        'filename': '<displayable-filename>',
        'title': '<displayable-title>'
       }
   ],
   'stats': {
       'key': 'value' // e.g. 'count-of-rows', etc.
   }
}
```

### Upload 

`/source/upload`

**Method:** `POST`

**Query Parameters:**

**Headers:**

* `Auth-Token` - permission token (received from conductor)

**Body:**

```javascript
{
    'meta': {
        'version': 1, // version of the _spec_
        'owner': '<user-id>', // Will be validated on upload
        'id': '<id>'
    },
    'inputs': [
        {
            'kind': 'datapackage',
            'url': '<url>',
            'parameters': {
                'resource-mapping': {
                    '<resource-name>': '<resource-url>'
                }
            }
        }    
    ],
    'processing': [
        {
            // TBD
        }
    ],
    'outputs': [
        {
            'kind': 'datapackage',
            'parameters': {
                // e.g. 'create-previews': false
            }
        }
    ]
}
```

**Returns:**

```javascript
{
  "success": true,
  "id": "<identifier>"
  "errors": [
      "<error-message>"
  ]
}
```


