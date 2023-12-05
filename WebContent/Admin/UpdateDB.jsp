<%@ include file="..\jdbc.jsp" %>
<%@ include file="header.jsp" %>


<%
String updateDB = request.getParameter("updateDB");
try{
    getConnection();

    if(updateDB.equals("add")){
        String prodName = request.getParameter("productname");
        String price = request.getParameter("price");
        String description = request.getParameter("desc");
        String cat = request.getParameter("catId");
        String updateOrNot = request.getParameter("updateDB");


        PreparedStatement pst = con.prepareStatement("INSERT product(productName, categoryId, productDesc, productPrice) VALUES (?, ?, ?, ?);");

        pst.setString(1, prodName);
        pst.setString(3, description);
        pst.setDouble(4, Double.parseDouble(price));
        pst.setInt(2, Integer.parseInt("2"));

        pst.executeUpdate();
    }else if(updateDB.equals("delete")){
        String prodId = request.getParameter("prodId");

        PreparedStatement pst = con.prepareStatement("DELETE FROM orderproduct WHERE productId = ?;");
        pst.setInt(1, Integer.parseInt(prodId));
        pst.executeUpdate();

        pst = con.prepareStatement("DELETE FROM productinventory WHERE productId = ?;");
        pst.setInt(1, Integer.parseInt(prodId));
        pst.executeUpdate();

        pst = con.prepareStatement("DELETE FROM product WHERE productId = ?;");
        pst.setInt(1, Integer.parseInt(prodId));
        pst.executeUpdate();
    }else{

    }

}catch(SQLException ex){
    out.println(ex);
}
%>