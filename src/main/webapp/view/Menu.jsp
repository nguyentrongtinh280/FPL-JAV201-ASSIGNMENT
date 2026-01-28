<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Menu</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <style>
        .header-custom {
            background: linear-gradient(90deg, #1e3c72, #2a5298);            padding: 12px 20px;
            border-radius: 10px;
        }


        .logo-img {
            width: 70px;
            height: 70px;
            object-fit: contain;
        }
    </style>

</head>
<body>
<!-- HEADER -->
<div class="row align-items-center mb-3 header-custom">

    <!-- LOGO -->
    <div class="col-md-3 d-flex align-items-center">
        <img src="${pageContext.request.contextPath}/images/TTSHop.png"
             class="logo-img"
             alt="TokTok Shop Logo">
        <span class="ms-2 fw-bold text-white">TokTok Shop</span>
    </div>

    <!-- SEARCH -->
    <div class="col-md-6">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Tìm kiếm...">
            <button class="btn btn-warning text-white">Tìm</button>
        </div>
    </div>

    <!-- USER + CART -->
    <div class="col-md-3 text-end text-white">
        <span class="me-3">Username</span>
        <i class="fa-solid fa-cart-shopping fs-4"></i>
    </div>
</div>

    <!-- SLIDER -->
    <div class="row">
        <div class="col-12">

            <div id="mainSlider" class="carousel slide" data-bs-ride="carousel">

                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="1"></button>
                </div>

                <div class="carousel-inner">

                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/images/img.png"
                             class="d-block w-4500px"
                             style="height: auto; object-fit:cover;">
                    </div>

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/images/slider1.jpg"
                             class="d-block w-2000px"
                             style="height: 200px; object-fit:cover;">
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
</div>

<!-- QUAN TRỌNG: Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
