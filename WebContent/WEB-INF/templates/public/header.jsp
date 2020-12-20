<%@page import="duynguyen.model.bean.Book"%>
<%@page import="duynguyen.model.dao.BookDAO"%>
<%@page import="duynguyen.util.ActionCart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="duynguyen.model.bean.Item"%>
<%@page import="java.util.List"%>
<%@page import="duynguyen.util.SlugUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Header desktop -->
<div class="container-menu-header">
	<div class="topbar">

		<span class="topbar-child1"> Chào mừng đến với MobileStore </span>
		<%
			if (session.getAttribute("listCart") == null) {
				List<Item> listCart = new ArrayList<Item>();
				session.setAttribute("listCart", listCart);
			}
			if (session.getAttribute("listFavorite") == null) {
				List<Item> listFavorite = new ArrayList<Item>();
				session.setAttribute("listFavorite", listFavorite);
			}
		%>
	</div>

	<div class="wrap_header">
		<!-- Logo -->
		<a href="${pageContext.request.contextPath}/" class="logo"> <img
			src="${pageContext.request.contextPath}/publicUrl/images/icons/logo.png"
			alt="IMG-LOGO">
		</a>

		<div class="search-product pos-relative bo4 of-hidden">
			<form action="${pageContext.request.contextPath}/search.html" method="GET" id="formsearch">
				<input class="s-text7 size6 p-l-23 p-r-50" type="text"
				name="searchproduct" placeholder="Bạn muốn tìm gì..." value='<c:if test="${not empty search}">${search}</c:if>'>

				<button type="submit" class="flex-c-m size5 ab-r-m color2 color0-hov trans-0-4">
					<i class="fs-12 fa fa-search" aria-hidden="true"></i>
				</button>
				
				<script type="text/javascript">
					$(document).ready(function(){
		        		$('#formsearch').validate({
		        			rules:{
		        				searchproduct:{
		        					required:true
		        				}
		        			},
		        			messages:{
		        				searchproduct:{
		        					required:'Not empty, please !'
		        				}
		        			},
		        		});
		        	});
				</script>				
			</form>
		</div>

		<!-- Menu -->
		<div class="wrap_menu">
			<nav class="menu">
			
				<ul class="main_menu">
					<li><a id="product" href="${pageContext.request.contextPath}/product/1.html">Sản Phẩm</a>
						<ul class="sub_menu">
							<c:if test="${not empty listParent}">
								<c:forEach items="${listParent}" var="objCat">
									<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCat.cname)}/${objCat.cid}/1.html" var="product"></c:set>
									<li><a href="${product}">${objCat.cname}</a>
										<c:set var="listChild" value="${catDao.getItemsParent(objCat.cid)}"></c:set>
										<c:if test="${not empty listChild}">
											<ul class="sub_menu">
												<c:forEach items="${listChild}" var="objCatChild">
													<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCatChild.cname)}/${objCatChild.cid}/1.html" var="product"></c:set>
													<li><a href="${product}">${objCatChild.cname}</a></li>
												</c:forEach>
											</ul>				
										</c:if>
									</li>
								</c:forEach>								
							</c:if>
						</ul>
					</li>
					<li><a id="cart" href="${pageContext.request.contextPath}/cart.html">Giỏ hàng</a></li>
					<li><a id="like" href="${pageContext.request.contextPath}/favorite.html">
							Sản phẩm yêu thích
							<span id="total-items-favorite" class="header-icons-noti">${ActionCart.totalItems(listFavorite)}</span>
						</a>
					</li>
					<c:choose>
						<c:when test="${empty user}">
							<li><a id="login" href="${pageContext.request.contextPath}/login.html">Đăng nhập</a></li>
							<li><a id="registed" href="${pageContext.request.contextPath}/registed.html">Đăng ký</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/logout.html">Đăng xuất</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
				
			</nav>
		</div>

		<!-- Header Icon -->
		<div class="header-icons">
			<c:choose>
				<c:when test="${not empty user}">
					<a href="${pageContext.request.contextPath}/logout.html" class="header-wrapicon1 dis-block" title="Sign in"> 
						Hello, ${user.username}
						<img
						src="${pageContext.request.contextPath}/publicUrl/images/icons/icon-header-01.png"
						class="header-icon1" alt="ICON">
					</a> <span class="linedivide1"></span>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/login.html" class="header-wrapicon1 dis-block" title="Sign in"> 
						<img
						src="${pageContext.request.contextPath}/publicUrl/images/icons/icon-header-01.png"
						class="header-icon1" alt="ICON">
					</a> <span class="linedivide1"></span>
				</c:otherwise>
			</c:choose>
			
			<div  class="header-wrapicon2">
				<img onclick="return showCart();" src="${pageContext.request.contextPath}/publicUrl/images/icons/icon-header-02.png"
				class="header-icon1 js-show-header-dropdown" alt="ICON"> 
				<span id="total-items" class="header-icons-noti">${ActionCart.totalItems(listCart)}</span>

				<!-- Header cart noti -->
				<div id="giohang" class="header-cart header-dropdown">
				</div>
			</div>
			<script type="text/javascript">
				function addFavorite(x){
					$.ajax({
						url: '${pageContext.request.contextPath}/addfavorite',
						type: 'POST',
						cache: false,
						data: {
							aIdPro : x
						},
						success: function(data) {
							$('#total-items-favorite').html(data);
						},
						error: function() {
							alert('Error!');
						}
					});
					return false;
				}
				function showCart(){
					$.ajax({
						url: '${pageContext.request.contextPath}/showcart',
						type: 'POST',
						cache: false,
						data: {
						},
						success: function(data) {
							var result = '';
							var totalNumber = 0;
							var total = 0;
							result += '<ul class="header-cart-wrapitem">';
							$.each(data, function(key, item){
								totalNumber += item['quantity'];
								total += item['quantity'] * item['product']['price'] * ( 1 - item['product']['discount']);
								result += '<li id="' + key + '" class="header-cart-item">';
								result += 	'<div class="header-cart-item-img">';
								result += 		'<img onclick="return deleteCart('+ item['product']['bid'] +');" src="${pageContext.request.contextPath}/pathUrl/files/' + item['product']['picture'] + '" alt="IMG">';
								result += 	'</div>';
								result += 	'<div class="header-cart-item-txt">';
								result +=		'<a href="#" class="header-cart-item-name">';
								result +=			item['product']['bname'];
								result +=		'</a>';
								result +=		'<span class="header-cart-item-info">';
								result +=			item['quantity'] + ' x ' + item['product']['price'] + ' VNĐ';
								result +=		'</span>';
								result +=		'<a onclick="return deleteCart('+ item['product']['bid'] +');" href="javascript:void(0);" class="header-cart-item-info"><i class="fa fa-trash"></i></a>';
								result += 	'</div>';
								result += '</li>';
							});
							result += '</ul>';
							result += '<div class="header-cart-total">';
							result += 	'Thành tiền: ' + total + ' VND';
							result += '</div>';
							result += '<div class="header-cart-buttons">';
							result += 	'<div class="header-cart-wrapbtn">';
							result += 		'<a href="${pageContext.request.contextPath}/cart.html" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">Giỏ hàng</a>';
							result += 	'</div>';
							result += 	'<div class="header-cart-wrapbtn">';
							result += 		'<a href="${pageContext.request.contextPath}/check.html" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">Thanh toán</a>';
							result += 	'</div>';
							result += '</div>';
							$(function(){
								$('#giohang').empty();
							});
							$(function(){
								$('#giohang').append(result);
							});
							$(function(){
								$('#total-items').empty();
							});
							$(function(){
								$('#total-items').append(totalNumber);
							});
						},
						error: function() {
							alert('Error!');
						}
					});
					return false;
				}
				function deleteCart(x){
					$(function(){
						$('#giohang').empty();
					});
					$.ajax({
						url: '${pageContext.request.contextPath}/deletecart',
						type: 'POST',
						cache: false,
						data: {
							aId : x
						},
						success: function(data) {
							var result = '';
							var totalNumber = 0;
							var total = 0;
							var cart = '';
							cart += '<div class="wrap-table-shopping-cart bgwhite">';
							cart += 	'<table class="table-shopping-cart">';
							cart += 		'<tr class="table-head">';
							cart += 			'<th class="column-1">Image</th>';
							cart += 			'<th class="column-2">Product</th>';
							cart += 			'<th class="column-3">Price</th>';
							cart += 			'<th class="column-4">Discount</th>';
							cart += 			'<th class="column-5">Quantity</th>';
							cart += 			'<th class="column-6">Money</th>';
							cart += 			'<th class="column-7">Function</th>';
							cart += 		'</tr>';
							result += '<ul class="header-cart-wrapitem">';
							$.each(data, function(key, item){
								totalNumber += item['quantity'];
								total += item['quantity'] * item['product']['price'] * ( 1 - item['product']['discount']);
								result += '<li id="' + key + '" class="header-cart-item">';
								result += 	'<div class="header-cart-item-img">';
								result += 		'<img onclick="return deleteCart('+ item['product']['bid'] +');" src="${pageContext.request.contextPath}/pathUrl/files/' + item['product']['picture'] + '" alt="IMG">';
								result += 	'</div>';
								result += 	'<div class="header-cart-item-txt">';
								result +=		'<a href="#" class="header-cart-item-name">';
								result +=			item['product']['bname'];
								result +=		'</a>';
								result +=		'<span class="header-cart-item-info">';
								result +=			item['quantity'] + ' x ' + item['product']['price'] + ' VNĐ';
								result +=		'</span>';
								result +=		'<a onclick="return deleteCart('+ item['product']['bid'] +');" href="javascript:void(0);" class="header-cart-item-info">Xóa</a>';
								result += 	'</div>';
								result += '</li>';
								cart += '<tr class="table-row">';
								cart += 	'<td class="column-1">';
								cart += 		'<div class="cart-img-product b-rad-4 o-f-hidden">';
								cart += 			'<img src="${pageContext.request.contextPath}/pathUrl/files/'+ item['product']['picture'] +'" alt="IMG-PRODUCT">';
								cart += 		'</div>';
								cart += 	'</td>';
								cart += 	'<td class="column-2">';
								cart += 		'<a href="#">'+ item['product']['bname']; + '</a>';
								cart += 	'</td>';
								cart += 	'<td class="column-3">' + item['product']['price'] + '</td>';
								cart += 	'<td class="column-4">' + item['product']['discount']*100 + '%' + '</td>';
								cart += 	'<td class="column-5">';
								cart += 		'<div class="flex-w bo5 of-hidden w-size17">';
								cart += 			'<button onclick="return addCartUpper(' + item['product']['bid'] + ');" class="btn-num-product-down color1 flex-c-m size7 bg8 eff2"><i class="fs-12 fa fa-minus" aria-hidden="true"></i></button>';
								cart += 				'<input class="size8 m-text18 t-center num-product" type="number" id="' + item['product']['bid'] + '" name="num-product1" value="' + item['quantity'] + '">';
								cart += 			'<button onclick="return addCartUpper(' + item['product']['bid'] + ');" class="btn-num-product-up color1 flex-c-m size7 bg8 eff2"><i class="fs-12 fa fa-minus" aria-hidden="true"></i></button>';
								cart += 		'</div>';
								cart +=		'</td>';
								cart += 	'<td class="column-6">' + item['quantity']*item['product']['price']*(1-item['product']['discount']) + '</td>';
								cart += 	'<td class="column-7"><a onclick="return deleteCart(' + item['product']['bid'] + ');" href="javascript:void(0);"><i class="fa fa-trash"></i></a></td>';
								cart += '</tr>';
							});
							result += '</ul>';
							result += '<div class="header-cart-total">';
							result += 	'Tổng tiền: ' + total + ' VNĐ';
							result += '</div>';
							result += '<div class="header-cart-buttons">';
							result += 	'<div class="header-cart-wrapbtn">';
							result += 		'<a href="${pageContext.request.contextPath}/cart.html" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">Giỏ hàng</a>';
							result += 	'</div>';
							result += 	'<div class="header-cart-wrapbtn">';
							result += 		'<a href="${pageContext.request.contextPath}/check.html" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">Thanh toán</a>';
							result += 	'</div>';
							result += '</div>';
							cart += 		'<tr class="table-row"><td class="column-2" colspan="5" style="text-align: center;"><span style="font-weight: bolder;">Thành tiền: ' + total + ' VND </span></td></tr>';
							cart += '	</table>';
							cart += '</div>';
							$(function(){
								$('#cart-1').empty();
							});
							$(function(){
								$('#cart-1').append(cart);
							});
							$(function(){
								$('#giohang').empty();
							});
							$(function(){
								$('#giohang').append(result);
							});
							$(function(){
								$('#total-items').empty();
							});
							$(function(){
								$('#total-items').append(totalNumber);
							});
						},
						error: function() {
							alert('Error!');
						}
					});
					return false;
				}
			</script>
		</div>
	</div>
