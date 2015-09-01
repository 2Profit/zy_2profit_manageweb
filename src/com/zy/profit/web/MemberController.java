package com.zy.profit.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.BaseEntity;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.member.entity.Member;
import com.zy.member.service.MemberService;
import com.zy.personal.entity.MemBankInfo;

@Controller
@RequestMapping("/boss/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private BrokerInfoService brokerInfoService;
	
	@RequestMapping("/list")
	public String queryPage(Member queryDto,PageModel<Member> pageModel,Model model){
		
		model.addAttribute("page", memberService.queryForPage(queryDto, pageModel));
		model.addAttribute("brokerInfos", brokerInfoService.findAllBrokerInfo(BaseEntity.DELETE_FLAG_NORMAL));
		model.addAttribute("queryDto",queryDto);
		
		return "member/memberList";
	}
	
	@RequestMapping("/edit")
	public String edit(Model model,Member entity){
		
		if(StringUtils.isNotBlank(entity.getId())){
			model.addAttribute("member", memberService.get(entity.getId()));
		}
		return "member/memberEdit";
	}
	
	@RequestMapping(value="/save")
	@ResponseBody
	@Transactional
	public ResultDto<Member> save(Member dto,HttpServletRequest request){
		ResultDto<Member> result = new ResultDto<Member>();
		try {
			UserDto userDto = UserSessionUtil.getSessionUser(request.getSession());
			if(StringUtils.isNoneBlank(dto.getId())){
				memberService.update(dto);
			}else{
				
				MemBankInfo memBankInfo = new MemBankInfo();
				memBankInfo.setBankAccount(dto.getMemBankInfo().getBankAccount());
				memBankInfo.setBankCardNum(dto.getMemBankInfo().getBankCardNum());
				memBankInfo.setBankAddress(dto.getMemBankInfo().getBankAddress());
				
				dto.setCreateId(userDto.getId());
				dto.setCreateName(userDto.getUsername());
				memberService.save(dto);
			}
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
}
