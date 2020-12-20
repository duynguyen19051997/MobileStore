<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Title Page -->
	<section class="bg-title-page p-t-50 p-b-40 flex-col-c-m" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
		<h2 class="l-text2 t-center">
			Đăng ký thành viên
		</h2>
	</section>

	<!-- content page -->
	<section class="bgwhite p-t-66 p-b-60">
		<div class="container">
			<div class="row">

				<div class="col-md-6 p-b-30">
					<c:if test="${not empty msg}">
						<h4 class="m-text26 p-b-36 p-t-15">
							<span style="color: red;">${msg}</span>
						</h4>
					 </c:if>
					<form id="registedform" class="leave-comment" action="" method="POST">
						<h4 class="m-text26 p-b-36 p-t-15">
							Đăng ký thành viên
						</h4>
						
						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="username" placeholder="Username">
						</div>
						
						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="fullname" placeholder="fullname">
						</div>

						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="password" name="password" placeholder="password">
						</div>

						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="email" placeholder="Email">
						</div>
						
						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="address" placeholder="Địa chỉ">
						</div>
						
						<div class="bo4 size15 m-b-20">
							<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="phone" placeholder="Số điện thoại">
						</div>

						<div class="w-size25">
							<!-- Button -->
							<button class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4" type="submit">
								Đăng ký
							</button>
						</div>
					</form>
					
					<script type="text/javascript">
						document.getElementById("registed").classList.add('active-menu');
						$(document).ready(function(){
			        		$('#registedform').validate({
			        			rules:{
			        				username: {
										required: true
									},
									fullname: {
										required: true
									},
									password: {
										required: true
									},
									email: {
										required: true,
										email: true
									},
									address: {
										required: true
									},
									phone: {
										required: true,
										number: true
									}
			        			},
			        			messages:{
			        				username: {
										required: 'Vui lòng nhập Username!'
									},
									fullname: {
										required: 'Vui lòng nhập tên đầy đủ !'
									},
									password: {
										required: 'Vui lòng nhập password !'
									},
									email: {
										required: 'Vui lòng nhập email !',
										email: 'Định dạng email không chính xác !'
									},
									address: {
										required: 'Vui lòng nhập địa chỉ!'
									},
									phone: {
										required: 'Vui lòng nhập số điện thoại !',
										number: 'Định dạng số điện thoại không chính xác !'
									}
			        			},
			        		});
			        	});
					</script>
				</div>
			</div>
		</div>
	</section>