import net.http
import os

// generate email: https://www.1secmail.com/api/v1/?action=genRandomMailbox&count={count}
// get mailbox: https://www.1secmail.com/api/v1/?action=getMessages&login={email_user}&domain={email_domain}
// read email: https://www.1secmail.com/api/v1/?action=readMessage&login={email_user}&domain={email_domain}&id={id}

pub fn generate_email() ?string{
	request := http.get('https://www.1secmail.com/api/v1/?action=genRandomMailbox&count=1') ?
	return request.text
}

pub fn get_inbox(username string, domain string) ?string {
	request := http.get('https://www.1secmail.com/api/v1/?action=getMessages&login=' + username + '&domain=' + domain) ?
	return request.text
}

pub fn read_mail(username string, domain string, id string) ?string {
	request := http.get('https://www.1secmail.com/api/v1/?action=readMessage&login=' + username + '&domain=' + domain + '&id=' + id) ?
	return request.text
}

fn main(){
	email := generate_email() ?
	println('Your new email is ' + email)
	for {
		mut cmd := os.input('VMail> ')
		if cmd.to_lower() == "inbox" {
			username := os.input('Username: ')
			domain := os.input('Domain: ')
			println(get_inbox(username, domain) ? )
		}
		else if cmd.to_lower() == "email" {
			dump(email)
		}
		else if cmd.to_lower() == "read" {
			username := os.input('Username: ')
			domain := os.input('Domain: ')
			mail_id := os.input('Mail ID: ')
			println(read_mail(username, domain, mail_id) ? )
		}
	}
}