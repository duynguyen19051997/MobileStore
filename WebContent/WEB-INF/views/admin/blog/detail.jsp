<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Product Information</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">home</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/book/index/1">Product Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Product Information</li>
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
						<c:if test="${not empty objPro}">
							<div class="card">
								<form id="form" class="form-horizontal" action="" method="POST" enctype="multipart/form-data">
									<div class="card-body">
										<div class="form-group row">
											<label for="bname" class="col-sm-3 text-right control-label col-form-label">Product's Name</label>
											<div class="col-sm-9 form-control">
												${objPro.bname}
											</div>
										</div>
										<div class="form-group row">
											<label for="fname" class="col-sm-3 text-right control-label col-form-label">Category</label>
											<div class="col-sm-9 form-control">
												${objPro.cname}
											</div>
										</div>
										<div class="form-group row">
											<label for="price" class="col-sm-3 text-right control-label col-form-label">Price</label>
											<div class="col-sm-9 form-control">
												${Integer.valueOf(objPro.price)} VNĐ
											</div>
										</div>
										<div class="form-group row">
											<label for="price" class="col-sm-3 text-right control-label col-form-label">Discount</label>
											<div class="col-sm-9 form-control">
												${Integer.valueOf(objPro.discount * 100)}%
											</div>
										</div>
										<div class="form-group row">
											<label for="price" class="col-sm-3 text-right control-label col-form-label">Views</label>
											<div class="col-sm-9 form-control">
												${objPro.count_view}
											</div>
										</div>
										<div class="form-group row">
											<c:if test="${not empty objPro.picture}">
												<label for="avatar" class="col-sm-3 text-right control-label col-form-label">Images</label>
												<div class="col-sm-9">
													<img width="50px" height="50px" alt="Hình ảnh" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}">
												</div>
											</c:if>
										</div>
										<div class="form-group row">
											<label for="price" class="col-sm-3 text-right control-label col-form-label">Status</label>
											<div class="col-sm-9 form-control">
												<c:if test="${objPro.enable == 1}">
													Are trading
												</c:if>
												<c:if test="${objPro.enable == 0}">
													Stop business
												</c:if>
											</div>
										</div>
										<div class="form-group row">
											<label for="detail" class="col-sm-3 text-right control-label col-form-label">Date created</label>
											<div class="col-sm-9 form-control">
												${objPro.date_create}
											</div>
										</div>
										<div class="form-group row">
											<label for="decription" class="col-sm-3 text-right control-label col-form-label">Decription</label>
											<div class="col-sm-9 form-control">
												${objPro.decription}
											</div>
										</div>
										<div class="form-group row">
											<label for="detail" class="col-sm-3 text-right control-label col-form-label">Detail</label>
											<div class="col-sm-9 form-control">
												${objPro.detail}
											</div>
										</div>
										<div class="form-group row">
											<label for="detail" class="col-sm-3 text-right control-label col-form-label">By</label>
											<div class="col-sm-9 form-control">
												${objPro.create_by}
											</div>
										</div>
									</div>
								</form>
								<script type="text/javascript">
							    	document.getElementById("book").classList.add('active-menu');
						       	</script>
							</div>
						</c:if>
					</div>
                </div>