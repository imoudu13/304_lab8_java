<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Mo and Gav's Store - Product Information</title>
<style>
        body {
            text-align: center;
        }
        h2, h3 {
            text-align: center;
            color: red;
        }
        img {
            display: block;
            margin: 0 auto;
        }
        #reviewsContainer {
            text-align: center;
        }

        #reviewList {
            float: none;
            width: 50%;
            margin: 20px auto;
            padding: 10px;
            border: 1px solid #ccc;
        }
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
String sql = "select productPrice, productDesc, productImageURL, productName from product where productId = ?";
try
{
    getConnection();

    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setString(1, productId);
    ResultSet rst = stmt.executeQuery();

    Double pPrice = null;
    String pDesc = null;
    String pImageUrl = null;
    String pName = null;
    if(rst.next()){
        pPrice = rst.getDouble(1);
        pDesc = rst.getString(2);
        pImageUrl = rst.getString(3);
        pName = rst.getString(4);
    }
    out.println("<h2>" + pName + "</h2>");
    out.println("<h3> id: " + productId + "</h3>");
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    out.println("<h3> Price: " + currFormat.format(pPrice) + "</h3>");
    out.println("<h3> Product description: " + pDesc + "</h3>");

    //Display local image
    if (pImageUrl != null) {
        out.println("<img src= '" + pImageUrl + "' alt='Here is an image'>");
    }
    //Display database image
        out.println("<img src='displayImage.jsp?id=" + productId + "' alt=''>");

    // TODO: Add links to Add to Cart and Continue Shopping
    String addCartURL = "addcart.jsp?id="+productId+"&name="+pName+"&price="+pPrice+"&action=add";
    out.println("<h2><a href='" + addCartURL + "'>Add To Cart</a></h2>");
    out.println("<h2><a href='listprod.jsp'>Continue Shopping</a></h2>");

}
catch (SQLException ex) {
    out.println(ex);
}
finally
{
    closeConnection();
}
%>


<div id="reviewscontainer">

<div>
    <h2>Write a Review</h2>
    <form action="submitReview.jsp" method="post">
        <input type="hidden" name="productId" value="<%= productId %>">
        <label for="username">Your Customer Id:</label>
        <input type="text" name="customerid" required><br>
        <label for="rating">Rating:</label>
        <input type="number" name="rating" min="1" max="5" required><br>
        <label for="comment">Comment:</label><br>
        <textarea name="comment" rows="4" cols="50" required></textarea><br>
        <input type="submit" value="Submit Review">
    </form>
</div>


<div id="reviewList">
    <h2>Product Reviews</h2>
    <ul>
        <%
            try {
                getConnection();
                PreparedStatement reviewStmt = con.prepareStatement("SELECT reviewComment, reviewRating, firstName, lastName FROM review JOIN customer ON review.customerId = customer.customerId WHERE productId = ?");
                reviewStmt.setInt(1, Integer.parseInt(productId));

                ResultSet reviewResult = reviewStmt.executeQuery();

                while(reviewResult.next()){
        %>
                    <li>
                        <strong><%= reviewResult.getString("firstName") + " " + reviewResult.getString("lastName") %></strong> rated it <%= reviewResult.getInt("reviewRating") %> stars<br>
                        <%= reviewResult.getString("reviewComment") %>
                    </li>
        <%
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            } finally {
                closeConnection();
            }
        %>
    </ul>
</div>
</div>

</body>
</html>

