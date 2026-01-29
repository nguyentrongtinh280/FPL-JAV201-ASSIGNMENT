<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body class="pt-5">
<jsp:include page="MenuAdmin.jsp"/>

<div class="container mt-4">

    <!-- ===== FORM PRODUCT ===== -->
    <h4 class="text-danger">THÔNG TIN SẢN PHẨM</h4>

    <form action="${pageContext.request.contextPath}/admin/product/${isEdit ? 'update' : 'create'}"
          method="post">

        <div class="mb-2">
            <label>Mã sản phẩm</label>
            <input type="text" name="productId"
                   value="${product.productId}"
                   class="form-control"
            ${isEdit ? "readonly" : ""} required>
        </div>

        <div class="mb-2">
            <label>Tên sản phẩm</label>
            <input type="text" name="productName"
                   value="${product.productName}"
                   class="form-control" required>
        </div>
    
        <div class="mb-2">
            <label>Thương hiệu</label>
            <input type="text" name="brand"
                   value="${product.brand}"
                   class="form-control">
        </div>

        <div class="mb-2">
            <label>Mô tả</label>
            <textarea name="description"
                      class="form-control">${product.description}</textarea>
        </div>

        <div class="mb-2">
            <label>Hình ảnh</label>
            <input type="text" name="image"
                   value="${product.image}"
                   class="form-control">
        </div>

        <div class="mb-2">
            <label>Ngày tạo</label>
            <input type="text"
                   value="${product.createdAt}"
                   class="form-control" readonly>
        </div>

        <button class="btn btn-primary">
            ${isEdit ? "Cập nhật" : "Thêm mới"}
        </button>

        <c:if test="${isEdit}">
            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.productId}"
               onclick="return confirm('Xóa sản phẩm?')"
               class="btn btn-danger">Xóa</a>
        </c:if>

        <a href="${pageContext.request.contextPath}/admin/product/reset"
           class="btn btn-secondary">Mới</a>
    </form>

    <hr>

    <!-- ===== TABLE PRODUCT ===== -->
    <h5>DANH SÁCH SẢN PHẨM</h5>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Brand</th>
            <th>Mô tả</th>
            <th>Hình</th>
            <th>Ngày tạo</th>
            <th>Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.productId}</td>
                <td>${p.productName}</td>
                <td>${p.brand}</td>
                <td>${p.description}</td>
                <td>${p.image}</td>
                <td>${p.createdAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/product/edit/${p.productId}"
                       class="btn btn-sm btn-warning">Sửa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- ===== CHỈ HIỂN THỊ KHI EDIT PRODUCT ===== -->
    <c:if test="${isEdit}">

        <hr>

        <!-- ===== FORM PRODUCT DETAIL ===== -->
        <h5 class="text-danger">CHI TIẾT SẢN PHẨM</h5>

        <form action="${pageContext.request.contextPath}/admin/productDetail/create"
              method="post" class="mb-3">

            <!-- Khóa ngoại Product -->
            <input type="hidden" name="productId"
                   value="${product.productId}">

            <div class="row g-3">

                <div class="col">
                    <input name="size" class="form-control" placeholder="Size" required>
                </div>

                <div class="col">
                    <input name="color" class="form-control" placeholder="Màu" required>
                </div>

                <div class="col">
                    <input type="number" name="price" class="form-control" placeholder="Giá" required>
                </div>

                <div class="col">
                    <input type="number" name="quantity" class="form-control" placeholder="Số lượng" required>
                </div>

                <div class="col">
                    <select name="status" class="form-select">
                        <option value="Còn hàng">Còn hàng</option>
                        <option value="Hết hàng">Hết hàng</option>
                    </select>
                </div>

                <div class="col">
                    <button class="btn btn-success w-100">Thêm</button>
                </div>

            </div>
        </form>


    </c:if>

</div>

<jsp:include page="FooterAdmin.jsp"/>
</body>
</html>
