<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp" %>

<%
String productId = request.getParameter("productId");
String customerid = request.getParameter("customerid");
int rating = Integer.parseInt(request.getParameter("rating"));
String comment = request.getParameter("comment");

try {
    getConnection();

    PreparedStatement submitReviewStatement = con.prepareStatement("INSERT INTO review (reviewRating, customerId, productId, reviewComment) VALUES (?, ?, ?, ?)");
    submitReviewStatement.setInt(3, Integer.parseInt(productId));
    submitReviewStatement.setInt(2, Integer.parseInt(customerid));
    submitReviewStatement.setInt(1, rating);
    submitReviewStatement.setString(4, comment);

    submitReviewStatement.executeUpdate();
} catch (SQLException ex) {
    ex.printStackTrace();
} finally {
    closeConnection();
}

response.sendRedirect("product.jsp?id=" + productId);
%>
