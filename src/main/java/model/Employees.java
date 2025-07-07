    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package model;

    /**
     *
     * @author lmq02
     */
    public class Employees {
        private int id;
        private String name;
        private String phone;
        private String address;
        private int accountId;

        public Employees(){

        }

        public Employees(String name, String phone, String address) {
            this.name = name;
            this.phone = phone;
            this.address = address;
        }

        public Employees(String name, String phone, String address, int accountId) {
            this.name = name;
            this.phone = phone;
            this.address = address;
            this.accountId = accountId;
        }

        public Employees(int id, String name, String phone, String address) {
            this.id = id;
            this.name = name;
            this.phone = phone;
            this.address = address;
        }

        public Employees(int id, String name, String phone, String address, int accountId) {
            this.id = id;
            this.name = name;
            this.phone = phone;
            this.address = address;
            this.accountId = accountId;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public int getAccountId() {
            return accountId;
        }

        public void setAccountId(int accountId) {
            this.accountId = accountId;
        }

        @Override
        public String toString() {
            return "Employees{" + "id=" + id + ", name=" + name + ", phone=" + phone + ", address=" + address + ", accountId=" + accountId + '}';
        }

    }
