<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/templates/taglib.jsp"%>
<!-- ============================================================== -->
	            <!-- Bread crumb and right sidebar toggle -->
	            <!-- ============================================================== -->
	             <div class="page-breadcrumb">
	                <div class="row">
	                    <div class="col-12 d-flex no-block align-items-center">
	                        <h3 class="page-title">Menu</h3>
	                        <div class="ml-auto text-right">
	                            <nav aria-label="breadcrumb">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item active" aria-current="page">Home</li>
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
								<!-- Column -->
								<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
									<div class="card card-hover">
										<a href="${pageContext.request.contextPath}/admin/cat/index/1" title="Categories">
											<div class="box bg-success text-center">
												<h1 class="font-light text-white"><i class="fas fa-align-justify"></i></h1>
												<h6 class="text-white">There are ${totalCat} categories</h6>
											</div>
										</a>
									</div>
								</div>
							
								 <!-- Column -->
								<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
									<div class="card card-hover">
										<a href="${pageContext.request.contextPath}/admin/product/index/1" title="Products">
											<div class="box bg-warning text-center">
												<h1 class="font-light text-white"><i class="fas fa-book"></i></h1>
												<h6 class="text-white">There are ${totalBook} products</h6>
											</div>
										</a>
									</div>
								</div>
								
								<c:if test="${'ADMIN' eq inforUser.name || 'MOD' eq inforUser.name}">
									<!-- Column -->
									<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
										<div class="card card-hover">
											<a href="${pageContext.request.contextPath}/admin/bill/index/1" title="Bills">
												<div class="box bg-danger text-center">
													<h1 class="font-light text-white"><i class="fas fa-shopping-cart"></i></h1>
													<h6 class="text-white">There are ${totalBill} bills</h6>
												</div>
											</a>
										</div>
									</div>
								
									<!-- Column -->
									<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
										<div class="card card-hover">
											<a href="${pageContext.request.contextPath}/admin/total/index" title="Total Income">
												<div class="box bg-warning text-center">
													<h1 class="font-light text-white"><i class="fas fa-money-bill-alt"></i></h1>
													<h6 class="text-white">Total income</h6>
												</div>
											</a>
										</div>
									</div>
								</c:if>
							
								<!-- Column -->
								<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
									<div class="card card-hover">
										<a href="${pageContext.request.contextPath}/admin/user/index/1" title="Users">
											<div class="box bg-primary text-center">
												<h1 class="font-light text-white"><i class="fas fa-users"></i></h1>
												<h6 class="text-white">There are ${totalUser} users</h6>
											</div>
										</a>
									</div>
								</div>
								
								<!-- Column -->
								<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
									<div class="card card-hover">
										<a href="${pageContext.request.contextPath}/admin/slide/index/1" title="Slide">
											<div class="box bg-secondary text-center">
												<h1 class="font-light text-white"><i class="fab fa-slideshare"></i></h1>
												<h6 class="text-white">There are ${totalSlide} slides</h6>
											</div>
										</a>
									</div>
								</div>
								
								<!-- Column -->
								<div id="box" class="col-md-6 col-lg-4 col-xlg-3">
									<div class="card card-hover">
										<a href="${pageContext.request.contextPath}/admin/comment/index/1" title="Comments">
											<div class="box bg-danger text-center">
												<h1 class="font-light text-white"><i class="fas fa-comments"></i></h1>
												<h6 class="text-white">There are ${totalCmt} comments</h6>
											</div>
										</a>
									</div>
								</div>
								
							</div>
						</div>
					</div>
                </div>