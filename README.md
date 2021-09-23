# github_stars

An app that retrieves users by name or nickname and show their starred repos using the Github GraphQL api.

## Getting Started

In order to access the api we have to authenticate within github. So this app provides an oauth login.
For this reason an oauth app must be created to have a working client_id and client_secret. I won't 
provide any of this in this public repository.

To create your github app head to [Developers setting](https://github.com/settings/developers) select
New OAuth App and make sure you put a callback URL with a localhost as host and 8080 as port (e.g. http://localhost:8080).
Then in the created app generate a new client secret. Copy everything because github will show it only once.

Next create a secrets.dart file in secrets directory with the contents:
```
const kClientId = '{YOUR APP's CLIENT ID}';
const kClientSecret = 'YOUR APP's CLIENT SECRET';
```

If you want to run the bundled real invocation tests you might want to add an access token constant as well:
```
const kAccessToken = '{YOUR MANUALLY OBTAINED ACCESS_TOKEN}}';
```

Now get dependencies and run. The first time you'll have to login with a github account and grant permission 
to read user email info. You'll navigate to the list page where you can query user's name and nickname.
Choose one in the suggested list and it should show user details and starred repos. Search suggestion list 
and starred repos are limited by 10, though it is hardcoded it can be changed in the [list_remote_datasource_impl.dart](https://github.com/mludovico/github_stars/blob/main/lib/app/list/data/list_remote_datasource_impl.dart#L11-L21)
query at build time.