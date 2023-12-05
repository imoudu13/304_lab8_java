<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("customerId");
    String pw = request.getParameter("password");
    try{
        getConnection();

        PreparedStatement pst = con.prepareStatement("UPDATE customer SET password = ? WHERE customerId = ?");

        pst.setString(1, pw);
        pst.setInt(2, Integer.parseInt(customerId));

        pst.executeUpdate();
    }catch(SQLException exe){
        out.println(exe);
    }
%>

<h1 align="center">Your password has been updated</h1>