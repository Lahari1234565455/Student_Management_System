<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Update Student</title>
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
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #26c0c0, #00b3b3, #004d4d);
        padding: 20px;
        perspective: 1000px;
    }

    .container {
        background: rgba(255, 255, 255, 0.15);
        padding: 40px 50px;
        border-radius: 25px;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3);
        backdrop-filter: blur(20px);
        width: 100%;
        max-width: 550px;
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
        font-size: 2rem;
        margin-bottom: 25px;
        color: #fff;
        text-align: center;
        text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
    }

    form {
        display: flex;
        flex-direction: column;
    }

    label {
        margin-bottom: 5px;
        font-size: 1rem;
        color: #e0f7f7;
        font-weight: 500;
    }

    input[type="text"], input[type="number"] {
        padding: 12px 15px;
        margin-bottom: 20px;
        border-radius: 12px;
        border: 1px solid #80d4d4;
        font-size: 1rem;
        transition: all 0.3s ease, transform 0.3s ease;
        background: rgba(255, 255, 255, 0.2);
        color: #004d4d;
        box-shadow: inset 0 5px 10px rgba(0, 255, 255, 0.2);
    }

    input[type="text"]:focus, input[type="number"]:focus {
        outline: none;
        box-shadow: 0 0 12px #00ffff, 0 0 20px #00ffff inset;
        border-color: #00ffff;
        transform: scale(1.02) translateZ(5px);
    }

    .btn-group {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }

    input[type="submit"], input[type="reset"] {
        flex: 1;
        padding: 12px 20px;
        border: none;
        border-radius: 12px;
        background: linear-gradient(45deg, #00cccc, #009999);
        color: #fff;
        font-size: 1rem;
        cursor: pointer;
        box-shadow: 0 5px 20px rgba(0,0,0,0.4);
        transition: all 0.3s ease, transform 0.3s ease;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
        background: linear-gradient(45deg, #009999, #00cccc);
        transform: scale(1.05) translateZ(5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.6);
    }

    @media (max-width: 600px) {
        .container {
            padding: 30px 20px;
        }

        .btn-group {
            flex-direction: column;
        }
    }
</style>
</head>
<body>
<div class="container">
    <h1><i class="fas fa-user-edit"></i> Update Student</h1>
    <%
        String rollNumber = request.getParameter("rollNumber");
        int rollNum = Integer.parseInt(rollNumber);

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "pst_sms", "sms");
            PreparedStatement ps = con.prepareStatement("select * from student where rollnumber = ?");
            ps.setInt(1, rollNum);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
    %>
    <form action="<%=request.getContextPath()%>/student_update.jsp" method="post">
        <label>Roll Number:</label>
        <input type="text" name="rollnumber" value="<%=rs.getInt(1)%>" readonly />

        <label>Student Name:</label>
        <input type="text" name="student_name" value="<%=rs.getString(2)%>" required />

        <label>Course:</label>
        <input type="text" name="course" value="<%=rs.getString(3)%>" required />

        <label>Gender:</label>
        <input type="text" name="gender" value="<%=rs.getString(4)%>" required />

        <label>Contact:</label>
        <input type="text" name="contact" value="<%=rs.getLong(5)%>" required />

        <div class="btn-group">
            <input type="submit" value="Update Student" />
            <input type="reset" value="Clear" />
        </div>
    </form>
    <%
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    %>
</div>
</body>
</html>
