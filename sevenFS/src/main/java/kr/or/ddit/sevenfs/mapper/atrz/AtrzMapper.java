package kr.or.ddit.sevenfs.mapper.atrz;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DocumHolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;

@Mapper
public interface AtrzMapper {
	//사원정보가져오기
	public List<AtrzVO> atrzEmploInfo();
	
	//목록 출력
	public List<AtrzVO> homeList(String emplNo);
	
	//기안문서 post
	public int draftInsert(DraftVO draftVO);
	
	//기안문서 detail
	public DraftVO draftDetail(String draftNo);
	
	//전자결재와 기안문서 조인하기 위한것
	public AtrzVO atrzDetail(@Param("atrzDocNo") String atrzDocNo);
	
	//결재대기문서 갯수
	public int beDocCnt(String emplNo);
	
	//전자 결재대기
	public List<AtrzVO> selectHomeBeDoc(String emplNo);
	//기안진행문서
	public List<AtrzVO> selectHomeReqDoc(String emplNo);
	//결재수신문서갯수
	public int recDocCnt(String emplNo);
	
	// 결재 수신 문서
	public List<AtrzVO> selectReceiptDoc(int currentPage, int pageSize, AtrzVO atrzVO);
	public int receiptTotalCnt(AtrzVO atrzVO);
	
	// 결재대기문서
	public List<AtrzVO> selectBeforeDoc(int currentPage, int pageSize, AtrzVO atrzVO);
	public int beforeTotalCnt(AtrzVO atrzVO);
	
	//문서양식- 연차신청서인경우
	public int insertHoDoc();
	
	//전자결재테이블 인서트
	public int insertAtrz(AtrzVO atrzVO);
	//전자결재선 테이블 인서트
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	//연차신청서 테이블 인서트
	public int insertHoliday(DocumHolidayVO documHolidayVO);
	
	//연차 신청서 상세보기
	public DocumHolidayVO holidayDetail(int holiActplnNo);
	
	
	

	
	
}
