package kr.or.ddit.sevenfs.controller.schedule;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.sevenfs.service.schedule.ScheduleLabelService;
import kr.or.ddit.sevenfs.service.schedule.ScheduleService;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/myCalendar")
@Slf4j
public class ScheduleController {
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	ScheduleLabelService labelService;
	// 드래그나 리사이즈로 변경하는건 map으로 담아서 로그아웃이나 페이지 벗아날시 한번에 db에 update한다.
	// 
	
	private Map<String, Object> uptMap = new HashMap<>();  
	
//	@Scheduled(fixedRate = 1000) // 60000밀리초 = 1분
	@Scheduled(fixedRate = 60000) // 60000밀리초 = 1분
	public void scheduledCalendarList() {
	    int size = uptMap.size();
	    if(size>0) {
	    	uptMapUpdate(size);
	    }
	}
	
	public void uptMapUpdate(int size) {
		log.info("업데이트 항목 개수 : "+size);
		if(size>0) {
			log.info("업데이트 항목 : "+uptMap);
			int result = scheduleService.scheduleUpdateMap(uptMap);
			log.info("업데이트 실행 -> 결과 : "+result);
			//  공통 함수로 두지 않은 이유는 일단 
			if(result!=0) {
				uptMap.clear();
				return;
			}
		}
		return;
	}
	
	@GetMapping("")
	public String calendarMain() {
		log.info("calendarMain 실행");
		return "schedule/scheduleHome";
	}
	/*
	 myCalendar.put("scheduleList", scheduleList);
	 myCalendar.put("labelList", labelList);
	*/
	
	@RequestMapping("/calendarList")
	@ResponseBody
	public Map<String,Object> calendarList(@RequestBody ScheduleVO scheduleVO){
		log.info("calendarList 실행");
		log.info("calendarList -> scheduleVO : "+scheduleVO);
		log.info("calendarList -> emplNO : "+scheduleVO.getEmplNo());
		int size = uptMap.size();
		if(size>0) {
	    	uptMapUpdate(size);
	    }
		Map<String,Object> myCalendar = scheduleService.scheduleList(scheduleVO);
		log.info("calendarList -> scheduleList : "+myCalendar.get("scheduleList"));
		List<ScheduleVO> list = (List<ScheduleVO>)myCalendar.get("scheduleList");
		log.info("calendarList -> labelList : "+myCalendar.get("labelList"));
		log.info("calendarList -> scheduleList 개수 : "+list.size() );
		return myCalendar;
	}
	
	@PostMapping("/labeling")
	@ResponseBody
	public Map<String,Object> calendarLabeling(@RequestBody Map<String, Object> fltrLbl){
		log.info("calendarLabeling -> fltrLbl : " + fltrLbl);
//		ScheduleVO scheduleVO = new ScheduleVO();
//		scheduleVO.setDeptCode((String)fltrLbl.get("deptCode"));
//		scheduleVO.setDeptCode((String)fltrLbl.get("emplNO"));
		Map<String,Object> myCalendar = scheduleService.calendarLabeling(fltrLbl);
		log.info("calendarLabeling -> myCalendar : " + myCalendar);
		return myCalendar;
	}
	
	@PostMapping("/addCalendar")
	@ResponseBody
	public Map<String,Object> addCalendar(@ModelAttribute  ScheduleVO scheduleVO){
		log.info("addCalendar -> scheduleVO : "+scheduleVO);
		int result = scheduleService.scheduleInsert(scheduleVO);
		int size = uptMap.size();
		if(size>0) {
	    	uptMapUpdate(size);
	    }
		Map<String,Object> myCalendar = scheduleService.scheduleList(scheduleVO);
		return myCalendar;
	}
	
	@ResponseBody
	@PostMapping("/uptCalendar")
	public Map<String,Object> uptCalendar(@ModelAttribute  ScheduleVO scheduleVO){
		log.info("uptCalendar -> scheduleVO : "+scheduleVO);
		int result = scheduleService.scheduleUpdate(scheduleVO);
		int size = uptMap.size();
		if(size>0) {
	    	uptMapUpdate(size);
	    }
		Map<String,Object> myCalendar = scheduleService.scheduleList(scheduleVO);
		return myCalendar;
	}
	
	@ResponseBody
	@PostMapping("/delCalendar")
	public Map<String,Object> delCalendar(@RequestBody ScheduleVO scheduleVO){
		int schdulNo = scheduleVO.getSchdulNo();
		uptMap.remove(schdulNo+"");
		log.info("delCalendar -> schdulNo : "+schdulNo);
		int result = scheduleService.delCalendar(schdulNo);
		int size = uptMap.size();
		if(size>0) {
	    	uptMapUpdate(size);
	    }
		Map<String,Object> myCalendar = scheduleService.scheduleList(scheduleVO);
		log.info("after delete -> myCalendar : "+myCalendar);
		return myCalendar;
	}
	
	@ResponseBody
	@PostMapping("/uptEvent")
	public int uptEvent(@RequestBody ScheduleVO scheduleVO) {
//	public void uptEvent(@RequestBody ScheduleVO scheduleVO) {
		log.info("uptEvent -> scheduleVO"+scheduleVO);
		uptMap.put(scheduleVO.getSchdulNo()+"", scheduleVO);
		log.info("uptMap -> "+uptMap);
		log.info("uptMap -> uptMap.size : "+uptMap.size());
		return uptMap.size();
	}
	
	
	@PostMapping("/labelAdd")
	@ResponseBody
//	public Map<String, String> labelAdd(@RequestBody ScheduleLabelVO labelVO) {
	public List<ScheduleLabelVO> labelAdd(@RequestBody ScheduleLabelVO labelVO) {
		log.info("labelAdd -> labelVO : "+labelVO);
		int result = labelService.labelAdd(labelVO);
		
		Map<String, String> response = new HashMap<>();
	    response.put("redirectUrl", "/myCalendar"); // 클라이언트가 리다이렉트할 URL
	    log.info("response : "+response);
	    
	    ScheduleVO scheduleVO = new ScheduleVO();
	    scheduleVO.setEmplNo(labelVO.getEmplNo());
	    List<ScheduleLabelVO> labelList = labelService.getLabel(scheduleVO);
	    return labelList;
	}
	@PostMapping("/getLabels")
	@ResponseBody
	public List<ScheduleLabelVO> getLabels(ScheduleVO scheduleVO) {
		log.info("getLabels -> scheduleVO : " + scheduleVO);
		List<ScheduleLabelVO> labelList = labelService.getLabel(scheduleVO);
		log.info("getLabels -> labelList : " + labelList);
		return labelList;
	}
}
