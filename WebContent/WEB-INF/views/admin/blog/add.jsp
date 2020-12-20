<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Thêm Blog</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/blog/index/1">Quản lý sản phẩm</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Thêm</li>
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
								<div class="card-body">
									<div class="form-group row">
										<label for="bname" class="col-sm-3 text-right control-label col-form-label">Tiêu đề</label>
										<div class="col-sm-9">
											<input name="blog_name" type="text" class="form-control" id="blog_name" placeholder="Tiêu đề">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Danh mục</label>
										<div class="col-sm-9">
											<select name="cid" class="form-control">
												<c:if test="${not empty listCat}">
													<c:forEach items="${listCat}" var="objCat">
														<option value="${objCat.cid}"> ${objCat.cname}</option>
													</c:forEach>
												</c:if>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label for="avatar" class="col-sm-3 text-right control-label col-form-label">Hình ảnh</label>
										<div class="col-sm-9">
											<input name="image" type="file" class="form-control" id="image">
										</div>
									</div>
									<div class="form-group row">
										<label for="content" class="col-sm-3 text-right control-label col-form-label">Nội dung</label>
										<div class="col-sm-9">
											<textarea id="decription" class="form-control ckeditor" name="content" rows="" cols=""></textarea>
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
						    	document.getElementById("blog").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			ignore: [],
					        			rules:{
					        				blog_name:{
					        					required:true
					        				},
					        				image:{
					        					required:true
					        				},
					        				content:{
					        					required: true,
					        					number: true
					        				},
					        				cid:{
					        					required:true
					        				}
					        			},
					        			messages:{
					        				blog_name:{
					        					required: 'Nhập tên tiêu đề!'
					        				},
					        				image:{
					        					required: 'Chọn hình ảnh'
					        				},
					        				content:{
					        					required: 'Nhập nội dung!'
					        				},
					        				cid:{
					        					required: 'Chọn danh mục!'
					        				}
					        			},
					        		});
					        	});
					       	</script>
						</div>
					</div>
                </div>