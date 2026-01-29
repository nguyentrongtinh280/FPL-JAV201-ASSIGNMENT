<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập</title>
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
    .login-card {
      width: 500px;
      height: 390px;
      border-radius: 15px;
      overflow: hidden;
    }
    .login-right {
      padding: 50px;
    }
    .form-control {
      height: 48px;
      border-radius: 50px;
      padding-left: 45px;
    }
    .form-control.is-invalid {
      background-position: right 15px center;
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
<div class="card login-card shadow-lg">
  <div class="row g-0">
    <div class="col-md-12 login-right">
      <h3 class="text-center fw-bold mb-4 text-primary">Đăng nhập</h3>
      <form action="login" method="post" id="loginForm" novalidate>
        <div class="mb-3 position-relative">
          <i class="fa fa-user input-icon"></i>
          <input type="text"
                 class="form-control ${emptyUsernameOrEmail or not empty errorEmailOrUsername ? 'is-invalid' : ''}"
                 name="username"
                 placeholder="Tên đăng nhập"
                 required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyUsernameOrEmail}">
                Vui lòng nhập tên đăng nhập!
              </c:when>
              <c:when test="${not empty errorEmailOrUsername}">
                ${errorEmailOrUsername}
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-lock input-icon"></i>
          <input type="password"
                 class="form-control ${emptyPassword or not empty errorPassword ? 'is-invalid' : ''}"
                 name="password"
                 placeholder="Mật khẩu"
                 required>
          <div class="invalid-feedback">
            <c:choose>
              <c:when test="${emptyPassword}">
                Vui lòng nhập mật khẩu!
              </c:when>
              <c:when test="${not empty errorPassword}">
                ${errorPassword}
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3">
          <div class="form-check">
            <input class="form-check-input" type="checkbox"
                   id="remember" name="remember">
            <label class="form-check-label" for="remember">
              Ghi nhớ đăng nhập
            </label>
          </div>
          <a href="OTP.jsp">Quên mật khẩu?</a>
        </div>

        <div class="d-grid mb-3">
          <button type="submit" class="btn btn-success text-white">
            Đăng nhập
          </button>
        </div>
        <div class="text-center">
          <span>Chưa có tài khoản?</span>
          <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none">
            Đăng ký
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
