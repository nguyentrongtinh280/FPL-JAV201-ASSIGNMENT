<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        }

        .cart-icon {
            background: #ffc107;
            color: #000;
            padding: 6px 10px;
            border-radius: 50%;
            margin-left: 8px;
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

            <!-- LOGO -->
            <div class="col-md-3 d-flex align-items-center justify-content-md-start justify-content-center">
                <img src="${pageContext.request.contextPath}/images/TTSHop.png" class="logo-img">
                <span class="brand-name ms-2">TokTok Shop</span>
            </div>

            <!-- SEARCH -->
            <div class="col-md-6 search-box">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm...">
                    <button class="btn btn-warning">Tìm</button>
                </div>
            </div>

            <!-- USER + CART -->
            <div class="col-md-3 text-md-end text-center user-cart">
                <span>Xin chào, User</span>
                <span class="cart-icon">
                    <i class="fa-solid fa-cart-shopping"></i>
                </span>
            </div>

        </div>

    </div>


    <!-- SLIDER -->
    <div class="container mt-3">

        <div id="mainSlider" class="carousel slide" data-bs-ride="carousel">

            <div class="carousel-indicators">
                <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="1"></button>
            </div>

            <div class="carousel-inner">

                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/images/img.png"
                         class="d-block w-100 rounded"
                         style="height:420px; object-fit:cover;">
                </div>

                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider1.png"
                         class="d-block w-100 rounded"
                         style="height:420px; object-fit:cover;">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/images/slider2.jpg"
                         class="d-block w-100 rounded"
                         style="height:420px; object-fit:cover;">
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

</div>

<!-- QUAN TRỌNG: Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
