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
</style>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Logo</a>

    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/home">Trang chủ</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/category">Quản lý danh mục</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/product">Quản lý sản phẩm</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/user">Quản lý người dùng</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-white" href="${pageContext.request.contextPath}/statistical">Thống kê</a>
        </li>
      </ul>

      <span class="navbar-text text-white me-3">
        <i class="fa fa-user"></i> Admin
      </span>

      <a class="btn btn-outline-light btn-sm"
         href="${pageContext.request.contextPath}/logout">Đăng xuất
      </a>
    </div>
  </div>
</nav>