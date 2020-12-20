<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>

<nav class="navbar top-navbar navbar-expand-md navbar-dark">
	<div class="navbar-header" data-logobg="skin5">
		<!-- This is for the sidebar toggle which is visible on mobile only -->
		<a class="nav-toggler waves-effect waves-light d-block d-md-none"
			href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
		<!-- ============================================================== -->
		<!-- Logo -->
		<!-- ============================================================== -->
		<a class="navbar-brand" href="${pageContext.request.contextPath}/"> <!-- Logo text --> <span
			class="logo-text"> <!-- dark Logo text --> <img width="228px"
				height="63px"
				src="${pageContext.request.contextPath}/adminUrl/assets/images/logo.png"
				alt="homepage" class="light-logo" />

		</span> <!-- Logo icon --> <!-- <b class="logo-icon"> --> <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
			<!-- Dark Logo icon --> <!-- <img src="assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->

			<!-- </b> --> <!--End Logo icon -->
		</a>
		<!-- ============================================================== -->
		<!-- End Logo -->
		<!-- ============================================================== -->
		<!-- ============================================================== -->
		<!-- Toggle which is visible on mobile only -->
		<!-- ============================================================== -->
		<a class="topbartoggler d-block d-md-none waves-effect waves-light"
			href="javascript:void(0)" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation"><i class="ti-more"></i></a>
	</div>
	<!-- ============================================================== -->
	<!-- End Logo -->
	<!-- ============================================================== -->
	<div class="navbar-collapse collapse" id="navbarSupportedContent"
		data-navbarbg="skin5">
		<!-- ============================================================== -->
		<!-- toggle and nav items -->
		<!-- ============================================================== -->
		<div class="navbar-nav float-left mr-auto"></div>
		<!-- ============================================================== -->
		<!-- Right side toggle and nav items -->
		<!-- ============================================================== -->
		<ul class="navbar-nav float-right">
			<!-- ============================================================== -->
			<!-- User profile and search -->
			<!-- ============================================================== -->
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic"
				href="" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i style="color: white;" class="mdi font-22">${inforUser.username}</i> <img
					src="${pageContext.request.contextPath}/adminUrl/assets/images/users/1.jpg"
					alt="user" class="rounded-circle" width="31"></a>
				<div class="dropdown-menu dropdown-menu-right user-dd animated">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/user/profile/${inforUser.id}"><i
						class="ti-user m-r-5 m-l-5"></i> My Profile</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout"><i
						class="fa fa-power-off m-r-5 m-l-5"></i>Đăng xuất</a>
					<div class="dropdown-divider"></div>
				</div></li>
			<!-- ============================================================== -->
			<!-- User profile and search -->
			<!-- ============================================================== -->
		</ul>
	</div>
</nav>