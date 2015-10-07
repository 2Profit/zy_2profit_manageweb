package com.zy.profit.web.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.base.entity.Nationality;
import com.zy.base.service.NationalityService;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.BaseEntity;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.DateUtils;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.member.entity.Member;
import com.zy.member.service.MemberService;
import com.zy.personal.entity.MemBankInfo;
import com.zy.personal.service.MemBankInfoService;

/**
 * 个人资料管理
 * 
 * @author Pingan
 *
 * @since  2015年10月5日
 */

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private BrokerInfoService brokerInfoService;
	@Autowired
	private MemBankInfoService memBankInfoService;
	
	@Autowired
	private NationalityService nationalityService;
	
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
			Member member = memberService.find(entity.getId());
			model.addAttribute("member", member);
		}
		
		List<Nationality> nationalities = nationalityService.findNationalities();
		model.addAttribute("nationalities", nationalities);
		
		return "member/memberEdit";
	}
	
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultDto<Member> save(Member dto,HttpServletRequest request){
		ResultDto<Member> result = new ResultDto<Member>();
		try {
			UserDto userDto = UserSessionUtil.getSessionUser(request.getSession());
			
			String bankAccount = request.getParameter("bankAccount");
			String bankCardNum = request.getParameter("bankCardNum");
			String bankAddress = request.getParameter("bankAddress");
			String nation = request.getParameter("nation");
			if(StringUtils.isNotBlank(nation)){
				Nationality nationality = new Nationality();
				nationality.setId(nation);
				dto.setNationality(nationality);
			}
			
			String createAccountDateStr = request.getParameter("createAccountDateStr");
			if(StringUtils.isNotBlank(createAccountDateStr)){
				dto.setCreateAccountDate(DateUtils.dfDate.parse(createAccountDateStr));
			}
			
			if(StringUtils.isNoneBlank(dto.getId())){
				
				Member member = memberService.find(dto.getId());
				member.setUserName(dto.getUserName());
				member.setAccountCategory(dto.getAccountCategory());
				member.setAccountType(dto.getAccountType());
				member.setCnName(dto.getCnName());
				member.setEnName(dto.getEnName());
				member.setCardType(dto.getCardType());
				member.setCard(dto.getCard());
				member.setMobile(dto.getMobile());
				member.setTelephone(dto.getTelephone());
				member.setEmail(dto.getEmail());
				member.setAddress(dto.getAddress());
				member.setSex(dto.getSex());
				member.setNationality(dto.getNationality());
				member.setIsVoteAuth(dto.getIsVoteAuth());
				member.setIsCommentAuth(dto.getIsCommentAuth());
				member.setCreateAccountDate(dto.getCreateAccountDate());
				member.setIsBindWeChat(dto.getIsBindWeChat());
				member.setStatus(dto.getStatus());
				
				MemBankInfo memBankInfo = member.getMemBankInfo();
				if(memBankInfo == null){
					memBankInfo = new MemBankInfo();
					memBankInfo.setCreateId(userDto.getId());
					memBankInfo.setCreateName(userDto.getUsername());
					
					member.setMemBankInfo(memBankInfo);
				}
				memBankInfo.setBankAccount(bankAccount);
				memBankInfo.setBankAddress(bankAddress);
				memBankInfo.setBankCardNum(bankCardNum);
				if(StringUtils.isNotBlank(memBankInfo.getId())){
					memBankInfoService.update(memBankInfo);	
				}else{
					memBankInfoService.save(memBankInfo);
				}

				memberService.update(member);
			}else{
				dto.setCreateId(userDto.getId());
				dto.setCreateName(userDto.getUsername());
				
				MemBankInfo memBankInfo = new MemBankInfo();
				memBankInfo.setBankAccount(bankAccount);
				memBankInfo.setBankCardNum(bankCardNum);
				memBankInfo.setBankAddress(bankAddress);
				memBankInfo.setCreateId(userDto.getId());
				memBankInfo.setCreateName(userDto.getUsername());
				memBankInfoService.save(memBankInfo);
				
				dto.setMemBankInfo(memBankInfo);
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
