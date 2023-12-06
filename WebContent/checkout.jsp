<%@ include file="header.jsp" %>

<html>
<head>
    <title>Ray's Grocery</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #ffffff;
        color: #333;
    }
    h1{
        color: #ff0000;
    }
    h3{
        color: #ff0000;
    }
    table {
        width: 70%;
        border-collapse: collapse;
        margin: 0 auto;
        color: #ff0000;
    }

    th, td {
        border: 1px solid #ffffff;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #ffffff;
        color: #ff0000;
    }
</style>
</head>
<body>

<h1>Enter your customer id and password to complete the transaction:</h1>

<form method="get" action="order.jsp">
<table>
<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</body>
</html>

