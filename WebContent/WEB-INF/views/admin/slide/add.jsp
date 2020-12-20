<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Add Slide</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/Slide/index/1">Slides Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Add</li>
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
							<form id="form" class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
								<div id="d2" class="card-body">
									<div class="form-group row">
										<label for="picture" class="col-sm-3 text-right control-label col-form-label">Slide</label>
										<div class="col-sm-9">
											<input name="picture" type="file" class="form-control" id="picture">
											<p class="help-block"><em>Format: jpg, png, jpeg,...</em></p>
										</div>
									</div>
									<div class="form-group row">
										<label for="sort" class="col-sm-3 text-right control-label col-form-label">Sort</label>
										<div class="col-sm-9">
											<input name="sort" type="number" class="form-control" id="sort" placeholder="500">
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
						    	document.getElementById("slide").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			rules:{
					        				picture:{
					        					required:true
					        				},
					        				sort:{
					        					required:true,
					        					number: true
					        				}
					        			},
					        			messages:{
					        				picture:{
					        					required: 'Enter Image, please!'
					        				},
					        				sort:{
					        					required: 'Enter Sort, please!',
					        					number: 'Enter the correct number format'
					        				}
					        			},
					        		});
					        	});
					       	</script>
						</div>
					</div>
                </div>