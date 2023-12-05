<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.concurrent.atomic.AtomicBoolean" %>
<%@ page import="java.io.IOException, java.io.PrintWriter"%>

<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>


<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");

	// TODO: Check if valid order id in database
	try{
	    //this variable will be true if the orderId is in the db
	    boolean inDB = false;
        //connect to db
        getConnection();

        int ordId = Integer.parseInt(orderId);
        //prepare the query
        PreparedStatement pst = con.prepareStatement("SELECT orderId, orderDate FROM ordersummary WHERE orderId = ?;");

        pst.setInt(1, ordId);     //put order Id in prepareStatement
        ResultSet rst = pst.executeQuery();
        Date orderDate = null;

        if(rst.next()){
            inDB = true;        //the orderId is in the database
            orderDate = rst.getDate("orderDate");
        }

        //start the transaction
        con.setAutoCommit(false);

        //get the prod id and quantity with same orderId
        pst = con.prepareStatement("SELECT productId, quantity FROM orderproduct WHERE orderId = ?;");
        pst.setInt(1, ordId);
        rst = pst.executeQuery();

        //stores product information, the prodId and quantity
        HashMap<Integer, Integer> products = new HashMap<>();
        int prodId = 0;
        int prodQuantity = 0;

        //iterate through the result table and put the id and quantity in the hashmap
        while(rst.next()){
            prodId = rst.getInt("productId");
            prodQuantity = rst.getInt("quantity");
            products.put(prodId, prodQuantity);
        }

        // TODO: Create a new shipment record.
        pst = con.prepareStatement("INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, 1);");
        pst.setDate(1, orderDate);
        pst.setString(2, "Blah Blah");
        pst.executeUpdate();        //execute the insert

        //these two statement will be used repeatedly so prepare them now
        PreparedStatement getQuant = con.prepareStatement("SELECT quantity FROM productinventory WHERE warehouseId = 1 and productId = ?");      //get quantities of product in db


        PreparedStatement updateWarehouse = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ?;");   //update the db

        // TODO: For each item verify sufficient quantity available in warehouse 1.

        Iterator<Map.Entry<Integer, Integer>> iterator = products.entrySet().iterator();
        while(iterator.hasNext()){
            Map.Entry<Integer, Integer> entry = iterator.next();

            int value = entry.getValue();
            int key = entry.getKey();


            try{
                //get a the quantity of that product in warehouse
                getQuant.setInt(1, key);     //set the next ? to whatever the product Id

                //execute query
                ResultSet rt = getQuant.executeQuery();
                rt.next();

                //get quantity in the warehouse
                int prodQ = rt.getInt("quantity");     //quantity of product in the warehouse


                // TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
                //check if there's enough
                if(prodQ >= value){
                    //there is enough, update the warehouse
                    //newQuantity = old quantity - whatever amount is in the order.
                    int newQuantity = prodQ - value;

                    updateWarehouse.setInt(1, newQuantity);
                    updateWarehouse.setInt(2, key);
                    updateWarehouse.executeUpdate();

                    %> <h2> Ordered Product: <%= key%> Qty: <%= value %> Previous Inventory: <%= prodQ %> New Inventory: <%= newQuantity %> </h2>    <%
                }else{
                    //if there isn't enough roll back and break the loop
                    con.rollback();


                    %> <h2> Shipment not done, Insuffiecient inventory for product id: <%= key%> </h2>    <%
                    break;    //change this boolean to false so on the next iteration the loop doesn't try to update the db
                }
            }catch(SQLException exe){
                out.println(exe);
            }

        }

        //another attempt at iterating

        // TODO: Auto-commit should be turned back on
        con.commit();
	}catch(SQLException ex){
	    out.println(ex);
	}

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
