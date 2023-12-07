<%@ include file="auth.jsp" %>
<head>
<style>
    a:hover {
        text-decoration: underline;
    }
    .header {
        background-color: rgb(255, 0, 0);
        color: #fff;
        padding: 10px;
        box-shadow: 0 0 20px rgb(255, 0, 0);
    }
    .left-link{
        margin-right: 15px;
    }
    .left-links a {
        color: #ffffff;
        text-decoration: none;
        float: left;
        margin-right: 10px;
    }
    .right-links {
        color: #ffffff;
        text-decoration: none;
        margin-right: 15px;
        float: right;
    }
    .user-info {
        color: #ffffff;
        margin-left: 10px;
        display: flex;
        align-items: center;
    }
    .user-name {
        color: #ffffff;
        margin-right: 10px;
    }
    .login-link {
        color: #ffffff;
        margin-left: 10px;
    }
    hr {
        border: none;
        border-top: 1px solid #ddd;
        margin: 10px 0;
    }
    .clear {
        clear: both;
    }
</style>
</head>

<div class="header">
    <!-- Left-aligned links -->
    <div class="left-links">
        <a href="..\index.jsp">Home</a>
        <a href="..\listprod.jsp">Products</a>
        <a href="..\showcart.jsp">Cart</a>
    </div>

    <!-- Right-aligned link -->

    <div class="right-links">
        <%if(authenticated){
            String userName = (String) session.getAttribute("authenticatedUser");%>
            <div class="user-info">
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



