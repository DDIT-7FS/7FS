package kr.or.ddit.sevenfs.controller.organization;

import java.io.Console;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dclz")
public class DclzTypeController {
	
	@Autowired
	DclztypeService dclztypeService;
	
	@GetMapping("/dclzType")
	public String dclzType(Model model, Principal principal, DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size
			) {
		
		String emplNo = principal.getName();
		//log.info("username : " + emplNo);
		dclzTypeVO.setEmplNo(emplNo);
		model.addAttribute("emplNo" , emplNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , emplNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);
		model.addAttribute("articlePage" , articlePage);
		
		
		//log.info("근태 현황 와씀");
		
		model.addAttribute("title" , "나의 근태 현황");
		
		// 근태현황 대분류 개수
		DclzTypeVO dclzCnt = dclztypeService.dclzCnt(emplNo);
		//log.info("dclzCnt : " + dclzCnt);
		model.addAttribute("dclzCnt" , dclzCnt);
		
		// 사원 상세 근태현황 목록
		List<DclzTypeDetailVO> empDetailDclzTypeCnt = dclztypeService.empDetailDclzTypeCnt(emplNo);
		//log.info("empDetailDclzTypeCnt" + empDetailDclzTypeCnt);
		
		model.addAttribute("empDetailDclzTypeCnt", empDetailDclzTypeCnt);		
		model.addAttribute("empDetailDclzTypeCnt",empDetailDclzTypeCnt);
		
		// 사원의 전체 근태현황 조회
		List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
		log.info("empDclzList : " + empDclzList);
		
		String allTime = dclzTypeVO.getAllWorkTime();
		log.info("제발담겨라 아아아 : " + allTime);
		model.addAttribute("allTime", allTime);
		
		//String dclzCode = empDclzList.get(0).getDclzCode();
		
		model.addAttribute("empDclzList",empDclzList);
		
		// 오늘날짜
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.applyPattern("yyyy년 MM월 dd일");
		//log.info("today : " + dateFormat.format(today));
		
	    model.addAttribute("today" , dateFormat.format(today));
		model.addAttribute("emplNo", emplNo);
		
		dclzTypeVO.setEmplNo(emplNo);
		//dclzTypeVO.setDclzCode(dclzCode);
		
		
		DclzTypeVO workTime = dclztypeService.getTodayWorkTime(dclzTypeVO);
		if(workTime == null) {
			return "organization/dclz/dclzType";
		}
		
		String todayWorkTime = workTime.getTodayWorkStartTime();
		String todayWorkEndTime = workTime.getTodayWorkEndTime();
		
     	model.addAttribute("todayWorkTime", todayWorkTime);
     	model.addAttribute("todayWorkEndTime", todayWorkEndTime);
		
		
		return "organization/dclz/dclzType";
	}
	
	
	// 출근 버튼 눌렀을때 실행
	@ResponseBody
	@GetMapping("/todayWorkStart")
	public String todayWorkStart(Principal principal, Model model, DclzTypeVO dclzTypeVO) {
		
		String emplNo = principal.getName();
		dclzTypeVO.setEmplNo(emplNo);

		 LocalTime now = LocalTime.now();
		 int nowHour = now.getHour();
		 
		 //log.info("nowHour : " + nowHour);
		 
		// 시간이 9시 이전이면 출근 insert 근태넘버 11
		 if(nowHour < 9) {
			 dclzTypeVO.setDclzCode("11");
		 }
		 else { // 시간이 9시 이후면 지각 insert 근태넘버 01
			 dclzTypeVO.setDclzCode("01");
		 }
		
		//log.info("출근한사람~~ : " + emplNo);
		
		// 현재 로그인한 사원번호 가져오기
         // 출근시간 insert
    	 int result = dclztypeService.workBeginInsert(dclzTypeVO);
    	 //log.info("result : " + result);
    	 
	    	// 오늘 출퇴근시간 조회
	         if(result == 1) {
	         	DclzTypeVO workTime = dclztypeService.getTodayWorkTime(dclzTypeVO);
	         	//log.info("workTime : " + workTime);
	         	
	         	// 출근시간 return
	         	String todayWorkTime = workTime.getTodayWorkStartTime();
	         	//log.info("controller 출근시간 : " + todayWorkTime);
	         	return todayWorkTime;
	         }
		return "실패";
	}
	
	
	// 퇴근 버튼 눌렀을때 실행
	@ResponseBody
	@GetMapping("/todayWorkEnd")
	public String todayWorkEnd(Principal principal, Model model, DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {
		
		String emplNo = principal.getName();
		dclzTypeVO.setEmplNo(emplNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , emplNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);

		List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
		//log.info("empDclzList : " + empDclzList);
		String dclzCode = empDclzList.get(0).getDclzCode();
		
		dclzTypeVO.setDclzCode(dclzCode);
		
		//log.info("퇴근한사람~~~~~ : " + emplNo);
		
		int result = dclztypeService.workEndInsert(dclzTypeVO);
		
		// 퇴근시간 insert
		if(result == 1) {
			DclzTypeVO workTime = dclztypeService.getTodayWorkTime(dclzTypeVO);
         	//log.info("workTime : " + workTime);
         	
         	// 출근시간 return
         	String todayWorkEndTime = workTime.getTodayWorkEndTime();
         	//log.info("controller 퇴근시간 : " + todayWorkEndTime);
         	
         	return todayWorkEndTime;
		}
		return "실패";
	}
	
	// 년도 , 달 선택했을때
	@ResponseBody
	@PostMapping("/yearSelect")
	public Map<String, Object> yearSelect(@RequestBody DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {
		
		String employeeNo = dclzTypeVO.getEmplNo();
		
		// 년도 조회 쿼리로 보낼 map
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , employeeNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		// 년도 + 달 조회 쿼리로 보낼 map
		Map<String, Object> mapMonth = new HashMap<>();
		mapMonth.put("emplNo" , employeeNo);
		mapMonth.put("currentPage", currentPage);
		mapMonth.put("size", size);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		
		// 페이지 정보
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);
		map.put("articlePage", articlePage);
		mapMonth.put("articlePage", articlePage);
		
		//log.info("param : " + dclzTypeVO);
		// jsp에서 보낸 년도
		String date = dclzTypeVO.getWorkBeginDate();
		String selYear = date.substring(0, 4);
		map.put("workBeginDate", selYear);
		dclzTypeVO.setWorkBeginDate(selYear);
		//log.info("선택년도 : " + dclzTypeVO.getWorkBeginDate());

		
		// jsp에서 보낸 달
		String mon = dclzTypeVO.getWorkEndDate();
		log.info("선택 달 : " + mon);
		
		if(mon == null) {
			// 년도에만 해당하는 목록
			List<DclzTypeVO> selYearList = dclztypeService.getSelectYear(map);
			//log.info("selYearList : " + selYearList);
			map.put("selYearList", selYearList);
			return map;
			
		}else {
			String emplNo = dclzTypeVO.getEmplNo();
			dclzTypeVO.setEmplNo(emplNo);
			
			mapMonth.put("emplNo", emplNo);
			
			
			String selectYear = dclzTypeVO.getWorkBeginDate();
			//log.info("월까지선택한 ㅁ년도 : " + selectYear);
			dclzTypeVO.setWorkBeginDate(selectYear);
			
			mapMonth.put("workBeginDate", selectYear);
			mapMonth.put("workEndDate", mon);
			
			//log.info("월선택 실행");
			dclzTypeVO.setWorkBeginDate(selYear);
			dclzTypeVO.setWorkEndDate(mon);
			
			List<DclzTypeVO> selMonList = dclztypeService.getSelectMonth(mapMonth);
			//log.info("selMonList : " + selMonList);
			mapMonth.put("selMonList", selMonList);
			
			return mapMonth;
		}
		
	}

}
