package model;

import java.io.Serializable;

public class Customer implements Serializable {
    private String name;
    private String birthDate;
    private String address;
    private String imageUrl;

    public Customer() {
    }

    public Customer(String name, String birthDate, String address, String imageUrl) {
        this.name = name;
        this.birthDate = birthDate;
        this.address = address;
        this.imageUrl = imageUrl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
