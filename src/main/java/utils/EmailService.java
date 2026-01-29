package utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    // ⚠️ Điền Gmail của bạn
    private static final String FROM_EMAIL = "quocanhbuinhat@gmail.com";

    // ⚠️ App Password Gmail (không phải mật khẩu Gmail thường)
    private static final String APP_PASSWORD = "mkjjiljafkdbvmqg";

    public static void sendOTP(String toEmail, String otp) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Mã OTP khôi phục mật khẩu");
            message.setText("Mã OTP của bạn là: " + otp);

            Transport.send(message);
            System.out.println("Đã gửi OTP thành công!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public static void send(String email, String otpKhôiPhụcMậtKhẩu, String s) {

    }
}
