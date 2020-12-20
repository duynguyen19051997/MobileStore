<%@page import="vn.edu.vinaenter.util.SlugUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Slide1 -->
	<section class="slide1">
		<div class="wrap-slick1">
			<div class="slick1">
				<c:if test="${not empty listSlide}">
					<c:forEach items="${listSlide}" var="objSlide">
						<div class="item-slick1 item1-slick1" style="background-image: url(${pageContext.request.contextPath}/pathUrl/files/${objSlide.slide});">
							<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
								<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="fadeInDown">
									Mobile Store 2020
								</span>
		
								<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="fadeInUp">
									Cửa hàng bán điện thoại di động
								</h2>
		
								<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="zoomIn">
									<!-- Button -->
									<a href="${pageContext.request.contextPath}/product/1.html" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
										Shop Now
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty listSlide}">
					<div class="item-slick1 item1-slick1" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
						<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
							<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="fadeInDown">
								Mobile Store 2020
							</span>
	
							<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="fadeInUp">
								Cửa hàng bán điện thoại di động
							</h2>
	
							<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="zoomIn">
								<!-- Button -->
								<a href="${pageContext.request.contextPath}/product/1.html" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
									Shop Now
								</a>
							</div>
						</div>
					</div>
	
					<div class="item-slick1 item2-slick1" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_2.jpg);">
						<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
							<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="rollIn">
								Book Collection 2018
							</span>
	
							<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="lightSpeedIn">
								New arrivals
							</h2>
	
							<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="slideInUp">
								<!-- Button -->
								<a href="${pageContext.request.contextPath}/product/1.html" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
									Shop Now
								</a>
							</div>
						</div>
					</div>
	
					<div class="item-slick1 item3-slick1" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_3.jpg);">
						<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
							<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="rotateInDownLeft">
								MobileStore 2020
							</span>
	
							<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="rotateInUpRight">
								Cửa hàng bán điện thoại di động
							</h2>
	
							<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="rotateIn">
								<!-- Button -->
								<a href="${pageContext.request.contextPath}/product/1.html" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</c:if>

			</div>
		</div>
	</section>
	
	<!-- Banner -->
	<section class="banner bgwhite p-t-40 p-b-40">
		<div class="container">
			<div class="row">

				<div class="col-sm-10 col-md-8 col-lg-4 m-l-r-auto">
					<c:if test="${empty user}">
					
						<!-- block2 -->
						<div class="block2 wrap-pic-w pos-relative m-b-30">
							<img src="${pageContext.request.contextPath}/publicUrl/images/khuyenmai.png" alt="IMG">
	
							<div class="block2-content sizefull ab-t-l flex-col-c-m">
								<h4 class="m-text4 t-center w-size3 p-b-8">
									Sign in and get 20% discount
								</h4>
	
								<p class="t-center w-size4">
									Be the frist to know about the latest fashion news and get exclu-sive offers
								</p>
	
								<div class="w-size2 p-t-25">
									<!-- Button -->
									<a href="${pageContext.request.contextPath}/login.html" class="flex-c-m size2 bg4 bo-rad-23 hov1 m-text3 trans-0-4">
										Đăng nhập
									</a>
								</div>
							</div>
						</div>
						
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
	<!-- New Product -->
	<section class="newproduct bgwhite p-t-45 p-b-105">
		<div class="container">
			<div class="sec-title p-b-60">
				<h3 class="m-text5 t-center">
						Sản phẩm được tìm kiếm nhiều nhất
				</h3>
			</div>

			<!-- Slide2 -->
			<div class="wrap-slick2">
				<div class="slick2">
					<c:if test="${not empty listProCountView}">
						<c:forEach var="objPro" items="${listProCountView}">
							<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objPro.cname)}/${objPro.cid}/${SlugUtil.makeSlug(objPro.bname)}/${objPro.bid}.html" var="urlDetail"></c:set>
							<c:choose>
								<c:when test="${objPro.discount > 0}">
									<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelsale"></c:set>
								</c:when>
								<c:otherwise>
									<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelnew"></c:set>
								</c:otherwise>
							</c:choose>
							<div class="item-slick2 p-l-15 p-r-15">
								<!-- Block2 -->
								<div class="block2">
									<div class="${pro}">
										<img width="272px" height="272px" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}" alt="IMG-PRODUCT">
		
										<div class="block2-overlay trans-0-4">
											<a onclick="return addFavorite(${objPro.bid});" href="javascript:void(0);" class="block2-btn-addwishlist hov-pointer trans-0-4">
												<i class="icon-wishlist icon_heart_alt" aria-hidden="true"></i>
												<i class="icon-wishlist icon_heart dis-none" aria-hidden="true"></i>
											</a>
		
											<div class="block2-btn-addcart w-size1 trans-0-4">
												<!-- Button -->
												<a onclick="return addCart(${objPro.bid});" href="javascript:void(0);" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
													<i style="font-size: 25px;" class="fa fa-shopping-cart"></i>
												</a>
											</div>
										</div>
									</div>
		
									<div class="block2-txt p-t-20" style="text-align: center;">
										<a href="${urlDetail}" style="font-weight: bolder;" class="block2-name dis-block s-text3 p-b-5">
											${objPro.bname}
										</a>
		
										<span class="block2-price m-text6 p-r-5">
											Giá: ${Integer.valueOf(objPro.price)} VND
										</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
	<!-- New Product -->
	<section class="newproduct bgwhite p-t-45 p-b-105">
		<div class="container">
			<div class="sec-title p-b-60">
				<h3 class="m-text5 t-center">
					Sản phẩm mới
				</h3>
			</div>

			<!-- Slide2 -->
			<div class="wrap-slick2">
				<div class="slick2">
					<c:if test="${not empty listProLast}">
						<c:forEach var="objPro" items="${listProLast}">
							<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objPro.cname)}/${objPro.cid}/${SlugUtil.makeSlug(objPro.bname)}/${objPro.bid}.html" var="urlDetail"></c:set>
							<c:choose>
								<c:when test="${objPro.discount > 0}">
									<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelsale"></c:set>
								</c:when>
								<c:otherwise>
									<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelnew"></c:set>
								</c:otherwise>
							</c:choose>
							<div class="item-slick2 p-l-15 p-r-15">
								<!-- Block2 -->
								<div class="block2">
									<div class="${pro}">
										<img width="272px" height="272px" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}" alt="IMG-PRODUCT">
		
										<div class="block2-overlay trans-0-4">
											<a onclick="return addFavorite(${objPro.bid});" href="javascript:void(0);" class="block2-btn-addwishlist hov-pointer trans-0-4">
												<i class="icon-wishlist icon_heart_alt" aria-hidden="true"></i>
												<i class="icon-wishlist icon_heart dis-none" aria-hidden="true"></i>
											</a>
		
											<div class="block2-btn-addcart w-size1 trans-0-4">
												<!-- Button -->
												<a onclick="return addCart(${objPro.bid});" href="javascript:void(0);" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
													<i style="font-size: 25px;" class="fa fa-shopping-cart"></i>
												</a>
											</div>
										</div>
									</div>
		
									<div class="block2-txt p-t-20" style="text-align: center;">
										<a href="${urlDetail}" style="font-weight: bolder;" class="block2-name dis-block s-text3 p-b-5">
											${objPro.bname}
										</a>
		
										<span class="block2-price m-text6 p-r-5">
											Giá: ${Integer.valueOf(objPro.price)} VND
										</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<script type="text/javascript">
				function addCart(x){
					$.ajax({
						url: '${pageContext.request.contextPath}/addcart',
						type: 'POST',
						cache: false,
						data: {
							aIdPro : x
						},
						success: function(data) {
							$('#total-items').html(data);
						},
						error: function() {
							alert('Error!');
						}
					});
					return false;
				}
			</script>
		</div>
	</section>

	<!-- Banner2 -->
	<section class="banner2 bg5 p-t-55 p-b-55">
		<div class="container">
			<div class="row">
				<div class="col-sm-10 col-md-8 col-lg-6 m-l-r-auto p-t-15 p-b-15">
					<div class="hov-img-zoom pos-relative">
						<img src="${pageContext.request.contextPath}/publicUrl/images/km.jpg" alt="IMG-BANNER">

						<div class="ab-t-l sizefull flex-col-c-m p-l-15 p-r-15">
							<span class="m-text9 p-t-45 fs-20-sm">
								The Beauty
							</span>

							<h3 class="l-text1 fs-35-sm">
								Lookbook
							</h3>

							<a href="#" class="s-text4 hov2 p-t-20 ">
								View Collection
							</a>
						</div>
					</div>
				</div>

				<div class="col-sm-10 col-md-8 col-lg-6 m-l-r-auto p-t-15 p-b-15">
					<div class="bgwhite hov-img-zoom pos-relative p-b-20per-ssm">
						<img src="${pageContext.request.contextPath}/publicUrl/images/km2.png" alt="IMG-BANNER">

						<div class="ab-t-l sizefull flex-col-c-b p-l-15 p-r-15 p-b-20">
							<div class="t-center">
								<a href="product-detail.html" class="dis-block s-text3 p-b-5">
									Gafas sol Hawkers one
								</a>

								<span class="block2-oldprice m-text7 p-r-5">
									$29.50
								</span>

								<span class="block2-newprice m-text8">
									$15.90
								</span>
							</div>

							<div class="flex-c-m p-t-44 p-t-30-xl">
								<div class="flex-col-c-m size3 bo1 m-l-5 m-r-5">
									<span class="m-text10 p-b-1 days">
										69
									</span>

									<span class="s-text5">
										days
									</span>
								</div>

								<div class="flex-col-c-m size3 bo1 m-l-5 m-r-5">
									<span class="m-text10 p-b-1 hours">
										04
									</span>

									<span class="s-text5">
										hrs
									</span>
								</div>

								<div class="flex-col-c-m size3 bo1 m-l-5 m-r-5">
									<span class="m-text10 p-b-1 minutes">
										32
									</span>

									<span class="s-text5">
										mins
									</span>
								</div>

								<div class="flex-col-c-m size3 bo1 m-l-5 m-r-5">
									<span class="m-text10 p-b-1 seconds">
										05
									</span>

									<span class="s-text5">
										secs
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>