<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Student Update Result</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Roboto', sans-serif;
    }

    body {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #26c0c0, #00b3b3, #004d4d);
        perspective: 1000px;
    }

    .container {
        background: rgba(255, 255, 255, 0.15);
        padding: 50px 60px;
        border-radius: 25px;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3);
        text-align: center;
        backdrop-filter: blur(20px);
        width: 100%;
        max-width: 450px;
        transform-style: preserve-3d;
        animation: float 6s ease-in-out infinite;
    }

    @keyframes float {
        0%,100% { transform: translateY(0px) rotateX(0deg) rotateY(0deg); }
        25% { transform: translateY(-10px) rotateX(3deg) rotateY(3deg); }
        50% { transform: translateY(10px) rotateX(-3deg) rotateY(-3deg); }
        75% { transform: translateY(-10px) rotateX(2deg) rotateY(-2deg); }
    }

    h1 {
        font-size: 2.2rem;
        margin-bottom: 20px;
        color: #fff;
        text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
        transform: translateZ(20px);
    }

    p {
        font-size: 1.2rem;
        color: #e0f7f7;
        margin-bottom: 30px;
        text-shadow: 1px 1px 5px rgba(0,0,0,0.3);
    }

    .btn {
        display: inline-block;
        padding: 12px 25px;
        border-radius: 15px;
        background: linear-gradient(45deg,#00cccc,#009999);
        color: #fff;
        text-decoration: none;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease, transform 0.3s ease;
        box-shadow: 0 5px 20px rgba(0,0,0,0.4);
    }

    .btn:hover {
        background: linear-gradient(45deg,#009999,#00cccc);
        transform: scale(1.05) translateZ(5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.6);
    }

    @media(max-width:500px){
        .container {
            padding: 35px 25px;
        }
    }
</style>
</head>
<body>
<div class="container">
    <h1><i class="fas fa-user-check"></i> Update Status</h1>
    <%
        String rollNumber = request.getParameter("rollnumber");
        String name = request.getParameter("student_name");
        String course = request.getParameter("course");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");

        int rollNum = Integer.parseInt(rollNumber);
        Long phone = Long.parseLong(contact);

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "pst_sms", "sms");
            PreparedStatement ps = con.prepareStatement(
                "update student set student_name=?, course=?, gender=?, contact=? where rollnumber=?"
            );
            ps.setString(1, name);
            ps.setString(2, course);
            ps.setString(3, gender);
            ps.setLong(4, phone);
            ps.setInt(5, rollNum);

            int i = ps.executeUpdate();
            if(i>0){
    %>
    <p><i class="fas fa-check-circle"></i> Student <strong><%=name%></strong> updated successfully!</p>
    <%
            } else {
    %>
    <p><i class="fas fa-exclamation-circle"></i> Update failed. Please check the Roll Number.</p>
    <%
            }
        } catch(Exception e){
            e.printStackTrace();
    %>
    <p><i class="fas fa-times-circle"></i> Error occurred: <%= e.getMessage() %></p>
    <%
        }
    %>
    <a href="student_update_controller.jsp" class="btn"><i class="fas fa-arrow-left"></i> Go Back</a>
</div>
</body>
</html>
