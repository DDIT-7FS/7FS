<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
.wdBtn {
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: 4rem;
	--bs-btn-font-size: .75rem;
	background-color: pink;
	color: white;
}

.actBtn {
	width: 50px;
	height: 20px;
	font-size: 0.8em;
	padding: 0;
	border: 0;
	text-align: center;
}

.atrzContSc {
	border: 1px solid lightgray;
	border-radius: 10px;
	height: 300px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
	padding: 20px;
	padding-bottom: 50px;
}

.atrzTabCont {
	border: 1px solid lightgray;
	border-radius: 10px;
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
.tableConCenter{
	padding-top: 10px; 
	padding-bottom: 10px;
}
#critical {
	padding-left: 4px;
}
.newAtrzDocBtn{
	padding: 0.5rem 1rem; 
	font-size: 0.875rem;
}
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
.emptyList{
	padding: 50px 0; 
	font-size: 1.2rem; 
	color: gray;
}
</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<!-- 여기서 작업 시작 -->
			<div class="col-sm-13" id="divCard">
				<div class="card">
					<div class="card-body">
						<!-- <p>결재하기</p> -->
						<!-- <p>${atrzVOList}</p> -->
						<!-- 메뉴바 시작 -->
						<div class="d-flex justify-content-between align-items-center">
							<div id="atrNavBar">
								<ul class="nav nav-pills" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link active" id="contact1-tab"
											data-bs-toggle="tab" data-bs-target="#contact1-tab-pane"
											type="button" role="tab" aria-controls="contact1-tab-pane"
											aria-selected="true">기안문서함</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="contact2-tab"
											data-bs-toggle="tab" data-bs-target="#contact2-tab-pane"
											type="button" role="tab" aria-controls="contact2-tab-pane"
											aria-selected="false">임시저장함</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="contact3-tab"
											data-bs-toggle="tab" data-bs-target="#contact3-tab-pane"
											type="button" role="tab" aria-controls="contact3-tab-pane"
											aria-selected="false">결재문서함</button>
									</li>
								</ul>
							</div>
							<!-- 오른쪽: 검색창 -->
							<div class="table_search d-flex align-items-center gap-2">
								<button id="s_eap_btn" class="main-btn active-btn rounded-full btn-hover newAtrzDocBtn"
									data-bs-toggle="modal" data-bs-target="#newAtrzDocModal">
									새 결재 진행</button>
								<select id="duration" class="form-select w-auto">
									<option value="all">전체기간</option>
									<option value="1">1개월</option>
									<option value="6">6개월</option>
									<option value="12">1년</option>
									<option value="period">기간입력</option>
								</select>
								<div id="durationPeriod" class="search_option d-none align-items-center" >
									<input id="fromDate" class="form-control" type="text" style="width: 150px;">
									~ 
									<input id="toDate" class="form-control" type="text" style="width: 150px;">
								</div>
								<!-- 검색 유형 선택 -->
								<select id="searchtype" class="form-select w-auto">
									<option value="title">제목</option>
									<option value="drafterName">기안자</option>
									<option value="drafterDeptName">기안부서</option>
									<option value="formName">결재양식</option>
									<option value="activityUserName">결재선</option>
								</select>
								<section class="search2">
									<div
										class="search_wrap d-flex align-items-center border rounded px-2">
										<!--focus되면 "search_focus" multi class로 추가해주세요.-->
										<input id="keyword" class="form-control border-0" type="text"
											placeholder="검색"> <span
											class="material-symbols-outlined">search</span>
									</div>
								</section>
							</div>
						</div>
					</div>
					<!-- 메뉴바 끝 -->
					<!-- 컨텐츠1 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="contact1-tab-pane"
							role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
							<div class="atrzTabCont">
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">기안문서함</h6>
											<div class="table-wrapper table-responsive">
												<c:choose>
													<c:when test="${empty atrzAllSubmitList}">
														<div class="text-center emptyList" >
															기안 문서함에 문서가 없습니다.
														</div>
													</c:when>
													<c:otherwise>
												<table class="table striped-table">
													<thead>
														<tr>
															<!-- select박스 -->
															<th class="text-center">
																<h6 class="fw-bolder">기안일</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">결재양식</h6>
															</th>
															<th></th>
															<th>
																<h6 class="fw-bolder">제목</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">문서번호</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">결재상태</h6>
															</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="atrzVO" items="${atrzAllSubmitList}">
															<tr>
																<td class="text-center">
																	<p class="text-sm fw-bolder">
																		<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																		<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																		${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;
																	</p>
																</td>
																<td class="text-center">
																	<p>
																		<c:choose>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																			<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																			<c:otherwise>퇴사신청서</c:otherwise>
																		</c:choose>
																	</p>
																</td>
																<td style="text-align: right;">
																	<c:choose>
																		<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																			<span class="material-symbols-outlined" style="font-size: 14px;">
																				attach_file
																			</span>
																		</c:when>
																		<c:otherwise>
																			<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																				attach_file
																			</span>
																		</c:otherwise>
																	</c:choose>
																</td>
																<td>
																	<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																		${atrzVO.atrzSj}
																	</a>
																</td>
																<td class="text-center">
																	<p>${atrzVO.atrzDocNo}</p>
																</td>
																<td class="text-center">
																	<p>
																		<c:choose>
																			<c:when test="${atrzVO.atrzSttusCode == '00' }">
																				<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '10' }">
																				<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '20' }">
																				<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '30' }">
																				<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '40' }">
																				<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																			</c:when>
																			<c:otherwise>
																				<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																			</c:otherwise>
																		</c:choose>
																	</p>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</c:otherwise>
										</c:choose>
											</div>
										</div>
									</div>
								</div>
								<!--기안문서함 끝-->
							</div>
						</div>
					</div>
					<!-- 컨텐츠1 끝 -->

					<!-- 컨텐츠2 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade" id="contact2-tab-pane" role="tabpanel"
							aria-labelledby="contact2-tab" tabindex="0">
							<div id="critical">
								<a class="btn" data-bs-toggle="modal"
									data-bs-target="#approvalSaveModal"> <span
									class="material-symbols-outlined">data_check</span> 
									<span class="txt">문서삭제</span>
								</a>
							</div>
							<div class="atrzTabCont">
								<!--임시저장함 시작-->
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">임시저장함</h6>
											<div class="table-wrapper table-responsive">
												<c:choose>
													<c:when test="${empty atrzStorageList}">
														<div class="text-center emptyList" >
															임시저장한 문서가 없습니다.
														</div>
													</c:when>
													<c:otherwise>
														<table class="table striped-table">
															<thead>
																<tr>
																	<!-- select박스 -->
																	<th class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
																		<input class="form-check-input" type="checkbox" id="checkbox-all">
																	</th>
																	<th></th>
																	<th>
																		<h6 class="fw-bolder">제목</h6>
																	</th>
																	<th>
																		<h6 class="fw-bolder">결재양식</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">결재상태</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">저장일시</h6>
																	</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="atrzVO" items="${atrzStorageList}">
																	<tr>
																		<td class="text-center">
																			<div class="check-input-primary">
																				<input class="form-check-input doc-check" type="checkbox" id="checkbox-1"value="${atrzVO.atrzDocNo}">
																			</div>
																		</td>
																		<td style="text-align: right;">
																			<c:choose>
																				<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																					<span class="material-symbols-outlined" style="font-size: 14px;">
																						attach_file
																					</span>
																				</c:when>
																				<c:otherwise>
																					<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																						attach_file
																					</span>
																				</c:otherwise>
																			</c:choose>
																		</td>
																		<td style="text-align:left;">
																			<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																				${atrzVO.atrzSj}
																			</a>
																		</td>
																		<td>
																			<p >
																				<c:choose>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																					<c:otherwise>퇴사신청서</c:otherwise>
																				</c:choose>
																			</p>
																		</td>
																		
																															
																		<td class="text-center">
																			<p>
																				<c:choose>
																					<c:when test="${atrzVO.atrzSttusCode == '00' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '10' }">
																						<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '20' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '30' }">
																						<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '40' }">
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																					</c:when>
																					<c:otherwise>
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																					</c:otherwise>
																				</c:choose>
																			</p>
																		</td>
																		<td class="text-center">
																			<p class="text-sm fw-bolder">
																				<fmt:formatDate value="${atrzVO.atrzTmprStreDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																				<fmt:formatDate value="${atrzVO.atrzTmprStreDt}" pattern="HH:mm:ss" var="onlyTime" />
																				${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}
																			</p>
																		</td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
								<!--임시저장함 끝-->
							</div>
						</div>
					</div>
					

					<!-- 컨텐츠2 끝 -->
					<!-- 컨텐츠3 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade" id="contact3-tab-pane" role="tabpanel"
							aria-labelledby="contact3-tab" tabindex="0">
							<div class="atrzTabCont">
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">결재문서함</h6>
											<div class="table-wrapper table-responsive">
												<c:choose>
													<c:when test="${empty atrzAllApprovalList}">
														<div class="text-center emptyList" >
															결재 문서함에 문서가 없습니다.
														</div>
													</c:when>
													<c:otherwise>
														<table class="table striped-table">
															<thead>
																<tr>
																	<!-- select박스 -->
																	
																	<th>
																		<h6 class="fw-bolder">결재양식</h6>
																	</th>
																	<th></th>
																	<th>
																		<h6 class="fw-bolder">제목</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">기안자</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">문서번호</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">기안일</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">완료일</h6>
																	</th>
																	<th class="text-center">
																		<h6 class="fw-bolder">결재상태</h6>
																	</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="atrzVO" items="${atrzAllApprovalList}">
																	<tr>
																		<td>
																			<p>
																				<c:choose>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																					<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																					<c:otherwise>퇴사신청서</c:otherwise>
																				</c:choose>
																			</p>
																		</td>
																		<td style="text-align: right;">
																			<c:choose>
																				<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																					<span class="material-symbols-outlined" style="font-size: 14px;">
																						attach_file
																					</span>
																				</c:when>
																				<c:otherwise>
																					<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																						attach_file
																					</span>
																				</c:otherwise>
																			</c:choose>
																		</td>
																		<td style="text-align:left;">
																			<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																				${atrzVO.atrzSj}
																			</a>
																		</td>
																		<td class="text-center">
																			<p>${atrzVO.drafterEmpnm}</p>
																		</td>
																		<td class="text-center">
																			<p>${atrzVO.atrzDocNo}</p>
																		</td>
																		<td class="text-center">
																			<p class="fw-bolder">
																				${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;
																			</p>
																		</td>
																		<td class="text-center">
																			<p class="fw-bolder">
																				<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																				<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
																				${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;
																			</p>
																		</td>
																		<td class="text-center">
																			<p>
																				<c:choose>
																					<c:when test="${atrzVO.atrzSttusCode == '00' }">
																						<span
																							class="status-btn close-btn actBtn col-sm-6 col-md-4"
																							style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '10' }">
																						<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '20' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '30' }">
																						<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																					</c:when>
																					<c:otherwise>
																						<span
																							class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
																							style="background-color: pink; color: #ed268a;">취소</span>
																					</c:otherwise>
																				</c:choose>
																			</p>
																		</td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
								<!--결재문서함 끝-->
							</div>
						</div>
					</div>
					<!-- 컨텐츠3 끝 -->
				</div>
			</div>
			<!-- 여기서 작업 끝 -->
		</div>
	</section>
