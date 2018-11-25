package donzo.thefun.service;

import java.util.ArrayList;
import java.util.List;

import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface ProjectService {
	
	public int projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception;

	
	
	
	
	
}
