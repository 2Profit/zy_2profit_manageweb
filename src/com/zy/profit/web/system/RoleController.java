package com.zy.profit.web.system;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.org.entity.Resource;
import com.zy.org.entity.Role;
import com.zy.org.entity.RoleResourceRel;
import com.zy.org.service.ResourceService;
import com.zy.org.service.RoleResourceRelService;
import com.zy.org.service.RoleService;


/**
 * 角色管理
 * @author Jianfang Xu
 *
 */
@Controller
@RequestMapping("/boss/role")
public class RoleController{
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private ResourceService resourceService;
	
	@Autowired
	private RoleResourceRelService roleResourceRelService;
	
	@RequestMapping("/list")
	public String rolePageList(HttpServletRequest request,Model model){
		int currentPage = 0;
		int pageSize = 10;
		Pageable pageable = new PageRequest(currentPage,pageSize);
		Page<Role> rolePageItem = roleService.findAll(pageable);
		List<Role> roleList = rolePageItem.getContent();
		
		model.addAttribute("roleList", roleList);
		
		return "system/role/list";
	}
	
	@RequestMapping("/add")
	public String add(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		Role role = null;
		if(StringUtils.isNotBlank(id)){
			role = roleService.find(id);
		}
		
		model.addAttribute("id", id);
		model.addAttribute("role", role);
		
		return "system/role/add";
	}
	
	@RequestMapping("/saveorupdate")
	@ResponseBody
	public Map<String,Object> doRoleSaveOrUpdate(HttpServletRequest request){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("sucess", false);
		
		String id = request.getParameter("id");
		String roleName = request.getParameter("roleName");
		String roleDesc = request.getParameter("roleDesc");
		String privileges = request.getParameter("privileges");
		String statusStr = request.getParameter("status");
		Integer status = 1; //默认可用
		
		if(StringUtils.isNotBlank(statusStr)){
			status = Integer.parseInt(statusStr);
		}
		Role role = null;
		try{
			if(StringUtils.isNotBlank(id)){
				role = roleService.find(id);
				role.setName(roleName);
				role.setDescription(roleDesc);
				role.setUpdateDate(new Date());
				role.setStatus(status);
				roleService.update(role);
				
				if(StringUtils.isNotBlank(privileges)){
					String[] privilegeArr = privileges.split(",");
					if(privilegeArr != null && privilegeArr.length > 0){
						for(int i=0;i<privilegeArr.length;i++){
							Resource resource = resourceService.find(privilegeArr[i]);
							if(resource != null){
								List<Resource> resourceList = roleResourceRelService.findResourceListByResource(resource.getId());
								if(resourceList != null && resourceList.size() > 0){
									
								}else{
									RoleResourceRel roleResourceRel = new RoleResourceRel();
									roleResourceRel.setCreateDate(new Date());
									roleResourceRel.setUpdateDate(new Date());
									roleResourceRel.setResource(resource);
									roleResourceRel.setRole(role);
									roleResourceRelService.save(roleResourceRel);
								}
							}
						}
					}
				}
			}else{
				role = new Role();
				role.setName(roleName);
				role.setDescription(roleDesc);
				role.setCreateDate(new Date());
				role.setUpdateDate(new Date());
				role.setStatus(status);
				roleService.save(role);
				
				if(StringUtils.isNotBlank(privileges)){
					String[] privilegeArr = privileges.split(",");
					if(privilegeArr != null && privilegeArr.length > 0){
						for(int i=0;i<privilegeArr.length;i++){
							Resource resource = resourceService.find(privilegeArr[i]);
							if(resource != null){
								RoleResourceRel roleResourceRel = new RoleResourceRel();
								roleResourceRel.setCreateDate(new Date());
								roleResourceRel.setUpdateDate(new Date());
								roleResourceRel.setResource(resource);
								roleResourceRel.setRole(role);
								roleResourceRelService.save(roleResourceRel);
							}
						}
					}
				}
			}
			resultMap.put("sucess", true);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
}
