package utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailService {
    private static final String FROM_EMAIL = "quocanhbuinhat@gmail.com";
    private static final String APP_PASSWORD = "mkjjiljafkdbvmqg";
    public static void sendOTP(String toEmail, String otp) {

        Properties props = new Properties();

        // Cấu hình SMTP Gmail
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            // Tạo mail
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            message.setSubject("OTP khôi phục mật khẩu - TokTok Shop");

            message.setText(
                    "Xin chào,\n\n" +
                            "Mã OTP khôi phục mật khẩu của bạn là: " + otp + "\n\n" +
                            "⚠ Mã có hiệu lực trong 5 phút.\n" +
                            "Vui lòng không chia sẻ mã này cho bất kỳ ai.\n\n" +
                            "Trân trọng,\nTokTok Shop"
            );

            // Gửi mail
            Transport.send(message);

            System.out.println("Đã gửi OTP tới email: " + toEmail);

        } catch (MessagingException e) {
            System.out.println("Lỗi gửi email OTP");
            e.printStackTrace();
        }
    }
    public static void sendContactMail(String customerName, String customerEmail, String content) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));

            // Gửi về chính bạn
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(FROM_EMAIL)
            );

            message.setSubject("Liên hệ hỗ trợ từ website");

            message.setText(
                    "Bạn nhận được một liên hệ mới:\n\n" +
                            "Họ tên: " + customerName + "\n" +
                            "Email: " + customerEmail + "\n\n" +
                            "Nội dung:\n" + content
            );

            Transport.send(message);

            System.out.println("Đã gửi mail liên hệ thành công");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
