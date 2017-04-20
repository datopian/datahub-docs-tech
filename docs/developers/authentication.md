# Data Package Registry Authentication

This page describes authentication of Data Package Registry users. The details provided can be used by developers, willing to contribute to the existing [dpm](https://github.com/frictionlessdata/dpm-py) API client or implement custom client for The Data Package Registry API.

The Data Package Registry Frontend allows users to be registered via [github](https://github.com) using the web browser. After a successful registration, user will be given unique API-KEY to authenticate with Data Package Registry API server.

## API authentication

Some Data Package Registry API methods require client to provide identity of a registered user. To prove its identity, client first has to obtain temporal JWT token, providing permanent API-KEY of a registered user. After that client can pass this token in the header of a request to the API.

To obtain a temporal JWT token, client should send POST request to `/api/auth/token`. Request should have json-encoded body with 'username' and 'secret' keys, where 'secret' is an API-KEY of the user:

```
response = requests.post(
        url='https://datapackaged.com/api/auth/token',
        {'username': 'my_username', 'secret': '1dd5f984bc'}))
```

If the username and API-KEY are valid, server will return json response with JWT token: `{'token': 'a6d8b887'}`

```
auth_token = response.json().get('token')
```

This token should be temporarily stored by the client. To access any API method with authentication, client should include this token in the "Authorization" header.

```
requests.post(api_url, headers={'Authorization', 'Bearer %s' % auth_token})
```
