<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%

	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
try{
        //connect to db
        getConnection();

        //prepare the query
        PreparedStatement pst = con.prepareStatement("SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country FROM customer WHERE userid = ?;");
        pst.setString(1, userName);     //put the actual userName in the query

        //execute query
        ResultSet rs = pst.executeQuery();
        rs.next();      //go to the one row


        //extract all required variable from result set
        String cid = rs.getString("customerId");
        String fName = rs.getString("firstName");
        String lName = rs.getString("lastName");
        String email = rs.getString("email");
        String pNum = rs.getString("phonenum");
        String addy = rs.getString("address");
        String city = rs.getString("city");
        String state = rs.getString("state");
        String pCode = rs.getString("postalCode");
        String country = rs.getString("country");

        //print the table
%>
        <table border='1'>
        <tr><th>ID</th><td><%= cid %></td></tr>
        <tr><th>First Name</th><td><%= fName %></td></tr>
        <tr><th>Last Name</th><td><%= lName %></td></tr>
         <tr><th>Email</th><td><%= email %></td></tr>
        <tr><th>Phone Number</th><td><%= pNum %></td></tr>
        <tr><th>Address</th><td><%= addy %></td></tr>
        <tr><th>City</th><td><%= city %></td></tr>
        <tr><th>State</th><td><%= state %></td></tr>
        <tr><th>Postal Code</th><td><%= pCode %></td></tr>
        <tr><th>Country</th><td><%= country %></td></tr>
        <tr><th>User id</th><td><%= userName %></td></tr>
        </table>"

<%
        //close everything
        rs.close();
}catch(SQLException ex){
        out.println(ex);
}finally{
        closeConnection();
}
%>

</body>
</html>

