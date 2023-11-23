<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Mo n' Gav's</title>
 <link rel="stylesheet" type="text/css" href="ListProd.css">
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>
<style>
    form {
      margin: 20px;
      font-family: Arial, sans-serif;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px;
      box-sizing: border-box;
      margin-bottom: 10px;
    }

    input[type="submit"], input[type="reset"] {
      padding: 10px 15px;
      background-color: #4caf50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      margin-right: 10px;
    }

    input[type="reset"] {
      background-color: #f44336;
    }


    .additional-text {
      color: #fff;
      font-style: italic;
      font-size: 0.9em;
    }
  </style>
<% // Get product name to search for
String name = request.getParameter("productName");
		
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
		String q = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%" + name + "%'";
		rst = stmt.executeQuery(q);
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
// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00

%>

</body>
</html>