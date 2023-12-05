<%@ include file="header.jsp" %>

<html>
<head>
    <title>Add Product</title>
</head>
<body>


    <form action="UpdateDB.jsp" method="post">
        <label for="pName">Product Name:</label>
        <input type="text" id="pName" name="productname" required><br>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price" required><br>

        <label for="desc">Product Description:</label>
        <input type="text" id="desc" name="desc" required><br>

        <label for="category">Category:</label>

        <select id="category" name="catId" required>
            <option value="1">Category 1</option>
            <option value="2">Category 2</option>
            <option value="3">Category 3</option>
        </select><br>

        <input type="hidden" name="updateDB" value="add">

        <input type="submit" value="Register">
    </form>
</body>
</html>
