/**
 * 公共js工具 
 */

/**
 * 全选按钮
 * @param chk
 * @param name
 */
function checkAllClick(chk, name){
	$('input[name="'+name+'"]:checkbox').prop('checked', chk.checked);
	$('input[name="'+$(chk).attr('name')+'"]').prop('checked', chk.checked);
}
