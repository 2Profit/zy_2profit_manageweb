package com.zy.profit.web.fund;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.taglibs.standard.lang.jstl.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.common.entity.PageModel;
import com.zy.common.util.AjaxResult;
import com.zy.common.util.CommonConstants;
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
	
	@RequestMapping("/pay/list")
	public String payList(HttpServletRequest request, Model model){
		
		String proposalNo = request.getParameter("proposalNo");
		String curType = request.getParameter("curType");
		String payType = request.getParameter("payType");
		String status = request.getParameter("status");
		
		model.addAttribute("proposalNo", proposalNo);
		model.addAttribute("curType", curType);
		model.addAttribute("payType", payType);
		model.addAttribute("status", status);
		
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(proposalNo) && StringUtils.isNumeric(proposalNo.trim())){
			params.put("proposalNo", Integer.parseInt(proposalNo.trim()));
		}
		if(StringUtils.isNotBlank(curType)){
			params.put("curType", Integer.parseInt(curType.trim()));
		}
		if(StringUtils.isNotBlank(payType)){
			params.put("payType", Integer.parseInt(payType.trim()));
		}
		if(StringUtils.isNotBlank(status)){
			params.put("status", Integer.parseInt(status.trim()));
		}
		
		Integer pageSize = HttpUtils.getPageSize(request);
		Integer currentPage = HttpUtils.getCurrentPage(request);
		
		PageModel<ProposalTrade> page = proposalTradeService.findPageModel(params, currentPage, pageSize);
		model.addAttribute("page", page);
		
		return "/fund/pay_list";
	}
	
	@RequestMapping("/pay/edit")
	public String payEdit(HttpServletRequest request, Model model){
		
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			ProposalTrade trade = proposalTradeService.find(id);
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
			String applierId = request.getParameter("applierId");
			User applier = new User();
			applier.setId(applierId);
			
			if("add".equals(type)){
				trade.setApplier(applier);
				trade.setStatus(CommonConstants.proposalStatusDefault.getIntKey());
				trade.setCreateId(loginUser.getId());
				trade.setCreateName(loginUser.getUsername());
				trade.setIp(HttpUtils.getIP(request));
				
				proposalTradeService.save(trade);
			}else if("update".equals(type)){
				ProposalTrade oTrade = proposalTradeService.find(trade.getId());
				oTrade.setTradeId(trade.getTradeId());
				oTrade.setAccount(trade.getAccount());
				oTrade.setAmount(trade.getAmount());
				oTrade.setPayType(trade.getPayType());
				oTrade.setCurType(trade.getCurType());
				oTrade.setApplier(applier);
				
				proposalTradeService.update(oTrade);
			}
			
			ajaxResult.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("操作异常");
		}
		
		return ajaxResult;
	}
	
}
