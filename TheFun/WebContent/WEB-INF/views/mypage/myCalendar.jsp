<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" href="CSS/Calendar/style.css">

<header id="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY SCHEDULE</h1>
    <p>내 일정</p>
  </div>
</header>

<body>
<div id="calendar"></div>
<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.5.1/moment.min.js"></script>
<script src="js/Calendar/index.js"></script>
</body>