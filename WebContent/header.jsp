<%@ include file="auth.jsp" %>
<head>
    <link rel="stylesheet" type="text/css" href="Header.css">
</head>
<div class="header">
    <div class="left-links">
        <a href="index.jsp">Home</a>
        <a href="listprod.jsp">Products</a>
        <a href="showcart.jsp">Cart</a>
    </div>

    <div class="right-links">
        <% if(authenticated){
            String userName = (String) session.getAttribute("authenticatedUser");
        %>
            <div class="user-info">
                <h3 class="user-name">Signed in as <%= userName %></h3>
                <a href="logout.jsp">Logout</a>
            </div>
        <% } else { %>
            <a class="login-link" href="login.jsp">Login</a>
        <% } %>
    </div>

    <div class="clear"></div>

    <hr>
</div>




