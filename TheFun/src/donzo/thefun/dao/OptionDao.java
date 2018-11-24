package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.OptionDto;

public interface OptionDao {
	public List<OptionDto> getOptions(int seq);
	public OptionDto getSelectOptions(int seq); 
	void optionWrite(List<OptionDto> newPotionlist, int projectSeq) throws Exception;


}
