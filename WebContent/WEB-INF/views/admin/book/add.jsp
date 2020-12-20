<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Thêm sản phẩm</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/product/index/1">Quản lý sản phẩm</a></li>
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
										<label for="bname" class="col-sm-3 text-right control-label col-form-label">Tên sản phẩm</label>
										<div class="col-sm-9">
											<input name="bname" type="text" class="form-control" id="bname" placeholder="Tên sản phẩm">
										</div>
									</div>
									<div class="form-group row">
										<label for="fname" class="col-sm-3 text-right control-label col-form-label">Danh mục</label>
										<div class="col-sm-9">
											<select name="cid" class="form-control">
												<c:if test="${not empty listCatChil}">
													<c:forEach items="${listCatChil}" var="objCat">
														<option value="${objCat.cid}"> ${objCat.cname}</option>
													</c:forEach>
												</c:if>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label for="price" class="col-sm-3 text-right control-label col-form-label">Giá</label>
										<div class="col-sm-9">
											<input name="price" type="number" class="form-control" id="price" placeholder="Giá">
										</div>
									</div>
									<div class="form-group row">
										<label for="avatar" class="col-sm-3 text-right control-label col-form-label">Hình ảnh</label>
										<div class="col-sm-9">
											<input name="avatar" type="file" class="form-control" id="avatar">
										</div>
									</div>
									<div class="form-group row">
										<label for="decription" class="col-sm-3 text-right control-label col-form-label">Đánh giá chi tiết</label>
										<div class="col-sm-9">
											<textarea id="decription" class="form-control ckeditor" name="decription" rows="" cols=""></textarea>
										</div>
									</div>
									<div class="form-group row">
										<label for="detail" class="col-sm-3 text-right control-label col-form-label">Thông số kĩ thuật</label>
										<div class="col-sm-9">
											<textarea id="detail" class="form-control ckeditor" name="detail" rows="" cols=""></textarea>
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
						    	document.getElementById("book").classList.add('active-menu');
					        	$(document).ready(function(){
					        		$('#form').validate({
					        			ignore: [],
					        			rules:{
					        				bname:{
					        					required:true
					        				},
					        				avatar:{
					        					required:true
					        				},
					        				price:{
					        					required: true,
					        					number: true
					        				},
					        				decription:{
					        					required:true
					        				},
					        				detail:{
					        					required:true
					        				},
					        			},
					        			messages:{
					        				bname:{
					        					required: 'Nhập tên sản phẩm!'
					        				},
					        				avatar:{
					        					required: 'Chọn hình ảnh!'
					        				},
					        				price:{
					        					required: 'Nhập giá!',
					        					number : 'Nhập đúng số'
					        				},
					        				decription:{
					        					required: 'NHập đánh giá chi tiết!'
					        				},
					        				detail:{
					        					required: 'Nhập thông số kỹ thuật!'
					        				},
					        			},
					        		});
					        	});
					       	</script>
						</div>
					</div>
                </div>