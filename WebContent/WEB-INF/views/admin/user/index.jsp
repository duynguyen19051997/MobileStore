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
	                    	<h3 class="page-title">Users Management</h3>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Users Management</li>
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
										<a href="${pageContext.request.contextPath}/admin/user/add" title="Add">
											<button class="btn btn-outline-success">Add</button>
										</a>
									</div>
									<div id="right" class="col-md-4">
										<form id="search" action="${pageContext.request.contextPath}/admin/user/search" method="get">
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
                                                <th class="d1">Id</th>
                                                <th class="d1">Username</th>
                                                <th class="d1">Detail</th>
                                                <th class="d1">Position</th>
                                                <th class="d1">Status</th>
                                                <th class="d1">Function</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listUser}">
                                        		<c:forEach items="${listUser}" var="objUser">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/user/delete/${objUser.id}/${currentPage}"></c:set>
           											<c:set var="urlEdit" value="${pageContext.request.contextPath}/admin/user/edit/${objUser.id}/${currentPage}"></c:set>
           											<c:set var="urlDetail" value="${pageContext.request.contextPath}/admin/user/profile/${objUser.id}"></c:set>		
		                                            <tr>
		                                                <td class="d1">${objUser.id}</td>
		                                                <td class="d1">${objUser.username}</td>
		                                                <td class="d1">
		                                                	<c:choose>
		                                                		<c:when test="${inforUser.name eq 'ADMIN'}">
		                                                			<a href="${urlDetail}" title="Chi tiết">Here</a>
		                                                		</c:when>
		                                                		<c:otherwise>
		                                                			<c:choose>
		                                                				<c:when test="${inforUser.id == objUser.id}">
		                                                					<a href="${urlDetail}" title="Chi tiết">Here</a>
		                                                				</c:when>
		                                                			</c:choose>
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <td class="d1">${objUser.name}</td>
		                                                <td class="d1" id="activeimg">
		                                                	<c:choose>
		                                                		<c:when test="${inforUser.name eq 'ADMIN' && inforUser.id != objUser.id}">
		                                                			<c:choose>
				                                                		<c:when test="${objUser.enable == 1}">
				                                                			<a href="javascript:void(0);" title="active">
				                                                				<img width="40px" height="40px" id="${objUser.id}" alt="Active" src="${pageContext.request.contextPath}/adminUrl/assets/images/active.png">
				                                                			</a>
				                                                		</c:when>
				                                                		<c:otherwise>
				                                                			<a href="javascript:void(0);" title="unactive">
				                                                				<img width="40px" height="40px" id="${objUser.id}" alt="Unactive" src="${pageContext.request.contextPath}/adminUrl/assets/images/unactive.png">
				                                                			</a>
				                                                		</c:otherwise>
				                                                	</c:choose>
		                                                		</c:when>
		                                                		<c:otherwise>
		                                                			<c:choose>
				                                                		<c:when test="${objUser.enable == 1}">
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
		                                                	<c:choose>
									                    		<c:when test="${inforUser.name eq 'ADMIN'}">
									                    			<c:choose>
									                    				<c:when test="${inforUser.id == objUser.id}">
									                    					<a href="${urlEdit}" title="Edit"><button type="button" class="btn btn-outline-danger">Edit</button></a>
									                    				</c:when>
									                    				<c:otherwise>
									                    					<a href="${urlEdit}" title="Edit"><button type="button" class="btn btn-outline-danger">Edit</button></a>
							                								<a onclick="return confirm('Are you sure you want to delete it?')" href="${urlDel}" title="Delete"><button type="button" class="btn btn-outline-warning">Delete</button></a>
									                    				</c:otherwise>
									                    			</c:choose>
									                    		</c:when>
									                    		<c:otherwise>
									                    			<c:if test="${inforUser.id == objUser.id}">
									                    				<a href="${urlEdit}" title="Edit"><button type="button" class="btn btn-outline-danger">Edit</button></a>
									                    			</c:if>
									                    		</c:otherwise>
									                    	</c:choose>
														</td>
		                                            </tr>
	                                            </c:forEach>
                                            </c:if>
                                            <c:if test="${empty listUser}">
                                            	<tr>
                                            		<td colspan="6" class="d1">Empty</td>
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
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/${currentPage -1}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/1" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								             <c:forEach begin="1" end="${numberOfPage}" var="i">
								            	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
									            	<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/${i}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/${i}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								            	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/${currentPage + 1}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/user/index/${numberOfPage}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
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
				    document.getElementById("user").classList.add('active-menu');
				    $(document).ready(function () {
				        $('#activeimg a img').click(function () {
				        	var src = $(this).attr('src');
				        	var id = $(this).attr('id');
				            $.ajax({
								url: '${pageContext.request.contextPath}/user/active',
								type: 'POST',
								cache: false,
								data: {
									aSrc: src, aId : id
								},
								success: function(data){
									$('#' + id).attr('src', data);
								},
								error: function (){
									alert('Error!');
								}
							});
				        });
				 	});
				</script>