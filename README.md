# slack2bigquery

## About me

[slack] => [slack outgoing webhook] => [slack_proxy] => [fluent_proxy] => [Google BigQuery]


## Deploy on heroku

Prepare 2 heroku repos(for `slack_proxy` and `fluent_proxy`)

On project root directory

```
$ git remote add heroku_slack git@heroku.com:<HEROKU REPO slack_proxy>.git
$ git remote add heroku_fluent git@heroku.com:<HEROKU REPO fluent_proxy>.git
```

### Config settings

```
$ heroku config:add FLUENT_ENDPOINT="https://<HEROKU REPO fluent_proxy>.herokuapp.com/<PATH>" --app <HEROKU REPO slack_proxy>
$ heroku config:add OAUTH_EMAIL="xxxxx-xxxxx@developer.gserviceaccount.com" PROJECT_NAME=slack-project DATASET_NAME=slack TABLE_NAME=timeline --app <HEROKU REPO fluent_proxy>
```

### BigQeury settings

Example of using `bq` command

```
$ bq mk slack
$ bq mk slack.timeline timestamp:integer,channel_name:string,user_name:string,text:string,service_id:string,channel_id:string,token:string,team_id:string,team_domain:string,user_id:string
```

Replace `./fluent_proxy/key.p12` key file

### Deploy

```
$ git subtree push --prefix slack_proxy heroku_slack master
$ git subtree push --prefix fluent_proxy heroku_fluent master
```

