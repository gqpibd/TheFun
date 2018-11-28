package donzo.thefun.service;

import donzo.thefun.model.MemberDto;

public interface MemberService {

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public boolean addAccount(MemberDto dto);

	public MemberDto tryLogin(MemberDto dto);
	
	public MemberDto getMypage(MemberDto mem) throws Exception;

	public boolean updateMember(MemberDto mem);
	
	
	
}
 