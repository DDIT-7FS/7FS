<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="통계" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<c:import url="../layout/prestyle.jsp" />

<!--스타일태그시작  -->
<style>
</style>
<!--스타일태그끝  -->


<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	/* 구글차트 패키지모음******* */
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawVisualization);
	/* 구글차트 패키지모음********* */ 
		
	
	
	// 차트 변경
	/* 차트 기본형태 : line */
    let comboChartType = 'line';
	function onChartTypeChange() {
        const selectBox = document.getElementById('chartTypeSelect');
        comboChartType = selectBox.value;
//         drawVisualization();
	console.log()
     }
// 	차트그려주는 drawVisualization
	function drawVisualization(AWOL) {
    // Some raw data (not necessarily accurate)
    	var data = new google.visualization.arrayToDataTable(AWOL.map(([key, value], idx) => idx== 0 ? [key, value] : [key, +value]));
    	console.log("데이타",data);
		console.log("했어용!!!!!!!!",AWOL);
//     	var data = google.visualization.arrayToDataTable([
//     		 ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
//              ['2004/05',  165,      938,         522,             998,           450,      614.6],
//              ['2005/06',  135,      1120,        599,             1268,          288,      682],
//              ['2006/07',  157,      1167,        587,             807,           397,      623],
//              ['2007/08',  139,      1110,        615,             968,           215,      609.4],
//              ['2008/09',  136,      691,         629,             1026,          366,      569.6]
//         ]);

        var options = {
          title : '',
          vAxis: {title: 'Cups'},
          hAxis: {title: 'Month'},
          seriesType: comboChartType
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
	
	  
	
	//object -> 요청파라미터 string
	 $(function(){
		$("#btnSubmit").on("click",function(){  
			
			//object -> 요청파라미터 string
			//1. 연간
			//interval=year&chartType=line&startYearsY=2024&endYearsY=2025&startYearsM=&startDays=&endDays=&dept=%EC%9D%B8%EC%82%AC%EB%B6%80&dept=%EC%98%81%EC%97%85%EB%B6%80
			
			//2. 월간
			//interval=month&chartType=line&startYearsM=2025&startMonths=01&endMonths=05&startDays=&endDays=&dept=%EC%83%9D%EC%82%B0%EB%B6%80&dept=%EA%B5%AC%EB%A7%A4%EB%B6%80
			
			//3. 일간
			//interval=day&chartType=bars&startYearsM=&startDays=2025-04-04&endDays=2025-04-30&dept=%ED%92%88%EC%A7%88%EB%B6%80&dept=%EC%97%B0%EA%B5%AC%EC%86%8C
			let frm = $("#frm").serialize();
			console.log("frm : ", frm);

    	  $.ajax({
    		 url:"/statistics/statisticsAWOL/AWOLAjax",
    		 data:frm,
    		 type:"post",
    		 dataType:"json",
    		 success:function(result){
    		 console.log("result : ", result);
    			 //매개
    			 
    			 let AWOL = result;
    			 
    			 google.charts.setOnLoadCallback(drawStuff(AWOL)));
    		 }
    	  });		
		});//end btnSubmit
	 });//end 달러function
	 
	 
	
	</script>

</head>
<body>
	<c:import url="../layout/sidebar.jsp" />
	<main class="main-wrapper">
		<c:import url="../layout/header.jsp" />

		<section class="section mt-4">
			<div class="container-fluid">
				<div class="row mt-5">
					<div class="col-12">
						<div class="card-style">
							<!-- 상위탭 시작  -->
							<div>
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab1" data-bs-toggle="tab"
											data-bs-target="#content1" type="button"
											onClick="location.href='statisticsHome'" role="tab"
											aria-controls="content1" aria-selected="true">Home</buㅈtton>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link active" id="tab2" data-bs-toggle="tab"
											data-bs-target="#content2" type="button" role="tab"
											aria-controls="content2" aria-selected="false">직원관리</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab3" data-bs-toggle="tab"
											data-bs-target="#content3" type="button" role="tab"
											aria-controls="content3" aria-selected="false">재무</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab4" data-bs-toggle="tab"
											data-bs-target="#content4" type="button" role="tab"
											aria-controls="content4" aria-selected="false">프로젝트관리</button>
									</li>
								</ul>
							</div>
							<!-- 상위탭 시작  -->

							<!-- 하위탭 시작  -->
							<div class="tab-content mt-3" id="myTabContent">
								<div class="tab-pane fade" id="content1" role="tabpanel"
									aria-labelledby="tab1">
									<!--home 탭키 내부입니다.  -->
								</div>

								<div class="tab-pane fade show active" id="content2"
									role="tabpanel">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link active" href="#">결근</a>
											<!-- active 클래스 위치 수정 --></li>
										<li class="nav-item"><a class="nav-link" href="#">지각/조퇴</a>
										</li>
									</ul>
								</div>

								<div class="tab-pane fade" id="content3" role="tabpanel"
									aria-labelledby="tab2">
									<ul class="nav nav-pills">
										<!--Spending Rate 지출율  -->
										<li class="nav-item"><a class="nav-link " href="#">지출
												예정대비 지출율</a></li>
										<!--roa = return on assets 약차 (수금율)  -->
										<li class="nav-item"><a class="nav-link" href="#">수금
												예측대비 수금율</a></li>
										<!-- ror = rate of return 수익율-->
										<li class="nav-item"><a class="nav-link" href="#">예상
												실 수익율 대비 수익율</a></li>
								</div>
								<div class="tab-pane fade" id="content4" role="tabpanel"
									aria-labelledby="tab3">
									<!-- keyPerformanceIndicator-->
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link " href="#">직급
												별 업무기여도 달성율</a></li>
										<!--Hire And Leaving (입,퇴사자) 통계  -->
										<li class="nav-item"><a class="nav-link" href="#">입,퇴사자</a>
										</li>
								</div>
								<div class="tab-pane fade" id="content5" role="tabpanel"
									aria-labelledby="tab4">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link " href="#">프로젝트별
												업무 기여도</a></li>
										<!--Project Acheviement Rate  -->
										<li class="nav-item"><a class="nav-link" href="#">프로젝트
												별 달성율</a></li>
								</div>
								<div class="tab-pane fade" id="content6" role="tabpanel"
									aria-labelledby="tab5">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link "
											href="http://localhost/1demo/table">표</a></li>
								</div>
							</div>
							<!-- 하위탭 끝  -->
							<!-- 그래프 내부카드  -->
							<div class="row mt-5">
								<div class="col-12">
									<div class="card-style">
										<!-- 연, 월, 일 선택 라디오 버튼 -->
										<form id="frm">
											<div class="d-flex  align-items-center mb-3">
												<legend>통계 기간 설정</legend>
												<button type="button" onClick="window.location.reload()"
													class="btn btn-outline-primary" >Re&nbsp;&nbsp;Try</button>
											</div>
											<div class="form-check radio-style mb-20 "
												style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval"
													value="year" id="year"> <label
													class="form-check-label" for="year">연간</label>
											</div>
											&nbsp;&nbsp;&nbsp;
											<div class="form-check radio-style mb-20"
												style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval"
													value="month" id="month"> <label
													class="form-check-label" for="month">월간</label>
											</div>
											&nbsp;&nbsp;&nbsp;
											<div class="form-check radio-style mb-20"
												style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval"
													value="day" id="day"> <label
													class="form-check-label" for="day">일간</label>
											</div>
											&nbsp;&nbsp;&nbsp;



											<!-- 동적으로 변경될 입력 필드 -->
											<!-- 기본적으로 숨겨둠 -->
											<div id="dynamicInputYears" style="display: none;">
												<div class="row card-style">
													<div class="card-header">
														<legend>연간 선택</legend>
													</div>
													<div class="card-body">
														<div class="select-style-1 form-group w-fit"">
															<label for="startYears" class="form-label"> 시작년도
															</label> <select name="startYearsY" class="form-select"
																id="startYearsY">
																<option selected="" disabled="" readonly=""
																	value="startYearsY">조회를 시작 할 년도를 선택해주세요</option>
																<option value="2025">2025</option>
																<option value="2024">2024</option>
																<option value="2023">2023</option>
																<option value="2022">2022</option>
																<option value="2021">2021</option>
															</select>
														</div>
														<div class="select-style-1 form-group w-fit">
															<label for="endYearsY" class="form-label"> 종료년도 </label>
															<select name="endYearsY" class="form-select"
																id="endYearsY">
																<option selected="" disabled="" readonly=""
																	value="endYearsY">조회를 종료 할 년도를 선택해주세요</option>
																<option value="2025">2025</option>
																<option value="2024">2024</option>
																<option value="2023">2023</option>
																<option value="2022">2022</option>
																<option value="2021">2021</option>
															</select>
														</div>
														<!--셀렉트 끝  -->
													</div>
												</div>
											</div>
											<!--dynamicInputYears 끝  -->

											<div id="dynamicInputMonths" style="display: none;">
												<div class="row card-style">
													<div class="card-header">
														<legend>월 선택</legend>
													</div>
													<div class="card-body">
														<div class="select-style-1 form-group w-fit">
															<label for="startYears" class="form-label"> 시작년도
															</label> <select name="startYearsM" class="form-select mb-2"
																id="startYearsM">
																<option selected="" readonly="" value="">조회 년도를
																	선택 해주세요</option>
																<option value="2025">2025</option>
																<option value="2024">2024</option>
																<option value="2023">2023</option>
																<option value="2022">2022</option>
																<option value="2021">2021</option>
															</select> <label for="startYearsM" class="form-label"> 시작월
															</label> <select name="startMonths" class="form-select mb-2"
																id="startMonths">
																<option selected="" disabled="" readonly="" value="">조회를
																	종료 할 월을 선택해주세요</option>
																<option value="01">1월</option>
																<option value="02">2월</option>
																<option value="03">3월</option>
																<option value="04">4월</option>
																<option value="05">5월</option>
																<option value="06">6월</option>
																<option value="07">7월</option>
																<option value="08">8월</option>
																<option value="09">9월</option>
																<option value="10">10월</option>
																<option value="11">11월</option>
																<option value="12">12월</option>
															</select> <label for="startMonths" class="form-label"> 종료월
															</label> <select name="endMonths" class="form-select mb-2"
																id="endMonths">
																<option selected="" disabled="" readonly="" value="">조회를
																	종료 할 월을 선택해주세요</option>
																<option value="01">1월</option>
																<option value="02">2월</option>
																<option value="03">3월</option>
																<option value="04">4월</option>
																<option value="05">5월</option>
																<option value="06">6월</option>
																<option value="07">7월</option>
																<option value="08">8월</option>
																<option value="09">9월</option>
																<option value="10">10월</option>
																<option value="11">11월</option>
																<option value="12">12월</option>
															</select>
														</div>
													</div>
												</div>
											</div>

											<div id="dynamicInputDays" style="display: none;">
												<div class="card-header">
													<legend>특정 기간 선택</legend>
												</div>
												<div class="input-style-1">
													<label>시작일</label> <input id="startDays" name="startDays"
														type="date" data-listener-added_846ff8c4="true">
												</div>
												<div class="input-style-1">
													<label>종료일</label> <input id="endDays" name="endDays"
														type="date" data-listener-added_846ff8c4="true">
												</div>
											</div>
											<div class="select-style-1 form-group">
												<label>조회 할 부서를 선택 해 주세요 <span class="text-danger">*</span></label>
												<div class="d-flex gap-5">
													<div class="form-check checkbox-style mb-20">
														<input class="form-check-input" type="checkbox"
															name="dept" value="selectAll" id="checkbox-1"  onclick='selectAll(this)'>
														<label class="form-check-label" for="checkbox-1" >전체선택</label>
														<!--전체선택 끝 부서시작  -->
														<input class="form-check-input" type="checkbox"
															name="dept" value="10" id="checkbox-1" >
														<label class="form-check-label" for="checkbox-1">인사부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="20" id="checkbox-2" >
														<label class="form-check-label" for="checkbox-2">경영지원부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="30" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">영업부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="40" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">생산부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="50" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">구매부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="60" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">품질부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="70" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">디자인부</label>
														<input class="form-check-input" type="checkbox"
															name="dept" value="80" id="checkbox-3" >
														<label class="form-check-label" for="checkbox-3">연구소</label>
													</div>
												</div>
											</div>
										</form>
										<!-- 전체 폼태그 끝 form  -->
										<div class="select-style-1 form-group w-fit">
											<select name="chartType" class="form-select" id="chartType"
												onchange="onChartTypeChange()">
												<label for="chartType" class="form-label">차트 유형 선택:</label>
												<option selected="" disabled="" readonly="" value="">그래프
													유형을	 선택해주세요</option>
												<option value="line">선형(Line)</option>
												<option value="bars">막대(Bar)</option>
												<option value="area">영역(Area)</option>
											</select>
											<div class="invalid-feedback">그래프 유형을 선택해주세요.</div>
										</div>
										<!-- 폼태그안의 카드 끝   -->
									</div>
									<button type="button" id="btnSubmit" tabindex="1"
										class="btn submit btn-primary col-2 mt-3"
										onclick="drawVisualization()">그래프 조회</button>
								</div>
								<!--제목 및 가로 세로 축 제목 적는 곳   -->
								<div class="input-style-1 form-group col-6 mt-3 mb-3">
									<label for="chartTitle" class="form-label required mt-3">제목</label>
									<input type="text" name="chartTitle" class="form-control"
										id="chartTitle" placeholder="차트의 제목을 입력해주세요" required
										maxlength="100">
									<div class="invalid-feedback">차트의 제목을 입력해주세요.</div>
									<label for="vAxisTitle" class="form-label required mt-3">세로축</label>
									<input type="text" name="vAxisTitle" class="form-control"
										id="vAxisTitle" placeholder="차트의 세로축을입력해주세요" required
										maxlength="100">
									<div class="invalid-feedback">차트의 제목을 입력해주세요.</div>
									<label for="hAxisTitle" class="form-label required mt-3">가로축</label>
									<input type="text" name="hAxisTitle" class="form-control"
										id="hAxisTitle" placeholder="차트의 가로축을 입력해주세요" required
										maxlength="100">
									<div class="invalid-feedback">차트의 제목을 입력해주세요.</div>
								</div>
								<div id="chart_div" style="width: 900px; height: 500px;"></div>
							</div>
							<!-- 카드끝 -->
						</div>
		</section>

		<script>



function handleIntervalChange(event) {
	console.log("왔다");

	//event : change 이벤트
	//event.target : <input class="form-check-input" type="radio" name="interval" value="year" id="year"> 
	  const { name,value } = event.target;
	  let dynamicInputYearsDom = document.querySelector("#dynamicInputYears");//<div id="dynamicInputYears"..
	  let dynamicInputMonthsDom = document.querySelector("#dynamicInputMonths");//<div id="dynamicInputMonths"..
	  let dynamicInputDaysDom = document.querySelector("#dynamicInputDays");//<div id="dynamicInputDays"..

	  //year, month, day
	  
	  if (value === "year") {
		console.log("헤이!")
        $('#startYearsM,#startMonths,#endMonths,#startDays,#endDays').prop('selectedIndex', 0);
        $('#startDays').val('');
        $('#endDays').val('');
        
	    dynamicInputYearsDom?.classList.add("d-block");
	    dynamicInputYearsDom?.classList.remove("d-none");

	    dynamicInputMonthsDom?.classList.add("d-none");
	    dynamicInputMonthsDom?.classList.remove("d-block");

	    dynamicInputDaysDom?.classList.add("d-none");
	    dynamicInputDaysDom?.classList.remove("d-block");
	  }

	  if (value === "month") {
		 
		$('#startYearsY, #endYearsY').prop('selectedIndex', 0);
		$('#startDays').val('');
	    $('#endDays').val('');
		  
		document.getElementById("dynamicInputYears").value = '';
		document.getElementById("dynamicInputDays").value = '';
		  
	    dynamicInputYearsDom?.classList.add("d-none");
	    dynamicInputYearsDom?.classList.remove("d-block");

	    dynamicInputMonthsDom?.classList.add("d-block");
	    dynamicInputMonthsDom?.classList.remove("d-none");

	    dynamicInputDaysDom?.classList.add("d-none");
	    dynamicInputDaysDom?.classList.remove("d-block");
	  }

	  if (value === "day") {
		 
		$('#startYearsY, #endYearsY,#startYearsM,#startMonths,#endMonths').prop('selectedIndex', 0);
		  
		document.getElementById("dynamicInputYears").value = '';
		document.getElementById("dynamicInputMonths").value = '';  
		  
	    dynamicInputYearsDom?.classList.add("d-none");
	    dynamicInputYearsDom?.classList.remove("d-block");

	    dynamicInputMonthsDom?.classList.add("d-none");
	    dynamicInputMonthsDom?.classList.remove("d-block");

	    dynamicInputDaysDom?.classList.add("d-block");
	    dynamicInputDaysDom?.classList.remove("d-none");
	  }
	}//end handleIntervalChange

	$(function(){
		console.log("개똥이!");
		$("input[name='interval']").on("change",function(e){ 
			console.log("개똥이2!");
			handleIntervalChange(e);
		});
	});
	//전체 체크 해제 
	function selectAll(selectAll)  {
		  const checkboxes 
		     = document.querySelectorAll('input[type="checkbox"]');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
	 }
</script>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>

</body>
</html>
