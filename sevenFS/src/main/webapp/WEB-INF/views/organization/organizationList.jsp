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
	<meta
		  name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	<section class="section">
	  <div class="container-fluid">
	  	<div class="row">
		  <div class="col-4">
			<div class="card-style">
			  <c:import url="../organization/orgList.jsp" />
			</div>
		  </div>
		  
		  <!-- 사원상세 페이지 -->
		  <div class="col-8">
			<div id="emplDetail" style="text-align: center;">
			  
			  <p id="employeeDetail" style="margin-top: 150px;">
				<span  class="material-symbols-outlined">person_check</span>
				사원을 선택하면 상세조회가 가능합니다.
			  </p>
			
			</div>
		  </div>
		  
		</div>
	  </div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>

<script type="text/javascript">
  // 사원 클릭 한 경우
  function clickEmp(data) {
    fetch("/emplDetail?emplNo=" + data.node.id, {
      method : "get",
      headers : {
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.text())
      .then(res => {

        console.log("사원상세정보 : " , res);
        $("#emplDetail").html(res);
      })
  }
  
  // 부서 클릭 한 경우
  function clickDept(data) {
    fetch("/deptDetail?cmmnCode=" + data.node.id, {
      method : "get",
      headers : {
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.text())
      .then(res => {
        console.log("부서상세정보 : " , res);
        $("#emplDetail").html(res);

        // 부서 삭제 - 관리자만 가능
        $(function(){
          $("#deptDeleteBtn").on("click", function(){
            swal({
              title: "정말 삭제하시겠습니까?",
              icon: "warning",
              buttons: true,
              dangerMode: true,
            })
              .then((willDelete) => {
                if (willDelete) {
                  fetch("deptDelete?cmmnCode="+ data.node.id,{
                    method : "get",
                    headers : {
                      "Content-Type": "application/json"
                    }
                  })
                    .then(resp => resp.text())
                    .then(res => {
                      console.log("삭제성공? : " , res);
                    })
                  swal("식제되었습니다.]", {
                    icon: "success",
                  })
                    .then((res)=>{
                      location.href = "/orglistAdmin";
                    })
                } else {
                  swal("취소되었습니다.");
                }
              });
          }); // end function
        }); // end del function
      })
  }
  

 </script>

<c:import url="../layout/prescript.jsp" />
</body>
</html>
