package com.zy.profit.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.org.entity.Role;
import com.zy.org.entity.User;
import com.zy.org.service.UserRoleRelService;
import com.zy.org.service.UserService;
import com.zy.profit.web.util.SystemConfig;
import com.zy.util.Md5Util;

/**
 * 后台登陆首页Controller
 * 
 * @author Jeff Xu
 *
 */
@Controller
@RequestMapping("/boss")
public class IndexController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private UserRoleRelService userRoleRelService;

	// 后台用户信息
	public final static String USER_SESSION_INFO = "user_session_info";
	
	public final static String USER_SESSION_ROLE = "user_session_role";

	// 登陆错误信息
	public final static String LOGIN_ERROR_INFO = "login_error_info";

	@RequestMapping("/background")
	public String background(){
		return "/background";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	/**
	 * 登陆
	 */
	@RequestMapping("/doLogin")
	public String doLogin(HttpServletRequest request) {
		String userName = request.getParameter("userName");
		String pwd = request.getParameter("pwd");
		String errorMsg = "";
		if (StringUtils.isNotBlank(userName) && StringUtils.isNotBlank(pwd)) {
			User user = userService.findUserByName(userName);
			if (user != null) {
				if (Md5Util.validatePassword(user.getPassword(), pwd)) {
					request.getSession().setAttribute(USER_SESSION_INFO, user);
					setSessionUserDto(request.getSession(), user);
					
					//查询用户角色
					List<Role> roles = userRoleRelService.getRoleListByUser(user.getId());
					HttpSession session = request.getSession();
					session.setAttribute(USER_SESSION_ROLE, roles);
					session.setAttribute("approvierRoleId", SystemConfig.getApprovierRoleId());;
					
					
					return "redirect:/boss/index";
				} else {
					errorMsg = "密码不正确!";
					request.getSession().setAttribute(LOGIN_ERROR_INFO,
							errorMsg);
					return "redirect:/boss/login";
				}
			} else {
				errorMsg = "用户名不正确!";
				request.getSession().setAttribute(LOGIN_ERROR_INFO, errorMsg);
				return "redirect:/boss/login";
			}
		} else {
			errorMsg = "用户名或者密码不能为空!";
			request.getSession().setAttribute(LOGIN_ERROR_INFO, errorMsg);
			return "redirect:/boss/login";
		}
	}

	private void setSessionUserDto(HttpSession session, User user) {
		UserDto dto = new UserDto();
		BeanUtils.copyProperties(user, dto);
		UserSessionUtil.setUserDto(session, dto);
	}

	/**
	 * 登出
	 * 
	 * @return
	 */
	@RequestMapping("/loginOut")
	public String doLoginOut(HttpServletRequest request) {		
		request.getSession().setAttribute(USER_SESSION_INFO, null);

		return "redirect:/boss/login";
	}

	/**
	 * 菜单页
	 * 
	 * @return
	 */
	@RequestMapping("/menu")
	public String menu(HttpServletRequest request, Model model) {
		String roleId = "";
		User user = (User) request.getSession().getAttribute(USER_SESSION_INFO);
		if (user != null) {
			List<Role> roleList = userRoleRelService.getRoleListByUser(user
					.getId());
			if (roleList != null && roleList.size() > 0) {
				roleId = roleList.get(0).getId();
			}
		}
		model.addAttribute("roleId", roleId);
		return "menu";
	}

	/**
	 * 跳转到Top页面
	 * 
	 * @return
	 */
	@RequestMapping("/top")
	public String top() {
		return "top";
	}

	/**
	 * 跳转到main页面
	 * 
	 * @return
	 */
	@RequestMapping("/main")
	public String main() {

		return "main";
	}

	/**
	 * 后台首页
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {

		return "index";
	}

	
}
