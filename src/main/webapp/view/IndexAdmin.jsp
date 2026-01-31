`          <%@ page contentType="text/html; charset=UTF-8" language="java" %>
          <!DOCTYPE html>
          <html lang="vi">
          <head>
            <meta charset="UTF-8">
            <title>Trang chủ</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
          </head>
          <body class="d-flex flex-column min-vh-100 bg-white pt-5">

          <jsp:include page="MenuAdmin.jsp"/>

          <main class="container my-4 flex-fill">

            <h4 class="mb-4 fw-semibold">BẢNG THỐNG KÊ HỆ THỐNG</h4>

            <div class="row g-4">

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-users fs-4 text-primary"></i>
                    <h6 class="text-muted mt-2">NGƯỜI DÙNG</h6>
                    <h3>${users}</h3>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-layer-group fs-4 text-success"></i>
                    <h6 class="text-muted mt-2">DANH MỤC</h6>
                    <h3>${categories}</h3>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-shirt fs-4 text-warning"></i>
                    <h6 class="text-muted mt-2">SẢN PHẨM</h6>
                    <h3>${products}</h3>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-box fs-4 text-info"></i>
                    <h6 class="text-muted mt-2">BIẾN THỂ</h6>
                    <h3>${productDetails}</h3>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-receipt fs-4 text-danger"></i>
                    <h6 class="text-muted mt-2">ĐƠN HÀNG</h6>
                    <h3>${orders}</h3>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="card shadow-sm border-0">
                  <div class="card-body">
                    <i class="fa-solid fa-money-bill-wave fs-4 text-success"></i>
                    <h6 class="text-muted mt-2">DOANH THU</h6>
                    <h3>${revenue} ₫</h3>
                  </div>
                </div>
              </div>

            </div>

          </main>



          <jsp:include page="FooterAdmin.jsp"/>

          </body>
          </html>
`