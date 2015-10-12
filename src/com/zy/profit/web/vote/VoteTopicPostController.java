package com.zy.profit.web.vote;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.base.entity.Notice;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.vote.entity.VotePostPraise;
import com.zy.vote.entity.VotePostReport;
import com.zy.vote.entity.VoteTopicPost;
import com.zy.vote.service.VotePostPraiseService;
import com.zy.vote.service.VotePostReportService;
import com.zy.vote.service.VoteTopicPostService;

@Controller
@RequestMapping("voteTopicPost")
public class VoteTopicPostController {

	@Autowired
	private VoteTopicPostService voteTopicPostService;
	@Autowired
	private VotePostPraiseService votePostPraiseService;
	@Autowired
	private VotePostReportService votePostReportService;
	
	
	
	@RequestMapping("/list")
	public String list(Model model,VoteTopicPost queryDto,PageModel<VoteTopicPost> pageModel){
		
		model.addAttribute("page", voteTopicPostService.queryPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "/vote/voteTopicPostList";
	}
	
	@RequestMapping("/praise/list")
	public String praiseList(Model model,VotePostPraise queryDto,PageModel<VotePostPraise> pageModel){
		
		model.addAttribute("page", votePostPraiseService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/votePostPraiseList";
	}
	
	@RequestMapping("/report/list")
	public String reportList(Model model,VotePostReport queryDto,PageModel<VotePostReport> pageModel){
		
		model.addAttribute("page", votePostReportService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/votePostReportList";
	}
	
	@ResponseBody
	@RequestMapping("/deleteFlag")
	public ResultDto<Notice> deleteFlag(@RequestBody VoteTopicPost queryDto){
		ResultDto<Notice> result = new ResultDto<Notice>();
		try {
			voteTopicPostService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	@RequestMapping("/editPost")
	@ResponseBody
	public ResultDto<VoteTopicPost> reply(VoteTopicPost dto){
		ResultDto<VoteTopicPost> result = new ResultDto<VoteTopicPost>();
		try {
			VoteTopicPost entity = voteTopicPostService.find(dto.getId());
			entity.setPostContent(dto.getPostContent());
			voteTopicPostService.save(entity);
		} catch (Exception e) {
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}
}
