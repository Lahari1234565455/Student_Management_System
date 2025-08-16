<!DOCTYPE html>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Registration</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

    body {
        font-family: 'Roboto', sans-serif;
        background: linear-gradient(135deg, #1c92d2, #f2fcfe);
        height: 100vh;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    .card {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(15px);
        padding: 40px 30px;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.25);
        text-align: center;
        width: 420px;
        max-width: 90%;
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        color: #fff;
    }

    @keyframes fadeInUp {
        from {opacity: 0; transform: translateY(30px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .success, .error {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        animation: bounce 0.8s ease;
        text-align: center;
        flex-wrap: wrap;
    }

    .success { color: #2ecc71; }
    .error { color: #e74c3c; }

    @keyframes bounce {
        0% {transform: scale(0.5);}
        50% {transform: scale(1.1);}
        100% {transform: scale(1);}
    }

    p {
        color: #fff;
        font-size: 16px;
        line-height: 1.8;
        margin-bottom: 25px;
        word-wrap: break-word;
        text-align: left;
    }

    .btn {
        display: inline-block;
        margin: 10px 5px 0;
        padding: 12px 25px;
        border-radius: 10px;
        text-decoration: none;
        font-size: 16px;
        font-weight: bold;
        transition: 0.3s;
        box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    }

    .btn-home {
        background: linear-gradient(135deg, #3498db, #2980b9);
        color: white;
    }

    .btn-home:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 20px rgba(0,0,0,0.3);
    }

    .btn-view {
        background: linear-gradient(135deg, #2ecc71, #27ae60);
        color: white;
    }

    .btn-view:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 20px rgba(0,0,0,0.3);
    }

    /* Decorative floating circles */
    .circle {
        position: absolute;
        border-radius: 50%;
        opacity: 0.15;
        animation: float 6s infinite ease-in-out;
    }

    .circle1 {width: 120px; height: 120px; background: #fff; top: -60px; left: -50px;}
    .circle2 {width: 80px; height: 80px; background: #ff9800; bottom: -40px; right: -30px; animation-delay: 2s;}
    .circle3 {width: 100px; height: 100px; background: #3498db; top: 30%; left: 80%; animation-delay: 4s;}

    @keyframes float {
        0%,100% {transform: translateY(0px);}
        50% {transform: translateY(-20px);}
    }

    /* Responsive */
    @media(max-width: 480px){
        .card { padding: 30px 20px; }
        p { font-size: 15px; }
        .btn { padding: 10px 20px; font-size: 14px; }
    }
</style>
</head>
<body>

<%
    String rollnumber = request.getParameter("rollnumber");
    String name = request.getParameter("student_name");
    String course = request.getParameter("course");
    String gender = request.getParameter("gender");
    String phone = request.getParameter("contact");

    int rNum = 0;
    long contact = 0;
    boolean success = false;

    try {
        if(rollnumber != null && !rollnumber.isEmpty() && phone != null && !phone.isEmpty()) {
            rNum = Integer.parseInt(rollnumber);
            contact = Long.parseLong(phone);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","pst_sms","sms");
            PreparedStatement ps = con.prepareStatement("insert into student values(?,?,?,?,?)");
            ps.setInt(1,rNum);
            ps.setString(2,name);
            ps.setString(3,course);
            ps.setString(4,gender);
            ps.setLong(5,contact);

            int i = ps.executeUpdate();
            if(i>0) success = true;

            con.close();
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

<div class="card">
    <div class="circle circle1"></div>
    <div class="circle circle2"></div>
    <div class="circle circle3"></div>

    <% if(success) { %>
        <div class="success"><i class="fas fa-check-circle"></i> Student Added Successfully!</div>
        <p><b>Name:</b> <%= name %><br>
           <b>Roll No:</b> <%= rollnumber %><br>
           <b>Course:</b> <%= course %><br>
           <b>Gender:</b> <%= gender %><br>
           <b>Contact:</b> <%= phone %></p>
    <% } else { %>
        <div class="error"><i class="fas fa-times-circle"></i> Insertion Failed. Try Again!</div>
    <% } %>

    <a href="add_student.html" class="btn btn-home"><i class="fas fa-arrow-left"></i> Back to Form</a>
    <a href="view_all_students_controller.jsp" class="btn btn-view"><i class="fas fa-users"></i> View Students</a>
</div>

</body>
</html>
