<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đặt hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    body {
      background-color: #f8f9fa;
    }
    .product-img {
      width: 90px;
      height: 70px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid #ddd;
    }
    .summary-box p {
      margin-bottom: 6px;
    }
    .summary-box .total {
      font-size: 1.2rem;
      font-weight: bold;
      color: #dc3545;
    }
    .qty-input {
      width: 70px;
      margin: auto;
    }
    .btn-delete {
      border: none;
      background: none;
      color: #dc3545;
    }
    .btn-delete:hover {
      color: #a71d2a;
    }

  </style>
</head>

<body>

<jsp:include page="/Menu.jsp"/>

<div class="container my-5">
  <h3 class="text-center fw-bold mb-4 text-primary">Chi tiết đơn hàng của bạn</h3>

  <div class="card shadow-sm mb-4">
    <div class="card-body p-0">
      <table class="table table-bordered align-middle text-center mb-0">
        <thead class="table-light">
        <tr>
          <th>Hình</th>
          <th>Thông tin sản phẩm</th>
          <th>Số lượng</th>
          <th>Giá</th>
          <th>Thành tiền</th>
          <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${products}" var="p">
          <td>${p.image}</td>
          <td>${p.name}</td>
          <td>
            <input type="number"
                   class="form-control form-control-sm text-center qty-input"
                   value="1" min="1">
          </td>
          <td>${p.price}</td>
          <td></td>
          <td>
            <button class="btn-delete text-danger" title="Xóa sản phẩm">
              <i class="fa-solid fa-trash"></i> Xóa
            </button>
          </td>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-md-7">
      <div class="card shadow-sm summary-box">
        <div class="card-body">
          <p>Tạm tính: <span class="float-end">950.000 ₫</span></p>
          <p>Giảm giá: <span class="float-end text-success">-50.000 ₫</span></p>
          <p>Phí vận chuyển: <span class="float-end">30.000 ₫</span></p>
          <hr>
          <p class="total">
            Tổng:
            <span class="float-end">930.000 ₫</span>
          </p>
          <button class="btn btn-primary mt-3 px-4">
            <i class="fa-solid fa-bag-shopping me-2"></i>Đặt hàng
          </button>
        </div>
      </div>
    </div>

    <div class="col-md-5">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="fw-bold mb-3">Hình thức thanh toán</h5>
          <div class="form-check mb-2">
            <input class="form-check-input" type="radio" name="payment">
            <label class="form-check-label">
              Thanh toán khi nhận hàng (COD)
            </label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="payment">
            <label class="form-check-label">
              Thanh toán chuyển khoản
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="FooterAdmin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
