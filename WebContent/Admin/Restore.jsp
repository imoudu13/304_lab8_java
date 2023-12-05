<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Database Restore</title>
</head>
<body>

<%
    String backupFilePath = "WebContent/ddl/SQLServer_orderdb.ddl"; // Replace with your backup file path
    String jdbcURL = "jdbc:mysql://localhost:3306/your_database";
    String dbUser = "username";
    String dbPassword = "password";