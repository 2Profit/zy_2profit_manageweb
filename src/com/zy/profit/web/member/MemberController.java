package com.zy.profit.web.member;

import java.io.File;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zy.base.entity.Nationality;
import com.zy.base.service.NationalityService;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.BaseEntity;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.AjaxResult;
import com.zy.common.util.CommonConstants;
import com.zy.common.util.ConstantEnity;
import com.zy.common.util.DateUtils;
import com.zy.common.util.ExcelUtils;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.member.entity.Member;
import com.zy.member.service.MemberService;
import com.zy.org.entity.User;
import com.zy.personal.entity.MemBankInfo;
import com.zy.personal.service.MemBankInfoService;
import com.zy.profit.web.util.FileUploadUtil;
import com.zy.profit.web.util.HttpUtils;
import com.zy.profit.web.util.SystemConfig;
import com.zy.proposal.entity.ProposalMemModify;
import com.zy.proposal.service.ProposalMemModifyService;
import com.zy.util.Md5Util;

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
	private MemBankInfoService memBankInfoService;
	
	@Autowired
	private NationalityService nationalityService;
	
	@Autowired
	private ProposalMemModifyService proposalMemModifyService;
	
	@RequestMapping("/list")
	public String queryPage(Model model, HttpServletRequest request){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String mNo = request.getParameter("mNo");
		if(StringUtils.isNotBlank(mNo) && StringUtils.isNumeric(mNo.trim())){
			params.put("no", Integer.parseInt(mNo.trim()));
		}
		model.addAttribute("mNo", mNo);
		
		String accountCategory = request.getParameter("accountCategory");
		if(StringUtils.isNotBlank(accountCategory)){
			params.put("accountCategory", accountCategory);
		}
		model.addAttribute("accountCategory", accountCategory);
		
		String accountType = request.getParameter("accountType");
		if(StringUtils.isNotBlank(accountType)){
			params.put("accountType", accountType);
		}
		model.addAttribute("accountType", accountType);
		
		String cnName = request.getParameter("cnName");
		if(StringUtils.isNotBlank(cnName)){
			params.put("cnName","%" +  cnName.trim() + "%");
		}
		model.addAttribute("cnName", cnName);

		String enName = request.getParameter("enName");
		if(StringUtils.isNotBlank(enName)){
			params.put("enName", "%" + enName.trim() + "%");
		}
		model.addAttribute("enName", enName);

		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotBlank(mobile)){
			params.put("mobile", mobile.trim());
		}
		model.addAttribute("mobile", mobile);
		
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(status)){
			params.put("status", status);
		}
		model.addAttribute("status", status);
		
		Integer currentPage = HttpUtils.getCurrentPage(request);
		Integer pageSize = HttpUtils.getPageSize(request);
		
		PageModel<Member> pageModel = memberService.queryForPage(params, currentPage, pageSize);
		
		model.addAttribute("page", pageModel);
		
		return "member/memberList";
	}
	
	@RequestMapping("/edit")
	public String edit(Model model, HttpServletRequest request){
		
		String type = request.getParameter("type");
		model.addAttribute("type", type);
		
		String memberId = request.getParameter("memberId");
		if("update".equals(type)){
			Member member = memberService.find(memberId);
			model.addAttribute("member", member);
		}else if("add".equals(type)){
//			Integer no = memberService.getSequenceNo();
//			model.addAttribute("no", no);
		}else if("pos".equals(type)){
			//审批
			String posId = request.getParameter("posId");
			ProposalMemModify proposalMemModify = proposalMemModifyService.find(posId);
			model.addAttribute("pmm", proposalMemModify);
			model.addAttribute("member", proposalMemModify.getMember());
		}
		
		List<Nationality> nationalities = nationalityService.findNationalities();
		model.addAttribute("nationalities", nationalities);
		
		return "member/memberEdit";
	}
	
	/*@RequestMapping(value="/save")
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
//				member.setEnName(dto.getEnName());
				member.setNickName(dto.getNickName());
				member.setCardType(dto.getCardType());
				member.setCard(dto.getCard());
				member.setMobile(dto.getMobile());
				member.setEmail(dto.getEmail());
				member.setAddress(dto.getAddress());
				member.setSex(dto.getSex());
				member.setNationality(dto.getNationality());
				member.setIsVoteAuth(dto.getIsVoteAuth());
				member.setIsCommentAuth(dto.getIsCommentAuth());
				member.setCreateAccountDate(dto.getCreateAccountDate());
				member.setIsBindWeChat(dto.getIsBindWeChat());
				member.setStatus(dto.getStatus());
				
				String pwd = dto.getPwd();
				if(!"########".equals(pwd)){
					//有修改
					member.setPwd(Md5Util.generatePassword(pwd));
				}
				
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
				
				dto.setPwd(Md5Util.generatePassword(dto.getPwd()));
				
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
	}*/
	
	@RequestMapping("/ajax/upload/img")
	@ResponseBody
	public AjaxResult ajaxUploadImg(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			
			MultipartFile mf = multipartRequest.getFile("file");
			String originFileName = mf.getOriginalFilename();
			String ext = originFileName.substring(originFileName.lastIndexOf(".")).toLowerCase();
			String imgName = UUID.randomUUID() + ext;
			
			InputStream is = mf.getInputStream();
			
			String imgPath = FileUploadUtil.uploadAttachment(is, imgName);
			
			ajaxResult.setData(imgPath);
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("上传图片失败");
		}
		
		return ajaxResult;
	}
	
	/**
	 * 用户表提案保存
	 * @param request
	 * @param posMember
	 * @return
	 */
	@RequestMapping("/ajax/save/member/pos")
	@ResponseBody
	public AjaxResult ajaxSaveMemberPos(HttpServletRequest request, ProposalMemModify posMember){
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setSuccess(false);
		
		try {

			String type = request.getParameter("type");
			
			//判断手机号码、邮箱是否已经注册
			if("add".equals(type)){
				int ret = memberService.vaildUserByMobile(posMember.getMobile());
				if(ret > 0){
					ajaxResult.setMsg("该手机号码已经注册");
					return ajaxResult;
				}
				
				if(StringUtils.isNotBlank(posMember.getEmail())){
					ret = memberService.vaildUserByEmail(posMember.getEmail());
					if(ret > 0){
						ajaxResult.setMsg("该邮箱已经被注册");
						return ajaxResult;	
					}
					
					ret = proposalMemModifyService.findCountByEmail(posMember.getEmail(), CommonConstants.proposalStatusDefault.getIntKey());
					if(ret > 0){
						ajaxResult.setMsg("该邮箱注册会员的提案已添加");
						return ajaxResult;
					}
					
				}
				
				//判断是否已经加入到提案中
				ret = proposalMemModifyService.findCountByMobile(posMember.getMobile(), CommonConstants.proposalStatusDefault.getIntKey());
				if(ret > 0){
					ajaxResult.setMsg("该手机号码注册会员的提案已添加");
					return ajaxResult;
				}
				
//				if(posMember.getNo() == null){
//					Integer no = memberService.getSequenceNo();
//					posMember.setNo(no);
//				}
				
				
			}else if("update".equals(type)){
				String memberId = request.getParameter("memberId");
				Member member = memberService.find(memberId);
				posMember.setMember(member);
				
				int ret = 0;
				if(!posMember.getMobile().equals(member.getMobile())){
					ret = memberService.vaildUserByMobile(posMember.getMobile());
					if(ret > 0){
						ajaxResult.setMsg("该手机号码已经注册");
						return ajaxResult;
					}
				}
				
				if(StringUtils.isNotBlank(posMember.getEmail())){
					if(!posMember.getEmail().equals(member.getEmail())){
						ret = memberService.vaildUserByEmail(posMember.getEmail());
						if(ret > 0){
							ajaxResult.setMsg("该邮箱已经被注册");
							return ajaxResult;
						}
					}
				}
				
			}else{
				ajaxResult.setMsg("参数异常");
				return ajaxResult;
			}
			
			User user = HttpUtils.getUser(request);
			posMember.setCreateId(user.getId());
			posMember.setCreateName(user.getUsername());
			
			posMember.setApplier(user);
			
			if("add".equals(type)) {
				posMember.setPosType("添加");
			}else if ("update".equals(type)){
				posMember.setPosType("修改");
			} else {
				posMember.setPosType(type);
			}
			posMember.setPosStatus(CommonConstants.proposalStatusDefault.getIntKey());
			posMember.setCreateAccountDate(new Date());
			
			proposalMemModifyService.save(posMember);
			
			ajaxResult.setData(posMember.getNo());
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("操作异常");
		}
		
		return ajaxResult;
	}
	
	@RequestMapping("/import/list")
	public String importList(HttpServletRequest request, Model model){
		
		List<ConstantEnity> cardTypes = CommonConstants.getCardTypes();
		model.addAttribute("cardTypes", cardTypes);
		
		List<Nationality> nationalities = nationalityService.findNationalities();
		model.addAttribute("nationalities", nationalities);
		
		return "/member/mem_import_list";
	}
	
	@RequestMapping("/download/template")
	public ResponseEntity<byte[]> dowloadImportTemplate(){
		String templatePath = "/static/template/member.xls";
		String fileUrl = SystemConfig.getWebRoot() + templatePath;
		return HttpUtils.download("导入模板.xls", fileUrl);
	}
	
	@RequestMapping("/ajax/upload/import_file")
	@ResponseBody
	public AjaxResult ajaxUploadImportFile(HttpServletRequest request){
		AjaxResult ajaxResult = new AjaxResult();
		
		ajaxResult.setSuccess(false);
		
		try {
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			
			MultipartFile mf = multipartRequest.getFile("file");
			String originFileName = mf.getOriginalFilename();
			String ext = originFileName.substring(originFileName.lastIndexOf(".")).toLowerCase();
			String fileName = UUID.randomUUID() + ext;
			
			if(!ext.equalsIgnoreCase(".xls")){
				ajaxResult.setMsg("上传文件格式有误");
				return ajaxResult;
			}
			
			InputStream is = mf.getInputStream();
			
			String filePath = SystemConfig.getTmpPath() + fileName;
			
			File file = new File(SystemConfig.getWebRoot() + SystemConfig.getTmpPath());
			if(!file.exists()){
				file.mkdirs();
			}
			
			FileUtils.copyInputStreamToFile(is, new File(file, fileName));
			
			List<List<String>> items = ExcelUtils.readJxlXls(SystemConfig.getWebRoot() + filePath, 1);
			
			ajaxResult.setData(items);
			
			ajaxResult.setSuccess(true);
			
		} catch (Exception e) {
			e.printStackTrace();
			ajaxResult.setMsg("上传失败");
		}
		
		return ajaxResult;
	}
	
}
