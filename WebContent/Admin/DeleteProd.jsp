<%@ include file="header.jsp" %>

<html>
<head>
    <title>Delete Product</title>
</head>
<body>


    <form action="UpdateDB.jsp" method="post">
        <label for="pName">Product Id:</label>
        <input type="text" id="pName" name="prodId" required><br>

        <input type="hidden" name="updateDB" value="delete">

        <input type="submit" value="Delete">
    </form>
</body>
</html>