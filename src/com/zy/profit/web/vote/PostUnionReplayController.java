package com.zy.profit.web.vote;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.vote.dto.PostUnionReplayDto;
import com.zy.vote.dto.ReportUnionDto;
import com.zy.vote.entity.VoteTopic;
import com.zy.vote.service.VotePostReportService;
import com.zy.vote.service.VoteTopicPostReplayService;
import com.zy.vote.service.VoteTopicPostService;
import com.zy.vote.service.VoteTopicService;

/**
 * 评论列表（包含评论的回复）
 * @author pingan
 * @since  2015-10-20
 */


@Controller
@RequestMapping("/postUnionReplay")
public class PostUnionReplayController {
	
	@Autowired
	private VoteTopicService voteTopicService;
	@Autowired
	private VoteTopicPostService voteTopicPostService;
	@Autowired
	private VoteTopicPostReplayService voteTopicPostReplayService;
	@Autowired
	private VotePostReportService votePostReportService;
	
	
	
	@RequestMapping("/report/list")
	public String reportList(Model model, ReportUnionDto queryDto,PageModel<ReportUnionDto> pageModel){
		
		model.addAttribute("page", votePostReportService.queryPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/reportUnionList";
	}
	
	@RequestMapping("/list")
	public String list(Model model, PostUnionReplayDto queryDto,PageModel<PostUnionReplayDto> pageModel){
		
		model.addAttribute("page", voteTopicPostService.queryPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/postUnionReplayList";
	}
	
	@ResponseBody
	@RequestMapping("/deleteFlag")
	public ResultDto<Object> deleteFlag(@RequestBody PostUnionReplayDto queryDto){
		ResultDto<Object> result = new ResultDto<Object>();
		try {
			if(PostUnionReplayDto.TYPE_POST.equals(queryDto.getType())){
				//删除
				if(queryDto.getDeleteFlag()==1){
					voteTopicPostService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
					VoteTopic entity = voteTopicService.get(queryDto.getTopicId());
					entity.setPostCount(entity.getPostCount()-1);
					voteTopicService.update(entity);
				}
				//恢复
				if(queryDto.getDeleteFlag()==0){
					voteTopicPostService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
					VoteTopic entity = voteTopicService.get(queryDto.getTopicId());
					entity.setPostCount(entity.getPostCount()+1);
					voteTopicService.update(entity);
				}
			}
			if(PostUnionReplayDto.TYPE_REPLAY.equals(queryDto.getType())){
				voteTopicPostReplayService.deleteById(queryDto.getIds());
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
}
