<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp" %>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Sửa sản phẩm</h3>
	                        <div class="ml-auto">
		                		<c:if test="${not empty msg}">
						       	 	<h3 class="text-success">${msg}</h3>
						    	</c:if>
						    </div>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
	                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/product/index/1">Product Management</a></li>
	                                    <li class="breadcrumb-item active" aria-current="page">Edit</li>
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
											<label for="bname" class="col-sm-3 text-right control-label col-form-label">Product's name</label>
											<div class="col-sm-9">
												<input value="${objPro.bname}" name="bname" type="text" class="form-control" id="bname" placeholder="Tên sản phẩm">
											</div>
										</div>
										<div class="form-group row">
											<label for="fname" class="col-sm-3 text-right control-label col-form-label">Danh mục sản phẩm</label>
											<div class="col-sm-9">
												<select name="cid" class="form-control">
													<c:if test="${not empty listCatChil}">
														<c:forEach items="${listCatChil}" var="objCat">
															<c:choose>
																<c:when test="${objCat.cid == objPro.cid}">
																	<option selected="selected" value="${objCat.cid}"> ${objCat.cname}</option>
																</c:when>
																<c:otherwise>
																	<option value="${objCat.cid}"> ${objCat.cname}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:if>
												</select>
											</div>
										</div>
										<div class="form-group row">
											<label for="price" class="col-sm-3 text-right control-label col-form-label">Giá</label>
											<div class="col-sm-9">
												<input value="${objPro.price}" name="price" type="number" class="form-control" id="price" placeholder="Giá">
											</div>
										</div>
										<div class="form-group row">
											<label for="avatar" class="col-sm-3 text-right control-label col-form-label">Hình ảnh</label>
											<div class="col-sm-9">
												<input name="avatar" type="file" class="form-control" id="avartar">
											</div>
											<c:if test="${not empty objPro.picture}">
												<label for="avatar" class="col-sm-3 text-right control-label col-form-label">Ảnh củ</label>
												<div class="col-sm-9">
													<img width="50px" height="50px" alt="Old Image" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}">
												</div>
											</c:if>
										</div>
										<div class="form-group row">
											<label for="decription" class="col-sm-3 text-right control-label col-form-label">Đánh giá chi tiết</label>
											<div class="col-sm-9">
												<textarea id="decription" class="form-control ckeditor" name="decription" rows="" cols="">${objPro.decription}</textarea>
											</div>
										</div>
										<div class="form-group row">
											<label for="detail" class="col-sm-3 text-right control-label col-form-label">Thông số kĩ thuật</label>
											<div class="col-sm-9">
												<textarea id="detail" class="form-control ckeditor" name="detail" rows="" cols="">${objPro.detail}</textarea>
											</div>
										</div>
										<div class="border-top">
											<div class="card-body" id="submit">
												<button type="submit" class="btn btn-primary">Edit</button>
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
						        					required: 'Vui lòng nhập tên sản phẩm!'
						        				},
						        				price:{
						        					required: 'Vui lòng nhập giá!',
						        					number : 'Vui lòng nhập đúng định dạng số'
						        				},
						        				decription:{
						        					required: 'Vui lòng nhập Đánh giá chi tiết!'
						        				},
						        				detail:{
						        					required: 'Vui lòng nhập Thông số kỹ thuật!'
						        				},
						        			},
						        		});
						        	});
						       	</script>
							</div>
						</c:if>
					</div>
                </div>