function confirmDelete(empId) {
  if (confirm("Bạn có chắc chắn muốn xóa nhân viên này?")) {
    window.location.href = "deleteEmployee?id=" + empId;
  }
}

