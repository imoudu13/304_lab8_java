<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

<%

// TODO: Write SQL query that prints out total order amount by day

NumberFormat currFormat = NumberFormat.getCurrencyInstance();       //object for formatting doubles as currency
String isAdmin = isArnold;


if(isAdmin.equals("arnold")){
    try{
        getConnection();

        out.println("<table border='1'>");
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

</body>
</html>

