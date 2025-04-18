<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="연차 관리" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../../layout/prestyle.jsp" %>
</head>
<body>
<%@ include file="../../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
       		<!-- Button trigger modal -->
			<div class="row">
            <div class="col-lg-12">
            <div class="d-flex justify-content-start">
             <button type="button" class="btn-sm main-btn primary-btn-light btn-hover text-dark rounded-md mb-3" data-bs-toggle="modal" data-bs-target="#exampleModal">
				 사원 연차 지급
			</button>
             </div>
              <div class="card-style">
                <div class="table-wrapper table-responsive">
                  <table class="table">
                  <h6>전체사원 연차 현황</h6>
                  <div class="mb-10 d-flex justify-content-end col-12">
                   <div>
                   	 <a href="/dclz/vacAdmin" class="btn-sm light-btn-light btn-hover mr-10 rounded-md">전체 목록 보기</a>
                   </div>
                   <form action="/dclz/vacAdmin" method="get" id="selTypeForm">
                  	<c:set var="duplTypes" value="" />
	                <div class="input-style-1 form-group mr-10">
		     	     <select id="vacType" class="form-select w-auto" required="required">
						<option>유형 선택</option>
						<c:forEach var="vacDatas" items="${allEmplVacList}">
						<c:set var="vacType" value="${vacDatas.cmmnCodeNm}" />
							<c:if test="${not fn:contains(duplTypes, vacType)}">
								<option value="${vacType}">${vacType}</option>
								<c:set var="duplTypes" value="${duplTypes},${vacType}" />
							</c:if>	
						</c:forEach>
					 </select> 
					 <input type="hidden" id="typeKeyword" name="keyword">
				  	</div> 
		            </form>
		            <form action="/dclz/vacAdmin" method="get" id="selYearForm">
                  	<c:set var="duplYears" value="" />
	                <div class="input-style-1 form-group">
		     	     <select id="vacYear" class="form-select w-auto" required="required">
						<option>년도 선택</option>
						<c:forEach var="vacDatas" items="${allEmplVacList}">
						<fmt:formatDate value="${vacDatas.dclzBeginDt}" pattern="yyyy" var="vacYear" />
							<c:if test="${not fn:contains(duplYears, vacYear)}">
								<option value="${vacYear}">${vacYear}</option>
								<c:set var="duplYears" value="${duplYears},${vacYear}" />
							</c:if>	
						</c:forEach>
					 </select> 
					 <input type="hidden" id="yearKeyword" name="keyword">
				  	</div>
				  	</form>
				  	<form action="/dclz/vacAdmin" method="get" id="selSearchNm">
				  	<div class="ml-10 d-flex">
				  	    <div class="rounded mb-3" style="width : 150px;">
				            <input type="search" class="form-control rounded" placeholder="이름 입력" aria-label="Search" name="keyword" aria-describedby="search-addon" id="shName" onkeydown="scEnter(event)">
				        </div>
				        <span class="input-group-text border-0" id="search-addon" style="height:40px">
				            <i class="fas fa-search" aria-hidden="true"></i>
				        </span>
			        </div>
		            </form>
		            </div>
                    <thead>
		            <%-- ${allEmplVacList} --%>
                      <tr>
                        <th>
                          <h6>사원 이름</h6>
                        </th>
                        <th>
                          <h6>연차 유형</h6>
                        </th>
                        <th>
                          <h6>연차 사용 기간</h6>
                        </th>
                        <th>
                          <h6>연차 사유</h6>
                        </th>
                      </tr>
                      <!-- end table row-->
                    </thead>
                    <tbody>
                    <c:set var="emplVacData" value="${allEmplVacList}"></c:set>
                      <c:forEach var="allVacData" items="${emplVacData}">
                      <tr>
                        <td>
                          <div>
                            <div>
                              ${allVacData.emplNm}
                            </div>
                          </div>
                        </td>
                        <td>
                          <div>
                            <div>
                              <h4><span class="status-btn warning-btn text-gray">${allVacData.cmmnCodeNm}</span></h4>
                            </div>
                          </div>
                        </td>
                        <td>
                          <fmt:formatDate var="beginDate" value="${allVacData.dclzBeginDt}" pattern="yyyy-MM-dd"/>
                          <fmt:formatDate var="endDate" value="${allVacData.dclzEndDt}" pattern="yyyy-MM-dd"/>
                        <c:choose>
                          	<c:when test="${beginDate ==  endDate}">
                          		 ${beginDate}
                          	</c:when>
                          	<c:otherwise>
                          		 ${beginDate} ~ ${endDate}
                          	</c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          ${allVacData.dclzReason}
                        </td>
                      </tr>
                      </c:forEach>
                      <!-- end table row -->
                    </tbody>
                  </table>
                  <!-- end table -->
                  <!-- 페이지네이션 -->
                  <div>
                  <page-navi
					url="/dclz/vacAdmin?"
					current="${param.get('currentPage')}"
					show-max="10"
					total="${articlePage.totalPages}">
				  </page-navi> 
				  </div>
				  <!-- 페이지네이션 -->
                </div>
              </div>
              <!-- end card -->
            </div>
            <!-- end col -->
          </div>
          
        <!-- Modal -->
        <!-- <form id="vacationSub"> -->
		<div class="modal fade" tabindex="-1" id="exampleModal" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
		  <div class="modal-dialog" style="max-width: 1000px;">
		    <div class="modal-content" >
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">연차 지급</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body d-flex">
		      	<div class="overflow-scroll" style="max-height: 80vh; width:400px;">
			      	<div>
						<c:import url="../searchBar.jsp" />
				 	</div>
					<div class="card-style overflow-scroll mt-15" style="max-height: 90vh;">
						<c:import url="../orgList.jsp" />	
					</div>
		        </div>
		        <!-- 화살표 버튼 -->
		        <div style="padding-left: 30px;">
		        	<div class="col-sm-1 d-flex flex-column align-items-center mt-140" >
						<div class="d-flex flex-column align-items-center" style="gap: 5px;">
							<button id="add_empl" type="button" class="btn btn-secondary">
							<i class="lni lni-arrow-right"></i>
							</button>
							<button id="remo_empl" type="button" class="btn btn-secondary">
							<i class="lni lni-arrow-left"></i>
							</button>
						</div>
					</div>
		        </div>
		        <!-- 화살표 버튼 -->
		        <div class="card-style w-80">
		        <div class="d-flex">
	        	 <div class="input-style-1 form-group mr-20">
		            <label for="username" class="form-label required">사원<span class="text-danger">*</span></label>
		            <input type="text" name="username" class="form-control" id="username" placeholder="사원을 선택해주세요." required maxlength="100" readonly>
		            <div class="invalid-feedback">사원을 선택해주세요.</div>
		          </div>
	        	  <div class="input-style-1 form-group">
		            <label for="" class="form-label required">부서<span class="text-danger"></span></label>
		            <input type="text" name="" class="form-control" id="emplDep" placeholder="" required maxlength="100" readonly>
		          </div>
		         </div>
		         <div class="d-flex">
	        	 <div class="input-style-1 form-group mr-40">
		            <label for="basicVac" class="form-label required">기본 연차<span class="text-danger"></span></label>
		             <select class="form-select" id="basicVac" style="width: 200px;">
				        <option value="없음">없음</option>
				        <option value="기본지급">기본지급</option>
				    </select>
		          </div>
	        	 <div class="input-style-1 form-group">
		            <label for="addVac" class="form-label required">추가 연차<span class="text-danger"></span></label>
		             <select class="form-select" id="addVac" style="width: 200px;">
				        <option value="없음">없음</option>
				        <option value="성과보상">성과보상</option>
				        <option value="근무보상">근무보상</option>
				    </select>
		          </div>
		          </div>
	        	 <div class="input-style-1 form-group col-4">
		            <label for="addVacCnt" class="form-label required">지급 연차 일수<span class="text-danger">*</span></label>
		            <input type="number" name="" class="form-control" id="addVacCnt" placeholder="" required maxlength="100">
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="main-btn dark-btn-light square-btn btn-hover btn-sm rounded-md" data-bs-dismiss="modal">닫기</button>
		        <button type="button" id="empBtn" class="main-btn active-btn-light square-btn btn-hover btn-sm rounded-md">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
		 <!-- </form> -->
		</div>
	</section>
  <%@ include file="../../layout/footer.jsp" %>
