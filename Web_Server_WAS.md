# Web Server WAS
## 네트워크 개요
### Packet
### OSI 7 및 TCP/IP
    - 포트: 응용프로그램을 구분할 수 있게 해준다.
### 이더넷과 인터넷
## IP 주소 체계(IPv4)
- 127.0.0.1을 사용하면 바로 본인 PC의 네트워크에서 찾기 때문에 효율적.


## Apache Web Server
### 설치 구성
- 다운로드: [아파치라운지](apachelounge.com)
- 아파치 환경설정
    - 아파치 설치 경로 -> Apache24\conf -> httpd.conf 열기
    - 서버 루트 확인: Define SRVROOT "c:/Apache24"
    - 서버 네임 변경: ServerName 127.0.0.1
    - 다큐멘트 루트 폴더 생성(폴더명 webroot)
    - 다큐멘트 루트 변경
        - DocumentRoot "c:/webroot"
        - <Directory "c:/webroot">

### 아파치 실행
- 관리자 권한으로 cmd 실행
- 아파치 실행 파일(httpd.exe) 위치로 이동: c:\...\Apache24\bin
- httpd -k intall 입력: 윈도우 서비스에 아파치 등록
- httpd -k restart: 서비스 시작
- httpd -k stop: 서비스 종료
- httpd -version: 버전 확인
- 서비스 -> Apache2.4 더블클릭 -> 시작유형: 수동

