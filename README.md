# README

This app works in concert with keycloak-krakend-demo repo and the netrunnerdb-api-server.

Build it with docker, bring it up.

You'll need to specify the client_id and client_secret you made in keycloak and the
redirect URLs in the application secrets for the development environment.

```
docker compose exec web bash
# use apt to install the editor of your choice. plural uses vim, so that's the example here:
apt install vim
export EDITOR=vim

rails credentials:edit --environment=development
```

and edit the file with the following, replacing the variables as appropriate:
```
oauth:
  client_id: ${CLIENT_ID}
  client_secret: ${CLIENT_SECRET} 
  redirect_uri: http://localhost:3400/callback
```

save those and you should be good to go.
