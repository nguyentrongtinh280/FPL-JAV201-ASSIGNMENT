<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý người dùng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .page-title {
      color: #2a5298;
      font-weight: 700;
      margin-bottom: 20px;
    }
    .card {
      border-radius: 12px;
    }
    .form-control {
      border-radius: 8px;
    }
    .btn {
      border-radius: 8px;
      padding: 8px 18px;
    }
    .table thead {
      background-color: #2a5298;
      color: #fff;
    }
    .table tbody tr:hover {
      background-color: #eef3ff;
    }
  </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-white pt-5">

<jsp:include page="MenuAdmin.jsp"/>

<main class="container my-4 flex-fill">
  <c:url var="url" value="/admin/user"/>
  
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h4 class="page-title text-center">Thông tin người dùng</h4>

      <form action="${url}" method="post" id="userForm" novalidate>
      <div class="row g-3">

          <c:if test="${isEdit}">
            <div class="mb-3">
              <label class="form-label">Id</label>
              <input type="text" name="userId"
                     class="form-control"
                     value="${user.userId}" readonly>
            </div>
          </c:if>

          <div class="col-md-6">
            <label class="form-label">Họ và tên</label>
            <input type="text" name="fullname" class="form-control"
                   value="${user.fullname}" required>
            <div class="invalid-feedback">Vui lòng nhập họ và tên!</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Tên đăng nhập</label>
            <input type="text" name="username"
                   class="form-control ${not empty errorUsername ? 'is-invalid' : ''}"
                   value="${user.username}"
            ${isEdit ? 'readonly' : ''} required>
            <div class="invalid-feedback">
              <c:choose>
                <c:when test="${not empty errorUsername}">
                  ${errorUsername}
                </c:when>
                <c:otherwise>
                  Vui lòng nhập tên đăng nhập!
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" name="email"
                   class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                   value="${user.email}" required>
            <div class="invalid-feedback">
              <c:choose>
                <c:when test="${not empty errorEmail}">
                  ${errorEmail}
                </c:when>
                <c:otherwise>
                  Vui lòng nhập email!
                </c:otherwise>
              </c:choose>
            </div>

          </div>

          <div class="col-md-6">
            <label class="form-label">Số điện thoại</label>
            <input type="text" name="phone"
                   class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                   value="${user.phone}" required>
            <div class="invalid-feedback">
              <c:choose>
                <c:when test="${not empty errorPhone}">
                  ${errorPhone}
                </c:when>
                <c:otherwise>
                  Vui lòng nhập số điện thoại!
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Mật khẩu</label>
            <input type="password" name="password" class="form-control"
                   value="${user.password}" required>
            <div class="invalid-feedback">Vui lòng nhập mật khẩu</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Xác nhận mật khẩu</label>
            <input type="password" name="confirmPassword"
                   class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                   required>
            <div class="invalid-feedback">
              <c:choose>
                <c:when test="${not empty errorPassword}">
                  ${errorPassword}
                </c:when>
                <c:otherwise>
                  Vui lòng xác nhận mật khẩu!
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="address" class="form-control"
                   value="${user.address}" required>
            <div class="invalid-feedback">Vui lòng nhập địa chỉ</div>
          </div>

          <div class="col-md-6">
            <label class="form-label d-block">Vai trò</label>
            <div class="form-check form-check-inline">
              <input type="radio" class="form-check-input role-radio"
                     name="role" value="false"
              ${user != null && !user.role ? 'checked' : ''}>
              <label class="form-check-label">Khách hàng</label>
            </div>

            <div class="form-check form-check-inline">
              <input type="radio" class="form-check-input role-radio"
                     name="role" value="true"
              ${user != null && user.role ? 'checked' : ''}>
              <label class="form-check-label">Quản trị viên</label>
            </div>

          </div>

          <div class="text-center mt-4">
            <button type="submit" formaction="${url}/create" class="btn btn-primary me-2">
              <i class="fa fa-plus"></i> Thêm
            </button>

            <button type="submit" formaction="${url}/update" class="btn btn-warning me-2">
              <i class="fa fa-pen"></i> Sửa
            </button>

            <button type="submit" formaction="${url}/delete"
                    class="btn btn-danger me-2"
                    onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">
              <i class="fa fa-trash"></i> Xóa
            </button>

            <button type="submit" formaction="${url}/reset" class="btn btn-success me-2">
              <i class="fa fa-rotate"></i> Mới
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <div class="d-flex mb-2">
        <input type="text" class="form-control w25 me-2">
        <button class="btn btn-primary">Tìm</button>
      </div>
    </div>
  </div>

  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h5 class="page-title">Danh sách người dùng</h5>

      <table class="table table-bordered table-hover text-center align-middle">
        <thead>
        <tr>
          <th>ID</th>
          <th>Họ và tên</th>
          <th>Tên đăng nhập</th>
          <th>Email</th>
          <th>Số điện thoại</th>
          <th>Vai trò</th>
          <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${users}" var="u">
          <tr>
            <td>${u.userId}</td>
            <td>${u.fullname}</td>
            <td>${u.username}</td>
            <td>${u.email}</td>
            <td>${u.phone}</td>
            <td>
              <span class="badge ${u.role ? 'bg-danger' : 'bg-primary'}">
                  ${u.role ? 'Admin' : 'User'}
              </span>
            </td>

            <td>
              <a href="${url}/edit?id=${u.userId}">
              <i class="fa fa-pen"></i>
                Sửa
              </a>
            </td>

          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</main>

<jsp:include page="FooterAdmin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const form = document.getElementById("userForm");
  const roleRadios = document.querySelectorAll(".role-radio");
  const actionButtons = document.querySelectorAll("button[formaction]");
  actionButtons.forEach(btn => {
    btn.addEventListener("click", function (event) {
      const action = btn.getAttribute("formaction");
      const needValidate =
              action.endsWith("/create") || action.endsWith("/update");
      roleRadios.forEach(radio => {
        radio.required = needValidate;
      });
      if (needValidate) {
        form.classList.add("was-validated");
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
      } else {
        form.classList.remove("was-validated");
      }
    });
  });
</script>
</body>
</html>
