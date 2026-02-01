<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sản phẩm</title>
    <meta charset="UTF-8">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <style>
        body { background: #f8f9fa; }

        .product-box {
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }

        .product-image {
            background: #f0f0f0;
            border-radius: 12px;
            height: 420px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-title {
            font-weight: 600;
            font-size: 22px;
        }

        .product-price {
            color: #e53935;
            font-size: 22px;
            font-weight: bold;
            margin: 10px 0;
        }

        .option-title {
            font-weight: 500;
            margin-bottom: 6px;
        }

        .option-btn {
            border: 1px solid #ccc;
            padding: 6px 14px;
            border-radius: 20px;
            background: #fff;
            font-size: 14px;
        }

        .qty-box {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .qty-box button {
            width: 32px;
            height: 32px;
            border: none;
            background: #e9ecef;
            border-radius: 6px;
        }

        .btn-buy {
            background: #0d6efd;
            color: #fff;
            padding: 10px 24px;
            border-radius: 25px;
            font-weight: 500;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.25s;
        }

        .btn-buy:hover {
            background: #0b5ed7;
            transform: translateY(-1px);
        }

        .btn-cart-circle {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            border: 2px solid #0d6efd;
            color: #0d6efd;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff;
            transition: 0.25s;
            font-size: 18px;
            cursor: pointer;
        }

        .btn-cart-circle:hover {
            background: #0d6efd;
            color: #fff;
            transform: translateY(-1px);
        }
    </style>
</head>

<body>

<jsp:include page="/Menu.jsp"/>

<div class="container mt-5 mb-5">
    <div class="row product-box">

        <div class="col-md-5 mb-4">
            <div class="product-image">
                <img src="${pageContext.request.contextPath}/images/${detail.image}">
            </div>
        </div>

        <div class="col-md-7">

            <div class="product-title">
                ${detail.product.productName}
            </div>

            <div class="product-price">
                ${detail.price} đ
            </div>

            <div class="mb-3">
                <div class="option-title">Màu sắc:</div>
                <div class="d-flex gap-2">
                    <c:forEach items="${details}" var="d">
                        <span class="option-btn">${d.color}</span>
                    </c:forEach>
                </div>
            </div>

            <div class="mb-3">
                <div class="option-title">Kích thước:</div>
                <div class="d-flex gap-2">
                    <c:forEach items="${details}" var="d">
                        <span class="option-btn">${d.size}</span>
                    </c:forEach>
                </div>
            </div>

            <div class="mb-4">
                <div class="option-title">Số lượng:</div>
                <div class="qty-box">
                    <button type="button" onclick="decreaseQty()">-</button>

                    <input type="text"
                           id="qty"
                           value="1"
                           class="form-control text-center"
                           style="width:60px"
                           readonly>

                    <button type="button" onclick="increaseQty()">+</button>
                </div>
            </div>

            <div class="d-flex gap-3 align-items-center">
                <a class="btn-buy" onclick="orderNow()">Đặt hàng</a>
                <a class="btn-cart-circle" onclick="addToCart()">
                    <i class="fa fa-cart-shopping"></i>
                </a>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/view/FooterAdmin.jsp"/>

<script>
    function increaseQty() {
        let qty = document.getElementById("qty");
        qty.value = parseInt(qty.value) + 1;
    }

    function decreaseQty() {
        let qty = document.getElementById("qty");
        let value = parseInt(qty.value);
        if (value > 1) {
            qty.value = value - 1;
        }
    }

    function addToCart() {
        let qty = document.getElementById("qty").value;
        window.location.href =
            "${pageContext.request.contextPath}/Cart.jsp?pid=${detail.product.productId}&qty=" + qty;
    }

    function orderNow() {
        let qty = document.getElementById("qty").value;
        window.location.href =
            "${pageContext.request.contextPath}/OrderDetail?pid=${detail.product.productId}&qty=" + qty;
    }
</script>

</body>
</html>
