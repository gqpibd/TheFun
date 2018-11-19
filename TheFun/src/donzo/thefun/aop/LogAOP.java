package donzo.thefun.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect // annotation 방식
public class LogAOP {
	
	@Around("within(donzo.thefun.dao.impl.*)") // AOP설정을 bean.xml에서 설정하지 않고 여기서 설정 해줌!
	public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable {
		String signatureStr = joinpoint.getSignature().toShortString();
		
		System.out.println("loggerAop:" + signatureStr + " 메소드가 실행되었습니다.");
		Object obj = joinpoint.proceed(); // 기능 실행
		return obj;
	}
}
