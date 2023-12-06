<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Mo n' Gav's</title>
 <link rel="stylesheet" type="text/css" href="ListProd.css">
</head>
<body>

<h1 align="center">Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp" class="centered-form">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
<form method="get" action="listprod.jsp" class="centered-form">
    <label for="category">Select Category:</label>
    <select name="category" id="category">
        <option value="">All Categories</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
    </select>
    <input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("category");

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";


try(
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
){
	ResultSet rst;
	
	if(name != null){
	    PreparedStatement query = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%?%'");
	    query.setString(1, name);
		//String q = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%" + name + "%'";
		rst = query.executeQuery();

		%> <h1>Products containing '<%= name %>'</h1> 

	<tr>
		<table>
			<thead>
				<th></th>
				<th>Product Name</th>
				<th>Price</th>
			</thead>
	</tr>
	<%
	}else if(category != null && !category.equals("")){
	    PreparedStatement query = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE categoryId = ?");   //update the db
	    query.setString(1, category);
	    rst = query.executeQuery();

    		%> <h1 align = "center">All Products </h1>

    	<tr>
    		<table>
    			<thead>
    				<th></th>
    				<th>Product Name</th>
    				<th>Price</th>
    			</thead>
    	</tr>
    	<%
	}else{
		rst = stmt.executeQuery("SELECT productId, productName, productPrice FROM product;");
		%> <h1 align = "center">All Products </h1>

	<tr>
		<table>
			<thead>
				<th></th>
				<th>Product Name</th>
				<th>Price</th>
			</thead>
	</tr>
	<%
	}
	while (rst.next()) {
		String pId = rst.getString("productId");
		String pName = rst.getString("productName");
		double pPrice = rst.getDouble("productPrice");

		//addcart.jsp?id=productId&name=productName&price=productPrice;
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		String addCartURL = "addcart.jsp?id="+pId+"&name="+URLEncoder.encode(pName, "UTF-8")+"&price="+pPrice+"&action=add";
		String productDetailsURL = "product.jsp?id=" + pId;
		%>
		<tr>
			<td> <a href = "<%= addCartURL %>" > Add To Cart</a> </td>
			<td> <a href = "<%= productDetailsURL %>" ><%= pName %></a></td>
			<td><%= currFormat.format(pPrice) %></td>
		</tr>
		<%
	}
}	
catch(SQLException ex){
	out.println(ex);

}
%>

</body>
</html>