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
import com.zy.profit.web.util.HttpUtils;
import com.zy.proposal.entity.ProposalCoin;
import com.zy.proposal.service.ProposalCoinService;

@RequestMapping("/pos/coin")
@Controller
public class ProposalCoinController {

	@Autowired
	private ProposalCoinService proposalCoinService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String proposalNo = request.getParameter("proposalNo");
		if(StringUtils.isNotBlank(proposalNo)){
			params.put("proposalNo", proposalNo);
		}
		model.addAttribute("proposalNo", proposalNo);
		
		String posStatus = request.getParameter("posStatus");
		if(StringUtils.isNotBlank(posStatus) && StringUtils.isNumeric(posStatus)){
			params.put("posStatus", Integer.parseInt(posStatus));
		}
		model.addAttribute("posStatus", posStatus);
		
		String memberNo = request.getParameter("memberNo");
		if(StringUtils.isNotBlank(memberNo) && StringUtils.isNumeric(memberNo)){
			params.put("memberNo", Integer.parseInt(memberNo));
		}
		model.addAttribute("memberNo", memberNo);
		
		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotBlank(mobile)){
			params.put("mobile", mobile.trim());
		}
		model.addAttribute("mobile", mobile);
		
		String name = request.getParameter("name");
		if(StringUtils.isNotBlank(name)){
			params.put("name", "%" + name.trim() + "%");
		}
		model.addAttribute("name", name);
		
		Integer pageSize = HttpUtils.getPageSize(request);
		Integer currentPage = HttpUtils.getCurrentPage(request);
		
		PageModel<ProposalCoin> pageModel = proposalCoinService.queryPageModel(params, pageSize, currentPage);
		model.addAttribute("page", pageModel);
		
		List<ConstantEnity> proposalStatus = CommonConstants.getProposalStatus();
		model.addAttribute("proposalStatus", proposalStatus);
		
		return "/fund/coin_list";
	}
	
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, Model model){
		
		String type = request.getParameter("type");
		model.addAttribute("type", type);
		
		if("pos".equals(type)){
			String posId = request.getParameter("posId");
			ProposalCoin proposalCoin = proposalCoinService.find(posId);
			model.addAttribute("p", proposalCoin);
		}
		
		return "/fund/coin_edit";
	}
	
	@RequestMapping("/ajax/save")
	@ResponseBody
	public AjaxResult ajaxSave(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			User user = HttpUtils.getUser(request);
			
			String memberId = request.getParameter("memberId");
			Member member = memberService.find(memberId);
			
			if(member == null){
				ajaxResult.setMsg("会员信息有误");
				return ajaxResult;
			}
			
			String coin = request.getParameter("coin");
			
			ProposalCoin proposalCoin = new ProposalCoin();
			proposalCoin.setApplier(user);
			proposalCoin.setCoin(Integer.parseInt(coin));
			proposalCoin.setMember(member);
			proposalCoin.setPosStatus(CommonConstants.proposalStatusDefault.getIntKey());
			
			proposalCoinService.save(proposalCoin);
			
			ajaxResult.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("保存失败");
		}
		
		return ajaxResult;
	}
	

	@RequestMapping("/ajax/pos/pass")
	@ResponseBody
	public AjaxResult ajaxPayPosPass(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			String[] posIds = request.getParameterValues("posIds");
			
			User user = HttpUtils.getUser(request);
			
			proposalCoinService.updateBatchPosPass(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审批失败");
		}
		
		return ajaxResult;
	}

	@RequestMapping("/ajax/pos/cancel")
	@ResponseBody
	public AjaxResult ajaxPayPosCancel(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			String[] posIds = request.getParameterValues("posIds");
			
			User user = HttpUtils.getUser(request);
			
			proposalCoinService.updateBatchPosCancel(posIds, user);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("审批失败");
		}
		
		return ajaxResult;
	}
	
	
}
