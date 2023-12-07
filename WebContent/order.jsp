<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Order Processing</title>
<style>
        table {
            margin: 0 auto;
        }
        h1{
            text-align: center;
            color: red;
        }
        th,td {
                background-color: #ffffff;
                color: #ff0000;
        }

</style>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String custPassword = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();


String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

// Determine if valid customer id was entered
boolean startQuery = true;
try{
	int n = Integer.parseInt(custId);
	startQuery = true;
}catch(NumberFormatException nfe){
	startQuery = false;
}

if (productList.isEmpty()){
    out.println("<h1>Your shopping cart is empty!</h1>");
}else if(!startQuery){
    out.println("<h1>Customer Id is invalid. Please return to the previous page and try again.</h1>");
}else{
    try(
	    Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();
    ){
	    String q = "SELECT  address, city, postalCode, country, state, firstName, lastName FROM customer WHERE customerId = " + custId + "AND password = '" + custPassword + "'";
	    ResultSet rst = stmt.executeQuery(q);



	    rst.next();
	
	    //add the order to order summary
	    String addy = rst.getString("address");
	    String city = rst.getString("city");
	    String postCode = rst.getString("postalCode");
	    String country = rst.getString("country");
	    String state = rst.getString("state");
	    String fName = rst.getString("firstName");
	    String lName = rst.getString("lastName");
	    String fullName = fName + " " + lName;


	    //get the auto increment order Id
	    String sql = "INSERT INTO ordersummary (shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry) VALUES ('" + addy +"', '" + city + "', '" + state + "', '" + postCode + "', '" + country + "')";
	    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	    pstmt.executeUpdate();
	    ResultSet keys = pstmt.getGeneratedKeys();
	    keys.next();
	    int orderId = keys.getInt(1);

	    %>
	    <h1>Your Order Summary</h1>

	    <table>
		    <thead>
			    <tr>
				    <th>Product Id</th>
				    <th>Product Name</th>
				    <th>Quantity</th>
				    <th>Price</th>
				    <th>Subtotal</th>
			    </tr>
		    </thead>
	    <%

	    double total = 0;
	    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		    while (iterator.hasNext()){
			    Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			    ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			    String productId = (String) product.get(0);
			    String price = (String) product.get(2);
			    double pr = Double.parseDouble(price);
			    int qty = ( (Integer)product.get(3)).intValue();

			    //subtotal Calculation
			    double subTotal = qty * pr;

    			total += subTotal;


	    		//get productName
	    		String getProdNameQuery = "SELECT productName FROM product WHERE productId = " + productId;
		    	ResultSet getProdName = stmt.executeQuery(getProdNameQuery);
			    getProdName.next();
			    String pName = getProdName.getString("productName");
	    %>
			
			<tr>
				<td><%= productId %></td>
				<td><%= pName %></td>
				<td><%= qty %></td>
				<td><%= currFormat.format(pr) %></td>
				<td><%= currFormat.format(subTotal) %></td>
			</tr>

		<%

			//put the product in order product
			PreparedStatement insertQ = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)");
			insertQ.setInt(1, orderId);
			insertQ.setInt(2, Integer.parseInt(productId));
			insertQ.setInt(3, qty);
			insertQ.setDouble(4, subTotal);
			insertQ.executeUpdate();
			

		    }
		    //remove the product from the lsit
		    productList.clear();
		
		%>
		    <tr>
			    <td colspan="4" align="right"> <b>Order Total: </b></td>
			    <td aling = "right"><%= currFormat.format(total)%></td>
		    </tr>
	    </table>
		    <h1>Order Completed. Will be shipped soon...</h1>
		    <h1>Your order refernce number is: <%= orderId%></h1>
		    <h1>Shippping to customer: <%= custId%> Name: <%= fullName%></h1>
		<%

		iterator = null;
    }
    catch(SQLException ex){
	    out.println("<H1>Customer Id or Password is invalid. Please return to the previous page and try again.</H1>");
    }
}
%>
</body>
</html>