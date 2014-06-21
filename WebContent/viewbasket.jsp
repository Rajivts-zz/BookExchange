<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>My Offers</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css'>
<!-- The below script Makes IE understand the new html5 tags are there and applies our CSS to it -->
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
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
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
    	if (session.getAttribute("username") == null) {
    		response.sendRedirect("login.jsp");
    	}
		if (request.getParameter("buyer") != null) {
			String url = "jdbc:h2:d:/mydb";
			Class.forName("org.h2.Driver");
			Connection con = DriverManager.getConnection(url);
			String buyer = request.getParameter("buyer");
			String sql = "UPDATE offer SET buyer = ? WHERE offerID = ?";
	    	PreparedStatement stmt = con.prepareStatement(sql);
	    	stmt.setNull(1, Types.NULL);
	    	stmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
	    	stmt.executeUpdate();
	    	response.sendRedirect("viewbasket.jsp");
		}
		if (request.getParameter("remove") != null) {
			String url = "jdbc:h2:d:/mydb";
			Class.forName("org.h2.Driver");
			Connection con = DriverManager.getConnection(url);
			String sql = "DELETE FROM offer WHERE offerID = ?";
	    	PreparedStatement stmt = con.prepareStatement(sql);
	    	stmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
	    	stmt.executeUpdate();
	    	response.sendRedirect("viewbasket.jsp");
		}
    	String url = "jdbc:h2:d:/mydb";
		Class.forName("org.h2.Driver");
		Connection con = DriverManager.getConnection(url);
    	String user = session.getAttribute("username").toString();
    	String sql = "SELECT * FROM offer WHERE buyer = ?";
    	PreparedStatement stmt = con.prepareStatement(sql);
    	stmt.setString(1, user);
    	ResultSet rs = stmt.executeQuery();
    	
    	ArrayList<String[]> selectedOffers = new ArrayList<String[]>();
    	String arg[] = new String[9];
    	while (rs.next()) {
    		arg[0] = Integer.toString(rs.getInt(1));
    		arg[1] = rs.getString(2);
    		arg[2] = Integer.toString(rs.getInt(3));
    		arg[3] = rs.getString(4);
    		arg[4] = rs.getString(5);
    		arg[5] = rs.getString(6);
    		arg[6] = Integer.toString(rs.getInt(7));
    		arg[7] = Integer.toString(rs.getInt(8));
    		arg[8] = Integer.toString(rs.getInt(9));
    		selectedOffers.add(arg);
    		arg = new String[9];
    	}
    	
    	stmt = con.prepareStatement("SELECT * FROM offer WHERE seller = ?");
    	stmt.setString(1, user);
    	rs = stmt.executeQuery();
    	
    	ArrayList<String[]> uploadedOffers = new ArrayList<String[]>();
    	arg = new String[9];
    	while (rs.next()) {
    		arg[0] = Integer.toString(rs.getInt(1));
    		arg[1] = rs.getString(2);
    		arg[2] = Integer.toString(rs.getInt(3));
    		arg[3] = rs.getString(4);
    		arg[4] = rs.getString(5);
    		arg[5] = rs.getString(6);
    		arg[6] = Integer.toString(rs.getInt(7));
    		arg[7] = Integer.toString(rs.getInt(8));
    		arg[8] = Integer.toString(rs.getInt(9));
    		uploadedOffers.add(arg);
    		arg = new String[9];
    	}
%>



