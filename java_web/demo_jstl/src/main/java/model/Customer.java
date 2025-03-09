package model;

public class Customer {
    private String name;
    private String birthDate;
    private String address;
    private String imageUrl;

    public Customer(String name, String birthDate, String address, String imageUrl) {
        this.name = name;
        this.birthDate = birthDate;
        this.address = address;
        this.imageUrl = imageUrl;
    }

    public String getName() { return name; }
    public String getBirthDate() { return birthDate; }
    public String getAddress() { return address; }
    public String getImageUrl() { return imageUrl; }
}
