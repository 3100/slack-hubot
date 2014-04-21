# Hubot on our kato-im

## Requirements

* `node.js`
* `redis`

## Env

* HUBOT_KATO_LOGIN : katoの専用アカウント
* HUBOT_KATO_PASSWORD : katoの専用アカウント用パスワード
* HUBOT_KATO_ROOMS : hubotが購読管理する各ルームのid(複数ある場合はカンマ区切り)

この他、東京アメッシュの画面をスクリーンキャプチャするために`webthumb`というWebサービスを使用しているため
機能を有効にするには

* HUBOT_WEBTHUMB_USER
* HUBOT_WEBTHUMB_API_KEY

を設定する必要があります。

### 現在対応している部屋は

LazyNight

* hubot部屋
* 技術
* 一般
* 暇な人
* QA
* お菓子部

飲み会

* 飲み会一般

開発用

* 開発用

## Start

~~~
./bin/hubot -a kato
~~~

## scriptの追加

scriptsフォルダに追加し、hubotを再起動してください。
