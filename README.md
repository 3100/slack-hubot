# Hubot on our slack

実質`heroku`用です。

## Requirements

* `node.js`
* `redis`

## Env

* HUBOT_SLACK_TOKEN : `slack`で配布されたトークン
* HUBOT_SLACK_TEAM : `slack`のチーム名
* HUBOT_SLACK_BOTNAME : hubotの名前

を設定する必要があります。

## Start

~~~
./bin/hubot -a slack
~~~

もしデバッグをしたい場合は、シェルで試行するとよいでしょう。

~~~
./bin/hubot
~~~

## scriptの追加

scriptsフォルダに追加し、hubotを再起動してください。

## Contribution

1. プロジェクトをフォークします。
1. ブランチを作成し、その中で変更を加えます。
1. コミットを1つにまとめます。
1. ブランチのままフォークプロジェクトにpushします。
1. プルリクエストを作成します。
