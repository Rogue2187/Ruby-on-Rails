# README

## DB設計(適宜修正)

### Users
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|name|string||
|refresh_token|string||
|access_token|string||

has_many videos

※devise,omniauth-google-oauth2を使用

### Videos
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|video|string|null: false|
|user_id|references|null: false,foreign_key: true|

belongs_to user

### Video-likes

### Comment

### Comment-likes

### Comment-dislikes

### Tags

### Channels

### User-channels
※中間テーブル
