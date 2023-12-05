<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%
    // Get the current list of products from the session
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    // Check if the productList is not null
    if (productList != null) {
        String action = request.getParameter("action");

        // Update quantity
        if ("update".equals(action)) {
            for (Map.Entry<String, ArrayList<Object>> entry : productList.entrySet()) {
                String productId = entry.getKey();
                String quantityParam = "quantity_" + productId;
                String quantityValue = request.getParameter(quantityParam);

                if (quantityValue != null && !quantityValue.isEmpty()) {
                    int newQuantity = Integer.parseInt(quantityValue);
                    ArrayList<Object> product = entry.getValue();
                    product.set(3, newQuantity);  // Update the quantity in the cart
                }
            }

            // Save the updated productList back to the session
            session.setAttribute("productList", productList);
        }
        // Remove item
        else if ("remove".equals(action)) {
            String productIdToRemove = request.getParameter("id");
            productList.remove(productIdToRemove);

            // Save the updated productList back to the session
            session.setAttribute("productList", productList);
        }
    }

    // Redirect back to the cart display page
    response.sendRedirect("showcart.jsp");
%>
