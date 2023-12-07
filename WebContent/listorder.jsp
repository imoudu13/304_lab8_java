<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mo n' Gav's</title>
    <style>
        h1{ color: red; }
        body {
        align-items: center;
          text-align: center;
        }
        table {
            margin: 0 auto;

        }
        form {
            display: inline-block;
            margin-top: 10px;
        }
        th, td{ color: red; text-align: center; }
    </style>
</head>
<body>

<h1 align = "center">Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

out.println();

try(
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
){
	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customer.customerId, firstName, lastName, totalAmount FROM customer JOIN ordersummary ON customer.customerId = ordersummary.customerId;");

	%> <table>
	    <tbody>
       				<tr>
       					<th>Order Id</th>
       					<th>Order Date</th>
       					<th>Customer Id</th>
       					<th>Customer Name</th>
       					<th>Total Amount</th>
       				</tr>
       <%
	while (rst.next()) {
		
		int orderId = rst.getInt("orderId");
		Date orderDate = rst.getDate("orderDate");
		int cId = rst.getInt("customerId");
		String fName = rst.getString("firstName");
		String lName = rst.getString("lastName");
		Double totalPrice = rst.getDouble("totalAmount");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		String fullName = fName + " " + lName;
		%>


                <tr>
                    <td><%= orderId %></td>
                    <td><%= orderDate %></td>
                    <td><%= cId %></td>
					<td><%= fullName %></td>
					<td><%= currFormat.format(totalPrice) %></td>
                </tr>
				
<%
		
		// Get products for the current order
		PreparedStatement productStatement = con.prepareStatement("SELECT productName, productPrice, orderproduct.productId, quantity, totalAmount FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId JOIN product ON product.productId = orderproduct.productId WHERE orderproduct.orderId = ?");
		productStatement.setInt(1, orderId);
		ResultSet productResultSet = productStatement.executeQuery();

		// Display products for the current order
		//out.println("<ul>");
			%>
			<tr align = "right">
            			    <td colspan="4">
            			        <table>
            			            <tbody>
            			                <tr>
            			                <th>Product Id</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        </tr>
			<%
		while (productResultSet.next()) {
			String prodId = productResultSet.getString("productId");
			double productPrice = productResultSet.getDouble("productPrice");
			int prodQuant = productResultSet.getInt("quantity");

			%>
			<tr>
			    <td><%= prodId %></td>
			    <td><%= prodQuant %></td>
			    <td><%= currFormat.format(productPrice) %></td>
			</tr>

			<%
			//out.println("<li>" + productName + " - $" + productPrice + "</li>");
		}
		//out.println("</ul>");

		%>
		    		                </tr>
                        		<tbody>
                        	<table>
        			    </td>
        			</tr>
		</table><%
		productResultSet.close();
		productStatement.close();
	}
}	
catch(SQLException ex){
	out.println(ex);

}
%>

</body>
</html>

