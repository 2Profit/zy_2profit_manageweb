/**
 * 后台管理系统通用js
 */
$(function(){
	
	//批量审核
	$("#confirm_button").bind("click",function(event){
		event.preventDefault();
		if($("input[name='ids']:checked").length==0){
			alert('请至少勾选一条记录');
			return;
		}
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		 var ids = [];
		 $("input[name='ids']:checked").each(function() {
			 ids.push($(this).val());
		 });
		 updateDeleteFlag(ids,2);			
	});
	//批量删除
	$("#delete_button").bind("click",function(event){
		event.preventDefault();
		if($("input[name='ids']:checked").length==0){
			alert('请至少勾选一条记录');
			return;
		}
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		 var ids = [];
		 $("input[name='ids']:checked").each(function() {
			 ids.push($(this).val());
		 });
		 updateDeleteFlag(ids,1);			
	});
	//批量恢复
	$("#revert_button").bind("click",function(event){
		event.preventDefault();
		if($("input[name='ids']:checked").length==0){
			alert('请至少勾选一条记录');
			return;
		}
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		 var ids = [];
		 $("input[name='ids']:checked").each(function() {
			 ids.push($(this).val());
		 });
		 updateDeleteFlag(ids,0);			
	});
	//审核
	$("a[name='confirm_href']").bind("click",function(event){
		event.preventDefault();
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		var ids = [];
		ids.push($(this).children().val());
		updateDeleteFlag(ids,2);			
	});
	//恢复
	$("a[name='revert_href']").bind("click",function(event){
		event.preventDefault();
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		var ids = [];
		ids.push($(this).children().val());
		updateDeleteFlag(ids,0);			
	});
	//删除
	$("a[name='delete_href']").bind("click",function(event){
		event.preventDefault();
		if(!confirm("是否确认对选择的信息进行操作？")){return;}
		var ids = [];
		ids.push($(this).children().val());
		updateDeleteFlag(ids,1);			
	});
	
	$('#checkAll').bind("click",function(){
		if($(this).prop("checked")){
			$("input[name='ids']").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$("input[name='ids']").each(function(){
				$(this).prop("checked",false);
			});
		}
	});
	
});