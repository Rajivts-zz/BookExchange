<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Search Offers</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css'>
<!-- The below script Makes IE understand the new html5 tags are there and applies our CSS to it -->
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<body>
<script type="text/javascript">
	function addSort() {
		var elem = document.getElementById("sortBy");
		var val = elem.options[elem.selectedIndex].value;
		var ordering = "";
		if (val == "Default") {
			ordering = "offerID";
			
		}
		else if (val == "PriceHiLo") {
			ordering = "price DESC";
		}
		else if (val == "PriceLoHi") {
			ordering = "price";
		}
		else if (val == "Subject") {
			ordering = "subject";
		}
		else {
			if (<%= request.getParameter("item").equals("book") %> ){
				ordering = "edition DESC";
			}
			else {
				ordering = "offerID";
			}
		}
		if (document.URL.indexOf("orderBy") < 0) {
			window.location = document.URL + "&orderBy=" + ordering;
		}
		else {
			var index = document.URL.indexOf("orderBy");
			window.location = document.URL.substring(0, index) + "orderBy=" + ordering;
		}
	}
</script>
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
        	<input type="text" placeholder="Search " <%= request.getParameter("item") %>  /><button type="submit">Search</button>
        </form>
        <div id="action-bar"><a href="login.jsp?msg=loggedout">Logout</a> ||  &nbsp; Welcome, <h3 style = "margin: 0; padding: 0; display: inline;"><%= session.getAttribute("username") %></h3></div>
    </div>
</aside>
    	<%
    	if (session.getAttribute("username") == null) {
    		response.sendRedirect("login.jsp");
    	}
    	String url = "jdbc:h2:d:/mydb";
    	String ordering = (request.getParameter("orderBy") == null ? "offerID" : request.getParameter("orderBy"));
		Class.forName("org.h2.Driver");
		Connection con = DriverManager.getConnection(url);
    	String type = request.getParameter("item");
    	String year = request.getParameter("year");
    	PreparedStatement stmt;
    	if (year == null || year.equals("")) {
    		String sql = "SELECT * FROM offer WHERE offerType = ? AND seller != ? AND buyer IS NULL ORDER BY " + ordering;
    		stmt = con.prepareStatement(sql);
    		stmt.setString(1, type);
    		stmt.setString(2, session.getAttribute("username").toString());
    	}
    	else {
    		stmt = con.prepareStatement("SELECT * FROM offer WHERE offerType = ? AND year = ? AND seller != ? AND buyer IS NULL ORDER BY " + ordering);
        	stmt.setString(1, type);
        	stmt.setInt(2, Integer.parseInt(year));
        	stmt.setString(3, session.getAttribute("username").toString());
    	}
    	ResultSet rs = stmt.executeQuery();
    	ArrayList<String[]> arr = new ArrayList<String[]>();
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
    		arr.add(arg);
    		arg = new String[9];
    	}
    	%>
<article id="grid">
	<div id="breadcrumb"><a href="index.jsp">Home</a> > <a href="search.html"><%= request.getParameter("item") %></a> > <h1><%= (request.getParameter("year") == null ? "" : "Year " + request.getParameter("year")) %></h1></div>
    <header>
        
        <form action="#" >
        <label for="sortBy">Sort By &nbsp;</label>
        <select onchange="javascript:addSort();" name="sortBy" id="sortBy">
            <option value="Default">Default</option>
            <option value="PriceHiLo">Price (High to Low)</a></option>
            <option value="PriceLoHi">Price (Low to High)</option>
            <option value="Subject">Subject</option>
            <option value="Edition">Edition</option>
        </select> &nbsp; Showing <%= arr.size() %> item(s) that match your query
        </form>
    </header>
    <ul id="items">
    	<%
    	for (int i = 0; i < arr.size(); i++) {
    	%>
    	<li>
            <a href="main.jsp?ID=<%= arr.get(i)[0]%>&item=<%= arr.get(i)[3]%>&subject=<%=arr.get(i)[4] %>&year=<%= (request.getParameter("year") == null ? "": request.getParameter("year"))%>"><img src="images/<%=(!request.getParameter("item").equals("labcoat") ? request.getParameter("item") : request.getParameter("item") + arr.get(i)[4]) %>.jpg" alt="Item"/></a>
            <a href="main.jsp?ID=<%= arr.get(i)[0]%>&item=<%= arr.get(i)[3]%>&subject=<%=arr.get(i)[4] %>&year=<%= (request.getParameter("year") == null ? "": request.getParameter("year"))%>" class="title"><%= arr.get(i)[4] + " " +arr.get(i)[3] + "--" + (arr.get(i)[5] == null ? "" : arr.get(i)[5]) + " " + (arr.get(i)[8].equals("0") ? "" : arr.get(i)[8]) %></a>
            <strong>RS <%= arr.get(i)[2] %> &nbsp;&nbsp;&nbsp;&nbsp;-By <%= arr.get(i)[1] %></strong>
        </li>
    	<%
    	}
    	%>
        
    </ul>
    <footer>
        
    </footer>
</article>
<footer>
	<div class="wrapper">
        <a href="#">Sitemap</a> <a href="#">Terms &amp; Conditions</a> <a href="#">Shipping &amp; Returns</a> <a href="#">Size Guide</a><a href="#">Help</a> <br /> 
    </div>
</footer>
</body>
</html>
