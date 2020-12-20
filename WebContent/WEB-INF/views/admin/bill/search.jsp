<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                    	<h3 class="page-title">Quản lý hóa đơn</h3>
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
								<div class="col-md-12">
									<div id="left" class="col-md-4">
									</div>
									<div id="right" class="col-md-4">
										<form id="search" action="${pageContext.request.contextPath}/admin/bill/search" method="get">
											<div class="input-group form">
												<input  type="text" name="search" value='<c:if test="${not empty search}">${search}</c:if>' class="form-control" placeholder="Nhập nội dung cần tìm">
												<span class="input-group-btn">
													<button class="btn btn-outline-info" type="submit">Search</button>
												</span>
											</div>
										</form>
										<script type="text/javascript">
								        	$(document).ready(function(){
								        		$('#search').validate({
								        			rules:{
								        				search:{
								        					required:true
								        				}
								        			},
								        			messages:{
								        				search:{
								        					required:'Not empty, please!'
								        				}
								        			},
								        		});
								        	});
								       	</script>
									</div>
								</div>
								<div class="clr"></div>
                                <div class="table-responsive">
                                    <table id="zero_config" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="d1">bill_id</th>
                                                <th class="d1">Người mua</th>
                                                <th class="d1">Status</th>
                                                <th class="d1">Ngày mua</th>
                                                <th class="d1">Chi tiết</th>
                                                <th class="d1">Thành tiền(VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listBill}">
                                        		<c:forEach items="${listBill}" var="objBill">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/bill/delete/${objBill.bill_id}/${currentPage}"></c:set>
		                                            <c:set var="urlDetail" value="#"></c:set>
		                                            <c:set var="active" value="${pageContext.request.contextPath}/adminUrl/assets/images/active.png"></c:set>
		                                            <c:set var="unactive" value="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png"></c:set>
		                                            <tr>
		                                                <td class="d1">${objBill.bill_id}</td>
		                                                <td class="d1">
		                                                	<a href="${pageContext.request.contextPath}/admin/user/profile/${objBill.user_id}" title="Detail">${objBill.username}</a>
		                                                </td>
		                                                <td class="d1">
		                                                	<c:choose>
		                                                		<c:when test="${objBill.status == 1}">
	                                                				<img width="40px" height="40px" alt="Active" src="${active}">
		                                                		</c:when>
		                                                		<c:otherwise>
	                                                				<img width="40px" height="40px" alt="Unactive" src="${unactive}">
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <td class="d1">${objBill.date_create}</td>
		                                                <td class="d1">
		                                                	<a href="${urlDetail}" title="Chi tiết">Chi tiết</a>
		                                                </td>
		                                                <td class="d1">${Integer.valueOf(objBill.total)}</td>
		                                            </tr>
	                                            </c:forEach>
                                            </c:if>
                                            <c:if test="${empty listBill}">
                                            	<tr>
                                            		<td colspan="7" class="d1">Empty</td>
                                            	</tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <div id="right" class="col-md-4">
									<nav aria-label="...">
									  <ul class="pagination">
										<li class="page-item disabled">
										  <p class="page-link">${currentPage} Of ${numberOfPage}</p>
										</li>
									  </ul>
									</nav>
								</div>
                               	<c:if test="${numberOfPage > 1}">
									<!--PAGINATION-->
									<div id="right" class="col-md-4">
										<nav aria-label="...">
										  <ul class="pagination">
								        	<c:choose>
								        		<c:when test="${currentPage - 1 >= 1}">
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/${currentPage -1}?search=${search}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/1?search=${search}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								            <c:forEach begin="1" end="${numberOfPage}" var="i">
								            	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
									            	<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/${i}?search=${search}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/${i}?search=${search}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								            	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/${currentPage + 1}?search=${search}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/bill/index/${numberOfPage}?search=${search}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
										  </ul>
										</nav>
									</div>
								</c:if>
							</div>
						</div>
					</div>
                </div>
                <script type="text/javascript">
				    document.getElementById("bill").classList.add('active-menu');
				    /* $(document).ready(function () {
				        $('#activeimg a img').click(function () {
				        	var src = $(this).attr('src');
				        	var id = $(this).attr('id');
				            $.ajax({
								url: '${pageContext.request.contextPath}/comment/active',
								type: 'POST',
								cache: false,
								data: {
									aSrc: src, aId : id
								},
								success: function(data){
									$('#' + id).attr('src', data);
								},
								error: function (){
									alert('Có lỗi xảy ra');
								}
							});
				        });
				 	}); */
				</script>