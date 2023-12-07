<%@ include file="header.jsp" %>

<html>
<head>
    <title>Add Product</title>
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

        <input type="submit" value="Add Product">
    </form>
</body>
</html>