<%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!-- j쿼리 사용시 여기 이후에 작성하기 -->
<!-- 새결재 진행 모달import -->
<c:import url="newAtrzDocModal.jsp" />
<!--임시저장목록 삭제-->
<!-- Modal -->
<div class="modal fade" id="approvalSaveModal" tabindex="-1"
aria-labelledby="approvalSaveModalLabel" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content border-0">
		<div class="modal-header border-0">
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body border-0">
			<h4 class="form-label">임시 저장 문서를 삭제하시겠습니까?</h4>
		</div>
			<div class="modal-footer border-0">
				<button type="button" class="main-btn primary-btn rounded-full btn-hover modalBtn" id="storageDeleteBtn">확인</button>
				<button type="button" class="main-btn light-btn rounded-full btn-hover modalBtn" data-bs-dismiss="modal">취소</button>
			</div>
	</div>
</div>
</div>
<!--일괄결재모달 끝-->
<!--임시저장목록 삭제-->

</body>
<script>
$(document).ready(function() {
	// 체크박스 전체 선택
	$("#checkbox-all").click(function() {
		if ($(this).is(":checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
});

//기간입력 선택시 활성화 시키는 스크립트
document.getElementById("duration").addEventListener("change",function() {
	var durationPeriod = document.getElementById("durationPeriod");
	if (this.value == "period") {
		durationPeriod.classList.remove("d-none");
		durationPeriod.classList.add("d-flex");
	} else {
		durationPeriod.classList.remove("d-flex");
		durationPeriod.classList.add("d-none");
	}
})
document.getElementById("storageDeleteBtn").addEventListener("click",function(){
	//체크 박스로 선택되 문서번호들 수집
	const checked = document.querySelectorAll(".doc-check:checked");
	const docNos = Array.from(checked).map(checkbox => checkbox.value);

	if(docNos.length ==0){
		swal({
			title: "삭제할 문서를 선택해주세요",
			icon: "warning",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인",
			timer: 2000
		});
		return;
	}
	
	//Ajax로 삭제 요청
	fetch("/atrz/storageListDelete", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify({atrzDocNos :docNos})
	})
	.then(response=>{
		if(!response.ok){
			throw new Error("서버 오류 발생");
			return response.text(); 
		}
	})
	.then(data=>{
		swal({
			title: "삭제되었습니다.",
			icon: "success",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인",
			timer: 2000
		});
		location.reload();
	})
	.catch(error=>{
		swal({
			title: "삭제 실패",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인",
			timer: 2000
		});
	})

})

</script>
</html>
