<%@page import="duynguyen.model.dao.CategoryDAO"%>
<%@page import="duynguyen.util.SlugUtil"%>
<%@page import="com.sun.corba.se.spi.ior.MakeImmutable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Title Page -->
	<section class="bg-title-page p-t-50 p-b-40 flex-col-c-m" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
		<h2 class="l-text2 t-center">
			Sản phẩm yêu thích
		</h2>
		<p class="m-text13 t-center">
			MobileStore 2020
		</p>
	</section>


	<!-- Content page -->
	<section class="bgwhite p-t-55 p-b-65">
		<div class="container">
			<div class="row">

				<div class="col-sm-6 col-md-4 col-lg-3 p-b-50">
					<div class="leftbar p-r-20 p-r-0-sm">
						<!--  -->
						<h4 class="m-text14 p-b-7">
							Danh mục sản phẩm
						</h4>

						<ul class="p-b-54">
							<li class="p-t-4">
								<a href="${pageContext.request.contextPath}/product/1.html" class="s-text13 active1">
									All
									<span class="badge badge-secondary">${bookDao.totalProductPublic()}</span>
								</a>
							</li>
							<c:if test="${not empty listParent}">
								<c:forEach items="${listParent}" var="objCat">
									<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCat.cname)}/${objCat.cid}/1.html" var="product"></c:set>
									<li class="p-t-4">
										<a id="${objCat.cid}" href="${product}" class="s-text13">
											${objCat.cname}
											<span class="badge badge-secondary">${bookDao.totalProductByParentIdPublic(objCat.cid)}</span>
										</a>
										<c:set var="listChild" value="${catDao.getItemsParent(objCat.cid)}"></c:set>
										<c:if test="${not empty listChild}">
											<ul class="p-b-54">
												<c:forEach items="${listChild}" var="objCatChild">
													<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCatChild.cname)}/${objCatChild.cid}/1.html" var="product"></c:set>
													<li class="d-2"><a id="${objCatChild.cid}" href="${product}">${objCatChild.cname}
														<span class="badge badge-secondary">${bookDao.totalBookByCidPublic(objCatChild.cid)}</span></a>
													</li>
												</c:forEach>
											</ul>				
										</c:if>
									</li>
								</c:forEach>
							</c:if>
							
						</ul>
						
					</div>
				</div>

				<div class="col-sm-6 col-md-8 col-lg-9 p-b-50">
				
					<!-- Product -->
					<div id="area-favorite" class="row">
						<c:if test="${not empty listFavorite}">
							<c:forEach items="${listFavorite}" var="objPro">
								<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objPro.product.cname)}/${objPro.product.cid}/${SlugUtil.makeSlug(objPro.product.bname)}/${objPro.product.bid}.html" var="urlDetail"></c:set>
								<c:choose>
									<c:when test="${objPro.product.discount > 0}">
										<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelsale"></c:set>
									</c:when>
									<c:otherwise>
										<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelnew"></c:set>
									</c:otherwise>
								</c:choose>
								<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">
									<!-- Block2 -->
									<div class="block2">
										<div class="${pro}">
											<img width="272px" height="272px" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.product.picture}" alt="IMG-PRODUCT">
		
											<div class="block2-overlay trans-0-4">
												<div class="block2-btn-addcart w-size1 trans-0-4">
													<a onclick="return addCart(${objPro.product.bid});" href="javascript:void(0);" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
														<i style="font-size: 25px;" class="fa fa-shopping-cart"></i>
													</a>
												</div>
											</div>
										</div>
										<div class="block2-txt p-t-20" style="text-align: center;">
											<a style="font-weight: bolder;" href="${urlDetail}" class="block2-name dis-block s-text3 p-b-5">
												${objPro.product.bname}
											</a>
											
											<span class="block2-price m-text6 p-r-5">
												${Integer.valueOf(objPro.product.price)} VND
											</span>
											
											<a onclick="return deleteFavorite(${objPro.product.bid});" href="javascript:void(0);" class="block2-price m-text6 p-r-5">
												<i class="fa fa-trash"></i>
											</a>
		
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${empty listFavorite}">
							<span>Empty</span>
						</c:if>
					</div>
					<%-- <c:if test="${numberOfPage > 1}">
						<!-- Pagination -->
						<div class="pagination flex-m flex-w p-t-26">
							<c:forEach begin="1" end="${numberOfPage}" var="i">
								<c:choose>
									<c:when test="${currentPage == i}">
										<c:set var="active" value="item-pagination flex-c-m trans-0-4 active-pagination"></c:set>
									</c:when>
									<c:otherwise>
										<c:set var="active" value="item-pagination flex-c-m trans-0-4"></c:set>
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath}/favorite/${i}.html" class="${active}">${i}</a>
							</c:forEach>
						</div>
					</c:if> --%>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			document.getElementById("like").classList.add('active-menu');
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
			function deleteFavorite(x){
				$.ajax({
					url: '${pageContext.request.contextPath}/deletefavorite',
					type: 'POST',
					cache: false,
					data: {
						aId : x
					},
					success: function(data) {
						var result = '';
						var pro = '';
						$.each(data, function(key, item){
							if (item['product']['discount'] > 0) {
								pro += 'block2-img wrap-pic-w of-hidden pos-relative block2-labelsale';
							} else {
								pro += 'block2-img wrap-pic-w of-hidden pos-relative block2-labelnew';
							}
							result += '<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">';
							result += 	'<div class="block2">';
							result += 		'<div class="' + pro + '">';
							result +=			'<img width="272px" height="272px" src="${pageContext.request.contextPath}/pathUrl/files/' + item['product']['picture'] + '" alt="IMG-PRODUCT">';
							result +=			'<div class="block2-overlay trans-0-4">';
							result += 				'<div class="block2-btn-addcart w-size1 trans-0-4">';
							result += 					'<a onclick="return addCart(' + item['product']['bid'] + ');" href="javascript:void(0);" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4"><i style="font-size: 25px;" class="fa fa-shopping-cart"></i></a>';
							result += 				'</div>';
							result += 			'</div>';
							result +=		'</div>';
							result += 		'<div class="block2-txt p-t-20" style="text-align: center;">';
							result += 			'<a style="font-weight: bolder;" href="#" class="block2-name dis-block s-text3 p-b-5">' + item['product']['bname'] + '</a>';
							result += 			'<span class="block2-price m-text6 p-r-5">' + item['product']['price'] + ' VNĐ</span>';
							result += 			'<a onclick="return deleteFavorite(' + item['product']['bid'] + ');" href="javascript:void(0);" class="block2-price m-text6 p-r-5"><i class="fa fa-trash"></i></a>';
							result +=		'</div>';
							result +=	'</div>';
							result += '</div>';
						});
						$(function(){
							$('#area-favorite').empty();
						});
						$(function(){
							$('#area-favorite').append(result);
						});
						$(function(){
							$('#total-items-favorite').empty();
						});
						$(function(){
							$('#total-items-favorite').append(data.length);
						});
					},
					error: function() {
						alert('Error!');
					}
				});
				return false;
			}
		</script>
	</section>