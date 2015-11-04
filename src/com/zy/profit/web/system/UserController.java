package com.zy.profit.web.system;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.common.entity.PageModel;
import com.zy.org.entity.Role;
import com.zy.org.entity.User;
import com.zy.org.entity.UserRoleRel;
import com.zy.org.service.RoleService;
import com.zy.org.service.UserRoleRelService;
import com.zy.org.service.UserService;
import com.zy.profit.web.IndexController;
import com.zy.util.Md5Util;


/**
 * 用户管理
 * @author Jianfang Xu
 *
 */
@Controller
@RequestMapping("/boss/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private UserRoleRelService userRoleRelService;
	
	@RequestMapping("/list")
	public String userPageList(HttpServletRequest request,Model model){
		String currentPageStr = request.getParameter("currentPage");
		String pageSizeStr = request.getParameter("pageSize");
		int currentPage = 1;
		int pageSize = 10;
		if(StringUtils.isNotBlank(currentPageStr)){
			currentPage = Integer.parseInt(currentPageStr);
		}
		if(StringUtils.isNotBlank(pageSizeStr)){
			pageSize = Integer.parseInt(pageSizeStr);
		}
		PageModel<User> page = userService.queryForPage(currentPage, pageSize);
		
		model.addAttribute("page", page);
		
		return "system/user/list";
	}
	
	@RequestMapping("/add")
	public String add(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		User user = null;
		Role userRole = null;
		if(StringUtils.isNotBlank(id)){
			user = userService.find(id);
			if(user != null){
				 List<Role> userRoleList = userRoleRelService.getRoleListByUser(user.getId());
				 if(userRoleList != null && userRoleList.size() > 0){
					 userRole = userRoleList.get(0);
				 }
			}
			
		}
		List<Role> roleList = roleService.getAll(); //获取用户角色
		
		model.addAttribute("roleList", roleList);
		model.addAttribute("user", user);
		model.addAttribute("userRole", userRole);
		model.addAttribute("id", id);
		return "system/user/add";
	}
	
	@RequestMapping("/saveorupdate")
	public String doSaveOrUpdate(HttpServletRequest request){
		String id = request.getParameter("id");
		String userName = request.getParameter("username");
		String realName = request.getParameter("realName");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String pwd = request.getParameter("newpassword2");
		String roleId = request.getParameter("roleId");
		Role role = null;
		User user = null;
		
		if(StringUtils.isNotBlank(roleId)){
			role = roleService.find(roleId);
		}
		
		if(StringUtils.isNotBlank(userName)){
			if(StringUtils.isNotBlank(id)){
				user = userService.find(id);
				user.setUpdateDate(new Date());
				user.setUsername(userName);
				user.setRealName(realName);
				user.setEmail(email);
				user.setMobile(mobile);
				if(StringUtils.isNotBlank(pwd)){
					user.setPassword(Md5Util.generatePassword(pwd));
				}
				userService.update(user);
				
				//删除原有角色信息
				userRoleRelService.deleteRoleByUserId(user.getId());
				
			}else{
				if(StringUtils.isNotBlank(pwd)){
					user = new User();
					user.setCreateDate(new Date());
					user.setUsername(userName);
					user.setRealName(realName);
					user.setEmail(email);
					user.setMobile(mobile);
					user.setPassword(Md5Util.generatePassword(pwd));
					userService.save(user);
				}
			}
			
			//保存关联关系
			if(user != null && role != null){
				UserRoleRel userRoleRel = new UserRoleRel();
				userRoleRel.setUser(user);
				userRoleRel.setRole(role);;
				userRoleRelService.save(userRoleRel);
			}
		}
		return "redirect:/boss/user/list";
	}
	
	/**
	 * 跳转到修改密码
	 * @return
	 */
	@RequestMapping("/updatePwd")
	public String updatePwd(){
		
		return "system/user/updatePwd";
	}
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping("/doPwdUpdate")
	public String doPwdUpdate(HttpServletRequest request){
		User u = (User) request.getSession().getAttribute(IndexController.USER_SESSION_INFO);
		String newpassword = request.getParameter("newpassword2");
		if(StringUtils.isNotBlank(newpassword)){
			if(u != null){
				u.setPassword(Md5Util.generatePassword(newpassword));
				u.setUpdateDate(new Date());
				userService.update(u);
			}
		}
		return "redirect:/boss/index";
	}
	
	/**
	 * 检查后台用户的唯一约束
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/unique")
	@ResponseBody
	public Map<String,Object> checkUnique(HttpServletRequest request){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String userName = request.getParameter("username");
		User user = userService.findUserByName(userName);
		if(user != null){
			resultMap.put("error", "该账户已经被使用!");
		}else{
			resultMap.put("ok", "该账户可以使用");
		}
		return resultMap;
	}
	
	/**
	 * 检查原始密码是否正确
	 * @param request
	 * @return
	 */
	@RequestMapping("/checkOldPwd")
	@ResponseBody
	public Map<String,Object> checkOldPwd(HttpServletRequest request){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		User u = (User) request.getSession().getAttribute(IndexController.USER_SESSION_INFO);
		String oldPwd = request.getParameter("oldPwd");
		if(u != null){
			if(StringUtils.isNotBlank(oldPwd)){
				if(Md5Util.validatePassword(u.getPassword(), oldPwd)){
					resultMap.put("ok", "原始密码正确!");
				}else{
					resultMap.put("error", "原始密码不正确?");
				}
			}else{
				resultMap.put("error", "原始密码不能为空!");
			}
		}
		return resultMap;
	}
	
}
