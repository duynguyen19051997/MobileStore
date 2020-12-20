<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Edit user</h3>
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
	                                    <li class="breadcrumb-item active" aria-current="page">Edit user</li>
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
											<input name="username" value="${objUser.username}" type="text" class="form-control" id="username" readonly="readonly">
										</div>
									</div>
									<div class="form-group row">
										<label for="fullname" class="col-sm-3 text-right control-label col-form-label">Fullname</label>
										<div class="col-sm-9">
											<input name="fullname" value="${objUser.fullname}" type="text" class="form-control" id="fullname">
										</div>
									</div>
									<div class="form-group row">
										<label for="email" class="col-sm-3 text-right control-label col-form-label">Email</label>
										<div class="col-sm-9">
											<input name="email" value="${objUser.email}" type="text" class="form-control" id="email">
										</div>
									</div>
									<div class="form-group row">
										<label for="address" class="col-sm-3 text-right control-label col-form-label">Address</label>
										<div class="col-sm-9">
											<input name="address" value="${objUser.address}" type="text" class="form-control" id="address">
										</div>
									</div>
									<div class="form-group row">
										<label for="phone" class="col-sm-3 text-right control-label col-form-label">Phone</label>
										<div class="col-sm-9">
											<input name="phone" value="${objUser.phone}" type="text" class="form-control" id="phone">
										</div>
									</div>
									<c:if test="${inforUser.id == 5 && objUser.id != 5}">
		                             	<div class="form-group row">
			                                 <label for="fname" class="col-sm-3 text-right control-label col-form-label">Status</label>
			                                 <c:choose>
			                                 	<c:when test="${objUser.enable == 1}">
			                                 		<input name="enable" type="radio"  value="1" checked="checked"> Active
			                                 		<input name="enable" type="radio" value="0"> No Active
			                                 	</c:when>
			                                 	<c:otherwise>
			                                 		<input name="enable" type="radio"  value="1"> Active
			                                 		<input name="enable" type="radio" value="0" checked="checked"> No Active
			                                 	</c:otherwise>
			                                 </c:choose>
			                             </div>
			                             <div class="form-group row">
			                                 <label for="fname" class="col-sm-3 text-right control-label col-form-label">Position</label>
			                                 <div class="col-sm-9">
				                                 <select name="role_id" class="form-control"> 
				                                 	<c:if test="${not empty listRole}">
					                                 	<c:forEach items="${listRole }" var="objRole">
					                                 		<c:choose>
					                                 			<c:when test="${objRole.role_id == objUser.role_id}">
					                                 				<option value="${objRole.role_id}" selected="selected">${objRole.name}</option>
					                                 			</c:when>
					                                 			<c:otherwise>
					                                 				<option value="${objRole.role_id}">${objRole.name}</option>
					                                 			</c:otherwise>
					                                 		</c:choose>
					                                 	</c:forEach>
				                                 	</c:if>
				                                 </select>
			                                 </div>
			                             </div>
		                             </c:if>
									<div class="border-top">
										<div class="card-body" id="submit">
											<button type="submit" class="btn btn-primary">Edit</button>
										</div>
									</div>
								</div>
							</form>
							<script type="text/javascript">
						    	document.getElementById("user").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			rules:{
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