<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Add User</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">home</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/user/index/1">Users Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Add user</li>
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
										<label for="username" class="col-sm-3 text-right control-label col-form-label">Username</label>
										<div class="col-sm-9">
											<input name="username" value="" type="text" class="form-control" id="username" placeholder="Username">
										</div>
									</div>
									<div class="form-group row">
										<label for="password" class="col-sm-3 text-right control-label col-form-label">Password</label>
										<div class="col-sm-9">
											<input name="password" value="" type="password" class="form-control" id="password" placeholder="Password">
										</div>
									</div>
									<div class="form-group row">
										<label for="fullname" class="col-sm-3 text-right control-label col-form-label">Fullname</label>
										<div class="col-sm-9">
											<input name="fullname" value="" type="text" class="form-control" id="fullname" placeholder="Fullname">
										</div>
									</div>
									<div class="form-group row">
										<label for="email" class="col-sm-3 text-right control-label col-form-label">Email</label>
										<div class="col-sm-9">
											<input name="email" value="" type="text" class="form-control" id="email" placeholder="Email">
										</div>
									</div>
									<div class="form-group row">
										<label for="address" class="col-sm-3 text-right control-label col-form-label">Address</label>
										<div class="col-sm-9">
											<input name="address" value="" type="text" class="form-control" id="address" placeholder="Address">
										</div>
									</div>
									<div class="form-group row">
										<label for="phone" class="col-sm-3 text-right control-label col-form-label">Phone</label>
										<div class="col-sm-9">
											<input name="phone" value="" type="text" class="form-control" id="phone" placeholder="Phone">
										</div>
									</div>
		                             <div class="form-group row">
		                                 <label for="fname" class="col-sm-3 text-right control-label col-form-label">Position</label>
		                                 <div class="col-sm-9">
			                                 <select name="role_id" class="form-control"> 
			                                 	<c:if test="${not empty listRole}">
				                                 	<c:forEach items="${listRole }" var="objRole">
				                                 		<option value="${objRole.role_id}">${objRole.name}</option>
				                                 	</c:forEach>
			                                 	</c:if>
			                                 </select>
		                                 </div>
		                             </div>
									<div class="border-top">
										<div class="card-body" id="submit">
											<button type="submit" class="btn btn-primary">Register</button>
										</div>
									</div>
								</div>
							</form>
							<script type="text/javascript">
						    	document.getElementById("user").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			rules:{
					        				username:{
					        					required:true
					        				},
					        				password:{
					        					required:true
					        				},
					        				fullname:{
					        					required:true
					        				},
					        				email:{
					        					required:true,
					        					email:true
					        				},
					        				address:{
					        					required:true
					        				},
					        				phone:{
					        					required:true,
					        					number:true
					        				}
					        			},
					        			messages:{
					        				username:{
					        					required:'Enter Username, please!'
					        				},
					        				password:{
					        					required:'Enter Password, please!'
					        				},
					        				fullname:{
					        					required:'Enter Fullname, please!'
					        				},
					        				email:{
					        					required:'Enter Email, please!',
					        					email:'Enter the correct email format!'
					        				},
					        				address:{
					        					required:'Enter Address, please!'
					        				},
					        				phone:{
					        					required:'Enter Numberphone, please!',
					        					number:'Enter the correct number format!'
					        				}
					        			},
					        		});
					        	});
					       	</script>
						</div>
					</div>
                </div>