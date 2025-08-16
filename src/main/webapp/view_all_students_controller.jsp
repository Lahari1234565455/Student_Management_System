<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Management System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        color: #fff;
        margin: 0;
        padding: 0;
    }

    h1, h3 {
        text-align: center;
        margin: 15px 0;
    }

    h1 {
        font-size: 36px;
        color: #ff9800;
    }

    h3 {
        font-size: 22px;
        color: #fff;
        margin-bottom: 30px;
    }

    table {
        border-collapse: collapse;
        width: 90%;
        margin: 0 auto 30px auto;
        background: rgba(255,255,255,0.1);
        backdrop-filter: blur(5px);
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0,0,0,0.5);
    }

    th, td {
        padding: 12px 15px;
        text-align: center;
    }

    th {
        background-color: rgba(255, 152, 0, 0.8);
        color: #fff;
        font-size: 16px;
    }

    tr:nth-child(even) {
        background-color: rgba(255,255,255,0.05);
    }

    tr:hover {
        background-color: rgba(255,255,255,0.2);
        transition: 0.3s;
    }

    .btn {
        display: inline-block;
        margin: 0 10px;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
        color: white;
        transition: 0.3s;
    }

    .btn-back {
        background: #007bff;
    }

    .btn-back:hover {
        background: #0069d9;
        transform: scale(1.05);
    }

    .btn-refresh {
        background: #28a745;
    }

    .btn-refresh:hover {
        background: #218838;
        transform: scale(1.05);
    }

    .button-container {
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</head>
<body>

<h1><i class="fas fa-user-graduate"></i> Student Management System</h1>
<h3>All Students</h3>

<div class="button-container">
    <a href="add_student.html" class="btn btn-back"><i class="fas fa-plus"></i> Add Student</a>
    <a href="view_all_students_controller.jsp" class="btn btn-refresh"><i class="fas fa-sync"></i> Refresh Table</a>
</div>

<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "pst_sms", "sms");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM student");
        ResultSet rs = ps.executeQuery();
%>

<table>
    <tr>
        <th>Roll Number</th>
        <th>Name</th>
        <th>Course</th>
        <th>Gender</th>
        <th>Contact</th>
    </tr>

<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt(1) %></td>
        <td><%= rs.getString(2) %></td>
        <td><%= rs.getString(3) %></td>
        <td><%= rs.getString(4) %></td>
        <td><%= rs.getLong(5) %></td>
    </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
    }
%>
</table>

</body>
</html>
