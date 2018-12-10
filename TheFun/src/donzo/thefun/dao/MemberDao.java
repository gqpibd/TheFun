package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;

public interface MemberDao {

	public boolean idExists(String id);

	public boolean emailExists(String email);

	public boolean addAccount(MemberDto dto);

	public MemberDto tryLogin(MemberDto dto);
	
	public MemberDto getUserInfo(String id) throws Exception;

	public boolean updateMember(MemberDto mem);

	public boolean addPoint(MemberDto mem);

	//idpw찾기
	public MemberDto find_idpw(MemberDto dto);
	
} 
