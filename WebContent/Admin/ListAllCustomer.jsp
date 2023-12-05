<%@ page import="java.text.NumberFormat" %>
<%@ include file="..\jdbc.jsp" %>
<%@ include file="header.jsp" %>


<%
try{
    getConnection();

    PreparedStatement pst = con.prepareStatement("SELECT firstname, lastname, customerId FROM customer;");

    ResultSet rst = pst.executeQuery();
    out.println("<table border='1'>");
    out.println("<tr><th>Name</th><th>Customer Id</th></tr>");

    while(rst.next()){
        out.println("<tr><td>" + rst.getString("firstname") + " " + rst.getString("lastname") + "</td><td>" + rst.getInt("customerId") + "</td></tr>");
    }
    rst.close();
}catch(SQLException ex){
    out.println(ex);
}

%>