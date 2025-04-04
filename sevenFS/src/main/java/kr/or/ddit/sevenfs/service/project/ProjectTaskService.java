package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface ProjectTaskService {

	public void insertProjectTask(ProjectTaskVO taskVO);
	
	public void insertProjectTaskBatch(List<ProjectTaskVO> taskList);

    public  List<ProjectTaskVO> getParentTasks(int prjctNo);
    
    
}
