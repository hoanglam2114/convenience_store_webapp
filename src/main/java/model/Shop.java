/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author pqtru
 */
public class Shop {
    private int shopId;
    private String shopName;
    private String shopAddress;
    private String shopPhone;
    private String shopEmail;
    private String shopOpeningHours;
    private String shopLogo;
    private String map;
    private BigDecimal latitude;
    private BigDecimal longitude;


    public Shop() {
    }

    public Shop(int shopId, String shopName, String shopAddress, String shopPhone, String shopEmail, String shopOpeningHours, String shopLogo) {}

    public Shop(int shopId, String shopName, String shopAddress, String shopPhone, String shopEmail, String shopOpeningHours, String shopLogo,String locationMap,BigDecimal latitude,BigDecimal longitude) {
        this.shopId = shopId;
        this.shopName = shopName;
        this.shopAddress = shopAddress;
        this.shopPhone = shopPhone;
        this.shopEmail = shopEmail;
        this.shopOpeningHours = shopOpeningHours;
        this.shopLogo = shopLogo;
        this.locationMap = locationMap;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Shop(int shopId, String shopName, String shopAddress, String shopPhone, String shopEmail, String shopOpeningHours, String shopLogo, String map) {
        this.shopId = shopId;
        this.shopName = shopName;
        this.shopAddress = shopAddress;
        this.shopPhone = shopPhone;
        this.shopEmail = shopEmail;
        this.shopOpeningHours = shopOpeningHours;
        this.shopLogo = shopLogo;
        this.map = map;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getShopAddress() {
        return shopAddress;
    }

    public void setShopAddress(String shopAddress) {
        this.shopAddress = shopAddress;
    }

    public String getShopPhone() {
        return shopPhone;
    }

    public void setShopPhone(String shopPhone) {
        this.shopPhone = shopPhone;
    }

    public String getShopEmail() {
        return shopEmail;
    }

    public void setShopEmail(String shopEmail) {
        this.shopEmail = shopEmail;
    }

    public String getShopOpeningHours() {
        return shopOpeningHours;
    }
    public void setShopOpeningHours(String shopOpeningHours) {
        this.shopOpeningHours = shopOpeningHours;
    }

    public String getShopLogo() {
        return shopLogo;
    }

    public void setShopLogo(String shopLogo) {
        this.shopLogo = shopLogo;
    }

    public String getLocationMap() {
        return locationMap;
    }
    public void setLocationMap(String locationMap) {
        this.locationMap = locationMap;
    }
    public BigDecimal getLatitude() {
        return latitude;
    }
    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }
    public BigDecimal getLongitude() {
        return longitude;
    }
    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public String getMap() {
        return map;
    }

    public void setMap(String map) {
        this.map = map;
    }

     @Override
    public String toString() {
        return "Shop{" + "shopId=" + shopId + ", shopName=" + shopName + ", shopAddress=" + shopAddress + ", shopPhone=" + shopPhone + ", shopEmail=" + shopEmail + ", shopOpeningHours=" + shopOpeningHours + ", shopLogo=" + shopLogo + '}';
    }

}
