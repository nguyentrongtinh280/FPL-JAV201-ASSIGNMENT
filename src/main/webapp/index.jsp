<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang chủ</title>
    <meta charset="UTF-8">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>


        h3 {
            font-weight: 600;
            letter-spacing: 1px;
        }

        .product-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            transition: 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 1px solid #eee;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(13,110,253,0.25);
            border-color: #0d6efd;
        }

        .product-img {
            height: 150px;
            border-radius: 10px;
            margin-bottom: 10px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-name {
            font-weight: 500;
            margin-top: 5px;
        }

        .product-price {
            color: #e53935;
            font-weight: bold;
        }

        .btn-cart {
            background: #0d6efd;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 6px 14px;
            font-size: 14px;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
            margin-top: 6px;
        }

        .btn-cart:hover {
            background: #084298;
            color: white;
        }

        .pagination-custom a {
            color: #555;
            border: 1px solid #ddd;
            padding: 6px 12px;
            margin: 2px;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
            background: white;
        }

        .pagination-custom a:hover {
            background: #0d6efd;
            color: white;
            border-color: #0d6efd;
        }
    </style>
</head>

<body>

<jsp:include page="Menu.jsp"/>

<h3 class="text-center text-primary mt-4">
    Xin Chào Bạn Đã Đến Với TokTok Shop
</h3>

<!-- ===== DANH SÁCH SẢN PHẨM ===== -->
<div class="container mt-4">
    <div class="row g-4">

        <%
            String[] tenSP = {
                    "Áo Thun Nam", "Áo Hoodie", "Giày Sneaker",
                    "Áo Thể Thao", "Áo Ba Lỗ",
                    "Quần Kaki", "Quần Nỉ",
                    "Balo Du Lịch", "Mũ Lưỡi Trai", "Kính Mát",
                    "ComBo Quần + Áo", "Đồ trẻ con ",
                    "ComBo Quần + Áo", "Đồ trẻ con "
                    ,"Balo Du Lịch", "Mũ Lưỡi Trai",
                    "Kính Mát", "ComBo Quần + Áo"

            };

            String[] giaSP = {
                    "150.000đ", "320.000đ", "850.000đ",
                    "280.000đ", "190.000đ",
                    "500.000đ", "250.000đ",
                    "380.000đ", "90.000đ", "120.000đ",
                    "120.000đ","120.000đ","150.000đ","190.000đ",
                    "120.000đ","120.000đ","150.000đ","190.000đ",

            };
            String ctx = request.getContextPath();

            String[] anhSP = {
                    ctx + "/images/ao1.jpg",
                    ctx + "/images/ao2.jpg",
                    ctx + "/images/sneaker.jpg",
                    ctx + "/images/aothethao.jpg",
                    ctx + "/images/aobalo.jpg",
                    ctx + "/images/quankaki.jpg",
                    ctx + "/images/quanni.jpg",
                    ctx + "/images/baloduLich.png",
                    ctx + "/images/muluoitrai.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/muluoitrai.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/muluoitrai.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg",
                    ctx + "/images/kinh.jpg"

            };

            for(int i=0; i<tenSP.length; i++){
        %>

        <div class="col-md-3 col-sm-4 col-6">
            <div class="product-card">
                <div class="product-img">
                    <img src="<%= anhSP[i] %>" alt="product">
                </div>
                <div class="product-name"><%= tenSP[i] %></div>
                <div class="product-price"><%= giaSP[i] %></div>
                <a href="#" class="btn-cart">
                    <i class="fa fa-cart-plus"></i> Giỏ Hàng
                </a>
            </div>
        </div>

        <% } %>

    </div>

    <!-- ===== PHÂN TRANG ===== -->
    <div class="text-center mt-4 pagination-custom">
        <a href="#"><i class="fa fa-angle-left"></i></a>
        <a href="#" class="bg-primary text-white">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#"><i class="fa fa-angle-right"></i></a>
    </div>
</div>

<jsp:include page="/view/FooterAdmin.jsp"/>

</body>
</html>
