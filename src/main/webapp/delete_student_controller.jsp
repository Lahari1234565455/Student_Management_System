<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Delete Student Result</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    body {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(to right, #ffd6d6, #ffb3b3);
        font-family: 'Roboto', sans-serif;
    }

    .message-box {
        background: rgba(255, 255, 255, 0.2);
        padding: 40px 50px;
        border-radius: 20px;
        text-align: center;
        backdrop-filter: blur(15px);
        box-shadow: 0 8px 40px rgba(0,0,0,0.2);
        color: #800000;
        max-width: 450px;
        width: 90%;
        animation: fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn {
        0% {opacity: 0; transform: translateY(-20px);}
        100% {opacity: 1; transform: translateY(0);}
    }

    .message-box h1 {
        font-size: 2rem;
        margin-bottom: 20px;
        color: #b22222;
        text-shadow: 1px 1px 6px rgba(0,0,0,0.2);
    }

    .message-box p {
        font-size: 1.2rem;
        margin-bottom: 30px;
    }

    .btn {
        display: inline-block;
        text-decoration: none;
        padding: 12px 25px;
        border-radius: 10px;
        font-weight: bold;
        margin: 5px;
        transition: all 0.3s ease;
        font-size: 1rem;
        cursor: pointer;
    }

    .back-btn {
        background-color: #fff;
        color: #b22222;
        border: 2px solid #b22222;
    }

    .back-btn:hover {
        background-color: #b22222;
        color: #fff;
        transform: scale(1.05);
    }

    .btn-view {
        background-color: #ff4d4d;
        color: #fff;
        border: none;
    }

    .btn-view:hover {
        background-color: #ff1a1a;
        transform: scale(1.05);
    }

    i {
        margin-right: 6px;
    }

</style>
</head>
<body>
    <div class="message-box">
    <%
        String rollnumber = request.getParameter("id");
        int rollNo = Integer.parseInt(rollnumber);

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "pst_sms", "sms"
            );
            PreparedStatement ps = con.prepareStatement(
                "delete from student where rollnumber = ?"
            );
            ps.setInt(1, rollNo);
            int i = ps.executeUpdate();

            if (i > 0) {
    %>
                <h1><i class="fas fa-check-circle"></i> Success!</h1>
                <p>Student with Roll Number <strong><%= rollNo %></strong> has been deleted successfully.</p>
    <%
            } else {
    %>
                <h1><i class="fas fa-times-circle"></i> Failed!</h1>
                <p>Deletion failed. Student with Roll Number <strong><%= rollNo %></strong> does not exist.</p>
    <%
            }

            ps.close();
            con.close();
        } catch(Exception e) {
    %>
            <h1><i class="fas fa-exclamation-triangle"></i> Error!</h1>
            <p>Something went wrong: <%= e.getMessage() %></p>
    <%
        }
    %>
        <a href="delete_student.html" class="btn back-btn"><i class="fas fa-arrow-left"></i> Go Back</a>
        <a href="view_all_students_controller.jsp" class="btn btn-view"><i class="fas fa-users"></i> View Students</a>
    </div>
</body>
</html>
