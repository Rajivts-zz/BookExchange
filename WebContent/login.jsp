<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
    <head>
    	<%@page import="java.sql.*" %>
        <meta charset="UTF-8" />
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
        <title>Book Sharing Login</title>
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="css/demo.css" />
        <link rel="stylesheet" type="text/css" href="css/style3.css" />
		<link rel="stylesheet" type="text/css" href="css/animate-custom.css" />
    </head>
    <body>
        <div class="container">
            <section>				
                <div id="container_demo" >
                    <a class="hiddenanchor" id="toregister"></a>
                    <a class="hiddenanchor" id="tologin"></a>
                    <div id="wrapper">
                        <div id="login" class="animate form">
                            <form  action="login.jsp" autocomplete="on" method="post"> 
                                <h1>Book Exchange</h1> 
                                <p> 
                                    <label for="username" class="uname" data-icon="u" > Your username </label>
                                    <input id="username" name="username" required="required" type="text" placeholder="myusername or mymail@mail.com"/>
                                </p>
                                <p> 
                                    <label for="password" class="youpasswd" data-icon="p"> Your password </label>
                                    <input id="password" name="password" required="required" type="password" placeholder="eg. X8df!90EO" /> 
                                </p>
                                
                                <p class="login button"> 
                                    <input type="submit" value="Login" /> 
								</p>
                                <p class="change_link">
									Not a member yet ?
									<a href="#toregister" class="to_register">Join us</a>
								</p>
                            </form>
                        </div>

                        <div id="register" class="animate form">
                            <form  action="login.jsp" autocomplete="on" method="post"> 
                                <h1> Book Exchange </h1> 
                                <p> 
                                    <label for="usernamesignup" class="uname" data-icon="u">Your username</label>
                                    <input id="usernamesignup" name="usernamesignup" required="required" type="text" placeholder="mysuperusername690" />
                                </p>
                                <p> 
                                    <label for="emailsignup" class="youmail" data-icon="e" > Your email</label>
                                    <input id="emailsignup" name="emailsignup" required="required" type="email" placeholder="mysupermail@mail.com"/> 
                                </p>
                                <p> 
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="passwordsignup" name="passwordsignup" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p> 
                                    <label for="passwordsignup_confirm" class="youpasswd" data-icon="p">Please confirm your password </label>
                                    <input id="passwordsignup_confirm" name="passwordsignup_confirm" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p class="signin button"> 
									<input type="submit" value="Sign up"/> 
								</p>
                                <p class="change_link">  
									Already a member ?
									<a href="#tologin" class="to_register"> Go and log in </a>
								</p>
                            </form>
                        </div>
						
                    </div>
                </div>  
            </section>
        </div>
    </body>
    <%
    	if (session.getAttribute("username") != null) {
    		if (request.getParameter("username") == null && request.getParameter("usernamesignup") == null) {
    			if (request.getParameter("msg") == null) {
    				response.sendRedirect("index.jsp");	
    			}
    			else {
	    			session.removeAttribute("username");
	    			session.removeAttribute("password");
    			}
    		}
    		else {
    			response.sendRedirect("index.jsp");
    		}
    	}
    	String uname = request.getParameter("username");
    	String signUname = request.getParameter("usernamesignup");
        if (uname == null && signUname == null) {}
        else {
        	String url = "jdbc:h2:d:/mydb";
    		Class.forName("org.h2.Driver");
    		Connection con = DriverManager.getConnection(url);
    		String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
    		PreparedStatement stmt = con.prepareStatement(sql);
        	if (uname != null) {
        		stmt.setString(1, request.getParameter("username"));
        		stmt.setString(2, request.getParameter("password"));
        		ResultSet rs = stmt.executeQuery();
        		if (rs.next()) {
        			session.setAttribute("username", request.getParameter("username"));
        			session.setAttribute("password", request.getParameter("password"));
        			response.sendRedirect("index.jsp");		
        		}
        		else {
        			response.sendRedirect("login.jsp");
        		}
        	}
        	else {
        		sql = "SELECT * FROM users WHERE username = ?";
        		stmt = con.prepareStatement(sql);
        		stmt.setString(1, request.getParameter("usernamesignup"));
        		ResultSet rs = stmt.executeQuery();
        		if (rs.next()) {
        		%> 
        		<script>
        			alert("The account already exist! Please use different username!");
        		</script>
        		<%		
        		}
        		else {
        			if (!request.getParameter("passwordsignup").equals(request.getParameter("passwordsignup_confirm"))) {
        				%> 
                		<script>
                			alert("The passwords do not match, please re-enter the password!");
                			window.location = "login.jsp#toregister";
                		</script>
                		<%
        			}
        			else {
	        			sql = "INSERT INTO users(username, password, email) VALUES(?, ?, ?)";
	        			stmt = con.prepareStatement(sql);
	        			stmt.setString(1, request.getParameter("usernamesignup"));
	            		stmt.setString(2, request.getParameter("passwordsignup"));
	            		stmt.setString(3, request.getParameter("emailsignup"));
	            		stmt.executeUpdate();
	            		%> 
	            		<script>
	            			alert("The account was created successfully!");
	            			window.location = "login.jsp#toregister";
	            		</script>
	            		<%		
        			}
        		}
        	}
        }
    %>
</html>