# これはなにか
Eメールを受信して、WEBサービスで処理するためのプログラム

# 使用例
    # vi /etc/postfix/main.cf
#
    luser_relay = mailcatch
#
    # vi /etc/aliases
#
    mailcatch:      "| /home/user/mailcatch/mailcatch.rb
#
    # newaliases
    # /etc/rc.d/init.d/postfix restart

とすると、自動で`hogehoge@domain`にメールした場合に、  
`http://domain/hogehoge/mailcatch/`にJSON形式のデータをPOSTしてくれるもの  

JSONに格納されているデータは
<pre><code>{
  "from" : "from@example.com",
  "subject" : "subject",
  "body" : "テキストのみ",
  "attachments" : [
    {
      "content" : "Base64エンコードされたファイル",
      "filename" : "添付ファイル名",
      "main_type" : "image",
      "sub_type" : "jpeg"
    }
  ]
}</pre></code>
のようになっており、対応している添付ファイルはjpegのみです。
