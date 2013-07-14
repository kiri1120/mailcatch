# mailcatch
## これはなにか
Eメールを受信して、WEBサービスで処理するためのプログラム

## 使用例
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

とすると、自動でhogehoge@domainにメールした場合に、
http://domain/hogehoge/mailcatch/にJSON形式のデータをPOSTしてくれるもの

JSONに格納されているデータは
from(最初の1つだけ)
subject
body（テキストパートのみ）
attachments（添付ファイル。jpegのみ。配列）content(Base64エンコードされたファイル)、filename（添付ファイル名）
