package donzo.thefun.service;

import javax.servlet.http.HttpServletResponse;

import donzo.thefun.model.MemberDto;

public interface MemberService {

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public boolean addAccount(MemberDto dto);

	public MemberDto tryLogin(MemberDto dto);
	
	public MemberDto getMypage(MemberDto mem) throws Exception;

	public boolean updateMember(MemberDto mem);
	
	//id 찾기
	public String find_id(HttpServletResponse response, String email) throws Exception;
	
}
 