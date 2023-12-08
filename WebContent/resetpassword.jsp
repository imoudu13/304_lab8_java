<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String customerId = request.getParameter("cid");
    String pw = request.getParameter("newpw");
    String reenter = request.getParameter("newpwreenter");

    if(pw.equals(reenter)){
        try{
                getConnection();

                PreparedStatement pst = con.prepareStatement("UPDATE customer SET password = ? WHERE customerId = ?");

                pst.setString(1, pw);
                pst.setInt(2, Integer.parseInt(customerId));

                pst.executeUpdate();
            }catch(SQLException exe){
                out.println(exe);
            }finally{
                closeConnection();
            }

            out.println("<h1>Your password has been updated. Please return to the log in screen.</h1>");
    }else{
        out.println("<h1>Please make both passwords you entered are matching. Return to the previous screen and try again.</h1>");
    }

%>
