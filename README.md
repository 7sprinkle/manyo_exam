# スキーマテーブル  
___  
## tasksテーブル  
モデル名　Task

|カラム名||データ型|  
| ------------------ | :----------------------------: | -------------------------: |
|title||string|  
|content||text|  
|priority||integer|  
|expired_at||datetime|  
|status||integer|  
|user_id||bigint|  
  

## usersテーブル  
モデル名　User

|カラム名||データ型|  
| ------------------ | :----------------------------: | -------------------------: |
|name||string|  
|email||string|  
|password_digest||password|  
  

## labelsテーブル  
モデル名　Label

|カラム名||データ型|  
| ------------------ | :----------------------------: | -------------------------: |
|name||string|  
  

## labelingsテーブル  
モデル名　Labling

|カラム名||データ型|  
| ------------------ | :----------------------------: | -------------------------: |
|task_id||bigint|  
|label_id||bigint|  



# Herokuへのデプロイ手順  
___
    $ heroku create  
  
##  アセットプリコンパイルをする  
    $ rails assets:precompile RAILS_ENV=production  

##  Heroku stackのバージョンを下げる  
    $ heroku stack:set heroku-18  

##  コミットする  
    $ git add -A  
    $ git commit -m "コミットメッセージ"  

## Heroku buildpackを追加  
    $ heroku buildpacks:set heroku/ruby  
    $ heroku buildpacks:add --index 1 heroku/nodejs  

## Herokuにデプロイ  
    $ git push heroku master

