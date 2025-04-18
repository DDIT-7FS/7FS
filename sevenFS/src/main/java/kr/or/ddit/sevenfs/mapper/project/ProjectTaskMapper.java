package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

@Mapper
public interface ProjectTaskMapper {

	public int insertProjectTask(ProjectTaskVO taskVO);

	public List<ProjectTaskVO> getParentTasks(int prjctNo); 
	
	public void insertProjectTaskBatch(List<ProjectTaskVO> taskList);

	public ProjectTaskVO selectTaskById(Long taskNo);

	public int updateTask(ProjectTaskVO taskVO);

	public int deleteTask(Long taskNo);

	public List<ProjectTaskVO> selectProjectTasks(int prjctNo);

	public void updateTaskParent(Map<String, Object> params);
	
	public void deleteTasksByProjectNo(int prjctNo);

	public void deleteProjectTasksByProject(long prjctNo);

	public int countChildTasks(Long parentTaskNo);

	public List<TaskVO> selectTaskCardsByProjectNo(Long prjctNo);

	public int updateTaskStatus(@Param("taskId") long taskId, @Param("status") String status);

	public TaskVO selectCardById(Long taskNo);

}
