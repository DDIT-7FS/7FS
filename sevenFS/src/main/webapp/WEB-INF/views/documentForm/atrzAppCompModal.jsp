<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<style>
.small-btn {
    padding: 10px 20px;
    font-size: 16px;
}
</style>
<head>
    <meta charset="UTF-8">
    <!-- <title>결재하기 모달</title> -->
</head>
<body>
    <!-- 결재모달 모달창 시작 -->
    <div class="modal fade" id="atrzApprovalModal" tabindex="-1" 
    aria-labelledby="atrzApprovalModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="atrzApprovalModalLabel">결재하기</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/selectForm/atrzDetail" method="post" id="atrzApprovalForm">
                        <input type="hidden" id="atrzDocNo" name="atrzDocNo" value="${atrzVO.atrzDocNo}">
                        <table class="table">
                            <tr>
                                <!-- <td>${atrzVO}</td> -->
                                <td>결재문서명</td>
                                <td>${atrzVO.atrzSj}</td>
                            </tr>
                            <tr>
                                <td>결재의견</td>
                                <td><textarea class="form-control" id="approvalMessage">승인합니다.</textarea></td>
                            </tr>
                            
                            <tr>
                                <td>결재옵션</td>
                                <td>
                                    <input type="checkbox" id="authorStatus">
                                    <label for="authorStatus">전결</label>
                                    <span>(체크시 모든 결재가 완료처리 됩니다)</span>
                                </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" id="atrzDetailappBtn" class="main-btn primary-btn rounded-full btn-hover small-btn">승인</button>
                    <button type="button" class="main-btn light-btn rounded-full btn-hover small-btn" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    <!--결재모달 끝-->


    <!--반려모달-->
    <div class="modal fade" id="atrzCompanModal" tabindex="-1" 
    aria-labelledby="atrzCompanModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="atrzCompanModalLabel">반려하기</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <table class="table">
                            <tr>
                                <td>결재문서명</td>
                                <td>${atrzVO.atrzSj}</td>
                            </tr>
                            <tr>
                                <td>반려의견</td>
                                <td><textarea class="form-control" id="companionMessage" placeholder="반려시 결재의견은 필수입력사항입니다."></textarea></td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" id="atrzDetailComBtn" class="main-btn danger-btn rounded-full btn-hover small-btn">반려</button>
                    <button type="button" class="main-btn light-btn rounded-full btn-hover small-btn" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    <!--반려모달-->

    <!--반려사유모달-->
    <div class="modal fade" id="atrzComOptionModal" tabindex="-1" 
    aria-labelledby="atrzComOptionModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="atrzComOptionModalLabel">반려사유</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <table class="table">
                            <tr>
                                <input type="text" class="form-control" id="recipient-name" value="${atrzVO.atrzOpinion}" readonly disabled>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="main-btn light-btn rounded-full btn-hover small-btn" data-bs-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
    <!--반려사유모달-->

</body>

</html>