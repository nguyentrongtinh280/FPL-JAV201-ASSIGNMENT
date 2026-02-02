<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
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
      height: 380px;
      background: #fff;
      border-radius: 12px;
      padding: 20px;
      text-align: center;
      transition: 0.3s;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      border: 1px solid #eee;
    }

    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 18px rgba(13,110,253,0.25);
      border-color: #0d6efd;
    }

    .product-img {
      height: 220px;
      border-radius: 10px;
      margin-bottom: 10px;
      background: #f0f0f0;
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

    .btn-action {
      background: #0d6efd;
      color: #fff;
      border-radius: 20px;
      padding: 6px 14px;
      font-size: 14px;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      transition: all 0.25s ease;
    }

    .btn-action:hover {
      background: #084298;
      color: #fff;
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(13,110,253,0.35);
    }

    .btn-action i {
      font-size: 14px;
      line-height: 1;
      display: flex;
      align-items: center;
    }
  </style>
</head>

<body>

<jsp:include page="Menu.jsp"/>

<h3 class="text-center text-primary mt-4 fw-bold">
  Xin Chào Bạn Đã Đến Với TokTok Shop
</h3>

<div class="container mt-4">
  <div class="row g-4">

    <c:forEach items="${products}" var="p">
      <c:if test="${not empty p.productDetails}">
        <c:set var="d" value="${p.productDetails[0]}"/>

        <div class="col-md-3 col-sm-4 col-6">
          <div class="product-card">

            <a href="${pageContext.request.contextPath}/product-detail?pid=${p.productId}"
               style="text-decoration:none;color:inherit">

              <div class="product-img">
                <img src="${pageContext.request.contextPath}/images/${d.image}">
              </div>

              <div class="product-name">${p.productName}</div>

              <div class="product-price">
                  ${d.price} đ
              </div>
            </a>

            <div class="d-flex justify-content-center gap-2 mt-2">

              <a href="${pageContext.request.contextPath}/Cart.jsp"
                 class="btn-action">
                <i class="fa fa-cart-plus"></i>
                Giỏ hàng
              </a>

              <a href="${pageContext.request.contextPath}/order-detail?pdid=${d.productDetailId}"
                 class="btn-action">
                <i class="fa-solid fa-bag-shopping me-2"></i> Mua hàng
              </a>

            </div>

          </div>
        </div>
      </c:if>
    </c:forEach>

  </div>
</div>

<jsp:include page="/view/FooterAdmin.jsp"/>

</body>
</html>
