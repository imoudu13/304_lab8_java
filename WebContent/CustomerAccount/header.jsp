<%@ include file="auth.jsp" %>

<div>
    <!-- Left-aligned links -->
    <div style="float: left;">
        <a href="..\index.jsp">Home</a>
        <a href="..\listprod.jsp">Products</a>
        <a href="..\showcart.jsp">Cart</a>
    </div>

    <!-- Right-aligned link -->

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

    <div style="clear: both;"></div> <!-- Clear the float to prevent layout issues -->

    <hr>
</div>

