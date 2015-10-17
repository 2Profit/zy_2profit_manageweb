package com.zy.profit.web.fund;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.common.entity.PageModel;
import com.zy.common.util.CommonConstants;
import com.zy.common.util.ConstantEnity;
import com.zy.proposal.entity.ProposalCoin;

@RequestMapping("/pos/coin")
@Controller
public class ProposalCoinController {

	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model){
		
		PageModel<ProposalCoin> pageModel = new PageModel<ProposalCoin>();
		model.addAttribute("page", pageModel);
		
		List<ConstantEnity> proposalStatus = CommonConstants.getProposalStatus();
		model.addAttribute("proposalStatus", proposalStatus);
		
		return "/fund/coin_list";
	}
	
}
