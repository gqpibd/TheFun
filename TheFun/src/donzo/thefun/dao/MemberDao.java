package donzo.thefun.dao;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;

public interface MemberDao {

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public boolean addAccount(MemberDto dto);

	public MemberDto tryLogin(MemberDto dto);
	
	/*getMypage*/
	public MemberDto getMypage(MemberDto mem) throws Exception;

	public boolean updateMember(MemberDto mem);

	
	
	
	
} 
