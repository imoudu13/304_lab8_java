<%@ include file="auth.jsp" %>

<head>
<link rel="stylesheet" type="text/css" href="Header.css">
<div>
    <div style="float: left;">
        <a href="..\index.jsp">Home</a>
        <a href="..\listprod.jsp">Products</a>
        <a href="..\showcart.jsp">Cart</a>
    </div>


    <div style="float: right;">
        <%if(authenticated){
            String userName = (String) session.getAttribute("authenticatedUser");%>
            <div style="display: inline-block;">
                <h3 style="display: inline;">Signed in as <%= userName %></h3>
                <a href="..\logout.jsp">Logout</a>
            </div>
        <%}else{ %>
            <a href="..\login.jsp">Login</a>
        <%}%>
    </div>

    <div style="clear: both;"></div>

    <hr>
</div>

