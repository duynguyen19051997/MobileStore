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
	                    	<h3 class="page-title">Categories Management</h3>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Categories Management</li>
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
										<a href="${pageContext.request.contextPath}/admin/cat/add" title="Add">
											<button class="btn btn-outline-success">Add</button>
										</a>
									</div>
									<div id="right" class="col-md-4">
										<form id="search" action="${pageContext.request.contextPath}/admin/cat/search" method="get">
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
                                                <th class="d1">Cid</th>
                                                <th class="d1">Category's Name</th>
                                                <th class="d1">Parent Category</th>
                                                <th class="d1">By</th>
                                                <th class="d1">Functions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listCat}">
                                        		<c:forEach items="${listCat}" var="objCat">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/cat/delete/${objCat.cid}/${currentPage}"></c:set>
           											<c:set var="urlEdit" value="${pageContext.request.contextPath}/admin/cat/edit/${objCat.cid}/${currentPage}"></c:set>	
		                                            <tr>
		                                                <td class="d1">${objCat.cid}</td>
		                                                <td class="d1">
		                                                	<c:choose>
		                                                		<c:when test="${objCat.parent_id == 0}">
		                                                			<a href="${pageContext.request.contextPath}/admin/cat/index/${objCat.cid}/1" title="">${objCat.cname}</a>
		                                                		</c:when>
		                                                		<c:otherwise>
		                                                			<a href="${pageContext.request.contextPath}/admin/book/${objCat.cid}/index/1">${objCat.cname}</a>
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <td class="d1">
		                                                	<c:if test="${objCat.parent_id == 0}">
		                                                		Nothing
		                                                	</c:if>
		                                                	<c:if test="${objCat.parent_id != 0}">
		                                                		<a href="${pageContext.request.contextPath}/admin/cat/index/1" title="">${catDao.getItemByCid(objCat.parent_id).cname}</a>
		                                                	</c:if>
		                                                </td>
		                                                <td class="d1">
		                                                	${objCat.create_by}
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
                                            <c:if test="${empty listCat}">
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
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}${currentPage -1}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}1" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								             <c:forEach begin="1" end="${numberOfPage}" var="i">
								            	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
									            	<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}${i}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}${i}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								            	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}${currentPage + 1}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/cat/index/${id}${numberOfPage}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
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
				    document.getElementById("cat").classList.add('active-menu');
				</script>