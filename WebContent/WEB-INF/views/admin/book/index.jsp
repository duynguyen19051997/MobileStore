<%@page import="vn.edu.vinaenter.model.dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                    	<c:choose>
	                    		<c:when test="${not empty objCat}">
	                    			<h3 class="page-title">${objCat.cname}</h3>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<h3 class="page-title">Quản lý sản phẩm</h3>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Quản lý sản phẩm</li>
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
                            <div style="width: 998px" id="d2" class="card-body">
								<div class="col-md-12">
									<div id="left" class="col-md-4">
										<a href="${pageContext.request.contextPath}/admin/product/add" title="Add">
											<button class="btn btn-outline-success">Add</button>
										</a>
									</div>
									<div id="right" class="col-md-4">
										<form id="search" action="${pageContext.request.contextPath}/admin/product/search" method="get">
											<div class="input-group form">
												<input  type="text" name="search" value="" class="form-control" placeholder="Search...">
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
								        					required:'Vui lòng nhập để tìm!'
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
                                                <th class="d1">Bid</th>
                                                <th class="d1">Tên sản phẩm</th>
                                                <th class="d1">Giá (VNĐ)</th>
                                                <th class="d1">Hình ảnh</th>
                                                <th class="d1">Danh mục sản phẩm</th>
                                                <th class="d1">By</th>
                                                <th class="d1">Chi tiết</th>
                                                <th class="d1">Trạng thái</th>
                                                <th width="160px" class="d1">Chức năng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listProduct}">
                                        		<c:forEach items="${listProduct}" var="objPro">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/product/delete/${objPro.bid}/${currentPage}"></c:set>
           											<c:set var="urlEdit" value="${pageContext.request.contextPath}/admin/product/edit/${objPro.bid}/${currentPage}"></c:set>	
		                                            <tr>
		                                                <td class="d1">${objPro.bid}</td>
		                                                <td class="d1">${objPro.bname}</td>
		                                                <td class="d1">${Integer.valueOf(objPro.price)}</td>
		                                                <td class="d1">
		                                                	<c:if test="${not empty objPro.picture}">
		                                                		<img width="50px" height="50px" alt="${objPro.bname}" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}">
		                                                	</c:if>
		                                                </td>
		                                                <td class="d1"><a href="${pageContext.request.contextPath}/admin/product/${objPro.cid}/index/1" title="${objPro.cname}">${objPro.cname}</a></td>
		                                                <td class="d1">${objPro.create_by}</td>
		                                                <td class="d1">
		                                                	<a href="${pageContext.request.contextPath}/admin/product/detail/${objPro.bid}">Here</a>
		                                                </td>
		                                                <td class="d1" id="activeimg">
		                                                	<c:choose>
		                                                		<c:when test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
		                                                			<c:choose>
				                                                		<c:when test="${objPro.enable == 1}">
				                                                			<a href="javascript:void(0);" title="active">
				                                                				<img width="40px" height="40px" id="${objPro.bid}" alt="Active" src="${pageContext.request.contextPath}/adminUrl/assets/images/active.png">
				                                                			</a>
				                                                		</c:when>
				                                                		<c:otherwise>
				                                                			<a href="javascript:void(0);" title="unactive">
				                                                				<img width="40px" height="40px" id="${objPro.bid}" alt="Unactive" src="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png">
				                                                			</a>
				                                                		</c:otherwise>
				                                                	</c:choose>
		                                                		</c:when>
		                                                		<c:otherwise>
		                                                			<c:choose>
				                                                		<c:when test="${objPro.enable == 1}">
			                                                				<img width="40px" height="40px" alt="Active" src="${pageContext.request.contextPath}/adminUrl/assets/images/active.png">
				                                                		</c:when>
				                                                		<c:otherwise>
			                                                				<img width="40px" height="40px" alt="Unactive" src="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png">
				                                                		</c:otherwise>
				                                                	</c:choose>
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <td class="d1">
															<a href="${urlEdit}" title="Edit">
																<button type="button" class="btn btn-outline-danger">Edit</button>
															</a>
															<a onclick="return confirm('Are you sure you want to delete it ?')" href="${urlDel}" title="Delete">
																<button type="button" class="btn btn-outline-warning">Delete</button>
															</a>
														</td>
		                                            </tr>
		                                    	</c:forEach>
                                            </c:if>
                                            <c:if test="${empty listProduct}">
                                            	<tr>
                                            		<td colspan="9" class="d1">Empty</td>
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
                               		<c:choose>
                               			<c:when test="${not empty objCat}">
                               				<c:set var="id" value="${objCat.cid}/"></c:set>
                               			</c:when>
                               		</c:choose>
									<!--PAGINATION-->
									<div id="right" class="col-md-4">
										<nav aria-label="...">
										  <ul class="pagination">
								        	<c:choose>
								        		<c:when test="${currentPage - 1 >= 1}">
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/product/${id}index/${currentPage -1}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/product/${id}index/1" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								             <c:forEach begin="1" end="${numberOfPage}" var="i">
								             	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
								             		<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/product/${id}index/${i}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/product/${id}index/${i}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								             	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/product/${id}index/${currentPage + 1}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/product/index/${numberOfPage}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
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
				    document.getElementById("book").classList.add('active-menu');
				    $(document).ready(function () {
				        $('#activeimg a img').click(function () {
				        	var src = $(this).attr('src');
				        	var id = $(this).attr('id');
				            $.ajax({
								url: '${pageContext.request.contextPath}/product/active',
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
				 	});
				</script>