<%@ include file="header.jsp" %>

<html>
<head>
    <title>Delete Product</title>
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


    <form action="UpdateDB.jsp" method="post">
        <label for="pName">Product Id:</label>
        <input type="text" id="pName" name="prodId" required><br>

        <input type="hidden" name="updateDB" value="delete">

        <input type="submit" value="Delete">
    </form>
</body>
</html>