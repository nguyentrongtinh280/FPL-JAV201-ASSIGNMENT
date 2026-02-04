<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Giỏ hàng</title>
  <meta charset="UTF-8">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    :root {
      --primary-color: #2a5298;
      --text-muted: #6c757d;
    }

    body {
      background: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .cart-box {
      background: #fff;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .page-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 25px;
    }

    .header-title {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .table thead {
      background: var(--primary-color);
      color: #fff;
    }

    .product-img {
      width: 80px;
      height: 80px;
      border-radius: 8px;
      overflow: hidden;
      margin: auto;
      border: 1px solid #e9ecef;
    }

    .product-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .price-text {
      font-weight: 600;
      color: #333;
    }

    .qty-input {
      width: 50px !important;
      text-align: center;
      font-weight: 600;
      border-left: 0;
      border-right: 0;
      background-color: #fff !important;
    }

    .checkout-btn {
      background: var(--primary-color);
      color: white;
      border: none;
      padding: 12px 40px;
      font-size: 1.1rem;
      border-radius: 8px;
      transition: 0.3s;
    }

    .checkout-btn:hover {
      background: #1e3c72;
      color: white;
    }
  </style>
</head>

<body>

<div class="container mt-5 mb-5">
  <div class="cart-box">

    <div class="page-header">
      <div class="header-title">
        <a href="${pageContext.request.contextPath}/home"
           class="d-flex align-items-center gap-3 text-decoration-none">
          <img src="${pageContext.request.contextPath}/images/TTSHop.png"
               style="width:55px;height:55px" alt="Logo">
          <h4 class="mb-0" style="color: var(--primary-color); font-weight: 700;">
            GIỎ HÀNG
          </h4>
        </a>
      </div>
    </div>

    <table class="table table-bordered text-center align-middle">
      <thead>
      <tr>
        <th>Ảnh</th>
        <th>Tên sản phẩm</th>
        <th>Phân loại</th>
        <th>Đơn giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
        <th>Thao tác</th>
      </tr>
      </thead>

      <tbody>
      <c:forEach items="${cartItems}" var="item">
        <tr>
          <td>
            <div class="product-img">
              <img src="${pageContext.request.contextPath}/images/${item.image}">
            </div>
          </td>

          <td class="text-start fw-bold">
              ${item.productName}
          </td>

          <td class="text-start text-muted" style="font-size: 0.9rem;">
            Màu: ${item.color}<br>
            Size: ${item.size}
          </td>

          <td class="price-text">
            $<span class="price">${item.price}</span>
          </td>

          <td>
            <div class="input-group justify-content-center flex-nowrap" style="width:120px;margin:0 auto;">
              <a href="${pageContext.request.contextPath}/cart/update?action=decrease&id=${item.productDetailId}"
                 class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-minus"></i>
              </a>

              <input type="text" class="form-control qty-input" value="${item.quantity}" readonly>

              <a href="${pageContext.request.contextPath}/cart/add?productDetailId=${item.productDetailId}"
                 class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-plus"></i>
              </a>
            </div>
          </td>

          <td class="price-text" style="color:green;">
            $<span class="total"></span>
          </td>

          <td>
            <a href="${pageContext.request.contextPath}/cart/remove?id=${item.productDetailId}"
               class="text-danger"
               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
              <i class="fa-solid fa-trash"></i>
            </a>
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty cartItems}">
        <tr>
          <td colspan="7" class="py-5 text-muted">
            <i class="fa-solid fa-cart-shopping fa-3x mb-3"></i>
            <p>Giỏ hàng của bạn đang trống</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-sm">
              Tiếp tục mua sắm
            </a>
          </td>
        </tr>
      </c:if>
      </tbody>
    </table>

    <c:if test="${not empty cartItems}">
      <div class="d-flex justify-content-end mt-4 align-items-center">
        <h5 class="me-4 mb-0">
          Tổng thanh toán:
          <strong style="color:green;font-size:1.5rem;">
            $${grandTotal}
          </strong>
        </h5>

        <a href="${pageContext.request.contextPath}/checkout"
           class="checkout-btn text-decoration-none">
          Đặt hàng
        </a>
      </div>
    </c:if>

  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll("tbody tr").forEach(row => {
      let price = row.querySelector(".price");
      let qty = row.querySelector(".qty-input");
      let total = row.querySelector(".total");
      if (price && qty && total) {
        total.innerText = (parseFloat(price.innerText) * parseInt(qty.value)).toFixed(2);
      }
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>