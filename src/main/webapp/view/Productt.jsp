<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý sản phẩm</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .page-title {
      color: #2a5298;
      font-weight: 700;
      margin-bottom: 20px;
    }
    .card {
      border-radius: 12px;
    }
    .form-control, .form-select {
      border-radius: 8px;
    }
    .btn {
      border-radius: 8px;
      padding: 8px 18px;
    }
    .table thead {
      background-color: #2a5298;
      color: #fff;
    }
    .table tbody tr:hover {
      background-color: #eef3ff;
    }
    img.product-img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 8px;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100 bg-white pt-5">

<jsp:include page="MenuAdmin.jsp"/>

<main class="container my-4 flex-fill">
  <c:url var="url" value="/admin/product"/>
  <br>

  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h4 class="page-title text-center">Thông tin sản phẩm</h4>

      <form action="${url}" method="post" enctype="multipart/form-data"
            id="productForm" novalidate>
        <div class="row g-3">

          <c:if test="${isEdit}">
            <div class="col-md-4">
              <label class="form-label">Mã sản phẩm</label>
              <input type="text" name="productId"
                     class="form-control"
                     value="${product.productId}" readonly>
            </div>
          </c:if>

          <div class="col-md-6">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" name="productName"
                   class="form-control"
                   value="${product.productName}" required>
            <div class="invalid-feedback">Vui lòng nhập tên sản phẩm</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Danh mục</label>
            <select name="categoryId" class="form-select" required>
              <option value="">-- Chọn danh mục --</option>
              <c:forEach items="${categories}" var="c">
                <option value="${c.categoryId}"
                  ${product.category.categoryId == c.categoryId ? 'selected' : ''}>
                    ${c.categoryName}
                </option>
              </c:forEach>
            </select>
            <div class="invalid-feedback">Vui lòng chọn danh mục</div>
          </div>

          <div class="col-md-12">
            <label class="form-label">Mô tả</label>
            <textarea name="description" rows="3"
                      class="form-control">${product.description}</textarea>
          </div>

          <div class="col-md-3">
            <label class="form-label">Size</label>
            <input type="text" name="size"
                   class="form-control"
                   value="${detail.size}" required>
          </div>

          <div class="col-md-3">
            <label class="form-label">Màu sắc</label>
            <input type="text" name="color"
                   class="form-control"
                   value="${detail.color}" required>
          </div>

          <div class="col-md-3">
            <label class="form-label">Giá</label>
            <input type="number" step="0.01" name="price"
                   class="form-control"
                   value="${detail.price}" required>
          </div>

          <div class="col-md-3">
            <label class="form-label">Số lượng</label>
            <input type="number" name="quantity"
                   class="form-control"
                   value="${detail.quantity}" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Hình ảnh</label>
            <input type="file" name="image" class="form-control">
          </div>

          <div class="col-md-6">
            <label class="form-label">Trạng thái</label>
            <select name="status" class="form-select">
              <option value="ACTIVE" ${detail.status == 'ACTIVE' ? 'selected' : ''}>Đang bán</option>
              <option value="INACTIVE" ${detail.status == 'INACTIVE' ? 'selected' : ''}>Ngừng bán</option>
            </select>
          </div>

          <div class="text-center mt-4">
            <button type="submit" formaction="${url}/create" class="btn btn-primary me-2">
              <i class="fa fa-plus"></i> Thêm
            </button>

            <button type="submit" formaction="${url}/update" class="btn btn-warning me-2">
              <i class="fa fa-pen"></i> Sửa
            </button>

            <button type="submit" formaction="${url}/delete"
                    class="btn btn-danger me-2"
                    onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
              <i class="fa fa-trash"></i> Xóa
            </button>

            <button type="submit" formaction="${url}/reset" class="btn btn-success">
              <i class="fa fa-rotate"></i> Mới
            </button>
          </div>

        </div>
      </form>
    </div>
  </div>

  <form action="${url}/search" method="get" class="d-flex mb-3">
    <input type="text" name="keyword"
           class="form-control w-25 me-2"
           placeholder="Nhập tên sản phẩm">
    <button class="btn btn-primary">
      <i class="fa fa-search"></i> Tìm kiếm
    </button>
  </form>

  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h5 class="page-title">Danh sách sản phẩm</h5>

      <table class="table table-bordered table-hover text-center align-middle">
        <thead>
        <tr>
          <th>Mã</th>
          <th>Tên</th>
          <th>Danh mục</th>
          <th>Size</th>
          <th>Màu</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Hình ảnh</th>
          <th>Trạng thái</th>
          <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${products}" var="p">
          <tr>
            <td>${p.productId}</td>
            <td>${p.productName}</td>
            <td>${p.category.categoryName}</td>
            <td>${p.size}</td>
            <td>${p.color}</td>
            <td>${p.price}</td>
            <td>${p.quantity}</td>
            <td>
              <img src="${pageContext.request.contextPath}/images/${p.image}"
                   class="product-img">
            </td>
            <td>
              <span class="badge ${p.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">
                  ${p.status == 'ACTIVE' ? 'Đang bán' : 'Ngừng bán'}
              </span>
            </td>
            <td>
              <a href="${url}/edit?id=${p.productId}">
                <i class="fa fa-pen"></i> Sửa
              </a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</main>

<jsp:include page="FooterAdmin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const form = document.getElementById("productForm");
  const buttons = document.querySelectorAll("button[formaction]");

  buttons.forEach(btn => {
    btn.addEventListener("click", e => {
      const action = btn.getAttribute("formaction");
      const needValidate =
              action.endsWith("/create") || action.endsWith("/update");

      if (needValidate) {
        form.classList.add("was-validated");
        if (!form.checkValidity()) {
          e.preventDefault();
          e.stopPropagation();
        }
      } else {
        form.classList.remove("was-validated");
      }
    });
  });
</script>

</body>
</html>
