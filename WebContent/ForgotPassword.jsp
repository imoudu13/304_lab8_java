<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
    <link rel="stylesheet" type="text/css" href="Login.css">
<style>
            .form {
                max-width: 400px;
                margin: 0 auto;
                margin-top: 30px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
            .submit{
                width: 40%;
                padding: 8px;
                margin-bottom: 10px;
            }
        </style>
</head>
<body>
<div class="form">
<br>
<form name="MyForm" method=post action="resetpassword.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Customer Id:</font></div></td>
	<td><input type="text" name="cid"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">New Password:</font></div></td>
	<td><input type="password" name="newpw" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Re-enter Password:</font></div></td>
	<td><input type="password" name="newpwreenter" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>
</body>