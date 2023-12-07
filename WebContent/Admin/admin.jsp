<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
    body {
        text-align: center;

    }
    table {
        margin: 0 auto;

    }
    form {
        display: inline-block;
        margin-top: 10px;
    }
    th, td{ color: red; text-align: center; }
</style>
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="..\jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%

// TODO: Write SQL query that prints out total order amount by day

NumberFormat currFormat = NumberFormat.getCurrencyInstance();       //object for formatting doubles as currency
String admin = isAdmin;

//checks is the current user is the admin
if(admin.equals("arnold")){
    try{
        getConnection();

        out.println("<table>");
        out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT CONVERT(varchar, orderDate, 23) AS OrderDateOnly, SUM(totalAmount) AS totalAm FROM ordersummary GROUP BY CONVERT(varchar, orderDate, 23) ORDER BY CONVERT(varchar, orderDate, 23);");

        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("OrderDateOnly") + "</td><td>" + currFormat.format(rs.getDouble("totalAm")) + "</td></tr>");
        }

        rs.close();
        stmt.close();
    }catch(SQLException ex){
        out.println(ex);
    }finally{
        closeConnection();
    }
}else{
    %>
        <h1>You have not been authenticated, please return to the login page.</h1>
        <h1><a href="login.jsp">Log in</a></h1>
    <%
}
%>

        <form action="ListAllCustomer.jsp" method="post">
            <input type="submit" value="List All Customers">
        </form>
        <form action="AddNewProduct.jsp" method="post">
            <input type="hidden" name="updateDB" value="add">
            <input type="submit" value="Add A New product">
        </form>
        <form action="DeleteProd.jsp" method="post">
        <input type="hidden" name="updateDB" value="delete">
            <input type="submit" value="Delete a Product">
        </form>
        <form action="..\loaddata.jsp" method="post">
            <input type="submit" value="Restore Database">
        </form>
</body>
</html>

