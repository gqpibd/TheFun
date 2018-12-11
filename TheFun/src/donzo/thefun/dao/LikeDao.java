package donzo.thefun.dao;

import donzo.thefun.model.LikeDto;


public interface LikeDao{
		
	public boolean changeLike(LikeDto dto);

	public boolean isLike(LikeDto dto);

	public int getLikeCount(int projectseq);
}
