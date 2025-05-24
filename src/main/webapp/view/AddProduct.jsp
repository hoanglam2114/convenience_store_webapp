<!-- Add Product Form (English) - Sneat Template Compatible -->

 <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Add Product</title>

        <link rel="stylesheet" href="../assets/vendor/css/core.css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
    </head>












<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h5 class="mb-0">Add Product</h5>
    <a href="ProductList.jsp" class="btn btn-info"><i class="bx bx-arrow-back me-1"></i> Back to Product List</a>
  </div>
  <div class="card-body">
    <form>
      <div class="row mb-3">
        <div class="col-md-6">
          <label for="productType" class="form-label">Product Type</label>
          <select class="form-select" id="productType">
            <option selected>Fresh Food</option>
            <option>Dry Goods</option>
            <option>Beverages</option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="barcode" class="form-label">Barcode <span class="text-danger">*</span></label>
          <input type="text" class="form-control" id="barcode" placeholder="Enter product barcode" required />
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="productName" class="form-label">Product Name</label>
          <input type="text" class="form-control" id="productName" placeholder="Enter product name" />
        </div>
        <div class="col-md-6">
          <label for="unit" class="form-label">Unit <span class="text-danger">*</span></label>
          <select class="form-select" id="unit">
            <option selected>Pack</option>
            <option>Box</option>
            <option>Kg</option>
          </select>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
          <input type="number" class="form-control" id="price" placeholder="Enter product price" required />
        </div>
        <div class="col-md-6">
          <label for="supplier" class="form-label">Supplier <span class="text-danger">*</span></label>
          <select class="form-select" id="supplier">
            <option selected>Coca-Cola Ltd</option>
            <option>PepsiCo</option>
            <option>Nestle</option>
          </select>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="manufactureDate" class="form-label">Manufacture Date</label>
          <input type="date" class="form-control" id="manufactureDate" />
        </div>
        <div class="col-md-6">
          <label for="expiryDate" class="form-label">Expiry Date</label>
          <input type="date" class="form-control" id="expiryDate" />
        </div>
      </div>

      <div class="mb-3">
        <label for="productImage" class="form-label">Product Image</label>
        <input class="form-control" type="file" id="productImage" />
      </div>

      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">Add Product</button>
        <button type="reset" class="btn btn-secondary">Reset</button>
      </div>
    </form>
  </div>
</div>