</div>


<!-- Menu Mobile -->
<div class="wrap-side-menu">
	<nav class="side-menu">
		<ul class="main-menu">
			<li class="item-topbar-mobile p-l-20 p-t-8 p-b-8"><span
				class="topbar-child1"> Free shipping for standard order over
					$100 </span></li>

			<li class="item-topbar-mobile p-l-20 p-t-8 p-b-8">
				<div class="topbar-child2-mobile">
					<span class="topbar-email"> fashe@example.com </span>

					<div class="topbar-language rs1-select2">
						<select class="selection-1" name="time">
							<option>USD</option>
							<option>EUR</option>
						</select>
					</div>
				</div>
			</li>

			<li class="item-topbar-mobile p-l-10">
				<div class="topbar-social-mobile">
					<a href="#" class="topbar-social-item fa fa-facebook"></a> <a
						href="#" class="topbar-social-item fa fa-instagram"></a> <a
						href="#" class="topbar-social-item fa fa-pinterest-p"></a> <a
						href="#" class="topbar-social-item fa fa-snapchat-ghost"></a> <a
						href="#" class="topbar-social-item fa fa-youtube-play"></a>
				</div>
			</li>

			<li class="item-menu-mobile"><a href="index.html">Home</a>
				<ul class="sub-menu">
					<li><a href="index.html">Homepage V1</a></li>
					<li><a href="home-02.html">Homepage V2</a></li>
					<li><a href="home-03.html">Homepage V3</a></li>
				</ul> <i class="arrow-main-menu fa fa-angle-right" aria-hidden="true"></i>
			</li>

			<li class="item-menu-mobile"><a href="product.html">Shop</a></li>

			<li class="item-menu-mobile"><a href="product.html">Sale</a></li>

			<li class="item-menu-mobile"><a href="cart.html">Features</a></li>

			<li class="item-menu-mobile"><a href="blog.html">Blog</a></li>

			<li class="item-menu-mobile"><a href="about.html">About</a></li>

			<li class="item-menu-mobile"><a href="contact.html">Contact</a>
			</li>
		</ul>
	</nav>
</div>