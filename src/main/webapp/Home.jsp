<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
  <title>Trang chủ</title>
  <meta charset="UTF-8">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    h3 { font-weight: 600; letter-spacing: 1px; }
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
    .product-name { font-weight: 500; margin-top: 5px; }
    .product-price { color: #e53935; font-weight: bold; }
    .btn-cart {
      background: #0d6efd;
      color: #fff;
      border-radius: 20px;
      padding: 6px 14px;
      font-size: 14px;
      text-decoration: none;
      margin-top: 6px;
      display: inline-block;
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
            <div class="product-img">
              <img src="${pageContext.request.contextPath}/images/${d.image}"
                   alt="${p.productName}">
            </div>

            <div class="product-name">${p.productName}</div>

            <div class="product-price">

              <fmt:formatNumber value="${d.price}" type="number" pattern="#,##0"/> VNĐ
            </div>

            <a href="${pageContext.request.contextPath}/order-detail?pdid=${d.productDetailId}"
               class="btn-cart">
              <i class="fa-solid fa-bag-shopping me-2"></i> Mua hàng
            </a>

            <a href="#" class="btn-cart">
              <i class="fa fa-cart-plus"></i> Giỏ Hàng
            </a>
          </div>
        </div>
      </c:if>
    </c:forEach>

  </div>
</div>

<jsp:include page="/view/FooterAdmin.jsp"/>

</body>
</html>
