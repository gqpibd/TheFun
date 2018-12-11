package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.OptionDto;

public interface OptionDao {
	
	//project detail에 쓰일 option들 ( 프로젝트 seq )
	public List<OptionDto> getOptions(int seq);
	
	//주문시 내가 선택한 option들 ( 옵션 seq )
	public OptionDto getSelectOptions(int seq); 
	
	public boolean optionWrite(List<OptionDto> newPotionlist, int projectSeq) throws Exception;
	
	public boolean deleteOptions(int seq) throws Exception;

	public boolean updateStock(OptionDto opdto);
}
