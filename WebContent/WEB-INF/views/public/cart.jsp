<%@page import="vn.edu.vinaenter.util.ActionCart"%>
<%@page import="vn.edu.vinaenter.util.SlugUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Title Page -->
	<section class="bg-title-page p-t-50 p-b-40 flex-col-c-m" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
		<h2 class="l-text2 t-center">
			Giỏ hàng
		</h2>
	</section>

	<!-- Cart -->
	<section class="cart bgwhite p-t-70 p-b-100">
		<div class="container">
			<!-- Cart item -->
			<div id="cart-1" class="container-table-cart pos-relative">
				<div class="wrap-table-shopping-cart bgwhite">
					<table class="table-shopping-cart">
						<tr class="table-head">
							<th class="column-1">Hình ảnh</th>
							<th class="column-2">Sản phẩm</th>
							<th class="column-3">Giá</th>
							<th class="column-4">Giảm giá</th>
							<th class="column-5">Số lượng</th>
							<th class="column-6">Thành tiền</th>
							<th class="column-7">Chức năng</th>
						</tr>
						<c:choose>
							<c:when test="${not empty listCart}">
								<c:forEach items="${listCart}" var="objCart">
									<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCart.product.cname)}/${objCart.product.cid}/${SlugUtil.makeSlug(objCart.product.bname)}/${objCart.product.bid}.html" var="urlDetail"></c:set>
									<tr class="table-row">
										<td class="column-1">
											<div class="cart-img-product b-rad-4 o-f-hidden">
												<img src="${pageContext.request.contextPath}/pathUrl/files/${objCart.product.picture}" alt="IMG-PRODUCT">
											</div>
										</td>
										<td class="column-2">
											<a href="${urlDetail}">
												${objCart.product.bname}
											</a>
										</td>
										<td class="column-3">${Integer.valueOf(objCart.product.price)}</td>
										<td class="column-4">
											${Integer.valueOf(objCart.product.discount * 100)} %
										</td>
										<td class="column-5">
											<div class="flex-w bo5 of-hidden w-size17">
												<button onclick="return addCartUpper(${objCart.product.bid});" class="btn-num-product-down color1 flex-c-m size7 bg8 eff2">
													<i class="fs-12 fa fa-minus" aria-hidden="true"></i>
												</button>
			
												<input class="size8 m-text18 t-center num-product" type="number" id="${objCart.product.bid}" name="num-product1" value="${objCart.quantity}">
			
												<button onclick="return addCartUpper(${objCart.product.bid});" class="btn-num-product-up color1 flex-c-m size7 bg8 eff2">
													<i class="fs-12 fa fa-plus" aria-hidden="true"></i>
												</button>
											</div>
										</td>
										<td class="column-6">${Integer.valueOf(objCart.product.price * (1 - objCart.product.discount) * objCart.quantity)} VND</td>
										<td style="text-align: center;" class="column-7"><a onclick="return deleteCart(${objCart.product.bid});" href="javascript:void(0);"><i style="font-size: 25px;" class="fa fa-trash"></i></a></td>
									</tr>
								</c:forEach>
								<tr class="table-row">
									<td class="column-2" colspan="7" style="text-align: center;"><span style="font-weight: bolder;">Tổng tiền: ${Integer.valueOf(ActionCart.total(listCart))} VND </span></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="column-2" colspan="5" style="text-align: center;">Giỏ hàng trống
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>

			<div class="flex-w flex-sb-m p-t-25 p-b-25 bo8 p-l-35 p-r-60 p-lr-15-sm">
				<div class="size10 trans-0-4 m-t-10 m-b-10">
					<!-- Button -->
					<button onclick="return showCart1();" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">
						Cập nhật giỏ hàng
					</button>
				</div>
				
				<div class="flex-w flex-m w-full-sm">
					<div class="size11 bo4 m-r-10">
						<input class="sizefull s-text7 p-l-22 p-r-22" type="text" name="coupon-code" placeholder="Discount code">
					</div>

					<div class="size12 trans-0-4 m-t-10 m-b-10 m-r-10">
						<!-- Button -->
						<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">
							Khuyến mãi
						</button>
					</div>
				</div>
				
				<div class="size10 trans-0-4 m-t-10 m-b-10">
					<a href="${pageContext.request.contextPath}/check.html" title="Pay"><button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">Thanh toán</button></a>
				</div>
				
			</div>
			
			<script type="text/javascript">
				document.getElementById("cart").classList.add('active-menu');
				function addCartUpper(x){
					var quantity = $('#' + x).val();
					$.ajax({
						url: '${pageContext.request.contextPath}/addcartupper',
						type: 'POST',
						cache: false,
						data: {
							aIdPro : x, aQuantity : quantity
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
				function showCart1(){
					$.ajax({
						url: '${pageContext.request.contextPath}/showcart',
						type: 'POST',
						cache: false,
						data: {
						},
						success: function(data) {
							var totalNumber = 0;
							var total = 0;
							var cart = '';
							cart += '<div class="wrap-table-shopping-cart bgwhite">';
							cart += 	'<table class="table-shopping-cart">';
							cart += 		'<tr class="table-head">';
							cart += 			'<th class="column-1">Hình ảnh</th>';
							cart += 			'<th class="column-2">Sản phẩm</th>';
							cart += 			'<th class="column-3">Giá</th>';
							cart += 			'<th class="column-4">Giảm giá</th>';
							cart += 			'<th class="column-5">Số lượng</th>';
							cart += 			'<th class="column-6">Thành tiền</th>';
							cart += 			'<th class="column-7">Chức năng</th>';
							cart += 		'</tr>';
							$.each(data, function(key, item){
								totalNumber += item['quantity'];
								total += item['quantity'] * item['product']['price'] * ( 1 - item['product']['discount']);
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
								cart += 	'<td style="text-align: center;" class="column-7"><a onclick="return deleteCart(' + item['product']['bid'] + ');" href="javascript:void(0);"><i style="font-size: 25px;" class="fa fa-trash"></i></a></td>';
								cart += '</tr>';
							});
							cart += 		'<tr class="table-row"><td class="column-2" colspan="5" style="text-align: center;"><span style="font-weight: bolder;">Tổng tiền: ' + total + ' VND </span></td></tr>';
							cart += '	</table>';
							cart += '</div>';
							$(function(){
								$('#cart-1').empty();
							});
							$(function(){
								$('#cart-1').append(cart);
							});
							$(function(){
								$('.header-icons-noti').empty();
							});
							$(function(){
								$('.header-icons-noti').append(totalNumber);
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
	</section>