<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" scope="application" value="게시판" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>${title}</title>
    <c:import url="../layout/prestyle.jsp" />
    <script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
		integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
</head>
<style>
    .col-sm-12 img {
        width: 100px;
        height: 100px;
    }
</style>
<body>
    <c:import url="../layout/sidebar.jsp" />
    <main class="main-wrapper">
        <c:import url="../layout/header.jsp" />
        
        <section class="section">
            <div class="container-fluid">
                <c:import url="../layout/title-wrap.jsp" />
                <!-- 파일 수정이 되게 하되, 파일이 없다면 새로 추가하는 로직 필요 -->
                <div class="row">
                    <div class="col-12">
                        <div class="card-style">
                            <h2 class="text-primary text-center">(🌸◔ ω ◔)</h2>
                            <form action="/bbs/bbsUpdate" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
                                <div>
                                    제목
                                    <input type="text" name="bbscttSj" value="${bbsVO.bbscttSj}" class="form-control" />
                                </div>
                                <br>
                                <div class="col-sm-12">
                                    내용
                                    <div id="descriptionTemp">${bbsVO.bbscttCn}</div>
                                    <textarea id="content" name="bbscttCn" rows="3" cols="30" class="form-control" hidden></textarea>
                                </div>
                                <br>
                                <div>
                                    작성자
                                    <input type="text" name="emplNo" value="${bbsVO.emplNo}" class="form-control" />
                                </div>
                                <br>
                                <div>
                                    파일
                                    <c:if test="${not empty bbsVO.files}">
                                        <c:forEach var="file" items="${bbsVO.files}">
                                            <p>${file.fileStreNm}</p>
                                        </c:forEach>
                                    </c:if>
                                    <input type="file" name="files" class="form-control" multiple>
                                </div>
                                <br>
                                <div>
                                    <button type="submit" class="btn btn-warning">확인</button> &nbsp;
                                    <a href="/bbs/bbsDetail?bbsSn=${bbsVO.bbsSn}" class="btn btn-secondary">취소</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:import url="../layout/footer.jsp" />
    </main>

    <c:import url="../layout/prescript.jsp" />
    
    <script type="text/javascript">
        // CKEditor5 적용
        ClassicEditor.create(document.querySelector("#descriptionTemp"), {
            ckfinder: { uploadUrl: "/bbs/image/upload" }
        })
        .then(editor => { window.editor = editor; })
        .catch(err => { console.error(err.stack); });
        
        $(function(){
            $(".ck-blurred").keydown(function(){
                 $("#content").val(window.editor.getData());
            });
            $(".ck-blurred").on("focusout", function(){
                 $("#content").val(window.editor.getData());
            });
        });
    </script>
</body>
</html>
