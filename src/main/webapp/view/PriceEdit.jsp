<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Edit Product Price</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">

  <div class="container">
    <div class="card shadow-sm rounded-3">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Edit Product Price</h5>
        <a href="ListProduct" class="btn btn-info text-white">
          <i class="bx bx-arrow-back me-1"></i> Back to Product List
        </a>
      </div>

      <div class="card-body">
        <form>
          <div class="row g-3 align-items-center">
            <div class="col-md-6">
              <label for="productName" class="form-label fw-bold">Product Name</label>
              <input type="text" id="productName" class="form-control bg-light" value="Coca-Cola" disabled />
            </div>

            <div class="col-md-6">
              <label for="newPrice" class="form-label fw-bold">New Price</label>
              <input type="number" id="newPrice" class="form-control" value="10000.0" />
            </div>
          </div>

          <div class="mt-4">
            <button type="submit" class="btn btn-primary">
              <i class="bx bx-save me-1"></i> Update Price
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

</body>
</html>

