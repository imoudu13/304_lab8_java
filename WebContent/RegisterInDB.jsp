<%@ include file="header.jsp" %>
<%@include file="jdbc.jsp" %>

<%
String first = request.getParameter("firstName");
String last = request.getParameter("lastName");
String email = request.getParameter("email");
String phoneNum = request.getParameter("phonenum");
String addy = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalCode = request.getParameter("postalCode");
String country = request.getParameter("country");
String userid = request.getParameter("userid");
String pw = request.getParameter("password");

	try{
	    getConnection();
	    PreparedStatement pst = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
	    pst.setString(1, first);
	    pst.setString(2, last);
	    pst.setString(3, email);
	    pst.setString(4, phoneNum);
	    pst.setString(5, addy);
	    pst.setString(6, city);
	    pst.setString(7, state);
	    pst.setString(8, postalCode);
	    pst.setString(9, country);
	    pst.setString(10, userid);
	    pst.setString(11, pw);

	    pst.executeUpdate();

	}catch(SQLException ex){
	    out.println(ex);
	}

	request.setAttribute("username", userid);
    request.setAttribute("password", pw);
    response.sendRedirect("validateLogin.jsp");

%>

