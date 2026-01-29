<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đơn hàng của tôi</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    body {
      background-color: #f8f9fa;
    }
    .status {
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 500;
    }
    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }
    .status-done {
      background-color: #d4edda;
      color: #155724;
    }
    .status-cancel {
      background-color: #f8d7da;
      color: #721c24;
    }
  </style>
</head>

<body>

<jsp:include page="/Menu.jsp"/>

<div class="container my-5">
  <h3 class="fw-bold mb-4 text-primary text-center">
    <i class="fa-solid fa-box me-2"></i>Đơn hàng của tôi
  </h3>

  <div class="card shadow-sm">
    <div class="card-body p-0">
      <table class="table table-hover align-middle mb-0 text-center">
        <thead class="table-light">
        <tr>
          <th>Mã đơn</th>
          <th>Ngày đặt</th>
          <th>Tổng tiền</th>
          <th>Thanh toán</th>
          <th>Trạng thái</th>
          <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <!-- Đơn hàng 1 -->
        <tr>
          <td>#ORD001</td>
          <td>15/01/2026</td>
          <td class="fw-semibold text-danger">930.000 ₫</td>
          <td>COD</td>
          <td>
            <span class="status status-pending">Đang xử lý</span>
          </td>
          <td>
            <a href="order-detail?id=ORD001" class="btn btn-sm btn-outline-primary">
              <i class="fa-solid fa-eye"></i> Xem
            </a>
          </td>
        </tr>

        <!-- Đơn hàng 2 -->
        <tr>
          <td>#ORD002</td>
          <td>05/01/2026</td>
          <td class="fw-semibold text-danger">1.250.000 ₫</td>
          <td>Chuyển khoản</td>
          <td>
            <span class="status status-done">Hoàn thành</span>
          </td>
          <td>
            <a href="order-detail?id=ORD002" class="btn btn-sm btn-outline-primary">
              <i class="fa-solid fa-eye"></i> Xem
            </a>
          </td>
        </tr>

        <!-- Đơn hàng 3 -->
        <tr>
          <td>#ORD003</td>
          <td>28/12/2025</td>
          <td class="fw-semibold text-danger">450.000 ₫</td>
          <td>COD</td>
          <td>
            <span class="status status-cancel">Đã hủy</span>
          </td>
          <td>
            <a href="order-detail?id=ORD003" class="btn btn-sm btn-outline-secondary">
              <i class="fa-solid fa-eye"></i> Xem
            </a>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<jsp:include page="FooterAdmin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
