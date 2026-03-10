<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>TÀI KHOẢN CÁ NHÂN</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<jsp:include page="/Menu.jsp"/>

<body class="bg-light">

<div class="container mt-4">
    <div class="row">

        <!-- MENU TRÁI -->
        <div class="col-md-3">
            <div class="bg-white rounded p-3 shadow-sm h-100">
                <div class="text-center">
                    <img src="${pageContext.request.contextPath}/images/avatar.jpg"style="width:150px;height:130px;
                    border-radius:12px;border:2px solid #ee4d2d;object-fit:cover;">

                    <h6 class="mt-2 mb-0">${user.username}</h6>
                    <small class="text-muted">Sửa hồ sơ</small>
                </div>

                <ul class="list-group list-group-flush mt-3">
                    <li class="list-group-item fw-bold text-danger">👤 Hồ sơ</li>
                    <li class="list-group-item text-danger">
                    <a href="${pageContext.request.contextPath}/reset-password"
                       class="text-danger text-decoration-none">🔒 Đổi mật khẩu</a>
                    </li>
                    <li class="list-group-item text-danger">

                    <a href="${pageContext.request.contextPath}/logout"
                           class="text-danger text-decoration-none">🚪 Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- NỘI DUNG PHẢI -->
        <div class="col-md-9">
            <div class="bg-white rounded p-4 shadow-sm h-100">
                <h5>Hồ sơ của tôi</h5>
                <p class="text-muted mb-4">
                    Quản lý thông tin hồ sơ để bảo mật tài khoản
                </p>

                <form action="${pageContext.request.contextPath}/profile" method="post">

                    <div class="row mb-3">
                        <div class="col-md-3 fw-semibold">Tên đăng nhập</div>
                        <div class="col-md-9 pt-2">${user.username}</div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-3 fw-semibold">Họ và tên</div>
                        <div class="col-md-9">
                            <input type="text" name="fullName"
                                   value="${user.fullname}"
                                   class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-3 fw-semibold">Email</div>
                        <div class="col-md-9">
                            <input type="email" name="email"
                                   value="${user.email}"
                                   class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-3 fw-semibold">Số điện thoại</div>
                        <div class="col-md-9">
                            <input type="text" name="phone"
                                   value="${user.phone}"
                                   class="form-control">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-9">
                            <button type="submit" class="btn btn-danger px-4">
                                Lưu thay đổi
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>

    </div>
</div>
<jsp:include page="/view/FooterAdmin.jsp"/>

</body>
</html>
