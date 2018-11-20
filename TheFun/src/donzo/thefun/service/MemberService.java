package donzo.thefun.service;

import donzo.thefun.model.MemberDto;

public interface MemberService {

	boolean idExists(String id);

	boolean emailExists(String email);

	boolean addAccount(MemberDto dto);

}
