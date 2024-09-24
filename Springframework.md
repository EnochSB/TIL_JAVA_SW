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

### pom.xml 설정
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