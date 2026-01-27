<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="index.jsp">Hello Servlet</a>
<body class="d-flex flex-column min-vh-100 bg-white pt-5">

<jsp:include page="Menu.jsp"/>

<main class="container my-4 flex-fill">

    <h1 class="text-center text-primary">Xin chào, trang chủ khách hàng.</h1>

</main>

<jsp:include page="view/FooterAdmin.jsp"/>
</body>
</html>
