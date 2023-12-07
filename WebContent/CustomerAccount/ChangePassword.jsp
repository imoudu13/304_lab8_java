<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("customerId");
%>

<html>
<head>
    <title>Change Password</title>
    <style>
            form{
                max-width: 400px;
                margin: 0 auto;
                margin-top: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
    </style>
</head>
<body>
    <form action="UpdatePW.jsp" method="post">

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <input type="hidden" name="customerId" value="<%= customerId %>">

        <input type="submit" value="update">
    </form>
</body>
</html>