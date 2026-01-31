<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đặt hàng</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    body { background-color: #f8f9fa; }
    .product-img {
      width: 90px;
      height: 70px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid #ddd;
    }
    .qty-input { width: 70px; margin: auto; }
    .total { font-size: 1.2rem; font-weight: bold; color: #dc3545; }
    .btn-delete { border: none; background: none; color: #dc3545; }
  </style>
</head>

<body>
<jsp:include page="/Menu.jsp"/>

<div class="container my-5">
  <h3 class="text-center fw-bold mb-4 text-primary">Chi tiết đơn hàng</h3>

  <form action="order-create" method="post">
    <div class="card shadow-sm mb-4">
      <div class="card-body p-0">
        <table class="table table-bordered align-middle text-center mb-0">
          <thead class="table-light">
          <tr>
            <th>Hình</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Thành tiền</th>
            <th></th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${cartItems}" var="item">
            <tr>
              <td>
                <img src="${item.product.image}" class="product-img">
              </td>
              <td>${item.product.name}</td>
              <td>
                <input type="number"
                       name="quantities"
                       value="${item.quantity}"
                       min="1"
                       class="form-control form-control-sm text-center qty-input">
              </td>
              <td>
                <fmt:formatNumber value="${item.price}" type="currency"/>
              </td>
              <td>
                <fmt:formatNumber value="${item.total}" type="currency"/>
              </td>
              <td>
                <a href="cart-remove?id=${item.product.id}" class="btn-delete">
                  <i class="fa-solid fa-trash"></i>
                </a>
              </td>
            </tr>

            <input type="hidden" name="productIds" value="${item.product.id}">
          </c:forEach>

          </tbody>
        </table>
      </div>
    </div>

    <div class="row g-4">
      <div class="col-md-7">
        <div class="card shadow-sm">
          <div class="card-body">
            <p>Tạm tính: <span class="float-end">
              <fmt:formatNumber value="${subtotal}" type="currency"/>
            </span></p>
            <p>Phí vận chuyển: <span class="float-end">
              <fmt:formatNumber value="${shippingFee}" type="currency"/>
            </span></p>
            <hr>
            <p class="total">
              Tổng:
              <span class="float-end">
                <fmt:formatNumber value="${totalAmount}" type="currency"/>
              </span>
            </p>
            <button class="btn btn-primary mt-3">
              <i class="fa-solid fa-bag-shopping me-2"></i>Đặt hàng
            </button>
          </div>
        </div>
      </div>

      <div class="col-md-5">
        <div class="card shadow-sm">
          <div class="card-body">
            <h5 class="fw-bold mb-3">Thanh toán</h5>

            <div class="form-check mb-2">
              <input class="form-check-input" type="radio"
                     name="paymentMethod" value="COD" checked>
              <label class="form-check-label">COD</label>
            </div>

            <div class="form-check">
              <input class="form-check-input" type="radio"
                     name="paymentMethod" value="BANKING">
              <label class="form-check-label">Chuyển khoản</label>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
</div>

<jsp:include page="FooterAdmin.jsp"/>
</body>
</html>
