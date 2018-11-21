package donzo.thefun.dao;

import donzo.thefun.model.MemberDto;

public interface MemberDao {

	/*getMypage*/
	public MemberDto getMypage(MemberDto mem) throws Exception;
	
}
