package donzo.thefun.dao;

import donzo.thefun.model.MemberDto;

public interface MemberDao {

	boolean idExists(String id);

	boolean emailExists(String email);

	boolean addAccount(MemberDto dto);

	MemberDto tryLogin(MemberDto dto);
	
	/*getMypage*/
	public MemberDto getMypage(MemberDto mem) throws Exception;
	
}
