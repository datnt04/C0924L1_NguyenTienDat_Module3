<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Discount Calculation Result</title>
</head>
<body>
<%
    String description = (String) request.getAttribute("description");
    double listPrice = (double) request.getAttribute("listPrice");
    double discountPercent = (double) request.getAttribute("discountPercent");
    double discountAmount = (double) request.getAttribute("discountAmount");
%>

<p><strong>Product Description:</strong> <%= description %></p>
<p><strong>List Price:</strong> $<%= listPrice %></p>
<p><strong>Discount Percent:</strong> <%= discountPercent %>%</p>
<p><strong>Discount Amount:</strong> $<%= discountAmount %></p>

</body>
</html>

