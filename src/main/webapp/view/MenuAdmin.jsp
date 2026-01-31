<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
  .navbar {
    background: linear-gradient(90deg, #1e3c72, #2a5298);
  }
  .navbar-brand {
    font-weight: bold;
    color: #fff !important;
  }
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

  .logo-img {
    width: 55px;
    height: 55px;
    object-fit: contain;
  }

  .brand-name {
    font-size: 20px;
    font-weight: bold;
    color: white;
  }
</style>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid">
    <div class="col-md-3 d-flex align-items-center justify-content-md-start justify-content-center">
      <img src="${pageContext.request.contextPath}/images/TTSHop.png" class="logo-img">
      <span class="brand-name ms-2">TokTok Shop</span>
    </div>

    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/admin/home">TRANG CHỦ</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/admin/category">QUẢN LÝ DANH MỤC</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/admin/product">QUẢN LÝ SẢN PHẨM</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/admin/user">QUẢN LÝ NGƯỜI DÙNG</a>
        </li>
      </ul>

      <span class="navbar-text text-white me-3">
        <i class="fa fa-user"></i> ${sessionScope.currentUser.fullname}
      </span>

      <a class="btn btn-outline-light btn-sm"
         href="${pageContext.request.contextPath}/logout">
        <div class="fw-bold">ĐĂNG XUẤT</div>
      </a>
    </div>
  </div>
</nav>