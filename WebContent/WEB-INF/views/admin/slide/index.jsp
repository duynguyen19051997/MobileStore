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
	                    	<h3 class="page-title">Slides Management</h3>
	                    	<div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Slides Management</li>
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
										<a href="${pageContext.request.contextPath}/admin/slide/add" title="Add">
											<button class="btn btn-outline-success">Add</button>
										</a>
									</div>
								</div>
								<div class="clr"></div>
                                <div class="table-responsive">
                                    <table id="zero_config" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="d1">id</th>
                                                <th class="d1">Slide</th>
                                                <th class="d1">Sort</th>
                                                <c:if test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
                                                	<th class="d1">Function</th>
                                                </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${not empty listSlide}">
                                        		<c:forEach items="${listSlide}" var="objSlide">
                                        			<c:set var="urlDel" value="${pageContext.request.contextPath}/admin/slide/delete/${objSlide.id}"></c:set>
           											<c:set var="urlEdit" value="${pageContext.request.contextPath}/admin/slide/edit/${objSlide.id}"></c:set>	
		                                            <tr>
		                                                <td class="d1">${objSlide.id}</td>
		                                                <td class="d1">
		                                                	<c:if test="${not empty objSlide.slide}">
		                                                		<img width="50px" height="50px" alt="${objSlide.slide}" src="${pageContext.request.contextPath}/pathUrl/files/${objSlide.slide}">
		                                                	</c:if>
		                                                </td>
		                                                <td class="d1">
		                                                	${objSlide.sort}
		                                                </td>
		                                                
	                                                	<c:if test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
															<td class="d1">
																<a href="${urlEdit}" title="Edit">
																	<button type="button" class="btn btn-outline-danger">Edit</button>
																</a>
																<a onclick="return confirm('Are you sure you want to delete it?')" href="${urlDel}" title="Delete">
																	<button type="button" class="btn btn-outline-warning">Delete</button>
																</a>
															</td>
														</c:if>
		                                            </tr>
	                                            </c:forEach>
                                            </c:if>
                                            <c:if test="${empty listSlide}">
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
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/${currentPage -1}" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == 1}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/1" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
								        		</c:otherwise>
								        	</c:choose>
								             <c:forEach begin="1" end="${numberOfPage}" var="i">
								            	<c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
									            	<c:choose>
									            		<c:when test="${i eq currentPage}">
									            			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/${i}">${i}</a></li>
									            		</c:when>
									            		<c:otherwise>
									            			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/${i}">${i}</a></li>
									            		</c:otherwise>
									            	</c:choose>
								            	</c:if>
								            </c:forEach>
								            <c:choose>
								        		<c:when test="${currentPage + 1 <= numberOfPage}">
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/${currentPage + 1}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class='<c:if test="${currentPage == numberOfPage}">page-item disabled</c:if>'><a class="page-link" href="${pageContext.request.contextPath}/admin/slide/index/${numberOfPage}" aria-label="Next"><span aria-hidden="true">Next</span></a></li>
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
				    document.getElementById("slide").classList.add('active-menu');
				</script>