</main>
<%@ include file="../../layout/prescript.jsp" %>
<script type="text/javascript">

let selectEmpl = null;
	
function clickEmp(data){
	//console.log("data : " , data);
	//console.log("사원번호 : " , data.node.id);
	fetch('/emplDetailData?emplNo=' + data.node.id,{
		method : 'get',
		headers : {
	        "Content-Type": "application/json"
	    }
	 })
	 .then(resp => resp.json())
	 .then(res => {
		 console.log('fetch결과 : ' ,res);
		 selectEmpl = res;
	  }) 
}

$(function(){	
	 // 추가화살표 눌렀을때
	 $('#add_empl').on('click', function(){
	  	
		 let emplData = selectEmpl.empDetail;
		 //console.log('선택한 사원 정보 : ' , emplData);
	
		 let emplNm = emplData.emplNm;
		 let emplPos = emplData.posNm;
		 let deptNm = emplData.deptNm;
		 $('#username').val(emplNm+' '+emplPos);
		 $('#emplDep').val(deptNm);
	 })
	 
	 // 삭제화살표 눌렀을때
	 $('#remo_empl').on('click', function(){
		 $('#username').val('');
		 $('#emplDep').val('');
	 })
	
	 // 사원선택없이 확인버튼 눌렀을때 경고창
	 $('#empBtn').on('click', function(){
		 let empData = selectEmpl.empDetail;
		 //console.log('사원 : ',empData.emplNo);
		 
		 //let emplData = $('#username');
		 //console.log(emplData.val());
		 const usernameVal = $('#username').val();
		 if(usernameVal == null || usernameVal == ''){
			 swal('사원을 선택해주세요.');
		 }
		 
		 // 기본연차
		 const basicVac = $('#basicVac').val();
		//성과보상, 근무보상
		 const addVacType = $('#addVac').val();
		 let vacCnt = $('#addVacCnt').val();
		 const emplNo = empData.emplNo;
		 //console.log('addVacType : ', addVacType);
		 //console.log('vacCnt : ', vacCnt);

		 // 기본 조정연차
		 let mdatYryc = 0;
		 // 성과보상
		 let cmpnstnYryc = 0;
		 // 근무보상
		 let excessWorkYryc = 0;

		 if(addVacType === '성과보상'){
			 cmpnstnYryc = vacCnt;
		 }else if(addVacType === '근무보상'){
			 excessWorkYryc = vacCnt;
		 }else if(basicVac === '기본지급'){
			 mdatYryc = vacCnt;
		 }
	 	 //console.log('dfjkld : ' , cmpnstnYryc);
	 	 //console.log('zzzz : ' , excessWorkYryc);
	 	 //console.log('기본연차일수 : ' , mdatYryc);
	 	 
	 	 // 연차 update 해줄 데이터 보내기
	 	 fetch('/dclz/addVacInsert',{
	 		 method : 'post',
	 		 headers : {
	 			"Content-Type": "application/json"
	 		 },
	 		 body : JSON.stringify({
	 			 emplNo : emplNo,
	 			 cmpnstnYryc : cmpnstnYryc,
	 			 excessWorkYryc : excessWorkYryc,
	 			 yrycMdatDaycnt : mdatYryc
	 		 })
	 	 }) // end fetch
	 	 .then(resp => resp.text())
	 	 .then(res => {
	 		 swal('연차 지급이 완료되었습니다.')
	 		 .then((value)=>{
	 			 $('#exampleModal').modal('hide');
	 		 })
	 		 
	 		 //console.log('연차 추가하고 받은 결과 : ' , res);
	 	 })
	 })
	 
	 // 유형 selectBox 선택시
	 $('#vacType').on('change', function(){
		 const vacType = $('#vacType').val();
		 console.log('선택한 유형 : ' , vacType);
		 // 선택한 유형 보내주기
		 const typeKeyword = $('#typeKeyword').val(vacType);
		 //console.log("바꿔준 input 값 : " , typeKeyword.val());
		 $('#selTypeForm').submit();
	 })
	 // 년도 선택시
	 $('#vacYear').on('change', function(){
		 const vacYear = $('#vacYear').val();
		 console.log('선택날짜 : ' , vacYear);
		 // 선택 날짜 보내주기
		 const yearKeyword = $('#yearKeyword').val(vacYear);
		 $('#selYearForm').submit();
	 })
	 
	 // 이름 검색하고 엔터 눌렀을시
	  /*  function scEnter(e) {
        if (e.code === "Enter") {
        	const schName = $('#schName').val();
        }
    }  */
	 
	 
	 // 이름 검색하고 돋보기 눌렀을시
	/*  function fSch(){
		 alert('dkfjdl');
		 const schName = $('#schName').val();
         console.log('이름 : ' , schName);
	 } */
	 
	 
}) // end fn
	
	
</script>

</body>
</html>
