<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%@ page import="java.text.NumberFormat" %>


<!DOCTYPE html>
<html>
<head>
<title>Previous Orders</title>
<style>
    body {
    align-items: center;
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


<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String customerId = request.getParameter("customerId");
try{
    getConnection();

    PreparedStatement pst = con.prepareStatement("SELECT orderId, CONVERT(varchar, orderDate, 23) AS OrderDateOnly, totalAmount FROM ordersummary WHERE customerId = ?");
    pst.setInt(1, Integer.parseInt(customerId));

    ResultSet rst = pst.executeQuery();

    out.println("<table>");
    out.println("<tr><th>Order Id</th><th>Order Date</th><th>Total Order Amount</th></tr>");


    while(rst.next()){
        out.println("<tr><td>" + rst.getInt("orderId") + "</td><td>" + rst.getString("OrderDateOnly") + "</td><td>" + currFormat.format(rst.getDouble("totalAmount")) + "</td></tr>");
    }

    rst.close();
}catch(SQLException ex){
    out.println(ex);
}finally{
    closeConnection();
}

%>

</body>
</html>
