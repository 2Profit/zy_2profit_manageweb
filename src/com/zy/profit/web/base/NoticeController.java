package com.zy.profit.web.base;

import java.io.File;
import java.io.IOException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zy.base.entity.Notice;
import com.zy.base.service.NoticeService;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.util.ImageUploadUtil;

/**
 * 公告
 * @author pingan
 * @since  2015-09-16
 */

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/list")
	public String list(Model model,Notice queryDto, PageModel<Notice> pageModel){
		
		model.addAttribute("page", noticeService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		return "notice/noticeList";
	}
	
	@RequestMapping("/edit")
	public String edit(Model model,Notice queryDto){
		
		if(StringUtils.isNotBlank(queryDto.getId())){
			model.addAttribute("notice", noticeService.get(queryDto.getId()));
		}
		return "notice/noticeEdit";
	}
	
	private String uploadFile(MultipartFile multipart,Notice dto) throws IllegalStateException, IOException{
		String originalFileName = multipart.getOriginalFilename();
		File convFile = new File(originalFileName);
        multipart.transferTo(convFile);
		return ImageUploadUtil.uploadFileHandler(convFile, Notice.class.getSimpleName(),
				originalFileName, dto.getImageWidth(), dto.getImageHeight());
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public ResultDto<Notice> save(Notice dto,
			@RequestParam("file") MultipartFile file){
		
		ResultDto<Notice> result = new ResultDto<Notice>();
		try {
			
			//上传图片到服务器
			if(file!=null && !file.isEmpty()){
				String returnCode = uploadFile(file, dto);
				if(!"400".equals(returnCode)){
					dto.setPhotoUrl(returnCode);
				}
			}
			
			noticeService.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/deleteFlag")
	public ResultDto<Notice> deleteFlag(@RequestBody Notice queryDto){
		ResultDto<Notice> result = new ResultDto<Notice>();
		try {
			if(queryDto.getIds()!=null && queryDto.getIds().length > 0){
				for(String id : queryDto.getIds()){
					Notice notice = noticeService.get(id);
					notice.setDeleteFlag(queryDto.getDeleteFlag());
					noticeService.update(notice);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
}
