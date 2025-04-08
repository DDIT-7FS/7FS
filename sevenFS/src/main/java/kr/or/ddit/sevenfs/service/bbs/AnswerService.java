package kr.or.ddit.sevenfs.service.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.AnswerVO;

public interface AnswerService {
	
	public void saveAnswer(AnswerVO vo);

	public List<AnswerVO> selectAnswer(Map<String, Object> params);
}
