<!DOCTYPE html>
<%@page import="java.sql.PreparedStatement"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Upload Offer</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css'>
<!-- The below script Makes IE understand the new html5 tags are there and applies our CSS to it -->
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<script type="text/javascript">
	function mySubmit() {
		alert("Offer Uploaded Successfully! You can go in My Offers to check your uploaded offers.");
		
	}
</script>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
	if (session.getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
	}
	boolean isBook = false;
	String seller = "", price = "", item = "", subject = "", year = "", semester = "", edition = "", publication = "";
	if (request.getParameter("item") != null) {
		seller = session.getAttribute("username").toString();
		price = request.getParameter("prices");
		item = request.getParameter("item");
		subject = request.getParameter("subject");
		year = request.getParameter("year");
		semester = request.getParameter("semester");
		edition = request.getParameter("edition");
		publication = request.getParameter("publication");
		if (request.getParameter("edition") != null && !request.getParameter("edition").equals("")) {
			isBook = true;
		}
		
		
		String url = "jdbc:h2:d:/mydb";
		Class.forName("org.h2.Driver");
		Connection con = DriverManager.getConnection(url);
		PreparedStatement stmt = null;
		if (isBook) {
			String sql = "INSERT INTO offer(seller, price, offerType, subject, semester, year, publication, edition) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			stmt = con.prepareStatement(sql);
			stmt.setString(7, publication);
			stmt.setInt(8, Integer.parseInt(edition));
		}
		else {
			String sql = "INSERT INTO offer(seller, price, offerType, subject, semester, year) VALUES (?, ?, ?, ?, ?, ?)";
			stmt = con.prepareStatement(sql);
		}
		stmt.setString(1, seller);
		stmt.setInt(2, Integer.parseInt(price));
		stmt.setString(3, item);
		stmt.setString(4, subject);
		stmt.setInt(5, Integer.parseInt(semester));
		stmt.setInt(6, Integer.parseInt(year));
		stmt.executeUpdate();
		response.sendRedirect("index.jsp");
	}
	
%>
<body>
<header>
		<div class="wrapper">
        <h1><a href="index.jsp" id="brand" title="Book Exchange">Book Exchange</a></h1>
        <nav>
            <ul>
                <li>
                  <a href="search.jsp?item=book">books</a>
                  <ul class="sub-menu">
                        <li><a href="search.jsp?item=book&year=1">F.E</a></li>
                        <li><a href="search.jsp?item=book&year=2">S.E</a></li>
                        <li><a href="search.jsp?item=book&year=3">T.E</a></li>
                        <li><a href="search.jsp?item=book&year=4">B.E</a></li>
                    </ul>
                </li>
                <li><a href="search.jsp?item=labcoat">Lab Coats</a></li>
                <li>
                	<a href="search.jsp?item=notes">Notes</a>
                    <ul class="sub-menu">
                        <li><a href="search.jsp?item=notes&year=1">F.E</a></li>
                        <li><a href="search.jsp?item=notes&year=2">S.E</a></li>
                        <li><a href="search.jsp?item=notes&year=3">T.E</a></li>
                        <li><a href="search.jsp?item=notes&year=4">B.E</a></li>
                    </ul>
                </li>
                <li><a href="search.jsp?item=tools">Workshop Tools</a></li>
                <li><a href="search.jsp?item=drafter"> Drafter </a></li>
                <li><a href="viewbasket.jsp"> My Offers </a></li>
          </ul>
        </nav>
    </div>
</header>
<aside id="top">
	<div class="wrapper">
        <ul id="social">
            <li><a href="#" class="facebook" title="like us us on Facebook">like us us on Facebook</a></li>
            <li><a href="#" class="twitter" title="follow us on twitter">follow us on twitter</a></li>
        </ul>
        <form>
        	<input type="text" placeholder="Search..." /><button type="submit">Search</button>
        </form>
        <div id="action-bar"><a href="login.jsp?msg=loggedout">Logout</a> ||  &nbsp; Welcome, <h3 style = "margin: 0; padding: 0; display: inline;"><%= session.getAttribute("username") %></h3></div>
    </div>
</aside>
<article id="address">
	<form>
    	<h1>Seller Details</h1>
       	<p>
            <label for="billFName">First name:</label>
            <input id="billFName" name="billFName" type="text" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="billLName">Last name:</label>
            <input id="billLName" name="billLName" type="text" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="billAddress1">Address:</label>
            <input id="billAddress1" name="billAddress1" type="text" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="billAddress2">&nbsp;</label>
            <input id="billAddress2" name="billAddress2" type="text">
        </p>
        <p>
            <label for="billCity">City:</label>
            <input id="billCity" name="billCity" type="text" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="email">Email:</label>
            <input id="email" name="email" type="email" required="true"><span class="alert">*</span>
        </p>
    	<p>
            <label for="phone">Phone:</label>
            <span style="display: none;" class="helper">Please enter your <strong>phone number</strong>.<br>We might need to contact you with regards to your offer.</span>
            <input id="phone" name="phone" type="tel" required="true"><span class="alert">*</span>
        </p>
    </form>
    <form id="ship" action="address.jsp" onsubmit="mySubmit()">
    	<h1>Offer Details</h1>
       	<p>
            <label for="item">Item Type:</label>
            <select name="item" id="item" required="true">
            	<option value="book">Book</option>
            	<option value="notes">Notes</option>
  				<option value="tools">Tools</option>
  				<option value="drafter">Drafter</option>
  				<option value="labcoat">Labcoat</option>
            </select>
        </p>
        <p>
            <label for="subject">Subject:</label>
            <input id="subject" type="text" name="subject" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="year">Engg. Year:</label>
            <input name="year" type="text" id="year" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="semester">Semester:</label>
            <input name="semester" type="text" id="semester" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="prices">Price:</label>
            <input name="prices" type="text" id="prices" required="true"><span class="alert">*</span>
        </p>
        <p>
            <label for="edition">Edition (for books):</label>
        	<input name="edition" type="text" id="semester"></p>
        <p>
        <p>
            <label for="publication">Publication (for books):</label>
        	<input name="publication" type="text" id="publication"></p>
        <p>
       	  <label>&nbsp;</label><button type="submit" class="continue" >Upload Offer</button>
        </p>

    </form>
</article>
<footer>
	<div class="wrapper">
        <a href="#">Sitemap</a> <a href="#">Terms &amp; Conditions</a> <a href="#">Shipping &amp; Returns</a> <a href="#">Size Guide</a><a href="#">Help</a> <br />
    </div>
</footer>
</body>
</html>
