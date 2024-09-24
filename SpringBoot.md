# Spring Boot
- STS 4버전 설치, 자바 17버전
- 상단 메뉴 Help -> Eclipse Marketplace -> web 검색 -> eclipse enterprise Java and Web Developer Tools 설치
- lombok 설치

## Spring Bean
- Singletom Pattern으로 생성된 스프링의 객체
- 스프링이 시작되어 종료될때까지 계속 메모리에 상주하면서 프로그램을 작동시킨다.
- 자바 클래스를 다음과 같은 방법을 거쳐 스프링 빈으로 만든다.
    1. xml 설정 파일에 등록(Spring Framework에서 주로 사용)
        - spring framwork: root-context.xml
    2. @Configuration + @Bean Annotation을 이용
    ```java
    @Configuration
    public class SampleConfiguration {

        @Bean   // 리턴된 객체가 스프링빈으로 생성
        public SampleController sampleController(){
            return new SampleController;
        }
    }
    ```
    3. @Component Annotation 이용
        - spring frameork에서는 xml 설정 파일에 \<context:component-scan base-package="패키지경로" /> 설정 필요.
        - Spring Boot는 생략
        - 보다 세분화된 목적으로 @Controller, @Service, @Repository Annotation을 사용 가능
- Spring IoC(Inversion of Control: 제어의 역전): 스프링 빈을 관리하는 클래스
    - 스프링 빈 보관함
    - ApplicationContext(BeanFactory Interface를 상속받은 구현체) 객체가 Spring이 시작될 때 Spring Bean들을 같이 구동시키면서 IoC 컨테이너에 보관/관리

## 의존성
- 의존성 생성
    - class A, class B가 있을 때 A a = new B();라고 선언
    - A 객체는 B객체와 의존 관계를 갖게 됨.
    - 프로그램 컴파일 과정에서 코드가 생성/메모리 할당

### 의존성 주입(Dependency Injection)
- 생성자 혹은 setter 메서드에서 의존할 객체를 인자로 받는 방식
- 실행 과정에서 코드가 구현되는데 필요한 메모리가 할당
- 의존성 생성보다 메모리 사용에 더욱 동적(Dynamic)이다.


## 프로젝트 시작
- 상단 메뉴 File -> New -> Spring Starter Project
- graddle 설정
    - 가끔 프로젝트 시작시 추가한 버전이 안맞아서 오류가 날 수도 있다.
    - 해당 라이브러리를 mvnrepository.com으로 가서 gradle 추가 문구를 가져와 build.gradle에 추가해야 한다.
    - 추가 한 뒤에는 build.gradle 파일 우클릭->Gradle->Refresh Gradle Project
    - 그래도 오류가 난다면 버전을 바꿔가며 시도

## application.properies 설정
- 이클립스는 복붙하면 오류 발생하는 경우가 있으니 타이핑
```properties
spring.application.name=BoardTest
# DB설정
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver
spring.datasource.url=jdbc:mariadb://localhost:3306/webdev
spring.datasource.username=webmaster
spring.datasource.password=****

# mybatis 설정
mybatis.config-location=classpath:/mybatis-config.xml
mybatis.mapper-locations=classpath:/mappers/**/*Mapper.xml
# ant 표기법
# classpath는 프로젝트 내 src/main/resources를 의미

# 개발 환경 설정
spring.devtools.livereload.enabled=true
spring.thymeleaf.cache=false
```

## mybatis 설정
- src/main/resources 아래에 mappers 폴더 생성
- mappers 우클릭 후 New -> Other...
- XML 안에 XML file 선택
- BoardMapper.xml 생성
- Source에 아래와 같이 작성
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
	PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.board.mapper.BoardMapper">

</mapper>
```
- xml 파일은 특정 태그에 대해 설명하기 위한 파일이다.
- src/main/resources 아래 mybatis-config.xml 생성
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
	PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
	"http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>

</configuration>
```
## Spring Boot 프로젝트 구성
- 아래 구성대로 패키지 생성(controller, dto, mapper, service)
- src/main/java
    - com.board
        - 프로젝트명Application.java
            - 설정파일: DB, WAS설정, 보안, 웹환경설정
        - /controller
            - ***Controller.java: service 프로그램 실행, view로 보내는 역할
        - /dto
            - DB와 1:1로 매칭 시키는 데이터 저장 객체, MVC에서 M(Model)
        - /mapper
            - SQL문을 품고 있는 객체
        - /service
            - SQL문을 품고있는 객체를 실행

### ***DTO.java 생성

### ***Mapper.java 생성

### ***Controller.java 생성

### ***Service.java 생성


### gradlew로 snapshot.jar 생성
- cmd로 workspace -> 프로젝트 폴더로 이동
- $gradlew build 입력
- 프로젝트 폴더에 build 폴더가 생성됨
- 프로젝트>build>lib 폴더에 SNAPSHOT.jar 파일이 생성되어 있음
- 이 파일을 가지고 아무 폴더로 가서 cmd로 $java -jar ***SNAPSHOT.jar 입력
- 스프링이 실행되어 파일 하나로 배포가 됨.