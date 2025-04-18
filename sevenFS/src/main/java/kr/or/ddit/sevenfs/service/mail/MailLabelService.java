package kr.or.ddit.sevenfs.service.mail;

import java.util.List;

import kr.or.ddit.sevenfs.vo.mail.MailLabelVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

public interface MailLabelService {

	int mailLblAdd(MailLabelVO labelVO);

	List<MailLabelVO> getLabelList(EmployeeVO employeeVO);

	int deleteLbl(String lblNo);

}
