<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Select Offer</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Terminal+Dosis'
	rel='stylesheet' type='text/css'>
<!-- The below script Makes IE understand the new html5 tags are there and applies our CSS to it -->
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.13.custom.min.js"></script>
<script type="text/javascript">
	$(function() {
		// Tabs
		$('#tabs').tabs();
	});
</script>
</head>
<body>
	<header>
		<div class="wrapper">
			<h1>
				<a href="index.jsp" id="brand" title="Book Exchange">Book
					Exchange</a>
			</h1>
			<nav>
				<ul>
					<li><a href="search.jsp?item=book">books</a>
						<ul class="sub-menu">
							<li><a href="search.jsp?item=book&year=1">F.E</a></li>
							<li><a href="search.jsp?item=book&year=2">S.E</a></li>
							<li><a href="search.jsp?item=book&year=3">T.E</a></li>
							<li><a href="search.jsp?item=book&year=4">B.E</a></li>
						</ul></li>
					<li><a href="search.jsp?item=labcoat">Lab Coats</a></li>
					<li><a href="search.jsp?item=notes">Notes</a>
						<ul class="sub-menu">
							<li><a href="search.jsp?item=notes&year=1">F.E</a></li>
							<li><a href="search.jsp?item=notes&year=2">S.E</a></li>
							<li><a href="search.jsp?item=notes&year=3">T.E</a></li>
							<li><a href="search.jsp?item=notes&year=4">B.E</a></li>
						</ul></li>
					<li><a href="search.jsp?item=tools">Workshop Tools</a></li>
					<li><a href="search.jsp?item=drafter"> Drafter </a></li>
					<li><a href="viewbasket.jsp"> My Offers </a></li>
				</ul>
			</nav>
		</div>
	</header>
	<%@page import="java.sql.*"%>
	<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
	<%@ page import="javax.mail.internet.*,javax.activation.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
		}
		if (request.getParameter("selected") != null) {
			String urls = "jdbc:h2:d:/mydb";
			Class.forName("org.h2.Driver");
			Connection con = DriverManager.getConnection(urls);
			String sqls = "SELECT email FROM users WHERE username = ?";
			PreparedStatement stmt = con.prepareStatement(sqls);
			stmt.setString(1, session.getAttribute("username").toString());
			ResultSet rst = stmt.executeQuery();
			rst.next();
			String to = rst.getString(1);
			
			stmt = con.prepareStatement("UPDATE offer SET buyer=? WHERE offerID=?");
			stmt.setString(1, session.getAttribute("username").toString());
			stmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
			stmt.executeUpdate();
			
			String to2 = request.getParameter("mail");
	
			// Sender's email ID needs to be mentioned
			String from = "sp.book.exchange@gmail.com";
			String pass = "sp_book_exchange";
	
			// Get system properties object
			Properties props = System.getProperties();
			String host = "smtp.gmail.com";
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.user", from);
			props.put("mail.smtp.password", "sp_book_exchange");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
	
			// Get the default Session object.
			Session mailSession = Session.getInstance(props, new Authenticator() {
		        	protected PasswordAuthentication  getPasswordAuthentication() {
		            	return new PasswordAuthentication(
		                        "sp.book.exchange@gmail.com", "sp_book_exchange");
		               	}
		        }
			);
	
			try {
				// Create a default MimeMessage object.
				MimeMessage message = new MimeMessage(mailSession);
				// Set From: header field of the header.
				message.setFrom(new InternetAddress(from));
				// Set To: header field of the header.
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(to));
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(to2));
				// Set Subject: header field
				message.setSubject("Book Exchange Deal Confirmation");
	
				// Send the actual HTML message, as big as you like
				message.setText("Dear User, you are engaged in a deal on BookExchange.\nBuyer Name: " + session.getAttribute("username").toString() + "\nBuyer EmailID: " + to + "\n\nSeller Name: " + request.getParameter("seller") + "\nSeller EmailID: " + request.getParameter("mail") + "\n\nPlease note both the buyer and the seller have been sent this mail so that can either party can initiate the deal. Good Luck!");
				Transport transport = mailSession.getTransport("smtp");
				transport.connect(host, from, "sp_book_exchange");
				// Send message
				transport.sendMessage(message, message.getAllRecipients());
				transport.close();
			} catch (MessagingException mex) {
				mex.printStackTrace();
			}
			response.sendRedirect("index.jsp");
		}

		
		
		String url = "jdbc:h2:d:/mydb";
		Class.forName("org.h2.Driver");
		Connection con = DriverManager.getConnection(url);
		String sql = "SELECT * FROM offer WHERE offerID = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
		ResultSet rs = stmt.executeQuery();

		String seller = "", price = "", offerType = "", subject = "", year = "", semester = "", publication = "", edition = "";
		String bookAddon;
		while (rs.next()) {
			seller = rs.getString(2);
			price = Integer.toString(rs.getInt(3));
			offerType = rs.getString(4);
			subject = rs.getString(5);
			publication = rs.getString(6);
			year = Integer.toString(rs.getInt(7));
			semester = Integer.toString(rs.getInt(8));
			edition = Integer.toString(rs.getInt(9));
		}
		boolean isBook = (publication == null ? false : true);
		bookAddon = publication + " publication, Edition " + edition;
		stmt = con
				.prepareStatement("SELECT username, email FROM users WHERE username = ?");
		stmt.setString(1, seller);
		rs = stmt.executeQuery();
		String mail = "";
		while (rs.next()) {
			mail = rs.getString(2);
		}
		String image = (offerType.equals("labcoat") ? offerType + subject
				: offerType);
	%>
	<aside id="top">
		<div class="wrapper">
			<ul id="social">
				<li><a href="#" class="facebook" title="like us us on Facebook">like
						us us on Facebook</a></li>
				<li><a href="#" class="twitter" title="follow us on twitter">follow
						us on twitter</a></li>
			</ul>
			<form>
				<input type="text" placeholder="Search..." />
				<button type="submit">Search</button>
			</form>
			<div id="action-bar">
				<a href="login.jsp?msg=loggedout">Logout</a> ||  &nbsp; Welcome, <h3 style = "margin: 0; padding: 0; display: inline;"><%= session.getAttribute("username") %></h3>
			</div>
		</div>
	</aside>
	<article id="mainview">
		<div id="breadcrumb">
			<a href="index.jsp">Home</a> > <a href="search.html"><%=request.getParameter("item")%></a>
			> <a href="search.html"><%=request.getParameter("year")%></a> >
			<%="offer" + request.getParameter("ID")%></div>
		<div id="description">
			<h1><%=subject + " " + offerType%></h1>
			<strong id="price">Rs <%=price%></strong>
			<p>
				View the different images of the product inorder to verify the
				quality and authenticity of the product that you are going to
				purchase. If you like the product click <strong>select
					offer</strong>, which will notify the seller that you are interested in the
				product. The seller will then contact you and finalize the deal. In
				case the seller doesn't contact you within 2 days, you can write to
				us at book.exchange@gmail.com and your problems will be resolved.
			</p>

			<p>
				<button type="submit" id="sub" class="continue" onclick="selected()">Select Offer</button>
				
			</p>
			<div id="tabs">
				<ul>
					<li><a href="#tabs-1" class="first">Details</a></li>
					<li><a href="#tabs-2">Returns</a></li>
					<li><a href="#tabs-3">Seller Info</a></li>
				</ul>
				<section id="tabs-1">
					<p>
						<strong>Title: </strong>
						<%=subject + " " + offerType%></p>
					<p>
						<strong>Price:</strong> Rs
						<%=price%></p>
					<p>
						<strong>Academic Year and Semester: </strong><%="Year " + year + " and Semester " + semester
					+ " of Engineering"%></p>
					<%
						if (isBook) {
					%>
					<p>
						<strong>Publication:</strong>
						<%=bookAddon%></p>
					<%
						}
					%>
				</section>
				<section id="tabs-2">
					<p>If you are not completely satisfied with your purchase,
						please write to us at book.exchange@gmail.com. Your problems will
						be promptly solved.</p>
				</section>
				<section id="tabs-3">
					<p>
						<strong>Seller Username: </strong><%=seller%></p>
					<p>
						<strong>Seller Email: </strong><%=mail%></p>
					<p>The above given mail address can be used to contact the
						seller and carry out further transactions.</p>
				</section>
			</div>
		</div>
		<div id="images">
			<a href="images/<%=image%>.jpg" target="_blank"><img
				src="images/<%=image%>.jpg"></a>
			<p>Click on the thumnails to view the images</p>
			<div id="productthumbs">
				<a href="#"><img src="images/<%=image%>.jpg" /></a><a href="#"><img
					src="images/<%=image%>.jpg" /></a><a href="#"><img
					src="images/<%=image%>.jpg" /></a>
			</div>
		</div>
	</article>

	<footer>
		<div class="wrapper">
			<a href="#">Sitemap</a> <a href="#">Terms &amp; Conditions</a> <a
				href="#">Shipping &amp; Returns</a> <a href="#">Size Guide</a><a
				href="#">Help</a> <br />
		</div>
	</footer>
</body>
<script type="text/javascript">
	function selected() {
		var ref = document.getElementById("sub");
		var val = (ref.innerHTML == "Select Offer" ? true : false);
		ref.innerHTML = "Selected";
		if (val)
			alert("You have succesfully selected the offer, the seller will be notified immediately!");
			window.location = document.URL + "&selected=true&seller=<%= seller %>&mail=<%= mail %>";
	}
</script>
</html>