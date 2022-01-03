package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.FacilityVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageVO;
import org.zerock.domain.ReserveVO;
import org.zerock.domain.SectionNumVO;
import org.zerock.service.ApartService;
import org.zerock.service.FacilityService;
import org.zerock.service.ReserveService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reserve/")
@Log4j
public class ReserveController {
	
	private final ApartService apartService;
	private final FacilityService facilityService;
	private final ReserveService reserveService;
	
	@GetMapping("/selectApart")
	public void viewApartList(Model model, Criteria cri) {
		model.addAttribute("list",apartService.getList(cri));
		model.addAttribute("pageMaker", new PageVO(cri, apartService.getTotal(cri)));
	}

	@GetMapping("/selectFac")
	public void facilityList(Model model, @RequestParam("apt_name") String apt_name) {
		model.addAttribute("faclist", facilityService.getList2(apt_name));
	}
	
	@GetMapping("/myreserve")
	public void myReserve(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("userInfo");
		String userId = member.getUserId();
		model.addAttribute("mylist", reserveService.getMyReserve(userId));
	}
	
	@GetMapping("/testimg")
	public void testPage(Model model) {
	}
	
	
	@GetMapping("/reserveFac")
	public void viewFacInfo(Model model, @RequestParam("fac_bno") Long fac_bno) {
		FacilityVO fac = facilityService.get(fac_bno);
		System.out.print("-------------");
		System.out.print(fac);
		model.addAttribute("info", fac);
		String opentime= fac.getFac_opentime();
		String closetime = fac.getFac_closetime();
		String[] splitOpen = opentime.split(":");
		String[] splitClose = closetime.split(":");
		
		model.addAttribute("openmin", splitOpen[1]);
		model.addAttribute("openhour", splitOpen[0]);
		model.addAttribute("closemin", splitClose[1]);
		model.addAttribute("closehour", splitClose[0]);
		
		int result = 0;
		result += (Integer.parseInt(splitClose[0])- Integer.parseInt(splitOpen[0]))*2;
		if(Integer.parseInt(splitOpen[1]) > Integer.parseInt(splitClose[1])) result -= 1;
		else if(Integer.parseInt(splitOpen[1]) > Integer.parseInt(splitClose[1])) result += 1;
		
		model.addAttribute("numtimeblock", result);
	}
	
	@PostMapping("/reserve")
	@ResponseBody
	public String reserveFacility(ReserveVO reserveVO, RedirectAttributes rttr, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("userInfo");
		reserveVO.setUserId(member.getUserId().toString());
		System.out.println("member info: " +member);
		int result = reserveService.register(reserveVO);
		
		if(result>0) return "ok";
		else return "no";
	}
	
	@PostMapping("/loadReserve")
	@ResponseBody
	public List<String> loadReserve(ReserveVO reserveVO) {
		List<String> list = reserveService.get(reserveVO);
		System.out.println(list);
		return list;
	}
	
	@PostMapping("/loadSectionNum")
	@ResponseBody
	public List<SectionNumVO> loadSectionNum(ReserveVO reserveVO) {
		List<SectionNumVO> list = reserveService.countSection(reserveVO);
		System.out.println(list);

		return list;
	}
	
	@PostMapping("/cancelReserve")
	@ResponseBody
	public String cancelReserve(ReserveVO reserveVO) {
		int result = reserveService.remove(reserveVO);
		if(result == 0) return "fail";
		else return "success";
	}
}
