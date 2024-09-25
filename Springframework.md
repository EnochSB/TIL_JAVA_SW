# Spring framework
## 설정
- 자바 11버전, 톰캣 9버전
- JAVA_HOME 환경변수 변경
- STS 3버전(4버전도 가능)
- 상단메뉴 Window->Web Browser: 1. default setting web browser

## Dynamic Web Project 시작
- Target runtime: 아파치톰캣9

## Spring framwork 프로젝트 시작
- File > New > Spring Legacy Project 선택
- 프로젝트명 입력, Templates 선택(Spring MVC Project)
- Package Name 입력(com.***.###)

### 한글 설정
- Windows 메뉴 > Preference > General > Workspace -> Text-file encoding을 UTF-8
- Project 메뉴 > Properties > Resources -> Inherited from container를 UTF-8
- Project 메뉴 > Properties > Project Facetes에서 자바 버전을 11로 변경
- src > main > webapp > WEB-INF > web.xml파일
    - <web-app ... </web-app> 사이에 다음 추가
    ```xml
    
    ```

### pom.xml 설정(dependency 등록)
- dbms 라이브러리 추가
    - mvnrepository.com에서 mariadb Maven 문구 가져오기
    - dependencies 태그 가장 아래에 추가
    - HikariCP 추가
    - Spring JDBC
    ```xml
    	<!-- Spring JDBC -->
		<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-jdbc</artifactId>
		    <version>${org.springframework-version}</version>
		</dependency>
    ```
    - mybatis, mybatis-spring 추가
    - Apache commons I/O 추가(파일 첨부 라이브러리)
    - Apache commons fileupload 추가(파일 첨부 라이브러리)
    - jackson-databind 추가(AJAX를 위한 xml관련 라이브러리)
    - gson 추가(JSON과 배열 간 타입 변환 설정)
    - 비밀번호 암호화
        - spring security core
        - spring security web
        - spring security config

### root-context.xml(여러 스프링 빈 설치)
- src > main > webapp > WEB-INF > spring에서 root-context.xml
- Namespaces 탭 선택 후 beans, context, jdbc, mybatis체크
- Source 탭 선택 후 Bean 코드 등록
```xml
	<!-- DB접속 관련 설정 -->
	<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
	  <property name="driverClassName" value="org.mariadb.jdbc.Driver" />
	  <property name="url" value="jdbc:mariadb://127.0.0.1:3306/webdev" />
	  <property name="username" value="webmaster" />
	  <property name="password" value="****" />
	</bean>
	
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
	  <property name="dataSource" ref="dataSource" />
	  <property name="configLocation" value="classpathe:/mybatis-config.xml" />
	  <property name="mapperLocations" value="classpath:mappers/**/*Mapper.xml" />
	</bean>
	
	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate" destroy-method="clearCache">
	  <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"/>
	</bean>
	
</beans>
```
- 위와 같은 클래스들을 스프링빈으로 만들겠다는 뜻.
- 각 id로 호출해서 사용.

### mybatis Mapper 설치


## 스프링 프레임워크 구성
### pom.xml
- Maven 빌드 지원 도구의 설정 파일(자바 버전, 의존성, 외부 라이브러리...)
### root-context.xml
- src/main/webapp/WEB-INF/spring
### mybatis-config.xml
- src/main/resources
- mybatis 설정: 실제 대부분 설정은 스프링 빈 생성시 속성 값으로 설정
### web.xml
- src/main/resources/WEB-INF
- 스프링 작동에 관련한 환경 설정
- 한글 인코딩 필터, 스프링 생성 xml 설정

## 테이블 별 1:1로 맵핑되는 DTO생성