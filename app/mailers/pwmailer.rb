class Pwmailer < ApplicationMailer
    def findpw_mail mailaddr, contentpw
        mail    from: 'bangut@gmail.com', 
                  to: mailaddr, 
             subject: '안녕하세요? bangut의 새로운 비밀번호입니다',
                body: contentpw
    end
end
