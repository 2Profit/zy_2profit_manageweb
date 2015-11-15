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

import com.zy.broker.entity.BrokerInfo;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.PageModel;
import com.zy.common.util.AjaxResult;
import com.zy.common.util.CommonConstants;
import com.zy.common.util.ConstantEnity;
import com.zy.org.entity.User;
import com.zy.profit.service.MemPosService;
import com.zy.profit.web.util.HttpUtils;
import com.zy.proposal.entity.ProposalBackDiscount;
import com.zy.proposal.entity.ProposalMemImg;
import com.zy.proposal.entity.ProposalMemModify;
import com.zy.proposal.service.ProposalBackDiscountService;
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
	
	@Autowired
	private BrokerInfoService brokerInfoService;
	
	@Autowired
	private ProposalBackDiscountService proposalBackDiscountService;
	
	@Autowired
	private MemPosService memPosService;
	
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
	
	@RequestMapping("/back_discount_list")
	public String backDiscount(HttpServletRequest request, Model model){
		
		List<ConstantEnity> posStatuses = CommonConstants.getProposalStatus();
		model.addAttribute("posStatuses", posStatuses);
		
		List<BrokerInfo> brokerInfos = brokerInfoService.findAllBrokerInfo(BrokerInfo.DELETE_FLAG_NORMAL);
		model.addAttribute("brokerInfos", brokerInfos);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String proposalNo = request.getParameter("proposalNo");
		model.addAttribute("proposalNo", proposalNo);
		if(StringUtils.isNotBlank(proposalNo) && StringUtils.isNumeric(proposalNo)){
			params.put("proposalNo", Integer.parseInt(proposalNo));
		}
		
		String posStatus = request.getParameter("posStatus");
		model.addAttribute("posStatus", posStatus);
		if(StringUtils.isNotBlank(posStatus)){
			params.put("posStatus", Integer.parseInt(posStatus));
		}
		
		String brokerInfoId = request.getParameter("brokerInfoId");
		model.addAttribute("brokerInfoId", brokerInfoId);
		if(StringUtils.isNotBlank(brokerInfoId)){
			params.put("brokerInfoId", brokerInfoId);
		}
		
		String email = request.getParameter("email");
		model.addAttribute("email", email);
		if(StringUtils.isNotBlank(email)){
			params.put("email", email.trim());
		}
		
		String mt4Card = request.getParameter("mt4Card");
		model.addAttribute("mt4Card", mt4Card);
		if(StringUtils.isNotBlank(mt4Card)){
			params.put("mt4Card", mt4Card.trim());
		}
		
		Integer currentPage = HttpUtils.getCurrentPage(request);
		Integer pageSize = HttpUtils.getPageSize(request);
		
		PageModel<ProposalBackDiscount> page = proposalBackDiscountService.findPageModel(params, currentPage, pageSize);
		
		model.addAttribute("page", page);
		
		return "/member/mem_pos_back_discount_list";
	}
	
	@RequestMapping("/back_disount_edit")
	public String posBackDiscount(HttpServletRequest request, Model model){
		
		String posId = request.getParameter("posId");
		ProposalBackDiscount proposalBackDiscount = proposalBackDiscountService.find(posId);
		model.addAttribute("pbd", proposalBackDiscount);
		
		return "/member/mem_pos_back_discount_edit";
	}
	
	
	@RequestMapping("/ajax/back_discount/pass")
	@ResponseBody
	public AjaxResult ajaxPosBackDiscountPass(HttpServletRequest request){
		AjaxResult ajaxResult  = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {
			String[] posIds = request.getParameterValues("posIds"); 
			
			User user = HttpUtils.getUser(request);
			
			try {
				
				memPosService.updatePosPass(posIds[0], user);
				
				ajaxResult.setSuccess(true);
				
			} catch (Exception e) {
				e.printStackTrace();
				ajaxResult.setMsg(e.getMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审核失败 ");
		}
		
		return ajaxResult;
	}
	
	@RequestMapping("/ajax/back_discount/cancel")
	@ResponseBody
	public AjaxResult ajaxPosBackDiscountCancel(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			String[] posIds = request.getParameterValues("posIds"); 
			
			String msg = request.getParameter("msg");
			
			User user = HttpUtils.getUser(request);
			
			try {
				
				memPosService.updatePosCancel(posIds[0], msg, user);
				
				ajaxResult.setSuccess(true);
				
			} catch (Exception e) {
				e.printStackTrace();
				ajaxResult.setMsg(e.getMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审核失败 ");
		}
		
		return ajaxResult;
	}
	
}
