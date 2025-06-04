function confirmDelete(customerId) {
  if (confirm("Bạn có chắc chắn muốn khách hàng này?")) {
    window.location.href = "deleteCustomer?id=" + customerId;
  }
}


