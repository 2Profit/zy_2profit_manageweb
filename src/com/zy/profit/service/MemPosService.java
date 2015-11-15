package com.zy.profit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zy.org.entity.User;
import com.zy.profit.web.util.MailUtils;
import com.zy.proposal.entity.ProposalBackDiscount;
import com.zy.proposal.service.ProposalBackDiscountService;

@Service
public class MemPosService {

	@Autowired
	private ProposalBackDiscountService proposalBackDiscountService;
	
	public void updatePosPass(String posId, User user) throws Exception{
		
		boolean hasMember = proposalBackDiscountService.updatePosPass(posId, user);
		
		ProposalBackDiscount proposalBackDiscount = proposalBackDiscountService.find(posId);
		
		boolean bSend = false;
		
		if(hasMember){
			bSend = MailUtils.sendTypePassReg(proposalBackDiscount.getEmail());
		}else{
			bSend = MailUtils.sendTypePassNoReg(proposalBackDiscount.getEmail(), posId);
		}
		
		if(!bSend){
			throw new Exception("发送邮件失败");
		}
		
	}
	
	public void updatePosCancel(String posId, String msg, User user) throws Exception{
		
		proposalBackDiscountService.updatePosCancel(posId, msg, user);
		
		ProposalBackDiscount proposalBackDiscount = proposalBackDiscountService.find(posId);
		
		boolean bSend = MailUtils.sendTypeCancel(proposalBackDiscount.getEmail());
		if(!bSend){
			throw new Exception("发送邮件失败");
		}
	}
	
}
