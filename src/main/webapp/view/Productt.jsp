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
    .page-title { color:#2a5298;font-weight:700 }
    .card { border-radius:12px }
    .form-control,.form-select,.btn { border-radius:8px }
    .table thead { background:#2a5298;color:#fff }
    img.product-img { width:60px;height:60px;object-fit:cover;border-radius:8px }
  </style>
</head>

<body class="bg-light pt-5">
<jsp:include page="MenuAdmin.jsp"/>

<main class="container my-4">
  <c:url var="url" value="/admin/product"/>
  <div class="card shadow mb-4">
    <div class="card-body">
      <h4 class="page-title text-center mb-3">Thông tin sản phẩm</h4>

      <form method="post" enctype="multipart/form-data">

        <c:if test="${isEdit}">
          <div class="mb-3">
            <label class="form-label">Mã sản phẩm</label>
            <input class="form-control" readonly value="${product.productId}">
            <input type="hidden" name="productId" value="${product.productId}">
          </div>
        </c:if>

        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Tên sản phẩm</label>
            <input name="productName"
                   value="${product.productName}"
                   class="form-control ${not empty errorProductName?'is-invalid':''}">
            <div class="invalid-feedback">${errorProductName}</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Danh mục</label>
            <select name="categoryId"
                    class="form-select ${not empty errorCategory?'is-invalid':''}">
              <option value="">-- Chọn danh mục --</option>
              <c:forEach items="${categories}" var="c">
                <option value="${c.categoryId}"
                  ${product.category.categoryId==c.categoryId?'selected':''}>
                    ${c.categoryName}
                </option>
              </c:forEach>
            </select>
            <div class="invalid-feedback">${errorCategory}</div>
          </div>

          <div class="col-md-12">
            <label class="form-label">Mô tả</label>
            <textarea name="description" class="form-control"
                      rows="3">${product.description}</textarea>
          </div>

          <div class="col-md-3">
            <label class="form-label">Size</label>
            <select name="size"
                    class="form-select ${not empty errorSize?'is-invalid':''}">
              <option value="">-- Chọn --</option>
              <c:forEach var="s" items="${['S','M','L','XL','XXL']}">
                <option value="${s}" ${detail.size==s?'selected':''}>${s}</option>
              </c:forEach>
            </select>
            <div class="invalid-feedback">${errorSize}</div>
          </div>

          <div class="col-md-3">
            <label class="form-label">Màu sắc</label>
            <select name="color"
                    class="form-select ${not empty errorColor?'is-invalid':''}">
              <option value="">-- Chọn --</option>
              <c:forEach var="c" items="${['Đen','Trắng','Đỏ','Xanh','Vàng','Xám']}">
                <option value="${c}" ${detail.color==c?'selected':''}>${c}</option>
              </c:forEach>
            </select>
            <div class="invalid-feedback">${errorColor}</div>
          </div>

          <div class="col-md-3">
            <label class="form-label">Giá</label>
            <input type="number" step="0.01"
                   name="price"
                   value="${detail.price}"
                   class="form-control ${not empty errorPrice?'is-invalid':''}">
            <div class="invalid-feedback">${errorPrice}</div>
          </div>

          <div class="col-md-3">
            <label class="form-label">Số lượng</label>
            <input type="number"
                   name="quantity"
                   value="${detail.quantity}"
                   class="form-control ${not empty errorQuantity?'is-invalid':''}">
            <div class="invalid-feedback">${errorQuantity}</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Hình ảnh</label>
            <input type="file" name="image" class="form-control">
          </div>

          <div class="col-md-6">
            <label class="form-label">Trạng thái</label>
            <select name="status" class="form-select">
              <option value="">-- Chọn --</option>
              <option value="ACTIVE" ${detail.status=='ACTIVE'?'selected':''}>Đang bán</option>
              <option value="INACTIVE" ${detail.status=='INACTIVE'?'selected':''}>Ngừng bán</option>
            </select>
          </div>
        </div>

        <div class="text-center mt-4">
          <button formaction="${url}/create" class="btn btn-primary">
              <i class="fa fa-plus"></i> Thêm
          </button>

          <button formaction="${url}/update" class="btn btn-warning me-2">
            <i class="fa fa-pen"></i> Sửa
          </button>

          <button formaction="${url}/delete" onclick="return confirm('Xóa sản phẩm?')"
                  class="btn btn-danger me-2">
            <i class="fa fa-trash"></i> Xóa
          </button>

          <button formaction="${url}/reset" class="btn btn-success">
            <i class="fa fa-rotate"></i> Mới
          </button>
        </div>

      </form>
    </div>
  </div>

  <form action="${url}/search" class="d-flex mb-3">
    <input name="keyword" class="form-control w-25 me-2" placeholder="Tên sản phẩm, giá, danh mục">
    <button class="btn btn-primary"><i class="fa fa-search"></i> Tìm kiếm
    </button>
  </form>

  <div class="card shadow">
    <div class="card-body">
      <h5 class="page-title mb-3">Danh sách sản phẩm</h5>

      <table class="table table-bordered table-hover text-center align-middle">
        <thead>
        <tr>
          <th>Mã</th>
          <th>Tên</th>
          <th>Danh mục</th>
          <th>Size</th>
          <th>Màu</th>
          <th>Giá</th>
          <th>SL</th>
          <th>Ảnh</th>
          <th>Trạng thái</th>
          <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${products}" var="p">
          <c:if test="${not empty p.productDetails}">
            <c:set var="d" value="${p.productDetails[0]}"/>
            <tr>
              <td>${p.productId}</td>
              <td>${p.productName}</td>
              <td>${p.category.categoryName}</td>
              <td>${d.size}</td>
              <td>${d.color}</td>
              <td>${d.price}</td>
              <td>${d.quantity}</td>
              <td>
                <img src="${pageContext.request.contextPath}/images/${d.image}" class="product-img">
              </td>
              <td>
                <span class="badge ${d.status=='ACTIVE'?'bg-success':'bg-danger'}">
                    ${d.status=='ACTIVE'?'Đang bán':'Ngừng bán'}
                </span>
              </td>
              <td>
                <a href="${url}/edit?id=${p.productId}"
                   class="btn btn-sm btn-outline-warning">
                  <i class="fa fa-pen"></i> Sửa
                </a>
              </td>
            </tr>
          </c:if>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</main>
<jsp:include page="FooterAdmin.jsp"/>
</body>
</html>
