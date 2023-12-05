<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("customerId");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");

    try{
        getConnection();

        PreparedStatement pst = con.prepareStatement("UPDATE customer SET address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE customerId = ?");

        pst.setString(1, address);
        pst.setString(2, city);
        pst.setString(3, state);
        pst.setString(4, postalCode);
        pst.setString(5, country);
        pst.setInt(6, Integer.parseInt(customerId));

        pst.executeUpdate();


    }catch(SQLException exe){
        out.println(exe);
    }
%>
<html>
<head>
    <title>Update Address Result</title>
</head>
<body>
    <h1>Updated Address Information</h1>
    <p>Address: <%= address %></p>
    <p>City: <%= city %></p>
    <p>State: <%= state %></p>
    <p>Postal Code: <%= postalCode %></p>
    <p>Country: <%= country %></p>

    <!-- Add additional content or actions as needed -->
</body>
</html>