## Apache tomcat
### 설치 구성
- 다운로드: [톰캣](https://tomcat.apache.org/)
- 톰캣 환경설정
    - c:\apache-tomcat-10.1.6\conf\server.xml 파일 수정
    ```xml
    <Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">

	    <Context path="/" docBase= "c:/webroot" unpackWARs="true" reloadable="true" />
    ```
- 환경 변수 추가 / CLASSPATH 수정
    - CATALINA_HOME, CATALINA_BASE 생성 후 변수 값: C\apache-tomcat-10.1.6
    - CATALINA_TMPDIR 생성 후: %CATALINA_HOME%\temp
    - CLASSPATH: %CATALINA_HOME%\lib\servlet-api.jar 추가
- 톰캣 시작/중지
    - 시작: C:\apache-tomcat-10.1.6\bin\startup 실행
    - 중지: C:\apache-tomcat-10.1.6\bin\shutdown 실행

## Servlet/JSP
|구분|JSP 태그|용도|
|-|-|-|
|지시자|<%@  %>|페이지 속성 지정|
|주석|<%--  --%>|주석 처리|
|선언|<%!  %>|변수, 메소드 처리|
|표현식|<%=  %>|결과값 출력|
|스크립트립|<%  %>|JAVA 코드 삽입|
|액션 태그|<jsp:action></jsp:action>|페이지 삽입, 공유. 자바빈 사용 등|

```java
package servlet;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/servlet/hostInfo")    // URL 경로
public class Hostinfo extends HttpServlet { // 추상 클래스 HttpServlet을 상속

    // doGet, doPost 2개의 메서드를 오버라이드 해서 사용.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<HTML><HEAD><TITLE>HelloServlet</TITLE></HEAD>");
        out.println("<BODY>");
        out.println("<h>안녕하세요? 서블릿 테스트 예제입니다.</h2>");
        out.println("<H2> Clinet IP: " + request.getRemoteAddr() + "</H2>");
        out.println("<H2> Client Host : " + request.getRemoteHost() + "</H2>");
        out.println("<H2> Request URI : " + request.getRequestURI() + "</H2>");
        out.println("</BODY></HTML>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response){

    }
}

// IDE의 JAVA PROJECTS의 Referenced Libraries를 통해 C:\apache-tomcat-10.1.6\lib\servlet-api.jar 추가
```
### 디렉토리 및 환경 설정 파일
1. 서블릿 디렉토리 생성
    - c:\webroot 폴더에 WEB-INF 폴더 생성
    - WEB-INF 아래에 classes, lib, src 폴더 생성
    ![디렉토리](/images/image74.png)

## Web Server/WAS 연동
- WAS(톰캣)에는 별도의 Web Server가 있지만 트래픽 분산과 3-tier 구조를 갖추기 위해 기능을 분리해 연동하는 것이 좋다.
### 연동 방식
1. mod_jk 모듈(mod_jk.so) 방식
    - Apache와 Tomcat 연동 만을 위한 전용 방식
    - JkMount 옵션을 이용하여 URL이나 컨텐츠별로 유연한 설정 가능
2. mod_proxy 방식
3. mod_proxy_ajp 방식

### mod_jk 모듈 사용
1. [아파치 라운지](https://www.apachelounge.com/download/)에서 mod_jk 모듈 다운
2. mod_jk.so파일을 c:\Apache24\modules 폴더로 복사
3. c:\Apache24\conf\에 workers.properties 파일 생성 후 아래 내용 작성
    ```txt
    c:\Apache24\conf\workers.properties
    worker.list=study
    worker.study.type=ajp13
    worker.study.host=localhost
    worker.study.port=8009
    ```
4. c:\Apache24\conf\httpd.conf 파일에 아래 내용 작성
    ``txt
    # mod_jk 설정
    LoadModule jk_module modules/mod_jk.so
    JkworkersFile conf/workers.properties
    JkMount /* study
    JkLogFile logs/mod_jk.log
    JkLogLevel ifo
    JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
    JkRequestLogFormat "%w %V %T"
    ```
5. c:\apache-tomcat-10.1.6\conf 내 server.xml에서 AJP(Apache JServ Protocol) 설정 부분 주석 해제 및 구문 추가
    ```txt
    <!-- Define an AJP 1.3 Connector on port 8009 -->

    <Connector protocol="AJP/1.3"
               address="127.0.0.1"
               port="8009"
               redirectPort="8443"
	           secretRequired="false" />
    ```

## 테스트 도메인 생성
- 메모장을 관리자권한으로 열고 C:\Windows\System32\drivers\etc 위치의 hosts파일 열기
- 127.0.0.1 www.boardservlet.com (예시) 작성
- c:\Apache24\conf\httpd.conf 파일에 아래 문구 주석 해제
    ```txt
    # mod_proxy를 사용하여 reverse proxy로 연결
    LoadModule proxy_module modules/mod_proxy.so
    LoadModule proxy_http_module modules/mod_proxy_http.so

    # Virtual hosts 설정
    Include conf/extra/httpd-vhosts.conf
    ```
- c:\Apache24\conf\extra 내 httpd-vhosts.conf 파일에 아래 추가
    ```txt
    <VirtualHost *:80>
        DocumentRoot "c:/webroot_boardservlet"
        ServerName boardservlet.com
        ServerAlias www.boardservlet.com
        ErrorLog "logs/www.boardservlet.com-error.log"
        CustomLog "logs/www.boardservlet.com-access.log" combined
        # Forward Proxy: On, Reverse Proxy: Off
        ProxyRequests Off
        ProxyPreserveHost On
        ProxyPass / http://127.0.0.1:8080/
        ProxypassReverse / http://127.0.0.1:8080/
        JkMount /* study/
    </VirtualHost>
    ```
    - DocumentRoot에 해당하는 폴더 생성
- 톰캣 환경 수정 (C:\apache-tomcat-10.1.6\conf\server.xml) 아래 내용 추가
    ```txt
        <Host name="www.boardservlet.com"  appBase="webapps"
                unpackWARs="true" autoDeploy="true">
        <Context path="/" docBase= "c:/webroot_boardservlet" unpackWARs="true" reloadable="true" />

            <!-- SingleSignOn valve, share authentication between web applications
                Documentation at: /docs/config/valve.html -->
            <!--
            <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
            -->

            <!-- Access log processes all example.
                Documentation at: /docs/config/valve.html
                Note: The pattern used is equivalent to using pattern="common" -->
            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                prefix="localhost_access_log" suffix=".txt"
                pattern="%h %l %u %t &quot;%r&quot; %s %b" />

        </Host>
    ```
    - 기존 localhost에서 Host name, docBase만 변경해서 추가한 것.