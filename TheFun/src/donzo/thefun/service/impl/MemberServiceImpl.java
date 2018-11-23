package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.MemberDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;

	@Override
	public boolean idExists(String id) {		
		return memberDao.idExists(id);
	}

	@Override
	public boolean emailExists(String email) {
		return memberDao.emailExists(email);
	}

	@Override
	public boolean addAccount(MemberDto dto) {
		return memberDao.addAccount(dto);
	}

	@Override
	public MemberDto tryLogin(MemberDto dto) {		
		return memberDao.tryLogin(dto);
	}	

	@Override
	public MemberDto getMypage(MemberDto mem) throws Exception{
		return memberDao.getMypage(mem);
	}

	@Override
	public boolean updateMember(MemberDto mem) {
		return memberDao.updateMember(mem);
	}
	 
	
	
}
