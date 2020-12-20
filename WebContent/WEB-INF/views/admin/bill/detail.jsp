<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                    	<h3 class="page-title">Hóa đơn của ${objBill.username} (${objBill.date_create})</h3>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Quản lý hóa đơn</li>
	                                </ol>
	                            </nav>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <!-- ============================================================== -->
	            <!-- End Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Sales Cards  -->
                <!-- ============================================================== -->
                <div class="row">
					<div class="col-md-12">
						<div class="card">
                            <div id="d2" class="card-body">
                                <div class="table-responsive">
                                    <table id="zero_config" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="d1">Mã sản phẩm</th>
                                                <th class="d1">Tên sản phẩm</th>
                                                <th class="d1">Số lượng</th>
                                                <th class="d1">Giá (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listDetaiBill}">
                                        		<c:forEach items="${listDetaiBill}" var="objBillDetail">
		                                            <tr>
		                                                <td class="d1">${objBillDetail.bid}</td>
		                                                <td class="d1">
		                                                	<a href="${pageContext.request.contextPath}/admin/product/detail/${objBillDetail.bid}" title="Xem sản phẩm">${objBillDetail.bname}</a>
		                                                </td>
		                                                <td class="d1">${objBillDetail.number}</td>
		                                                <td class="d1">${Integer.valueOf(objBillDetail.price)}</td>
		                                            </tr>
	                                            </c:forEach>
                                            </c:if>
                                            <c:if test="${empty listDetaiBill}">
                                            	<tr>
                                            		<td colspan="4" class="d1">Empty</td>
                                            	</tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <div id="right" class="col-md-4">
									<nav aria-label="...">
									  <ul class="pagination">
										<li class="page-item disabled">
										  <p class="page-link">Tổng tiền:  ${Integer.valueOf(objBill.total)} VND</p>
										</li>
									  </ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
                </div>
                <script type="text/javascript">
				    document.getElementById("bill").classList.add('active-menu');
				</script>