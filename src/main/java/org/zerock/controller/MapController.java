package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ApartVO;
import org.zerock.domain.AttachFileVO;
import org.zerock.domain.FacilityVO;
import org.zerock.service.ApartService;
import org.zerock.service.FacilityService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequiredArgsConstructor
@RequestMapping("/map/")
@Log4j
public class MapController {
	
	private final ApartService apartService;
	private final FacilityService facilityService;
	
	@GetMapping("/viewMap")
	public void viewMap() {
		
	}
	
	@GetMapping("/viewApartList")
	public void viewApartList(Model model) {
		model.addAttribute("list", apartService.getList());
	}
	
	@GetMapping("/facilityList")
	public void facilityList(Model model) {
		model.addAttribute("faclist", facilityService.getList());
	}
	
	@GetMapping("/registerFac")
	public void registerFac(Model model, @RequestParam("apt_name")String apt_name, @RequestParam("apt_bno")Long apt_bno) {
		
		model.addAttribute("apt_name",apt_name);
		model.addAttribute("getApart", apartService.get(apt_bno));
	}

	@PostMapping("/registerApart")
	public String registerApart(ApartVO apartVO, RedirectAttributes rttr) {
				
		apartService.register(apartVO);
		return "redirect:/map/viewApartList";
	}
	
	@PostMapping("/registerFacility")
	public String registerFacility(FacilityVO facilityVO, RedirectAttributes rttr) {
		facilityService.register(facilityVO);
		
		return "redirect:/map/facilityList";
	}
	
	//file upload
	

	
			private String getFolder() {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date();
				String str = sdf.format(date);
				return str.replace("-",File.separator);
			}
			
			private boolean checkImageType(File file) {
				try {
					String contentType = Files.probeContentType(file.toPath());
					return contentType.startsWith("image");
				} catch(IOException e) {
					e.printStackTrace();
				}
				return false;
			}
			
			@PostMapping(value="/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
			@ResponseBody
			public ResponseEntity<List<AttachFileVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
				List<AttachFileVO> list = new ArrayList<>();
				
				String uploadFolder = "C:\\upload";
				String uploadFolderPath = getFolder();
				//make folder
				File uploadPath = new File(uploadFolder, uploadFolderPath);
				log.info("upload path: "+uploadPath);
				
				if(uploadPath.exists() == false) {
					uploadPath.mkdirs();
				}

				for(MultipartFile multipartFile : uploadFile) {
					AttachFileVO attachVO = new AttachFileVO();
					
					String uploadFileName = multipartFile.getOriginalFilename();
					
					uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
					log.info("only file name: "+ uploadFileName);
					attachVO.setFileName(uploadFileName);
					//파일 중복 이름 피하기
					UUID uuid = UUID.randomUUID();
					uploadFileName = uuid.toString()+"_"+uploadFileName;
					
					try {
						File saveFile = new File(uploadFolder, uploadFileName);
						multipartFile.transferTo(saveFile);
					
						attachVO.setUuid(uuid.toString());
						attachVO.setUploadPath(uploadFolderPath);
						//check image type file
						if(checkImageType(saveFile)) {
							attachVO.setImage(true);
							FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
							Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
							thumbnail.close();
						}
						list.add(attachVO);
					} catch (Exception e) {
						log.error(e.getMessage());
					}
				}
				return new ResponseEntity<>(list,HttpStatus.OK);
			}
			
			@GetMapping("/display")
			@ResponseBody
			public ResponseEntity<byte[]> getFile(String fileName) {
				log.info("fileName:" +fileName);
				File file = new File("C:\\upload\\"+fileName);
				log.info("file: "+file);
				ResponseEntity<byte[]> result = null;
				try {
					HttpHeaders header = new HttpHeaders();
					header.add("Content-Type", Files.probeContentType(file.toPath()));
					result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
				} catch(IOException e) {
					e.printStackTrace();
				}
				return result;
			}

}