<article id="basket">
<a href="address.jsp" style="text-decoration: none;"><button class="continue">Upload Offer</button></a>
<h1>My Selected Offers</h1>
<table width="100" border="1">
    <tr>
        <th scope="col" class="description">Product</th>
        <th scope="col" class="options">Details</th>
        <th align="right" scope="col" class="price">Price</th>
    </tr>
    <%
    	for (int i = 0; i < selectedOffers.size(); i++) {
    		String image = (selectedOffers.get(i)[3].equals("labcoat") ? selectedOffers.get(i)[3] + selectedOffers.get(i)[4] : selectedOffers.get(i)[3]);
    	%>
		    <tr>
		        <td align="left" valign="top" class="description"><img src="images/<%= image %>.jpg" alt="item" class="left" /><p><strong><%=selectedOffers.get(i)[4] + " " +  selectedOffers.get(i)[3]%></strong><br />This academic material has been selected by you for purchasing, and is currently in the selected state. If your deal gets completed successfully with the seller, then please click on '<strong>remove</strong>' to remove this offer. If you are no longer interested in this offer click '<strong>Cancel Deal</strong>'</p>
		        <button type="submit" onclick="removes('<%= selectedOffers.get(i)[0] %>')">Remove</button></td>
		        <td align="left" valign="top" class="options">
		        	<dl>
		                <dt>Product ID:</dt>
		                <dd><%=selectedOffers.get(i)[0]%></dd>
		                <dt>Product Type:</dt>
		                <dd><%=selectedOffers.get(i)[3]%></dd>
		                <dt>Subject:</dt>
		                <dd><%=selectedOffers.get(i)[4]%></dd>
		                <dt>Semester:</dt>
		                <dd><%=selectedOffers.get(i)[7]%></dd>
		            </dl>
		            <button type="submit" onclick="putBack('<%= selectedOffers.get(i)[0] %>');">Cancel Deal</button>
		        </td>
		        <td align="right" valign="top" class="price">Rs <%=selectedOffers.get(i)[2]%></td>
		    </tr>
    <%	}
    %>
</table>   
<h1>My Uploaded Offers</h1>
<table width="100" border="1">
    <tr>
        <th scope="col" class="description">Product</th>
        <th scope="col" class="options">Details</th>
        <th align="right" scope="col" class="price">Price</th>
    </tr>
    <%
    	for (int i = 0; i < uploadedOffers.size(); i++) {
    		String image = (uploadedOffers.get(i)[3].equals("labcoat") ? uploadedOffers.get(i)[3] + uploadedOffers.get(i)[4] : uploadedOffers.get(i)[3]);
    	%>
		    <tr>
		        <td align="left" valign="top" class="description"><img src="images/<%= image %>.jpg" alt="item" class="left" /><p><strong><%=uploadedOffers.get(i)[4] + " " +  uploadedOffers.get(i)[3]%></strong><br />This academic material has been made available by you for selling. If your deal gets completed successfully with the buyer, then please click on '<strong>Remove</strong>' to remove this offer.</p>
		        <button type="submit" onclick="removes('<%= uploadedOffers.get(i)[0] %>')">Remove</button></td>
		        <td align="left" valign="top" class="options">
		        	<dl>
		                <dt>Product ID:</dt>
		                <dd><%=uploadedOffers.get(i)[0]%></dd>
		                <dt>Product Type:</dt>
		                <dd><%=uploadedOffers.get(i)[3]%></dd>
		                <dt>Subject:</dt>
		                <dd><%=uploadedOffers.get(i)[4]%></dd>
		                <dt>Semester:</dt>
		                <dd><%=uploadedOffers.get(i)[7]%></dd>
		            </dl>
		        </td>
		        <td align="right" valign="top" class="price">Rs <%=uploadedOffers.get(i)[2]%></td>
		    </tr>
    <%	}
    %>
</table>   
</article>
<footer>
	<div class="wrapper">
        <a href="#">Sitemap</a> <a href="#">Terms &amp; Conditions</a> <a href="#">Shipping &amp; Returns</a> <a href="#">Size Guide</a><a href="#">Help</a> <br />
    </div>
</footer>
</body>
<script type="text/javascript">
	function putBack(i) {
		alert("Your selected offer will now be removed from your selected list and added to the list of available offers!");
		window.location = document.URL + "?buyer=<%= session.getAttribute("username").toString()%>&ID=" + i;
	}
	function removes(i) {
		alert("Your offer will now be removed from your list and from the list of available offers assuming that the deal has been completed succesfully!");
		window.location = document.URL + "?remove=yes&ID=" + i;
	}
</script>
</html>