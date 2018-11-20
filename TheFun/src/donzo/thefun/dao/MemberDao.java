package donzo.thefun.dao;

import donzo.thefun.model.MemberDto;

public interface MemberDao {

	boolean idExists(String id);

	boolean emailExists(String email);

	boolean addAccount(MemberDto dto);

}
