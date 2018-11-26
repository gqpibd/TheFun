package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface OptionDao {
	
	void optionWrite(List<OptionDto> newPotionlist, int projectSeq) throws Exception;

}
