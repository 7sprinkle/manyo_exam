# スキーマテーブル  
___  
## tasksテーブル  
モデル名　Task

|カラム名||データ型|  
| ------------------ | :----------------------------: | -------------------------: |
|title||string|  
|content||text|  
|priority||integer|  
|interval||datetime|  
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
