<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("customerId");
%>

<html>
<head>
    <title>Update Information</title>
    <style>
            form{
                max-width: 400px;
                margin: 0 auto;
                margin-top: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
    </style>
</head>
<body>
    <form action="UpdateAddress.jsp" method="post">
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>

        <label for="city">City:</label>
        <input type="text" id="city" name="city" required><br>

        <label for="state">State:</label>
        <input type="text" id="state" name="state" required><br>

        <label for="postalCode">Postal Code:</label>
        <input type="text" id="postalCode" name="postalCode" required><br>

        <label for="country">Country:</label>
        <input type="text" id="country" name="country" required><br>

         <input type="hidden" name="customerId" value="<%= customerId %>">

        <input type="submit" value="update">
    </form>
</body>
</html>