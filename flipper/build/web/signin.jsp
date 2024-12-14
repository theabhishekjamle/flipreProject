<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
</head>
<body>
    <h1>Welcome to Flipper</h1>

     <%
        // Get the email and password from the request parameters
        String email = request.getParameter("uemail");
        String password = request.getParameter("upassword");

        if (email != null && password != null) {
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a connection to the database
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/flipr_data?useSSL=false&allowPublicKeyRetrieval=true", 
                        "root", 
                        "abhi");

                // Create a statement to query the database
                Statement st = con.createStatement();

                // Query to check if the email and password match in the database
                String query = "SELECT * FROM signup_data WHERE uemail = '" + email + "' AND upassword = '" + password + "'";

                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {
                    // If a matching record is found, the user is authenticated
                    out.println("<script>alert('Login Successful!');</script>");
                } else {
                    // If no match is found, show an error message
                    out.println("<script>alert('Invalid Email or Password. Please try again.');</script>");
                }

                // Close the database connection
                con.close();
            } catch (Exception e) {
                // Handle exceptions by printing the error message
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            }
        }
    %>
</body>
</html>
