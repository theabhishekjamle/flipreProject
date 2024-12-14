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
        // Retrieve user inputs from the form
        String name = request.getParameter("uname");
        String email = request.getParameter("uemail");
        String phone = request.getParameter("uphone");
        String password = request.getParameter("upassword");
        int token = 0; // Initialize the token variable

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

            // Query to retrieve the maximum token value from the database
            ResultSet rs = st.executeQuery("SELECT MAX(token) FROM signup_data");

            if (rs.next()) {
                // Increment the token by 1 if tokens already exist
                token = rs.getInt(1) + 1;
            } else {
                // Start with token 1 if no records are found
                token = 1;
            }

            // Insert the new user data into the database
            String insertQuery = "INSERT INTO signup_data (uname, uemail, uphone, upassword, token) VALUES ('"+ name + "', '" + email + "', '" + phone + "', '" + password + "', '" + token + "')";
            st.executeUpdate(insertQuery);

            // Close the database connection
            con.close();
    %>
            <!-- Display the token in an alert box -->
            <script>
                alert("Registration Successful! Your ID is: <%= token %>");
            </script>
    <%
        } catch (Exception e) {
            // Handle exceptions by printing the error message
            out.println("Error: " + e);
        }
    %>
</body>
</html>
