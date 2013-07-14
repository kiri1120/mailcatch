#!/usr/bin/env ruby
# coding: utf-8

require 'nkf'
require 'mail'
require 'json'
require 'base64'
require 'httpclient'

email = Mail.new(STDIN.read)

if  email.multipart?
  body_part = email.text_part.body
else
  body_part = email.body
end

product_name, domain = email.to.first.split('@')

data = {
  from:         email.from.first,
  subject:      email.subject,
  body:         NKF.nkf('-w', body_part.to_s.strip),
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

begin
  client = HTTPClient.new
  client.post_content(
    "http://localhost/#{product_name}/mailcatch/",
    JSON.generate(data),
    'Content-Type' => 'application/json'
  )
rescue
  error_body = "This is the mail system at host #{domain}.

I'm sorry to have to inform you that your message could not be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can delete your own text from the attached returned message.

                   The mail system

<#{product_name}@#{domain}>: unknown user: \"#{product_name}\""

  # error mail
  mail = Mail.deliver do
    delivery_method(:sendmail)
    to(data[:from])
    from('postmaster@' + domain)
    subject('Undelivered Mail Returned to Sender')
    body(error_body)
  end
end

