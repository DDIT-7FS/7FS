package kr.or.ddit.sevenfs.service.atrz;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;

public interface AtrzService {
	//결재 대기중인 문서리스트
	public List<AtrzVO> atrzApprovalList(String emplNo);
	//기안중인 문서리스트
	public List<AtrzVO> atrzSubmitList(String emplNo);
	//기안완료된 문서리스트
	public List<AtrzVO> atrzCompletedList(String emplNo);
		
	//목록 출력
	public List<AtrzVO> homeList(String emplNo);
	
	//기안문서 상세보기
	public DraftVO draftDetail(String draftNo);
	
	
	//전자결재 테이블 등록
	public int insertAtrz(AtrzVO atrzVO);
	//전자결재선 등록
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	
	//연차신청서 등록
	public int insertHoliday(HolidayVO holidayVO);

	
	//지출결의서 등록
	public int insertSpending(SpendingVO spendingVO);
	//급여명세서 등록
	public int insertSalary(SalaryVO salaryVO);
	//급여계좌변경신청서 등록
	public int insertBankAccount(BankAccountVO bankAccountVO);
	//기안서 등록
	public int insertDraft(DraftVO draftVO);
	
	//전자결재 상세보기
	public AtrzVO getAtrzDetail(String atrzDocNo);
	//2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
	public int insertUpdateAtrz(AtrzVO atrzVO);
	
	//연차신청서 상세보기
	public HolidayVO holidayDetail(String atrzDocNo);
	
	//전자결재 문서 상세보기 결재라인 수정(업데이트)
	public int atrzDetailAppUpdate(AtrzVO atrzVO);
	
	
	
	//비즈니스 로직 이란???
	//컨드롤러에서는 화면에서 보여지는것만 
	//mapper에는 db연결만 
	//service는 로직처리한다.
	
	
}
