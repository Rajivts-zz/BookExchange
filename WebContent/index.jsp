<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Book Exchange</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css'>
<!-- The below script Makes IE understand the new html5 tags are there and applies our CSS to it -->
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body id="home">
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
<aside id="top" style = "background : rgba(141, 137, 137, 0.39);">
	<div class="wrapper">
        <ul id="social">
            <li><a href="#" class="facebook" title="like us us on Facebook">like us on Facebook</a></li>
            <li><a href="#" class="twitter" title="follow us on twitter">follow us on twitter</a></li>
        </ul>
        <form>
     
        </form>
        <div id="action-bar"><a href="login.jsp?msg=loggedout">Logout</a> ||  &nbsp; Welcome, <h3 style = "margin: 0; padding: 0; display: inline;"><%= session.getAttribute("username") %></h3></div>
    </div>
</aside>
<article>
	<a href="#" onclick = "return false" style = "cursor : default;"><img src="images/photo.jpg" /></a>
</article>
<footer>
	<div class="wrapper">
       <a href="#">Sitemap</a> <a href="#">Terms &amp; Conditions</a> <a href="#">Shipping &amp; Returns</a> <a href="#">Size Guide</a><a href="#">Help</a> <br />
    </div>
</footer>
</body>
<%
	if (session.getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
	}
%>
</html>