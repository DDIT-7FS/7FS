package kr.or.ddit.sevenfs.mapper.project;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface KanbanMapper {

    List<ProjectTaskVO> selectTasksByProjectNo(Long prjctNo);

    int updateTaskStatus(Long taskNo, String newStatus);

    ProjectTaskVO selectTaskById(Long taskNo);
    

}
