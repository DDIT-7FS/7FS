package kr.or.ddit.sevenfs.mapper.atrz;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;

@Mapper
public interface AtrzMapper {
	//결재 대기중인 문서리스트
	public List<AtrzVO> atrzApprovalList(String emplNo);
	//기안 올린 문서리스트
	public List<AtrzVO> atrzSubmitList(String emplNo);
	//기안완료된 문서리스트
	public List<AtrzVO> atrzCompletedList(String emplNo);
	
	//목록 출력
	public List<AtrzVO> homeList(String emplNo);
	
	//기안문서 post
	public int draftInsert(DraftVO draftVO);
	
	//기안문서 detail
	public DraftVO draftDetail(String draftNo);
	
	//전자결재와 기안문서 조인하기 위한것
	public AtrzVO atrzDetail(@Param("atrzDocNo") String atrzDocNo);
	
	//전자결재 테이블 등록
	public int insertAtrz(AtrzVO atrzVO);
	//전자결재선 테이블 등록
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	
	//연차신청서 테이블 등록
	public int insertHoliday(HolidayVO documHolidayVO);
	//연차 신청서 상세보기
	public HolidayVO holidayDetail(int holiActplnNo);
	
	//지출결의서 테이블 등록
	public int insertSpending(SpendingVO spendingVO);
	
	
	
	
	

	
	
}
