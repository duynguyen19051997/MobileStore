<%@page import="duynguyen.model.dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                    	<h3 class="page-title">Comments Management</h3>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Comments Management</li>
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
										<form id="search" action="${pageContext.request.contextPath}/admin/comment/search" method="get">
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
                                                <th class="d1">Cmt_id</th>
                                                <th class="d1">Content</th>
                                                <th class="d1">Status</th>
                                                <th class="d1">Date created</th>
                                                <th class="d1">Where</th>
                                                <th class="d1">By</th>
                                                <c:if test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
                                                	<th class="d1">Function</th>
                                                </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listCmt}">
                                        		<c:forEach items="${listCmt}" var="objCmt">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/comment/delete/${objCmt.cmt_id}/${currentPage}"></c:set>
		                                            <tr>
		                                                <td class="d1">${objCmt.cmt_id}</td>
		                                                <td class="d1">${objCmt.content}</td>
		                                                <td class="d1" id="activeimg">
		                                                	<c:choose>
		                                                		<c:when test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
		                                                			<c:choose>
				                                                		<c:when test="${objCmt.active == 1}">
				                                                			<a href="javascript:void(0);" title="active">
				                                                				<img width="40px" height="40px" id="${objCmt.cmt_id}" alt="Active" src="${pageContext.request.contextPath}/adminUrl/assets/images/active.png">
				                                                			</a>
				                                                		</c:when>
				                                                		<c:otherwise>
				                                                			<a href="javascript:void(0);" title="unactive">
				                                                				<img width="40px" height="40px" id="${objCmt.cmt_id}" alt="Unactive" src="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png">
				                                                			</a>
				                                                		</c:otherwise>
				                                                	</c:choose>
		                                                		</c:when>
		                                                		<c:otherwise>
		                                                			<c:choose>
				                                                		<c:when test="${objCmt.active == 1}">
			                                                				<img width="40px" height="40px" alt="Active" src="${pageContext.request.contextPath}/adminUrl/assets/images/active.png">
				                                                		</c:when>
				                                                		<c:otherwise>
			                                                				<img width="40px" height="40px" alt="Unactive" src="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png">
				                                                		</c:otherwise>
				                                                	</c:choose>
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <td class="d1">${objCmt.date_create}</td>
		                                                <td class="d1">
		                                                	<a href="${pageContext.request.contextPath}/admin/book/detail/${objCmt.bid}" title="Detail">${objCmt.bname}</a>
		                                                </td>
		                                                <td class="d1">
		                                                	<a href="${pageContext.request.contextPath}/admin/user/profile/${objCmt.id}" title="Detail">${objCmt.username}</a>
		                                                </td>
		                                                <c:if test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
			                                                <td class="d1">
																<a onclick="return confirm('Are you sure you want to delete ?')" href="${urlDel}" title="Delete">
																	<button type="button" class="btn btn-outline-warning">Delete</button>
																</a>
															</td>
														</c:if>
		                                            </tr>
	                                            </c:forEach>
                                            </c:if>
                                            <c:if test="${empty listCmt}">
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
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/${currentPage -1}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/1" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								             <c:forEach begin="1" end="${numberOfPage}" var="i">
								            	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
									            	<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/${i}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/${i}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								            	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/${currentPage + 1}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/comment/index/${numberOfPage}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
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
				    document.getElementById("comment").classList.add('active-menu');
				    $(document).ready(function () {
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
									alert('Error');
								}
							});
				        });
				 	});
				</script>