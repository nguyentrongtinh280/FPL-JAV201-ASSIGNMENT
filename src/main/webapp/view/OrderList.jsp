<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đơn hàng của tôi</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

  <style>
    body { background-color: #f8f9fa; }
    .status { padding: 4px 10px; border-radius: 20px; font-size: 0.85rem; }
    .PENDING { background: #fff3cd; color: #856404; }
    .DONE { background: #d4edda; color: #155724; }
    .CANCEL { background: #f8d7da; color: #721c24; }
  </style>
</head>

<body>
<jsp:include page="/Menu.jsp"/>

<div class="container my-5">
  <h3 class="fw-bold mb-4 text-primary text-center">
    <i class="fa-solid fa-box me-2"></i>Đơn hàng của tôi
  </h3>

  <div class="card shadow-sm">
    <table class="table table-hover align-middle mb-0 text-center">
      <thead class="table-light">
      <tr>
        <th>Mã đơn</th>
        <th>Ngày đặt</th>
        <th>Tổng tiền</th>
        <th>Thanh toán</th>
        <th>Trạng thái</th>
        <th></th>
      </tr>
      </thead>

      <tbody>
      <c:forEach items="${orders}" var="o">
        <tr>
          <td>#${o.orderId}</td>
          <td>
            <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/>
          </td>
          <td class="fw-semibold text-danger">
            <fmt:formatNumber value="${o.totalAmount}" type="currency"/>
          </td>
          <td>${o.paymentMethod}</td>
          <td>
            <span class="status ${o.orderStatus}">
                ${o.orderStatus}
            </span>
          </td>
          <td>
            <a href="order-detail?id=${o.orderId}"
               class="btn btn-sm btn-outline-primary">
              <i class="fa-solid fa-eye"></i> Xem
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<jsp:include page="FooterAdmin.jsp"/>
</body>
</html>
