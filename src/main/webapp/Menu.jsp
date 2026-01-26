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

    .search-input {
        width: 220px;
        border-radius: 20px;
    }

    .cart-icon {
        position: relative;
        color: #fff;
        font-size: 18px;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/home">Logo</a>

        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/user/home">Trang chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/user/product">Sản phẩm</a>
                </li>
            </ul>


            <form class="d-flex me-3"
                  action="${pageContext.request.contextPath}/user/search"
                  method="get">

                <input class="form-control form-control-sm search-input me-2"
                       type="search"
                       name="keyword"
                       placeholder="Tìm sản phẩm...">

                <button class="btn btn-outline-light btn-sm" type="submit">
                    <i class="fa fa-search"></i>
                </button>
            </form>

            <a href="${pageContext.request.contextPath}/user/cart"
               class="me-3 cart-icon">
                <i class="fa fa-shopping-cart"></i>
            </a>

            <a href="${pageContext.request.contextPath}/user/profile"
               class="me-3 cart-icon">
                <i class="fa fa-user"></i>
            </a>

            <a class="btn btn-outline-light btn-sm"
               href="${pageContext.request.contextPath}/login">Đăng nhập
            </a>
        </div>
    </div>
</nav>