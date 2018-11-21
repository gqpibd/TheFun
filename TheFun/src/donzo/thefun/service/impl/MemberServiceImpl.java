package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.MemberDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao MemberDao;

	@Override
	public MemberDto getMypage(MemberDto mem) throws Exception{
		return MemberDao.getMypage(mem);
	}
	
	
	
}
