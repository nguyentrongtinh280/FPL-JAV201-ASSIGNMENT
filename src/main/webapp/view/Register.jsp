<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng Ký tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
  <style>
    body {
      min-height: 100vh;
      background: #c3c3c3;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .register-card {
      max-width: 900px;
      width: 500px;
      border-radius: 15px;
      overflow: hidden;
    }

    .login-right {
      padding: 50px;
    }

    .form-control {
      border-radius: 50px;
      padding-left: 45px;
      height: 48px;
    }
    .invalid-feedback {
      margin-left: 20px;
    }

    .input-icon {
      position: absolute;
      top: 24px;
      left: 18px;
      transform: translateY(-50%);
      color: #aaa;
      pointer-events: none;
    }
    .form-control.is-invalid {
      padding-right: 45px;
      background-position: right 15px center;
      background-size: 18px;
    }
  </style>
</head>
<body>

<div class="card register-card shadow-lg">
  <div class="row g-0">
    <div class="col-md-12 login-right">
      <h3 class="text-center fw-bold mb-4 text-primary">Đăng ký tài khoản</h3>
      <form action="register" method="post" id="registerForm" novalidate>

        <div class="mb-3 position-relative">
          <i class="fa-solid fa-file-signature input-icon"></i>
          <input type="text" class="form-control ${emptyFullname ? 'is-invalid' : ''}"
                 name="fullname" value="${user.fullname}"
                 placeholder="Họ và tên" required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyFullname}">
                Vui lòng nhập họ và tên!
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-user input-icon"></i>
          <input type="text" class="form-control ${emptyUsername || not empty errorUsername ? 'is-invalid' : ''}"
                 name="username" value="${user.username}"
                 placeholder="Tên đăng nhập" required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyUsername}">
                Vui lòng nhập tên đăng nhập!
              </c:when>
              <c:when test="${not empty errorUsername}">
                ${errorUsername}
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-solid fa-phone input-icon"></i>
          <input type="text" class="form-control ${emptyPhone || not empty errorPhone ? 'is-invalid' : ''}"
                 name="phone" value="${user.phone}"
                 placeholder="Số điện thoại" required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyPhone}">
                Vui lòng nhập số điện thoại!
              </c:when>
              <c:when test="${not empty errorPhone}">
                ${errorPhone}
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-lock input-icon"></i>
          <input type="password" class="form-control ${emptyPassword ? 'is-invalid' : ''}"
                 name="password" value="${user.password}"
                 placeholder="Mật khẩu" required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyPassword}">
                Vui lòng nhập mật khẩu!
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-lock input-icon"></i>
          <input type="password" class="form-control ${emptyConfirmPassword || not empty errorPassword ? 'is-invalid' : ''}"
                 name="confirmPassword"
                 placeholder="Xác nhận mật khẩu" required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyConfirmPassword}">
                Vui lòng nhập xác nhận mật khẩu!
              </c:when>
              <c:when test="${not empty errorPassword}">
                ${errorPassword}
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="d-grid mb-3">
          <button type="submit" class="btn btn-success text-white">
            Đăng ký
          </button>
        </div>
        <div class="text-center">
          <span>Đã có tài khoản?</span>
          <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">
            Đăng nhập
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>