<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang chủ</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
</head>
<body>

<div class="container-fluid p-3">

    <!-- HEADER -->
    <div class="row header align-items-center mb-3">
        <div class="col-md-3 logo">
            <span class="border p-2 me-2">Blog Logo</span>
            <span>Trang chủ</span>
        </div>

        <div class="col-md-6 search">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm...">
                <button class="btn btn-primary">Tìm</button>
            </div>
        </div>

        <div class="col-md-3 user-cart text-end">
            <span class="border p-2 me-2">Username</span>
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
                        <img src="${pageContext.request.contextPath}/images/login.png"
                             class="d-block w-100" style="height:350px; object-fit:cover;">
                    </div>

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/images/login_user.png"
                             class="d-block w-100" style="height:350px; object-fit:cover;">
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
