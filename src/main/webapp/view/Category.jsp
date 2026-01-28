<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý danh mục</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .page-title {
      color: #2a5298;
      font-weight: 700;
      margin-bottom: 20px;
    }
    .section-title {
      color: #2a5298;
      font-weight: 700;
      text-transform: uppercase;
    }
    .card {
      border-radius: 12px;
    }
    .form-control {
      border-radius: 10px;
      height: 44px;
    }
    .btn-action {
      border-radius: 8px;
      padding: 8px 16px;
      width: 140px;
      font-weight: 500;
    }
    .table thead {
      background-color: #2a5298;
      color: #fff;
    }
    .table tbody tr {
      cursor: pointer;
    }
    .table tbody tr:hover {
      background-color: #eef3ff;
    }
    .search-btn {
      height: 44px;
      border-radius: 10px;
      white-space: nowrap;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100 bg-white pt-5">

<jsp:include page="MenuAdmin.jsp"/>

<main class="container my-4 flex-fill">
  <c:url var="url" value="/category"/>

  <!-- FORM -->
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h4 class="section-title text-center mb-4">THÔNG TIN DANH MỤC</h4>

      <form action="${url}" method="post" id="categoryForm">
        <input type="hidden" name="id" id="fieldId" value="${category.id}">

        <div class="row g-3">
          <div class="col-md-12">
            <label class="form-label fw-bold">Tên danh mục</label>
            <input type="text" name="name" id="fieldName"
                   class="form-control"
                   value="${category.name}">
          </div>

          <div class="col-md-12">
            <label class="form-label fw-bold">Mô tả</label>
            <textarea name="description" id="fieldDesc"
                      class="form-control" rows="5">${category.description}</textarea>
          </div>

          <div class="col-12 mt-4 d-flex gap-2">
            <button type="submit" formaction="${url}/create"
                    class="btn btn-primary btn-action">
              <i class="fa fa-plus"></i> Thêm
            </button>

            <button type="submit" formaction="${url}/update"
                    class="btn btn-warning text-white btn-action">
              <i class="fa fa-pen"></i> Sửa
            </button>

            <button type="submit" formaction="${url}/delete"
                    class="btn btn-danger btn-action">
              <i class="fa fa-trash"></i> Xóa
            </button>

            <button type="submit" formaction="${url}/reset"
                    class="btn btn-success btn-action">
              <i class="fa fa-rotate"></i> Mới
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- SEARCH -->
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <form action="${url}/search" method="get" class="d-flex gap-2">
        <input type="text"
               name="keyword"
               class="form-control flex-grow-1"
               placeholder="Nhập từ khóa tìm kiếm"
               value="${param.keyword}">
        <button type="submit" class="btn btn-primary search-btn px-4">
          Tìm kiếm
        </button>
      </form>
    </div>
  </div>

  <!-- TABLE -->
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h5 class="section-title mb-3">DANH SÁCH DANH MỤC</h5>

      <div class="table-responsive">
        <table class="table table-bordered table-hover text-center align-middle"
               id="categoryTable">
          <thead>
          <tr>
            <th style="width: 10%;">ID</th>
            <th style="width: 30%;">Tên danh mục</th>
            <th style="width: 60%;">Mô tả</th>
          </tr>
          </thead>

          <tbody>
          <c:forEach items="${categories}" var="c">
            <tr onclick="fillForm('${c.id}', '${c.name}', '${c.description}')">
              <td>${c.id}</td>
              <td class="text-start fw-bold text-primary">${c.name}</td>
              <td class="text-start">${c.description}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty categories}">
            <tr>
              <td colspan="3" class="text-muted py-4">
                Chưa có danh mục nào
              </td>
            </tr>
          </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</main>

<jsp:include page="FooterAdmin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function fillForm(id, name, description) {
    document.getElementById("fieldId").value = id
    document.getElementById("fieldName").value = name
    document.getElementById("fieldDesc").value = description
  }
</script>

</body>
</html>
