<%
	boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;
	String isArnold = authenticated ? session.getAttribute("authenticatedUser").toString() : "";

	if (!authenticated)
	{
	    String customerOrAdmin = "";
	    if(request.getRequestURL().toString().equals("http://localhost/shop/customer.jsp")){
	        customerOrAdmin = " Please log in to view customer information";
	    }else{
	        customerOrAdmin = " Please log in as 'arnold' to view Administrator information";
	    }

		String loginMessage = "You have not been authorized. "+ customerOrAdmin;
        session.setAttribute("loginMessage",loginMessage);        
		response.sendRedirect("login.jsp");
	}
%>
