<%@page import="vn.edu.vinaenter.util.SlugUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<div class="flex-w p-b-90">
	<div class="w-size6 p-t-30 p-l-15 p-r-15 respon3">
		<img alt="MobileStore" width="300px" src="${pageContext.request.contextPath}/publicUrl/images/icons/logo.png">
	</div>

	<div class="w-size7 p-t-30 p-l-15 p-r-15 respon4">
		<h4 class="s-text12 p-b-30">Danh mục chính</h4>
		<c:if test="${not empty listParent}">
			<ul>
				<c:forEach items="${listParent}" var="objCat">
					<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCat.cname)}/${objCat.cid}/1.html" var="product"></c:set>
					<li class="p-b-9"><a href="${product}" class="s-text7"> ${objCat.cname} </a></li>
				</c:forEach>
			</ul>
		</c:if>
	</div>

	<div class="w-size7 p-t-30 p-l-15 p-r-15 respon4">
		<h4 class="s-text12 p-b-30">Links</h4>

		<ul>
			<li class="p-b-9"><a href="#" class="s-text7"> Search </a></li>

			<li class="p-b-9"><a href="#" class="s-text7"> About Us </a></li>

			<li class="p-b-9"><a href="#" class="s-text7"> Contact Us </a></li>

			<li class="p-b-9"><a href="#" class="s-text7"> Returns </a></li>
		</ul>
	</div>

	<div class="w-size7 p-t-30 p-l-15 p-r-15 respon4">
		<h4 class="s-text12 p-b-30">Help</h4>

		<ul>
			<li class="p-b-9"><a href="#" class="s-text7"> Track Order </a>
			</li>

			<li class="p-b-9"><a href="#" class="s-text7"> Returns </a></li>

			<li class="p-b-9"><a href="#" class="s-text7"> Shipping </a></li>

			<li class="p-b-9"><a href="#" class="s-text7"> FAQs </a></li>
		</ul>
	</div>

	<div class="w-size8 p-t-30 p-l-15 p-r-15 respon3">
		<h4 class="s-text12 p-b-30">Newsletter</h4>

		<form>
			<div class="effect1 w-size9">
				<input class="s-text7 bg6 w-full p-b-5" type="text" name="email"
					placeholder="email@example.com"> <span class="effect1-line"></span>
			</div>

			<div class="w-size2 p-t-20">
				<!-- Button -->
				<button class="flex-c-m size2 bg4 bo-rad-23 hov1 m-text3 trans-0-4">
					Subscribe</button>
			</div>

		</form>
	</div>
</div>

<div class="t-center p-l-15 p-r-15">
	<a href="#"> <img class="h-size2"
		src="${pageContext.request.contextPath}/publicUrl/images/icons/paypal.png"
		alt="IMG-PAYPAL">
	</a> <a href="#"> <img class="h-size2"
		src="${pageContext.request.contextPath}/publicUrl/images/icons/visa.png"
		alt="IMG-VISA">
	</a> <a href="#"> <img class="h-size2"
		src="${pageContext.request.contextPath}/publicUrl/images/icons/mastercard.png"
		alt="IMG-MASTERCARD">
	</a> <a href="#"> <img class="h-size2"
		src="${pageContext.request.contextPath}/publicUrl/images/icons/express.png"
		alt="IMG-EXPRESS">
	</a> <a href="#"> <img class="h-size2"
		src="${pageContext.request.contextPath}/publicUrl/images/icons/discover.png"
		alt="IMG-DISCOVER">
	</a>

	<div class="t-center s-text8 p-t-20">
		Copyright © 2018 All rights reserved. | This template is made with <i
			class="fa fa-heart-o" aria-hidden="true"></i> by <a
			href="https://colorlib.com" target="_blank">Colorlib</a>
	</div>
</div>