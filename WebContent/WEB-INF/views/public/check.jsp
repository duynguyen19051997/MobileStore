<%@page import="duynguyen.util.ActionCart"%>
<%@page import="duynguyen.util.SlugUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Title Page -->
	<section class="bg-title-page p-t-50 p-b-40 flex-col-c-m" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
		<h2 class="l-text2 t-center">
			Thanh toán
		</h2>
	</section>

	<!-- Cart -->
	<section class="cart bgwhite p-t-70 p-b-100">
		<div class="container">
			<!-- Cart item -->
			<div class="container-table-cart pos-relative">
				<div id="check" class="wrap-table-shopping-cart bgwhite">
					<table class="table-shopping-cart">
						<tr class="table-head">
							<th class="column-1">Hình ảnh</th>
							<th class="column-2">Sản phẩm</th>
							<th class="column-3">Giá</th>
							<th class="column-4">Giảm giá</th>
							<th class="column-5">Số lượng</th>
							<th class="column-6">Thành tiền</th>
						</tr>
						<c:choose>
							<c:when test="${not empty listCart}">
								<c:forEach items="${listCart}" var="objCart">
									<tr class="table-row">
										<td class="column-1">
											<div class="cart-img-product b-rad-4 o-f-hidden">
												<img src="${pageContext.request.contextPath}/pathUrl/files/${objCart.product.picture}" alt="IMG-PRODUCT">
											</div>
										</td>
										<td class="column-2">${objCart.product.bname}</td>
										<td class="column-3">${Integer.valueOf(objCart.product.price)}</td>
										<td class="column-4">
											<c:if test="${objCart.product.discount > 0}">
												${Integer.valueOf(objCart.product.discount * 100)} %
											</c:if>
										</td>
										<td class="column-5">${objCart.quantity}</td>
										<td class="column-6">${Integer.valueOf(objCart.product.price * (1 - objCart.product.discount) * objCart.quantity)} VND</td>
									</tr>
								</c:forEach>
								<tr class="table-row">
									<td class="column-2" colspan="6" style="text-align: center;"><span style="font-weight: bolder;">Tổng tiền: ${Integer.valueOf(total)} VND </span></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="column-2" colspan="6" style="text-align: center;"><a href="${pageContext.request.contextPath}/product/1.html">Chọn sản phẩm</a></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>

			<!-- Total -->
			<div class="bo9 w-size18 p-l-40 p-r-40 p-t-30 p-b-38 m-t-30 m-r-0 m-l-auto p-lr-15-sm">
				
				<h5 class="m-text20 p-b-24">
					Hóa đơn
				</h5>

				<!--  -->
				<div class="flex-w flex-sb-m p-t-26 p-b-30">
					<span class="m-text22 w-size19 w-full-sm">
						Thành tiền:
					</span>

					<span class="m-text21 w-size20 w-full-sm">
						${Math.floor(Integer.valueOf(total) / 23200)} USD
					</span>
				</div>

				<!-- <div class="size15 trans-0-4">
					Button
					<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">
						Proceed to Checkout
					</button>
				</div> -->
				
				<div id="paypal-button-container"></div>

			    <script>
				    paypal.Buttons({
			    	 createOrder: function(data, actions) {
				    	  var dollar = ${Integer.valueOf(total)} / 23200;
				          dollar = Math.floor(dollar);
				          console.log(dollar);    
				        return actions.order.create({
				          purchase_units: [{
				            amount: {
				              value: dollar
				            }
				          }]
				        });
				      },
				      onApprove: function(data, actions) {
				        return actions.order.capture().then(function(details) {
				        	//đưa lên server
				            $.ajax({
				                url: '<%=request.getContextPath()%>/checkout',
				                type: 'POST',
				                cache: false,
				                data:{
				                	
				                },
			                	success: function(data){
				                 	$(function(){
										$('#total-items').empty();
									});
									$(function(){
										$('#total-items').append(data);
									});
									window.alert('Bạn đã giao dịch thành công!');
					                //window.location.reload(true);
			                	},
				                error: function (){
				                  /* console.log('lỗi ajax order'); */
				                  window.alert('Error!');
				                }
				              });
				          // Call your server to save the transaction
				          return fetch('/paypal-transaction-complete', {
				            method: 'post',
				            body: JSON.stringify({
				              orderID: data.orderID
				            })
				          });
				        });
				      }
				    }).render('#paypal-button-container');
				</script>
			</div>
		</div>
	</section>