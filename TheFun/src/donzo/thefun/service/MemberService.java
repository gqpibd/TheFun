package donzo.thefun.service;

import javax.servlet.http.HttpServletResponse;

import donzo.thefun.model.MemberDto;

public interface MemberService {

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public boolean addAccount(MemberDto dto);

	public MemberDto tryLogin(MemberDto dto);
	
	public MemberDto getUserInfo(String id) throws Exception;

	public boolean updateMember(MemberDto mem);

	public boolean addPoint(MemberDto mem);
	
	//idpw 찾기
	public MemberDto find_idpw(MemberDto dto);
	
}
 