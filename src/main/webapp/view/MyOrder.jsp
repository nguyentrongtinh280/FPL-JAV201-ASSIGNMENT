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
  </style>
</head>

<body>
<jsp:include page="/Menu.jsp"/>

<div class="container my-5">
  <h3 class="fw-bold mb-4 text-primary text-center">
    <i class="fa-solid fa-box me-2"></i>Đơn hàng của tôi
  </h3>

  <div class="card shadow-sm">
    <table class="table table-hover align-middle mb-0 text-center table-bordered">
      <thead class="table-light">
      <tr>
        <th>Mã đơn</th>
        <th>Sản phẩm</th>
        <th>Số lượng</th>
        <th>Ngày đặt</th>
        <th>Tổng tiền</th>
        <th>Thanh toán</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
      </tr>
      </thead>

      <tbody>
      <c:forEach items="${orders}" var="o">
        <tr>
          <td>${o.orderId}</td>

          <td class="text-start">
            <c:forEach items="${o.orderDetails}" var="d">
              • ${d.productDetail.product.productName}<br/>
            </c:forEach>
          </td>

          <td>
            <c:set var="totalQty" value="0"/>
            <c:forEach items="${o.orderDetails}" var="d">
              <c:set var="totalQty" value="${totalQty + d.quantity}"/>
            </c:forEach>
            ${totalQty}
          </td>

          <td>${o.orderDate}</td>

          <td class="fw-semibold">
            <fmt:formatNumber value="${o.totalAmount}" type="currency"/>
          </td>

          <td>${o.paymentMethod}</td>

          <td>
            <c:choose>
              <c:when test="${o.orderStatus == 'PENDING'}">
                <span class="badge bg-warning text-dark">
                  Đang xử lý
                </span>
              </c:when>

              <c:when test="${o.orderStatus == 'DONE'}">
                <span class="badge bg-success">
                  Đã giao
                </span>
              </c:when>

              <c:when test="${o.orderStatus == 'CANCEL'}">
                <span class="badge bg-danger">
                  Đã hủy
                </span>
              </c:when>
            </c:choose>
          </td>

          <td>
            <c:if test="${o.orderStatus == 'DONE'}">
              <a href="${pageContext.request.contextPath}/order/rebuy?id=${o.orderId}"
                 class="btn btn-sm btn-success">
                <i class="fa-solid fa-rotate-right me-1"></i>Mua lại
              </a>
            </c:if>

            <c:if test="${o.orderStatus == 'PENDING'}">
              <a href="${pageContext.request.contextPath}/order/cancel?id=${o.orderId}"
                 class="btn btn-sm btn-danger"
                 onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?');">
                <i class="fa-solid fa-xmark me-1"></i>Hủy đơn hàng
              </a>
            </c:if>

            <c:if test="${o.orderStatus == 'CANCEL'}">
              <span class="text-muted fst-italic">Không khả dụng</span>
            </c:if>
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty orders}">
        <tr>
          <td colspan="8" class="text-muted py-4">
            Bạn chưa có đơn hàng nào
          </td>
        </tr>
      </c:if>
      </tbody>
    </table>
  </div>
</div>

<jsp:include page="FooterAdmin.jsp"/>
</body>
</html>
