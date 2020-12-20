<%@page import="duynguyen.util.SlugUtil"%>
<%@page import="com.sun.corba.se.spi.ior.MakeImmutable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/templates/taglib.jsp"%>
<!-- Title Page -->
	<section class="bg-title-page p-t-50 p-b-40 flex-col-c-m" style="background-image: url(${pageContext.request.contextPath}/publicUrl/images/books_flowers_1.jpg);">
		<h2 class="l-text2 t-center">
			MobileStore
		</h2>
	</section>


	<!-- Content page -->
	<section class="bgwhite p-t-55 p-b-65">
		<div class="container">
			<div class="row">

				<div class="col-sm-6 col-md-4 col-lg-3 p-b-50">
					<div class="leftbar p-r-20 p-r-0-sm">
						<!--  -->
						<h4 class="m-text14 p-b-7">
							Danh mục sản phẩm
						</h4>
						<ul class="p-b-54">
							<li class="p-t-4">
								<a href="${pageContext.request.contextPath}/product/1.html" class="s-text13 active1">
									All
									<span class="badge badge-secondary">${bookDao.totalProductPublic()}</span>
								</a>
							</li>
							<c:if test="${not empty listParent}">
								<c:forEach items="${listParent}" var="objCat">
									<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCat.cname)}/${objCat.cid}/1.html" var="product"></c:set>
									<li class="p-t-4">
										<a id="${objCat.cid}" href="${product}" class="s-text13">
											${objCat.cname}
											<span class="badge badge-secondary">${bookDao.totalProductByParentIdPublic(objCat.cid)}</span>
										</a>
										<c:set var="listChild" value="${catDao.getItemsParent(objCat.cid)}"></c:set>
										<c:if test="${not empty listChild}">
											<ul class="p-b-54">
												<c:forEach items="${listChild}" var="objCatChild">
													<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objCatChild.cname)}/${objCatChild.cid}/1.html" var="product"></c:set>
													<li class="d-2"><a id="${objCatChild.cid}" href="${product}">${objCatChild.cname}
														<span class="badge badge-secondary">${bookDao.totalBookByCidPublic(objCatChild.cid)}</span></a>
													</li>
												</c:forEach>
											</ul>				
										</c:if>
									</li>
								</c:forEach>
							</c:if>
							
						</ul>

					</div>
				</div>

				<div class="col-sm-6 col-md-8 col-lg-9 p-b-50">
					<!--  -->
					<div class="flex-sb-m flex-w p-b-35">
						<div class="flex-w">
							<div class="rs2-select2 bo4 of-hidden w-size12 m-t-5 m-b-5 m-r-10">
								<select class="selection-2" name="sorting">
									<option>Default Sorting</option>
									<option>Popularity</option>
									<option>Price: low to high</option>
									<option>Price: high to low</option>
								</select>
							</div>

							<div class="rs2-select2 bo4 of-hidden w-size12 m-t-5 m-b-5 m-r-10">
								<select class="selection-2" name="sorting">
									<option>Price</option>
									<option>$0.00 - $50.00</option>
									<option>$50.00 - $100.00</option>
									<option>$100.00 - $150.00</option>
									<option>$150.00 - $200.00</option>
									<option>$200.00+</option>

								</select>
							</div>
						</div>

						<span class="s-text8 p-t-5 p-b-5">
							Showing 1–12 of 16 results
						</span>
					</div>

					<!-- Product -->
					<div class="row">
						<c:if test="${not empty listSearch}">
							<c:forEach items="${listSearch}" var="objPro">
								<c:set value="${pageContext.request.contextPath}/${SlugUtil.makeSlug(objPro.cname)}/${objPro.cid}/${SlugUtil.makeSlug(objPro.bname)}/${objPro.bid}.html" var="urlDetail"></c:set>
								<c:choose>
									<c:when test="${objPro.discount > 0}">
										<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelsale"></c:set>
									</c:when>
									<c:otherwise>
										<c:set var="pro" value="block2-img wrap-pic-w of-hidden pos-relative block2-labelnew"></c:set>
									</c:otherwise>
								</c:choose>
								<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">
									<!-- Block2 -->
									<div class="block2">
										<div class="${pro}">
											<img width="272px" height="272px" src="${pageContext.request.contextPath}/pathUrl/files/${objPro.picture}" alt="IMG-PRODUCT">
		
											<div class="block2-overlay trans-0-4">
												<a href="#" class="block2-btn-addwishlist hov-pointer trans-0-4">
													<i class="icon-wishlist icon_heart_alt" aria-hidden="true"></i>
													<i class="icon-wishlist icon_heart dis-none" aria-hidden="true"></i>
												</a>
		
												<div class="block2-btn-addcart w-size1 trans-0-4">
													<!-- Button -->
													<button class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
														<i style="font-size: 25px;" class="fa fa-shopping-cart"></i>
													</button>
												</div>
											</div>
										</div>
										<div class="block2-txt p-t-20" style="text-align: center;">
											<a href="${urlDetail}" style="font-weight: bolder;" class="block2-name dis-block s-text3 p-b-5">
												${objPro.bname}
											</a>
			
											<span class="block2-price m-text6 p-r-5">
												Giá: ${Integer.valueOf(objPro.price)} VND
											</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
					<c:if test="${numberOfPage > 1}">
						<!-- Pagination -->
						<div class="pagination flex-m flex-w p-t-26">
							<c:forEach begin="1" end="${numberOfPage}" var="i">
								<c:choose>
									<c:when test="${currentPage == i}">
										<c:set var="active" value="item-pagination flex-c-m trans-0-4 active-pagination"></c:set>
									</c:when>
									<c:otherwise>
										<c:set var="active" value="item-pagination flex-c-m trans-0-4"></c:set>
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath}/search/${i}.html?searchproduct=${search}" class="${active}">${i}</a>
							</c:forEach>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</section>