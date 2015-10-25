package com.zy.profit.web.fund;

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
import com.zy.member.entity.Member;
import com.zy.member.service.MemberService;
import com.zy.org.entity.User;
import com.zy.org.service.UserService;
import com.zy.profit.web.util.HttpUtils;
import com.zy.proposal.entity.ProposalTrade;
import com.zy.proposal.service.ProposalTradeService;

@Controller
@RequestMapping("/fund")
public class FundController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private ProposalTradeService proposalTradeService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/ajax/find/member")
	@ResponseBody
	public AjaxResult ajaxFindMember(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			String username = StringUtils.trim(request.getParameter("username"));
			
			Member member = null;
			if(username.length() == 11){
				member = memberService.findMemberByLogin(username);
			}else{
				Integer no = null;
				try {
					no = Integer.parseInt(username);
				} catch (Exception e) {
				}
				if(no != null){
					member = memberService.findMemberByNo(no);
				}
			}
			
			Map<String, Object> dataMap = new HashMap<String, Object>();
			if(member != null){
				dataMap.put("cnName", member.getCnName());
				dataMap.put("no", member.getNo());
				dataMap.put("mobile", member.getMobile());
				dataMap.put("id", member.getId());
			}
			
			ajaxResult.setData(dataMap);
			
			ajaxResult.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("查询失败");
		}
		
		return ajaxResult;
	}
	
	@RequestMapping("/pay/list")
	public String payList(HttpServletRequest request, Model model){
		
		List<ConstantEnity> proposalStatuses = CommonConstants.getProposalStatus();
		model.addAttribute("proposalStatuses", proposalStatuses);
		
		String proposalNo = request.getParameter("proposalNo");
		String payType = request.getParameter("payType");
		String status = request.getParameter("status");
		String memberNo = request.getParameter("memberNo");
		String mobile = request.getParameter("mobile");
		String cnName = request.getParameter("cnName");
		
		model.addAttribute("proposalNo", proposalNo);
		model.addAttribute("payType", payType);
		model.addAttribute("status", status);
		model.addAttribute("memberNo", memberNo);
		model.addAttribute("mobile", mobile);
		model.addAttribute("cnName", cnName);
		
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(proposalNo) && StringUtils.isNumeric(proposalNo.trim())){
			params.put("proposalNo", Integer.parseInt(proposalNo.trim()));
		}
		if(StringUtils.isNotBlank(payType)){
			params.put("payType", Integer.parseInt(payType.trim()));
		}
		if(StringUtils.isNotBlank(status)){
			params.put("status", Integer.parseInt(status.trim()));
		}
		
		if(StringUtils.isNotBlank(memberNo) && StringUtils.isNumeric(memberNo)){
			params.put("memberNo", Integer.parseInt(memberNo));
		}
		
		if(StringUtils.isNotBlank(mobile) && StringUtils.isNumeric(mobile)){
			params.put("mobile", mobile.trim());
		}
		
		if(StringUtils.isNotBlank(cnName) && StringUtils.isNumeric(cnName)){
			params.put("cnName", "%" + cnName + "%");
		}
		
		Integer pageSize = HttpUtils.getPageSize(request);
		Integer currentPage = HttpUtils.getCurrentPage(request);
		
		PageModel<ProposalTrade> page = proposalTradeService.findPageModel(params, currentPage, pageSize);
		model.addAttribute("page", page);
		
		return "/fund/pay_list";
	}
	
	@RequestMapping("/pay/edit")
	public String payEdit(HttpServletRequest request, Model model){
		
		String posId = request.getParameter("posId");
		if(StringUtils.isNotBlank(posId)){
			ProposalTrade trade = proposalTradeService.find(posId);
			model.addAttribute("trade", trade);
		}
		
		List<User> users = userService.findUsers(); 
		model.addAttribute("users", users);
		
		model.addAttribute("type", request.getParameter("type"));
		
		return "/fund/pay_edit";
	}
	
	@RequestMapping("/ajax/pay/submit")
	@ResponseBody
	public AjaxResult ajaxPaySubmit(ProposalTrade trade, HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		User loginUser = HttpUtils.getUser(request);
		
		try {
			String type = request.getParameter("type");
			User user = HttpUtils.getUser(request); 
			
			if("add".equals(type)){
				
				String memberId = request.getParameter("memberId");
				Member member = memberService.find(memberId);
				if(member == null){
					ajaxResult.setMsg("会员信息有误");
					return ajaxResult;
				}
				
				trade.setMember(member);
				
				trade.setApplier(user);
				trade.setStatus(CommonConstants.proposalStatusDefault.getIntKey());
				trade.setCreateId(loginUser.getId());
				trade.setCreateName(loginUser.getUsername());
				trade.setIp(HttpUtils.getIP(request));
				
				proposalTradeService.save(trade);
			}else if("update".equals(type)){
//				ProposalTrade oTrade = proposalTradeService.find(trade.getId());
//				oTrade.setTradeId(trade.getTradeId());
//				oTrade.setAmount(trade.getAmount());
//				oTrade.setPayType(trade.getPayType());
//				oTrade.setApplier(applier);
//				
//				proposalTradeService.update(oTrade);
			}
			
			ajaxResult.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("操作异常");
		}
		
		return ajaxResult;
	}

	@RequestMapping("/ajax/pay/pos/pass")
	@ResponseBody
	public AjaxResult ajaxPayPosPass(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			String[] posIds = request.getParameterValues("posIds");
			
			User user = HttpUtils.getUser(request);
			
			proposalTradeService.updateBatchPosPass(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审批失败");
		}
		
		return ajaxResult;
	}

	@RequestMapping("/ajax/pay/pos/cancel")
	@ResponseBody
	public AjaxResult ajaxPayPosCancel(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			String[] posIds = request.getParameterValues("posIds");
			
			User user = HttpUtils.getUser(request);
			
			proposalTradeService.updateBatchPosCancel(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审批失败");
		}
		
		return ajaxResult;
	}
	
}
