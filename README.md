# ����͂Ȃɂ�
E���[������M���āAWEB�T�[�r�X�ŏ������邽�߂̃v���O����

# �g�p��
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

�Ƃ���ƁA������hogehoge@domain�Ƀ��[�������ꍇ�ɁA  
http://domain/hogehoge/mailcatch/��JSON�`���̃f�[�^��POST���Ă�������  

JSON�Ɋi�[����Ă���f�[�^��
<pre><code>
{
  "from" : "from@example.com",
  "subject" : "subject",
  "body" : "�e�L�X�g�̂�",
  "attachments" : [
    {
      "content" : "Base64�G���R�[�h���ꂽ�t�@�C��",
      "filename" : "�Y�t�t�@�C����",
      "main_type" : "image",
      "sub_type" : "jpeg"
    }
  ]
}</pre></code>
�̂悤�ɂȂ��Ă���A�Ή����Ă���Y�t�t�@�C����jpeg�݂̂ł��B
