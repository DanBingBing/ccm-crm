<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<!-- web路径问题：
	不以/开始的相对路径，找资源以当前的路径为基准，经常出问题。
	以/开始的相对路劲，找资源以服务器的路径为标准(http://localhost:3306)，需加上项目名(以/开始，不以/结束)，例：
		http://localhost:3306/sss-crm
	${pageContext.request.contextPath }/
 -->
 
<% 
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!-- 引入jQuery -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.2.1.min.js"></script>

<!-- 引入样式 -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面（bootstrap栅格系统搭建） -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<!-- 将屏幕分为12列，这里占用了12列 -->
			<div class="col-md-12">
				<h1>SSM-CRM</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<!-- 本身占4列，偏移8列 （使用列偏移）-->
  			<div class="col-md-4 col-md-offset-8">
  				<!-- 使用按钮效果-->
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									修改
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6 col-md-offset-1">
				<h4>当前${pageInfo.pageNum }页，总共${pageInfo.pages }页，总共${pageInfo.total }条记录</h4>
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6  col-md-offset-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH}/emps?pageNumber=1">首页</a></li>
				  	<!-- 判断是否有上一页，有则显示可点击上一页的图标，没有则不显示该图标 -->
				  	<c:if test="${pageInfo.hasPreviousPage }">
				  		<li>
				      		<a href="${APP_PATH}/emps?pageNumber=${pageInfo.pageNum -1 }" aria-label="Previous">
				        	<span aria-hidden="true">&laquo;</span>
				      	</a>
				    </li>
				  	</c:if>
				    
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
				    	<c:if test="${page_num == pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_num }</a></li>
				    	</c:if>
				    	<c:if test="${page_num != pageInfo.pageNum }">
				    		<li><a href="${APP_PATH}/emps?pageNumber=${page_num }">${page_num }</a></li>
				    	</c:if>
				    </c:forEach>
				    
				    <!-- 判断是否有下一页，有则显示可点击下一页的图标，没有则不显示 -->
				    <c:if test="${pageInfo.hasNextPage }">
				    	<li>
				      		<a href="${APP_PATH}/emps?pageNumber=${pageInfo.pageNum +1 }" aria-label="Next">
				        		<span aria-hidden="true">&raquo;</span>
				      		</a>
				    	</li>
				    </c:if>
				    
				    <!-- 总页码数就是最后一页 -->
				    <li><a href="${APP_PATH}/emps?pageNumber=${pageInfo.pages }">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>