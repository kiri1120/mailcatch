#!/usr/bin/env ruby
# coding: utf-8

require 'nkf'
require 'mail'
require 'json'
require 'base64'
require 'httpclient'

config_path = File.expand_path('../config/config.json', __FILE__)
config = JSON.parse(File.read(config_path), {:symbolize_names => true})

email = Mail.new(STDIN.read)

from    = email.from.first
to      = email.to.first
subject = email.subject

if  email.multipart?
  body = email.text_part.body
else
  body = email.body
end

data = {
  from:         from,
  subject:      subject,
  body:         NKF.nkf('-w', body.to_s.strip),
  attachments:  []
}

if email.has_attachments?
  email.attachments.each do |attachment|
    if attachment.main_type == 'image' && attachment.sub_type == 'jpeg'
      data[:attachments].push({
        content:    Base64.encode64(attachment.read),
        main_type:  attachment.main_type,
        sub_type:   attachment.sub_type,
        filename:   attachment.filename
      })
    end
  end
end

json_data = JSON.generate(data)
product_name, domain = to.split('@')
error_from = 'MAILER-DAEMON@' + domain
uri = "http://localhost/#{product_name}/mailcatch/"

client = HTTPClient.new

begin
  client.post_content(uri, json_data, 'Content-Type' => 'application/json')
rescue
  # error mail
  Mail.defaults do
    delivery_method :smtp, config[:smtp_setting]
  end

  Mail.deliver({
    to:       from,
    from:     error_from,
    subject:  'Undelivered Mail Returned to Sender',
    body:     "This is the mail system at host #{domain}.

I'm sorry to have to inform you that your message could not\nbe delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<#{to}>: unknown user: \"#{product_name}\""
  })
end

