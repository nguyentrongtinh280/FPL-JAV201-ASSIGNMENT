<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Menu</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <style>
        .header-custom {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            padding: 10px 20px;
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

        .search-box input {
            border-radius: 20px 0 0 20px;
        }

        .search-box button {
            border-radius: 0 20px 20px 0;
            background: #ffc107;
            font-weight: 600;
        }

        .user-cart {
            color: white;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
        }

        .cart-wrapper {
            position: relative;
            cursor: pointer;
        }

        .cart-icon {
            background: #ffc107;
            color: #000;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: red;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 50%;
            font-weight: bold;
        }
        .user-name {
            white-space: nowrap;
        }
        /* Mobile responsive */
        @media (max-width: 768px) {
            .header-custom {
                text-align: center;
            }

            .search-box {
                margin-top: 10px;
            }

            .user-cart {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header-custom">
        <div class="row align-items-center">
            <div class="col-md-3 d-flex align-items-center justify-content-md-start justify-content-center">
                <img src="${pageContext.request.contextPath}/images/TTSHop.png"
                     alt="Logo"
                     style="width:55px;height:55px">
                <span class="brand-name ms-2">TokTok Shop</span>
            </div>

            <div class="col-md-6 search-box">
                <form action="${pageContext.request.contextPath}/home" method="get">
                    <div class="input-group">
                        <input type="text"
                               name="keyword"
                               class="form-control"
                               placeholder="Tìm theo tên, loại hoặc giá (vd: 100-500)">
                        <button class="btn btn-warning">
                            <i class="fa fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>


            <div class="col-md-3 text-md-end text-center user-cart">

                <a href="${pageContext.request.contextPath}/cart"
                   class="cart-wrapper text-decoration-none">
                    <div class="cart-icon">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </div>
                    <span class="cart-badge">3</span>
                </a>

                <c:if test="${empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-outline-light btn-sm">
                        <i class="fa fa-sign-in-alt"></i> ĐĂNG NHẬP
                    </a>
                </c:if>

                <c:if test="${not empty sessionScope.currentUser}">
<%--                <span class="user-name">--%>
<%--                    Xin chào,--%>
<%--                    <strong>${sessionScope.currentUser.fullname}</strong>--%>
<%--                </span>--%>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-outline-light btn-sm">
                        <i class="fa fa-sign-out-alt"></i> ĐĂNG XUẤT
                    </a>
                </c:if>

            </div>

        </div>
    </div>

    <div class="container mt-3">
        <div id="mainSlider"
             class="carousel slide carousel-fade"
             data-bs-ride="carousel"
             data-bs-interval="3000"
             data-bs-pause="false">

            <div class="carousel-indicators">
                <button data-bs-target="#mainSlider" data-bs-slide-to="0" class="active"></button>
                <button data-bs-target="#mainSlider" data-bs-slide-to="1"></button>
                <button data-bs-target="#mainSlider" data-bs-slide-to="2"></button>
                <button data-bs-target="#mainSlider" data-bs-slide-to="3"></button>
                <button data-bs-target="#mainSlider" data-bs-slide-to="4"></button>
            </div>

            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/images/slider11.png"
                         class="d-block w-100" style="height:420px;object-fit:cover">
                </div>

                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider12.png"
                         class="d-block w-100" style="height:420px;object-fit:cover">
                </div>

                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider13.png"
                         class="d-block w-100" style="height:420px;object-fit:cover">
                </div>

                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider14.png"
                         class="d-block w-100" style="height:420px;object-fit:cover">
                </div>

                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider15.png"
                         class="d-block w-100" style="height:420px;object-fit:cover">
                </div>

            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#mainSlider" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainSlider" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
