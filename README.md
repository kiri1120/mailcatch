# mailcatch
## ����͂Ȃɂ�
E���[������M���āAWEB�T�[�r�X�ŏ������邽�߂̃v���O����

## �g�p��
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
from(�ŏ���1����)
subject
body�i�e�L�X�g�p�[�g�̂݁j
attachments�i�Y�t�t�@�C���Bjpeg�̂݁B�z��jcontent(Base64�G���R�[�h���ꂽ�t�@�C��)�Afilename�i�Y�t�t�@�C�����j
