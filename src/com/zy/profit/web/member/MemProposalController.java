package com.zy.profit.web.member;

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
import com.zy.common.util.AjaxResult;
import com.zy.common.util.CommonConstants;
import com.zy.common.util.ConstantEnity;
import com.zy.org.entity.User;
import com.zy.profit.web.util.HttpUtils;
import com.zy.proposal.entity.ProposalMemImg;
import com.zy.proposal.entity.ProposalMemModify;
import com.zy.proposal.service.ProposalMemImgService;
import com.zy.proposal.service.ProposalMemModifyService;

/**
 * 
 * @author Administrator
 *
 */
@RequestMapping("/mem/pos")
@Controller
public class MemProposalController {

	@Autowired
	private ProposalMemModifyService proposalMemModifyService;
	
	@Autowired
	private ProposalMemImgService proposalMemImgService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model){
		
		List<ConstantEnity> posStatuses = CommonConstants.getProposalStatus();
		model.addAttribute("posStatuses", posStatuses);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String proposalNo = request.getParameter("proposalNo");
		if(StringUtils.isNotBlank(proposalNo) && StringUtils.isNumeric(proposalNo.trim())){
			params.put("proposalNo", Integer.parseInt(proposalNo.trim()));
		}
		model.addAttribute("proposalNo", proposalNo);
		
		String no = request.getParameter("no");
		if(StringUtils.isNotBlank(no) && StringUtils.isNumeric(no.trim())){
			params.put("no", Integer.parseInt(no.trim()));
		}
		model.addAttribute("no", no);

		String posStatus = request.getParameter("posStatus");
		if(StringUtils.isNotBlank(posStatus)){
			params.put("posStatus", Integer.parseInt(posStatus));
		}
		model.addAttribute("posStatus", posStatus);
		
		String cnName = request.getParameter("cnName");
		if(StringUtils.isNotBlank(cnName)){
			params.put("cnName", "%" + cnName + "%");
		}
		model.addAttribute("cnName", cnName);
		
		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotBlank(mobile)){
			params.put("mobile", mobile);
		}
		model.addAttribute("mobile", mobile);
		
		Integer currentPage = HttpUtils.getCurrentPage(request);
		Integer pageSize = HttpUtils.getPageSize(request);
		
		PageModel<ProposalMemModify> pageModel = proposalMemModifyService.queryPage(params, currentPage, pageSize);
		
		model.addAttribute("page", pageModel);
		
		return "/member/mem_pos_list";
	}
	
	@RequestMapping("/ajax/pass")
	@ResponseBody
	public AjaxResult ajaxPass(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {
			
			User user = HttpUtils.getUser(request);
			
			String[] posIds = request.getParameterValues("posIds");
			
			String msg = request.getParameter("msg");
			
			proposalMemModifyService.updateBatchPosPass(posIds, msg, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("操作异常");
		}
		
		return ajaxResult;
	}
	
	@RequestMapping("/ajax/cancel")
	@ResponseBody
	public AjaxResult ajaxCancel(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {
			
			User user = HttpUtils.getUser(request);
			
			String[] posIds = request.getParameterValues("posIds");
			
			String msg = request.getParameter("msg");
			
			proposalMemModifyService.updateBatchPosCancel(posIds, msg, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("操作异常");
		}
		
		return ajaxResult;
	}
	
	@RequestMapping("/img/list")
	public String imgList(HttpServletRequest request, Model model){

		List<ConstantEnity> posStatuses = CommonConstants.getProposalStatus();
		model.addAttribute("posStatuses", posStatuses);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String proposalNo = request.getParameter("proposalNo");
		if(StringUtils.isNotBlank(proposalNo) && StringUtils.isNumeric(proposalNo)){
			params.put("proposalNo", Integer.parseInt(proposalNo));
		}
		model.addAttribute("proposalNo", proposalNo);
		
		String no = request.getParameter("no");
		if(StringUtils.isNotBlank(no) && StringUtils.isNumeric(no)){
			params.put("no", Integer.parseInt(proposalNo));
		}
		model.addAttribute("no", no);
		
		String posStatus = request.getParameter("posStatus");
		if(StringUtils.isNotBlank(posStatus)){
			params.put("posStatus", Integer.parseInt(posStatus));
		}
		model.addAttribute("posStatus", posStatus);
		
		String cnName = request.getParameter("cnName");
		if(StringUtils.isNotBlank(cnName)){
			params.put("cnName", "%" + cnName + "%");
		}
		model.addAttribute("cnName", cnName);
		
		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotBlank(mobile)){
			params.put("mobile", mobile.trim());
		}
		model.addAttribute("mobile", mobile);
		
		Integer pageSize = HttpUtils.getPageSize(request);
		Integer currentPage = HttpUtils.getCurrentPage(request);
		
		PageModel<ProposalMemImg> pageModel = proposalMemImgService.queryPageModel(params, pageSize, currentPage);
		
		model.addAttribute("page", pageModel);
		
		return "/member/mem_pos_img_list";
	}
	
	@RequestMapping("/img/edit")
	public String imgEdit(HttpServletRequest request, Model model){
		
		String posId = request.getParameter("posId");
		
		ProposalMemImg proposalMemImg = proposalMemImgService.find(posId);
		model.addAttribute("pmm", proposalMemImg);
		
		return "/member/mem_pos_img_edit";
	}
	
	/**
	 * 证明  通过
	 * @param request
	 * @return
	 */
	@RequestMapping("/ajax/img/pass")
	@ResponseBody
	public AjaxResult ajaxImgPosPass(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {

			User user = HttpUtils.getUser(request);
			
			String[] posIds = request.getParameterValues("posIds");
			proposalMemImgService.updateBatchPosPass(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("提案操作失败");
		}
		return ajaxResult;
	}
	
	/**
	 * 证明  未通过
	 * @param request
	 * @return
	 */
	@RequestMapping("/ajax/img/cancel")
	@ResponseBody
	public AjaxResult ajaxImgPosCancel(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {
			
			User user = HttpUtils.getUser(request);
			
			String[] posIds = request.getParameterValues("posIds");
			proposalMemImgService.updateBatchPosCancel(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("提案操作失败");
		}
		return ajaxResult;
	}
	
	
}