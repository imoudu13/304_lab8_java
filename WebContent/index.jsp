<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
        <title>Sole Flare</title>
        <link rel="stylesheet" type="text/css" href="Index.css">
</head>
<body>
    <h1 id="welcome-heading" align="center">Welcome to Sole Flare</h1>

    <img src="Logo.png" alt="Logo" class="center" width="200" height="400">

    <div id="main-content">

            <%if(authenticated && isArnold.equals("arnold")){%>
                    <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>
                    <h2 align="center"><a href="Admin/admin.jsp">Administrator Page</a></h2>
            <%}else if(authenticated){%>
                    <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>
                    <h2 align="center"><a href="CustomerAccount/customer.jsp">View Your Information</a></h2>
            <%}else{%>
                    <h2><a href="login.jsp">Login</a></h2>
                    <h2><a href="Register.jsp">Create An Account</a></h2>
            <%}%>
    </div>
</body>
<html>

