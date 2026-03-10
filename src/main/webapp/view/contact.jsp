<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liên hệ</title>

    <style>
        .contact-container {
            width: 500px;
            margin: 40px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .contact-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .contact-container input,
        .contact-container textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .contact-container button {
            width: 100%;
            padding: 10px;
            background-color: #2a5298;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .contact-container button:hover {
            background-color: #1e3c72;
        }

        .success-message {
            color: green;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="contact-container">
    <h2>Liên hệ hỗ trợ</h2>

    <form action="${pageContext.request.contextPath}/contact" method="post">

        <label>Họ và tên:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Nội dung:</label>
        <textarea name="message" rows="5" required></textarea>

        <button type="submit">Gửi liên hệ</button>
    </form>

    <c:if test="${not empty message}">
        <div class="success-message">
                ${message}
        </div>
    </c:if>
</div>

</body>
</html>
