<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치기릿 관리자 페이지</title>

<style>
	header {
		background-color: greenyellow;
		height: 100px;
		text-align: center;
		line-height: 100px
	}
	
	nav {
		width: 200px;
		height: 500px;
		float: left;
		border: 1px solid gray;
		margin-right: 20px;
	}

	table {
		width: 50%;
		border-collapse: collapse;
	}

	#search {
		width: 50%;
		display: flex;
		justify-content: space-between;
	}
</style>

</head>

<body>
	<jsp:include page="./AdminHeader.jsp" />
	
	<form method="get">
	<div id="search">
		<button type="button" id="downloadBtn">Excel 파일로 다운로드</button>
		<div>
		<select name="searchType">
			<option value="M_id">회원 번호</option>
			<option value="M_name">회원 이름</option>
			<option value="nickname">닉네임</option>
			<option value="email">이메일 주소</option>
			<option value="P_number">연락처</option>
			<option value="reg_date">가입일</option>
			<%-- <option value="">최근 접속일</option>
			<option value="">계정 정지 여부</option> --%>
		</select>
		<input type="search" name="searchValue" value="${map.searchValue}" />
		<input type="submit" value="검색" />
		</div>
	</div>
	</form>
	

	<h3>회원 목록</h3>
<form method="post" onsubmit="return checkbox(this);">
	<table border="1">
		<tr>
			<td></td>
			<td>회원 번호</td>
			<td>회원 성함</td>
			<td>닉네임</td>
			<td>이메일 주소</td>
			<td>연락처</td>
			<td>가입일</td>
			<%-- <td>최근 접속일</td>
			<td>계정 정지 여부</td> --%>
		</tr>
		<c:choose>
			<c:when test="${empty memberList}">
				<tr>
					<td colspan="9" align="center">등록된 회원이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${memberList}" var="member" varStatus="stat">
				<tr align="center">
					<td>
						<input type="checkbox" name="selectedMember" value="${member.memberId}">
					</td>
					<td>
						<a href="../MatchGetIt/MemberInfoPage.do
						?email=${member.email}&emailType=${member.memberTypeId}">${member.memberId}</a>
					</td>
					<td>${member.memberName}</td>
					<td>${member.nickName}</td>
					<td>${member.email}</td>
					<td>${member.phoneNumber}</td>
					<td>${member.regDate}</td>
					<%-- <td></td><td></td> --%>
					<%-- <td>${member.lastLoginDate}</td>
					<td>${member.isBanned}</td> --%>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<br>
	<div id="bottom">
		
		
	</div>
	
	<table>
		<tr>
			<td width="150">
				<button type="submit">선택한 회원 삭제하기</button>
			</td>
			<td align="center">
				<span>${map.pagingStr}</span>
			</td>
		</tr>
	</table>
</form>
	
<script>
	function checkbox(form) {
		let selectedMember = document.querySelectorAll('input[type="checkbox"]:checked');
		//console.log(selectedMember);
		
		if (selectedMember.length == 0) {
			alert('선택한 회원이 없습니다.');
			return false;
		}

		return confirm(selectedMember.length+"명의 회원을 삭제하시겠습니까? (삭제하면 되돌릴 수 없습니다.)");
	}
	
	document.querySelector('#downloadBtn').addEventListener('click', function() {
		location.href = '../MatchGetIt/Download.do';
	})
</script>

</body>
</html>
