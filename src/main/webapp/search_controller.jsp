<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Search Result</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #ffd33d, #ffe066);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: white;
            padding: 40px 50px;
            border-radius: 25px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.25);
            text-align: center;
            max-width: 450px;
            width: 100%;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
        }

        .card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0,0,0,0.3);
        }

        h2 {
            margin-bottom: 25px;
            color: #333;
            font-size: 2rem;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
        }

        p {
            font-size: 1.1rem;
            color: #555;
            margin: 10px 0;
        }

        .buttons {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 12px;
            background: #ffb700;
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 179, 0, 0.3);
        }

        .btn:hover {
            background: #ffa500;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 165, 0, 0.4);
        }

        .not-found {
            color: #ff4d4d;
            font-weight: bold;
            font-size: 1.3rem;
            margin-bottom: 20px;
        }

        .error {
            color: #ff0000;
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="card">
<%
    String id = request.getParameter("id");

    if (id != null && !id.trim().isEmpty()) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "pst_sms", "sms"
            );
            PreparedStatement ps = con.prepareStatement("SELECT * FROM student WHERE rollnumber = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
                <h2>Student Details</h2>
                <p><strong>Roll Number:</strong> <%= rs.getInt(1) %></p>
                <p><strong>Name:</strong> <%= rs.getString(2) %></p>
                <p><strong>Course:</strong> <%= rs.getString(3) %></p>
                <p><strong>Gender:</strong> <%= rs.getString(4) %></p>
                <p><strong>Contact:</strong> <%= rs.getLong(5) %></p>
<%
            } else {
%>
                <div class="not-found">Student Not Found!</div>
<%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
%>
            <div class="error">Error Occurred: <%= e.getMessage() %></div>
<%
        }
    } else {
%>
        <div class="not-found">No ID Provided!</div>
<%
    }
%>
    <div class="buttons">
        <a class="btn" href="search_student.html">Search Again</a>
        <a class="btn" href="view_all_students_controller.jsp">View All Students</a>
    </div>
</div>
</body>
</html>
