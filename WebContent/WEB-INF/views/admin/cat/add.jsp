<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Add Category</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin's Homepage</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/cat/index/1">Category's Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Add Category</li>
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
							<form id="form" class="form-horizontal" action="" method="POST">
								<div id="d2" class="card-body">
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Category's Name</label>
										<div class="col-sm-9">
											<input name="cname" type="text" class="form-control" id="fname" placeholder="Category's Name">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Parent Category</label>
										<div class="col-sm-9">
											<select name="parent_id" class="form-control">
												<option value="0"> Not selected </option>
												<c:if test="${not empty listCatParent}">
													<c:forEach items="${listCatParent}" var="objCatParent">
														<option value="${objCatParent.cid}"> ${objCatParent.cname}</option>
													</c:forEach>
												</c:if>
											</select>
										</div>
									</div>
									<div class="border-top">
										<div class="card-body" id="submit">
											<button type="submit" class="btn btn-primary">Add</button>
										</div>
									</div>
								</div>
							</form>
							<script type="text/javascript">
						    	document.getElementById("cat").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			rules:{
					        				cname:{
					        					required:true
					        				}
					        			},
					        			messages:{
					        				cname:{
					        					required:'Not empty, please!'
					        				}
					        			},
					        		});
					        	});
					       	</script>
						</div>
					</div>
                </div>