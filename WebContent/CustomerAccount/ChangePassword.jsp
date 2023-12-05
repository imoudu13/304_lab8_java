<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("customerId");
%>

<html>
<head>
    <title>Change Password</title>
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