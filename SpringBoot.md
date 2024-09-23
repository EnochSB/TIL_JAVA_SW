# Spring Boot
- STS 4버전 설치
- 상단 메뉴 Help -> Eclipse Marketplace -> web 검색 -> eclipse enterprise Java and Web Developer Tools 설치
- lombok 설치
## 프로젝트 시작
- 상단 메뉴 File -> New -> Spring Starter Project
- graddle 설정

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
    PUBLIC "-//mybatis.org//DTD 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>

</configuration>
```
## Spring Boot 프로젝트 구성
- src/main/java
    - com.board
        - 프로젝트명Application.java
            - 설정파일:
        - /controller
        - /dto
        - /mapper
        - /service