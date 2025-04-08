<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="title" scope="application" value="게시글 상세" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${title}</title>
<c:import url="../layout/prestyle.jsp" />

</head>
<style>
    img {
        width: 100px;
        height: 100px;
    }
    
    .board-detail {
        max-width: 100%;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #f9f9f9;
    }
    .board-detail div {
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .board-detail div:last-child {
        border-bottom: none;
    }
    .board-detail p {
        margin: 5px 0;
        font-weight: bold;
    }
</style>
<body>
	<c:import url="../layout/sidebar.jsp" />
	<main class="main-wrapper">
		<c:import url="../layout/header.jsp" />

		<section class="section">
			<div class="container-fluid">

				<div class="row">
					<div class="col-12">
						<div class="card-style">
							<h2 class="text-primary text-center">(🌸◔ ω ◔)</h2>
							<p>${bbsVO.bbsSn} 번</p><br>
							<form action="/bbs/bbsUpdate" method="get">
								<input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
								<input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
								<div class="board-detail">
									<div>제목<p>${bbsVO.bbscttSj}</p></div><br>
									<div>내용<p>${bbsVO.bbscttCn}</p></div><br>
									<div>작성자<p>${myEmpInfo.emplNm}</p></div><br>
									<div>작성일<p>${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}</p></div><br>
									<c:set var="Efile" value="${bbsVO.files}" />
									<div>파일
										<c:if test="${not empty Efile}">
											<c:forEach var="file" items="${bbsVO.files}">
												<a href="http://localhost/download?fileName=test/34e5c6bb8bd34d62a8eae92ef506005e_carnation-g75dae9d9b_1280.jpg"" target="_blank">${file.fileStreNm}</a>
											</c:forEach>
										</c:if>
										<c:if test="${empty Efile}">
											<p>파일없음</p>
										</c:if>
									</div><br>
								</div>
								<div class="position-relative">
									<div class="position-absolute bottom-0 start-0">
										<a href="/bbs/bbsList?bbsCtgryNo=${bbsVO.bbsCtgryNo}" class="btn btn-outline-secondary">목록으로 돌아가기</a>
									</div>
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button type="submit" class="btn btn-outline-warning">수정</button>&nbsp;
										<button type="button" class="btn btn-outline-danger"
											onclick="bbsDelete(${bbsVO.bbsSn})">삭제</button>&nbsp;
									</div>
								</div>
							</form>
							<!-- 댓글 영역 -->
								<div class="card-style mt-4">
								    <h5 class="text-primary">💬 댓글</h5>
								
								    <!-- 댓글 입력창 -->
								    <div class="mt-3">
								        <textarea id="answerCn" rows="3" class="form-control" placeholder="댓글을 입력하세요." ></textarea>
								        <div class="d-flex justify-content-end mt-2">
								            <button type="button" class="btn btn-primary" onclick="submitComment()">댓글 등록</button>
								        </div>
								    </div>
								
								    <!-- 댓글 리스트 출력 영역 -->
								    <div id="answerContent" class="mt-4">
								        <%-- AJAX로 댓글 목록이 여기 들어올 예정 --%>
								    </div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<c:import url="../layout/footer.jsp" />
	</main>

	<c:import url="../layout/prescript.jsp" />
	<!-- 삭제 폼 -->
	<script>
	
	

	
    function bbsDelete(bbsSn){
        if(confirm("삭제하시겠습니까?")){
            $.ajax({
                url: "/bbs/bbsDelete",
                method: "post",
                data: {bbsSn: bbsSn},
                success: function(){
                    alert("삭제되었습니다.");
                    window.location.href = "/bbs/bbsList?bbsCtgryNo="+${bbsVO.bbsCtgryNo};
                }
            });
        }
    }
    
	// 댓글 등록
	function submitComment() {
	    const answerCn = $("#answerCn").val().trim();  // 앞뒤 공백 제거
	
	    if (!answerCn) {
	        alert("댓글 내용을 입력해주세요.");
	        $("#answerCn").focus();
	        return;
	    }
	
	    $.ajax({
	        type: "POST",
	        url: "/bbs/answer",
	        data: {
	            bbsSn: ${bbsVO.bbsSn},
	            bbsCtgryNo: ${bbsVO.bbsCtgryNo},
	            answerCn: answerCn,
	            emplNo: ${myEmpInfo.emplNo}
	        },
	        success: function(response) {
	            console.log("댓글 등록 성공");
	            $("#answerCn").val(""); // 입력창 비우기
	            loadAnswer(); // 댓글 목록 새로고침
	        },
	        error: function(xhr) {
	            console.error("댓글 등록 실패:", xhr.responseText);
	        }
	    });
	}
	
	// 댓글 목록 불러오기
	function loadAnswer() {
	    $.ajax({
	        url: "/bbs/answer",
	        type: "GET",
	        data: {
	            bbsSn: ${bbsVO.bbsSn},
	            bbsCtgryNo: ${bbsVO.bbsCtgryNo}
	        },
	        
	        success: function(data) {
	            console.log("댓글 데이터:", data);
	            let html = "";
	            data.forEach(function(answer) {
	                console.log("각 댓글:", answer); // 실제 데이터 확인
	                html += `
	                    <div class="card mb-3">
	                        <div class="card-body">
	                            <div class="d-flex justify-content-between align-items-center mb-2">
	                                <h6 class="mb-0 fw-bold text-primary">${myEmpInfo.emplNm}</h6>
	                                <small class="text-muted">\${answer.answerCreatDt}</small>
	                            </div>
	                            <p class="card-text">\${answer.answerCn}</p>
	                        </div>
	                    </div>
	                `;

	            });
	            
	            console.log("최종 HTML:", html);
	            $("#answerContent").html(html);
	        }
,
	        error: function(xhr) {
	            console.error("댓글 불러오기 실패:", xhr.responseText);
	        }
	    });
	}
	
	$(document).ready(function() {
	    loadAnswer();  // 페이지 들어오면 바로 댓글 가져오게
	});


	</script>

		
</body>
</html>
