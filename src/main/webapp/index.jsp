<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>

<% 
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!-- 引入jQuery -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.2.1.min.js"></script>

<!-- 先引入 jQuery，bootstrap依赖于它，不然可能导致某些功能不生效-->
<!-- 引入样式 -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- bootstrap模态框(员工修改) -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">员工修改</h4>
	      </div>
	      <div class="modal-body">
	      	
	      	<!-- bootstrap水平排列的表单 -->
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName-update-static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			       <input type="text" class="form-control" name="email" id="email_update_input">
			       <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <!-- 单选框 -->
			    <label class="radio-inline">
					<input type="radio" name="gender" id="gender1_Update_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
					<input type="radio" name="gender" id="gender2_Update_input" value="F"> 女
				</label>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      	<!-- 下拉列表，下拉列表里的数据从数据库从查询出来再选择，只提交部门id即可 -->
			    	<select class="form-control" name="dId" id="dept_Update_select">
			    	</select>
			    </div>
			  </div>  
			</form>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- bootstrap模态框(员工添加) -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      	
	      	<!-- bootstrap水平排列的表单 -->
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <!-- 单选框 -->
			    <label class="radio-inline">
					<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
					<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      	<!-- 下拉列表，下拉列表里的数据从数据库从查询出来再选择，只提交部门id即可 -->
			    	<select class="form-control" name="dId" id="dept_add_select">
			    	</select>
			    </div>
			  </div>  
			</form>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">批量删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6 col-md-offset-1" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6  col-md-offset-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		// 定义一个总记录数，用于查询分页插件查询最后一页的信息
		// 定义一个当前记录数，用户查询当前页的信息
		var totalRecord,currentPage;
		
		// 页面加载完成后，直接发送ajax请求，获取分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pageNumber="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					// 1.解析json并显示员工数据
					build_emps_table(result);
					// 2.解析json并显示分页信息
					build_page_info(result);
					// 3.解析json并显示分页条
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result){
			// 因为ajax请求不会刷新页面，请求的数据直接添加到页面上了，
			// 由于这里的分页信息、分页条等都是在ajax发送请求后返回的，
			// 所以当点击不同的页码按钮时会把请求的信息直接显示到页面，在这之前应先清空表格
			$("#emps_table tbody").empty();
			
			// 获取所有员工数据
			var emps = result.extend.pageInfo.list
			// 遍历员工数据
			$.each(emps,function(index,item){
				//alert(item.empName);
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender == "M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				// 在数据库中不能存在员工对应的部门为空，因为页面上的下拉列表默认有一个值
				// 如果为空则会出错（只有手动添加数据库数据时才可能出现，从页面上添加不会出现，因为有默认值）
				var deptName = $("<td></td>").append(item.department.deptName);
				var editBtn =$("<button></button").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				var delBtn =$("<button></button").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				
				// 为编辑员工的按钮设置一个属性
				editBtn.attr("edit-id",item.empId);
				// 为删除员工的按钮设置一个属性
				delBtn.attr("delete-id",item.empId);
				
				var btnTd =$("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				// 可以链式操作，append方法执行完成后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptName)
					.append(btnTd)
					.appendTo("#emps_table tbody");
				
			});
		}
		
		function build_page_info(result){
			// 清空数据
			$("#page_info_area").empty();
			
			$("#page_info_area").append($("<h4></h4>").append("当前"+result.extend.pageInfo.pageNum+"页，总共"
					+result.extend.pageInfo.pages+"页，总共"
					+result.extend.pageInfo.total+"条记录"));
			// 保存总记录数，用于查询分页插件查询最后一页的信息
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		function build_page_nav(result){
			// 清空数据
			$("#page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			// 判断页码上是否还有前一页，没有则点击a标签不生效
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				// 为首页、上一页添加单击事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			// 判断页码上是否还有下一页，没有则点击a标签不生效
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				/* 当一直点击下一页或者上一页时，页面上的当前页的页码会小于0,或者大于最大页数，此时，可：
				(1)在pageNum-1,pageNum+1后判断是否出现上述结果，如果出现则获取首页或末页的信息。
				(2)分页合理化参数(pageHelper插件)设置：
						在配置pageHelper插件的配置文件中配置一个分页合理化参数的属性：
						<property name="reasonable" value="true"/> */

				// 为下一页、末页添加单击事件
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			
			
			// 添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);
			
			// 遍历显示的页码号 1,2,3 ...,遍历给ul添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var pageLi = $("<li></li>").append($("<a></a>").append(item));
				// 判断当前页是否是传过来的数据中的信息，是则可以点击a标签
				if(result.extend.pageInfo.pageNum == item){
					pageLi.addClass("active");
				}
				// 绑定单击事件，获取对应页码的数据
				pageLi.click(function(){
					to_page(item);
				});
				
				ul.append(pageLi);
			});
			
			// 添加末页和下一页的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			// 把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		// 表单完整重置方法（重置表单数据和样式）
		function reset_form(ele){
			// 清除表单中的数据（表单重置），因为jQuery没有重置表单方法，这里调用dom中的reset()方法重置
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		// 点击新增按钮打开模态框，绑定单击事件
		$("#emp_add_modal_btn").click(function(){
			// 调用清空表单的方法重置表单
			reset_form("#empAddModal form");
			
			// 发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			
			// 参考bootstrap中文手册的javascript插件的模态框
			$("#empAddModal").modal({
				// 模态框打开后，点击背景不会关闭
				backdrop:"static"
			});
		});
		
		// 发送ajax请求，查出部门信息
		function getDepts(ele){
			// 清空信息
			$(ele).empty();
			
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					// 模态框下只有一个下拉列表，可这样来找
					//$("#empAddModal select")
					$.each(result.extend.depts,function(){
						// this表示当前被遍历的对象，可用 this.deptName this.deptId
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		// 添加员工时数据校验
		function validate_add_form(){
			//校验员工姓名信息，使用正则表达式
			var empName = $("#empName_add_input").val();
			// ^[\u2E80-\u9FFF]{2,5} 该正则表达式表示可以允许使用中文
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			// 正则表达式测试，返回false表示进行ajax请求提交
			//alert(regName.test(empName));
			//return false;
			
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位的中文或者是6-16位的英文组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位的中文或者是6-16位的英文组合！");
				// 将它抽取出来作为一个方法使用
				/* $("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名可以是2-5位的中文或者是6-16位的英文组合！"); */
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text(""); */
			};
			
			// 校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确！");
				show_validate_msg("#email_add_input","error","邮箱格式不正确！");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确！"); */
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
			};
			
			// 正则表达式校验成功，返回true表示进行ajax请求提交
			return true;
		}
		// 将上面重复的代码抽取为一个方法
		function show_validate_msg(ele,status,msg){
			// 清除当前元素的父元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			};
		}
		
		// 当要输入框里的用户名改变时，应该发送ajax请求校验用户名是否可用
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH }/checkUser",
				type:"GET",
				data:"empName="+empName,
				success:function(result){
					if(result.code == 200){
						// 校验用户名是否重复
						show_validate_msg("#empName_add_input","success","用户名可用！");
						// 设置一个校验状态
						$("emp_save_btn").attr("ajax_va","success");
					}else{
						//show_validate_msg("#empName_add_input","error","用户名已存在，请重新输入！");
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("emp_save_btn").attr("ajax_va","error");
					}
				}
			});
		});

		// 单击保存，保存员工信息
		$("#emp_save_btn").click(function(){
			// 在保存员工信息之前应该对数据进行校验
			/* if(!validate_add_form()){
				return false;
			}; */
			
			// 判断之前的ajax用户名是否校验成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			};
			
			// 发送ajax请求保存员工信息
			//alert($("#empAddModal form").serialize()); 
			$.ajax({
				url:"${APP_PATH }/emp",
				type:"POST",
				/* 
				jQuery中的方法：serialize()
					序列表表格内容为字符串，用于ajax请求。
				*/
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.message);
					if(result.code == 200){
						// 1.关闭模态框
						$("#empAddModal").modal("hide");
						/* 2.来到最后一页，显示刚才保存的员工信息
								pageHelper会把大于当前总页码的数作为作为最后一页
								所以这里可以很方便的获取最后一页的数据就好了
								因为总记录数一定大于总页数，所以使用总记录数 */
						to_page(totalRecord);
					}else{
						// 显示失败信息
						//console.log(result);
						// 有哪个字段的错误信息就显示哪个字段
						//alert(result.extend.errorFields.email);
						//alert(result.extend.errorFields.empName);
						if(undefined != result.extend.errorFields.email){
							// 显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							// 显示用户名错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					};
					
				}
			});
		});
		
		// 根据员工id查出用户信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(id);
					// 1.获取返回值中的员工信息
					var empData = result.extend.emp;
					// 2.将返回的员工信息显示到模态框的页面上
					$("#empName-update-static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		// 因为是在按钮创建之前就绑定了click事件，所以绑不上
		// 1.可以在按钮创建时绑定 2.可使用live()方法
		// jQuery新版没有live()方法，可以使用on()方法替代，要复杂一点
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			// 1.查出部门列表并显示
			getDepts("#empUpdateModal select");
			// 2.查出员工信息并显示
			getEmp($(this).attr("edit-id"));
			// 3.把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			// 4.弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		// 点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			// 校验邮箱是否合法
			// 1.校验邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_ipdate_input","error","邮箱格式不正确！");
				return false;
			}else{
				show_validate_msg("#email_ipdate_input","success","");
			};
			
			/*	问题:
				如果该ajax中直接使用PUT请求，后台Controller中会造成只取到empId，其他字段的值为null
					这里请求体中有数据，但是Employee对象中封装不上其他的信息 ，也就是sql为：
						update tbl_emp  where emp_id = ?（会报错）
				原因：
				Tomcat：
					1.将请求体中的数据封装为一个Map
					2.request.getParameter("empName")就会从这个map中取到值。
					3.SpringMvc封装POJO对象的时候。
						会把POJO中的每个属性的值，request.getParameter("email")
						
				ajax发送PUT请求：
					请求体中的数据，request.getParameter("empName")拿不到
					tomcat一看是PUT请求就不会封装请求体中的数据为Map，只有POST请求才会封装为Map。
					（可查看Tomcat的源码中的Connector.java）
					
				解决：（SpingMvc的解决方法）
					在web.xml文件中配置上HttpPutFormContentFilter过滤器
						它的作用是将请求体中的数据解析包装成一个map。
						request被重新包装，request.getParameter()方法被重写，就会从SpringMvc封装的map中取数据
			*/
			
			// 2.发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				//type:"POST",
				// 将表单数据序列化为字符串
				// 因为Controller的方法中的请求是put,所以这里将序列化后的数据加上put才能正确请求
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					// 1.关闭模态框
					$("#empUpdateModal").modal("hide");
					// 2.回到本页面
					to_page(currentPage);
				}
			});
		});
		
		// 单个员工删除
		$(document).on("click",".delete_btn",function(){
			// 1.弹出是否确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("delete-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				// 确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.message);
						// 删除请求处理成功后回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		// 完成全选、全不选功能
		$("#check_all").click(function(){
			// attr获取checked时是undifined
			// 我们这些dom原生的的属性推荐使用prop()获取值，attr用于获取自定义的属性值
			//alert($(this).attr("checked"));
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
			
		});
		
		// 如果当前页上的数据都被选择了，则最顶上的单选框也被选择
		$(document).on("click",".check_item",function(){
			// 判断当前页选中的个数是否为当前页上的所有单选框的个数,在jquery中  :checked 用于匹配被选中的单选框
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		// 点击批量删除
		/*$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				// this表示当前正在遍历的
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				// 组装员工的emp_id(1-2-3...)
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				
			});
			// 去除empNames中多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			// 去除del_idstr中多余的 -
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删【"+empNames+"】除吗？")){
				// 发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.message);
						// 回到当前页面
						to_page(currentPage);
					}
				});
			}
		});*/
		
	</script>
</body>
</html>