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
        .page-title { color:#2a5298; font-weight:700 }
        .card { border-radius:12px }
        .form-control,.btn { border-radius:8px }
        .table thead { background:#2a5298; color:#fff }
        .table tbody tr { vertical-align: middle; }
    </style>
</head>

<body class="bg-light pt-5">
<jsp:include page="MenuAdmin.jsp"/>

<main class="container my-4">
    <c:url var="url" value="/admin/category"/>
    <br/>

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h4 class="page-title text-center mb-3">THÔNG TIN DANH MỤC</h4>

            <form method="post">

                <c:if test="${isEdit}">
                    <input type="hidden" name="categoryId" value="${category.categoryId}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label">
                            Tên danh mục
                        </label>

                        <input name="categoryName"
                               value="${category.categoryName}"
                               class="form-control ${not empty errors.categoryName ? 'is-invalid' : ''}">

                        <div class="invalid-feedback">
                            ${errors.categoryName}
                        </div>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description"
                                  rows="3"
                                  class="form-control">${category.description}</textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button formaction="${url}/create" class="btn btn-primary me-2">
                        <i class="fa fa-plus"></i> Thêm
                    </button>

                    <button formaction="${url}/update" class="btn btn-warning text-white me-2">
                        <i class="fa fa-pen"></i> Sửa
                    </button>

                    <button formaction="${url}/delete"
                            onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')"
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
        <input name="keyword"
               value="${param.keyword}"
               placeholder="Nhập từ khóa"
               class="form-control w-25 me-2 shadow-sm">
        <button class="btn btn-primary">
            <i class="fa fa-search"></i> Tìm kiếm
        </button>
    </form>

    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="page-title mb-3">DANH SÁCH DANH MỤC</h5>

            <table class="table table-bordered table-hover text-center align-middle">
                <thead>
                <tr>
                    <th>Mã danh mục</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th style="width:150px">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${categories}" var="c">
                    <tr>
                        <td>${c.categoryId}</td>
                        <td class="fw-bold text-primary">${c.categoryName}</td>
                        <td>${c.description}</td>
                        <td>
                            <a href="${url}/edit?categoryId=${c.categoryId}"
                               class="btn btn-sm btn-outline-warning">
                                <i class="fa fa-pen"></i> Sửa
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty categories}">
                    <tr>
                        <td colspan="4" class="text-muted py-4">
                            Chưa có danh mục nào
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</main>

<jsp:include page="FooterAdmin.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
