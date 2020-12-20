<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Profile</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Home</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/user/index/1">Users Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Profile</li>
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
							<c:if test="${not empty objUser}">
								<div id="d2" class="card-body">
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Username</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.username}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Fullname</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.fullname}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Email</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.email}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Address</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.address}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Phone</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.phone}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Date created</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.date_create}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Status</label>
										<div class="col-sm-9">
											<c:choose>
												<c:when test="${objUser.enable == 1}">
													<input name="cname" type="text" value="Hoạt động" class="form-control" id="fname" disabled="disabled">
												</c:when>
												<c:otherwise>
													<input name="cname" type="text" value="Đang bị khóa" class="form-control" id="fname" disabled="disabled">
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Position</label>
										<div class="col-sm-9">
											<input name="cname" type="text" value="${objUser.name}" class="form-control" id="fname" disabled="disabled">
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</div>
                </div>
                <script type="text/javascript">
				    document.getElementById("user").classList.add('active-menu');
				</script>
            