<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
    <h2>Product Discount Calculator</h2>
    <form action="display-discount" method="post">
        <label>Product Description:</label>
        <input type="text" name="description" ><br><br>

        <label>List Price:</label>
        <input type="number" name="listPrice" ><br><br>

        <label>Discount Percent:</label>
        <input type="number" name="discountPercent" ><br><br>

        <button type="submit">Calculate Discount</button>
    </form>
</body>
</html>
