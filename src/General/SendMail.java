package General;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Class for sending email messages
 *
 */


public class SendMail {
	
	private String to;
	private String subject;
	private String message;
	
	public SendMail() {
	}

	public void registerMail(String to, String username, String auth_code) {
		this.to = to;
		this.subject = "TextRPG Registration";
		String link = "<a href='localhost/text-rpg/activate.jsp?code="+auth_code+"&username="+username+"'>link</a>";
		this.message = "Hello "+username+", welecome to TextRPG!<br><br>In order to activate your account, please go to the following " 
					+ link + ".<br><br>Regards,<br>TextRPG Team";
	}
	
	public void contactMail(String subject, String message, String name, String from) {
		this.to = "textrpgsce@gmail.com";
		this.subject = subject;
		this.message = "New mail from "+name+"!\nEmail: "+from+"\nMessage: "+message;
	}
	
	public void forgotPassword(String to, String code) {
		this.to = to;
		this.subject = "New Password";
		this.message = "New Password:  "+code;
	}
	
	synchronized public void send() throws MessagingException {
		
		String  from_email = "textrpgsce@gmail.com",
		        from_uname = "textrpgsce",
		        from_password = "coolpw123",
		        from_host = "smtp.gmail.com",
		        from_port  = "465";
		
		Properties props = new Properties();
		props.put("mail.smtp.user", from_email);
		props.put("mail.smtp.host", from_host);
		props.put("mail.smtp.port", from_port);
		props.put("mail.smtp.starttls.enable","true");
		props.put("mail.smtp.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.socketFactory.port", from_port);
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session session = Session.getInstance(props);

		MimeMessage msg = new MimeMessage(session);
		msg.setText(message, "UTF-8", "html");
		msg.setSubject(subject);
		msg.setFrom(new InternetAddress(from_email));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		Transport transport = session.getTransport("smtps");
		transport.connect(from_host, 465, from_uname, from_password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	}
}
