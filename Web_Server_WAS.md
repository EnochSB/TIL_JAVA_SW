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
- 3-tier: webserver-WAS-DBMS로 구성된 웹서비스의 기본 아키텍처

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
    ```properties
    # c:\Apache24\conf\workers.properties
    worker.list=study
    worker.study.type=ajp13
    worker.study.host=localhost
    worker.study.port=8009
    ```
    - worker.list=study에서 worker의 이름인 "study"는 임의로 작성 가능. 그 이후로 통일 필요.
    - ajp13: 아파치 웹서버와 아파치 톰캣 WAS 간의 연동을 위한 프로토콜(Apache Jserv Protocol ver1.3)
4. c:\Apache24\conf\httpd.conf 파일에 아래 내용 작성
    ```conf
    # mod_jk 설정
    # c:\Apache24\conf\httpd.conf
    LoadModule jk_module modules/mod_jk.so
    JkworkersFile conf/workers.properties
    JkMount /* study
    JkLogFile logs/mod_jk.log
    JkLogLevel ifo
    JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
    JkRequestLogFormat "%w %V %T"
    ```
5. c:\apache-tomcat-10.1.6\conf 내 server.xml에서 AJP(Apache JServ Protocol) 설정 부분 주석 해제 및 구문 추가
    ```xml
    <!-- Define an AJP 1.3 Connector on port 8009 -->

    <Connector protocol="AJP/1.3"
               address="127.0.0.1"
               port="8009"
               redirectPort="8443"
	           secretRequired="false" />
    ```

## 가상 호스팅(Virtual Hosting)
- 기존의 호스팅: H/W, N/W를 갖춘 IDC(Internet Data Center)에서 장소(상면)와 네트워크를 제공
- ASP(Application Service Provider): Saas와 유사한 방식으로 S/W 임대
- 가상 호스팅: 한 대의 H/W에 웹서버 프로그램을 설치하고 거기에서 여러 개의 웹서비스를 구현
- 예: 여러 개의 사이트를 하나의 서버에서 운영 => 비용 절감

### 가상 호스팅-테스트 도메인 생성
- 메모장을 관리자권한으로 열고 C:\Windows\System32\drivers\etc 위치의 hosts파일 열기
- 127.0.0.1 www.boardservlet.com (예시) 작성
- c:\Apache24\conf\httpd.conf 파일에 아래 문구 주석 해제
    ```conf
    # mod_proxy를 사용하여 reverse proxy로 연결
    LoadModule proxy_module modules/mod_proxy.so
    LoadModule proxy_http_module modules/mod_proxy_http.so

    # Virtual hosts 설정
    Include conf/extra/httpd-vhosts.conf
    ```
- c:\Apache24\conf\extra 내 httpd-vhosts.conf 파일에 아래 추가
    ```conf
    <VirtualHost *:80>
        DocumentRoot "c:/webroot_boardservlet"
        ServerName boardservlet.com
        ServerAlias www.boardservlet.com
        ErrorLog "logs/www.boardservlet.com-error.log"
        CustomLog "logs/www.boardservlet.com-access.log" combined
        # On: Forward Proxy, Off: Reverse Proxy
        ProxyRequests Off
        # Web Server에 요청이 오면 Proxy 서버로 요청을 전달
        ProxyPreserveHost On
        ProxyPass / http://127.0.0.1:8080/
        ProxypassReverse / http://127.0.0.1:8080/
        JkMount /* study
    </VirtualHost>

    # ROOT.war로 배포할 경우
    <VirtualHost *:80>
        DocumentRoot "c:/webroot_boardservlet/ROOT"
        ServerName boardservlet.com
        ServerAlias www.boardservlet.com
        ErrorLog "logs/www.boardservlet.com-error.log"
        CustomLog "logs/www.boardservlet.com-access.log" combined
        # On: Forward Proxy, Off: Reverse Proxy
        ProxyRequests Off
        # Web Server에 요청이 오면 Proxy 서버로 요청을 전달
        ProxyPreserveHost On
        ProxyPass / http://127.0.0.1:8080/
        ProxypassReverse / http://127.0.0.1:8080/
        JkMount /* study
    </VirtualHost>
    ```
    - DocumentRoot에 해당하는 폴더 생성 후 기존 webroot에 있던 프로젝트 옮기기
- 톰캣 환경 수정 (C:\apache-tomcat-10.1.6\conf\server.xml) 아래 내용 추가
    ```xml
        <Host name="www.boardservlet.com"  appBase="webapps"
                unpackWARs="true" autoDeploy="true">
        <Context path="/" docBase= "c:/webroot_boardservlet" unpackWARs="true" reloadable="true" />

            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                prefix="localhost_access_log" suffix=".txt"
                pattern="%h %l %u %t &quot;%r&quot; %s %b" />

        </Host>
        <!-- 혹은 -->
        <Host name="www.boardservlet.com"  appBase="c:/webroot_boardservlet"
                unpackWARs="true" autoDeploy="true">

            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                prefix="localhost_access_log" suffix=".txt"
                pattern="%h %l %u %t &quot;%r&quot; %s %b" />

        </Host>
    ```
    - 기존 localhost에서 Host name, docBase만 변경해서 추가한 것.
- 위와 같이 설정한 후 톰캣과 아파치 서버를 켠 뒤 브라우저에서 www.boardservlet.com에 접속 가능

## Load Balancing / Session Cluster (부하 분산)
- H/W에서: Switch 장비로 사용자의 요청들을 여러 장비로 분산 처리
- S/W
    - WAS: 멀티 인스턴스를 생성
    - 여러 개의 Tomcat Engine이 여러 개의 자바 애플리케이션을 실행

### 멀티 인스턴스 설정
1. 인스턴스용 디렉토리 생성
    - C:\apache-tomcat-10.1.6 아래에 lb01, lb02 디렉토리 생성
2. 인스턴스용 디렉토리 구성
    - lb01, lb02에 C:\apache-tomcat-10.1.6 내에 conf, lib를 복사해 붙여넣기
    - lb01, lb02 아래
        - bin, logs, work, temp 디렉토리 생성
        - bin 디렉토리에 startup_lb01.bat, shutdown_lb01.bat 생성, lb02도 똑같이.
        ```bat
        # c:\apache-tomcat-10.1.6\lb01\bin\startup_lb01.bat
        @echo off
        set JAVA_HOME=C:\JDK\jdk-17.0.6
        set CATALINA_HOME=C:\apache-tomcat-10.1.6
        set CATALINA_BASE=%CATALINA_HOME%\lb01
        %CATALINA_HOME%\bin\startup.bat
        ```
        ```bat
        # c:\apache-tomcat-10.1.6\lb01\bin\shutdown_lb01.bat
        @echo off
        set JAVA_HOME=C:\JDK\jdk-17.0.6
        set CATALINA_HOME=C:\apache-tomcat-10.1.6
        set CATALINA_BASE=%CATALINA_HOME%\lb01
        %CATALINA_HOME%\bin\shutdown.bat
        ```
        - conf 디렉토리의 server.xml 파일 수정: 포트가 겹치지 않도록
        ```xml
        <!--lb01/conf/server.xml-->
        <?xml version="1.0" encoding="UTF-8"?>
        <!--port 변경 lb02:8025-->
        <Server port="8015" shutdown="SHUTDOWN">
        <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
        <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
        <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
        <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
        <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

        <GlobalNamingResources>
            <Resource name="UserDatabase" auth="Container"
                    type="org.apache.catalina.UserDatabase"
                    description="User database that can be updated and saved"
                    factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                    pathname="conf/tomcat-users.xml" />
        </GlobalNamingResources>

        <Service name="Catalina">
            <!--port 변경, redirectPort 변경 lb02: 8082, 8463-->
            <Connector port="8081" protocol="HTTP/1.1"
                    connectionTimeout="20000"
                    redirectPort="8453" />
            <!--port 변경, redirectPort 변경 lb02: 8029, 8463-->
            <Connector protocol="AJP/1.3"
                    address="127.0.0.1"
                    port="8019"
                    redirectPort="8453"
            secretRequired="false" />


            <Engine name="Catalina" defaultHost="localhost">
            <!--Clustering 주석 해제-->
            <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
            <Realm className="org.apache.catalina.realm.LockOutRealm">
                <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                    resourceName="UserDatabase"/>
            </Realm>
            <!--docBase 변경 lb02: c:/webroot_lb02-->
            <Host name="localhost"  appBase="webapps"
                    unpackWARs="true" autoDeploy="true">
            <Context path="/" docBase= "c:/webroot_lb01" unpackWARs="true" reloadable="true" />

                <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                    prefix="localhost_access_log" suffix=".txt"
                    pattern="%h %l %u %t &quot;%r&quot; %s %b" />
            </Host>

            </Engine>
        </Service>
        </Server>
        ```
        - docBase로 설정한 webroot_lb01과 webroot_lb02를 생성하고 각각 index.jsp, WEB-INF생성
3. 로드밸런싱 설정
    - webroot_lb01, webroot_lb02 아래
        - index.jsp
        - WEB-INF
            - classes
            - lib
            - web.xml
            ```xml
              </description>
              <distributable/>

            </web-app>
            ```
            - 문서 제일 아래 \<distribubale/> 문구 추가
    - Apache 웹서버 설정
        - worker.properties 수정
        ```properties
        worker.list=study,router
        worker.study.type=ajp13
        worker.study.host=localhost
        worker.study.port=8009

        worker.router.type=lb
        worker.router.sticky_session=true
        worker.router.balance_workers=lb01,lb02
        worker.lb01.type=ajp13
        worker.lb01.host=www.lb.com
        worker.lb01.port=8019
        worker.lb01.lbfactor=1
        worker.lb02.type=ajp13
        worker.lb02.host=www.lb.com
        worker.lb02.port=8029
        worker.lb02.lbfactor=1
        ```
        - httpd-vhosts.conf 아래 내용 추가
        ```conf
        <VirtualHost *:80>
            DocumentRoot "c:/webroot_lb01"
            ServerName lb.com
            ServerAlias www.lb.com
            ErrorLog "logs/www.lb.com-error.log"
            CustomLog "logs/www.lb.com-access.log" combined
            JkMount /* router
        </VirtualHost>
        ```
- 위와 같이 설정하고 톰캣과 아파치서버를 연 뒤 브라우저에서 www.lb.com에 접속
- 새로고침을 계속 하면 서버가 lb01와 lb02 중에서 계속 바뀜을 알 수 있다.

4. 세션 클러스터링(Session Clustering)
- 사용자가 여러 서버를 통해 접속하더라도 세션 정보를 저장하고 서버끼리 공유해서 같은 서비스를 체험할 수 있게 함.
- 톰캣: conf 디렉토리의 server.xml
```xml
<Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
```
- 위 문구를 주석 해제해서 설정 가능.
- webroot_lb01, webroot_lb02 아래 index.jsp
```jsp
<!--c:\webroot_lb01\index.jsp-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>​
<HTML>​
<%
    // 세션 생성해서 서버에 저장
    session.setAttribute("username", "홍길동");
%>
<BODY>​
    <h1>lb01 인스턴스</h1>
    <h1>세션 확인 : <%=(String)session.getAttribute("username")%></h1>
    서버 버전 : <%=application.getServerInfo() %><br>​
    서블릿 버전 : <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br>​
    JSP 버전 : <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>​
</BODY>​
</HTML>
```
```jsp
<!--c:\webroot_lb02\index.jsp-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>​
<HTML>​
<BODY>​
    <h1>lb02 인스턴스</h1>
    <h1>세션 확인 : <%=(String)session.getAttribute("username")%></h1>
    서버 버전 : <%=application.getServerInfo() %><br>​
    서블릿 버전 : <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br>​
    JSP 버전 : <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>​
</BODY>​
</HTML>
```
- lb01에서만 사용자의 세션 정보를 저장했지만 lb02에서도 사용할 수 있음을 알 수 있다.

## TLS/HTTP2
### SSL/TLS
- 방문한 웹사이트의 위험 여부를 판단하고 서버와 클라이언트 사이에 암호화 된 통신을 하기 위해서는 HTTPS 통신 필요
- HTTPS 기반 웹서비스를 하기 위해서는 서버 운영기관에서 **인증기관(CA)**에 해당 사이트가 누구의 소유이고, 누가 만든 것인지 등 정보를 제공한 후 CA로부터 웹서비스 운영기관의 신원을 보증 받을 수 있는 디지털 인증서를 구입하여 웹서버에 설치해야 한다.
- SSL: HTTPS 서비스를 운영하기 위한 기반 기술.
- TLS: SSL 3.0을 국제 표준화 기구에서 새로 정립한 것. TLS 1.0 = SSL 3.0.
- TLS는 암호화 통신을 위해 대칭키, 비대칭키 방식을 혼용. 서버인증(Server Authentication), 클라이언트인증(Client Authentication), 데이터 암호화(Data Encryption) 기능 제공

### OPENSSL 설정
- OPENSSL: 디지털 인증서 발급을 위한 오픈소스 라이브러리, openssl 1.0.2부터 ALPN을 지원.
- ALPN(Application-Layer Protocol Negotiation): HTTP/2를 사용하기 위한 TLS의 확장 프로토콜 규약
- 브라우저는 ALPN을 지원하지 않으면 HTTP/2 통신을 하지 않고 HTTP/1.1로 강제 통신
1. [opnssl사이트](https://sourceforge.net/projects/openssl/)에서 OPENSSL 다운로드
2. C 드라이브 하위에 압축 해제
3. 환경변수 추가
    - OPENSSL_CONF: C:\OpenSSL\bin\openssl.cnf
4. C:\OpenSSL\bin\openssl.exe 실행
5. OpenSSL 콘솔 화면에서 아래 내용 실행
    - 비밀번호 있는 개인키 설정(생략): 공인인증서의 경우 비밀번호가 필요하지만, https의 ssl인증서에는 서비스 등록 때마다 비밀번호 입력이 필요한 방법은 필요 없다.
        - OpenSSL> genrsa -des3 -out private.pem 2048
    - <U>비밀번호 없는 개인키 생성</U>
        - **OpenSSL> gensra -out private.key 2048**
    - 개인키와 쌍이 되는 공개키 생성
        - OpenSSL> rsa -in privatekey.key -pubout -out public.key
    - <U>CSR(Certificate Signing Request: 인증발급요청서) 생성</U>
        - **OpenSSL> req -new -key private.key -out private.csr**
    - 나만의 사설 CA에서 인증까지 받은 인증서 만들기(생략가능)
        - 사설 인증서 서명키 생성: OpenSSL> genrsa -aes256 -out rootCA.key 2048
        - 사설 인증서 서명키를 이용해 사설 인증발급요청서 생성: OpenSSL> req -x509 -new -nodes -key rootCA.key -days 3650 -out rootCA.pem
        - 사설 인증서 생성: OpenSSL> x509 -req -in private.csr -CA rootCA.pem -CAkey rooCA.key -CAcreateserial -out private.crt -days 3650
    - <U>사설 CA이용 안했을 때 인증서 생성</U>
        - **OpenSSL> req -new -x509 -days 3650 -in private.csr -key private.key -out private.crt**
    - Tomcat에 SSL/TLS 적용시
        - Tomcat용 인증서 생성: OpenSSL> pkcs12 -export -in private.crt -inkey private.key -out .keystore -name tomcat

### HTTPS 통신을 위한 Handshake 절차
![handshake](/images/image72.png)
1. 서버 측에서는 OPENSSL을 이용해 서버에 대한 정보와 인증 등이 담긴 인증서와, 공개키(비대칭키)를 인증기관(CA)에 등록
2. 클라이언트가 등록되어져 있는 공개키(비대칭키)로 공통키(대칭키)를 암호화하여 서버 측에 전송. 서버 측에서는 클라이언트에서 전송된 암호(공통키로 암호화된)를 개인키(비대칭키)를 사용하여 복호화된 공통키를 획득
3. 서버 및 클라이언트는 공통키를 사용하여 보안 통신을 수행

- **비대칭키(공개키)**: 공개키(Public Key), 개인키(Private Key)로 나누어지며, 공개키로 암호화를 하고 개인키로 복호화. 개인키가 분실되지 않는 한 안전하지만, 부하를 유발하는 단점. **개인키는 서버측에서 관리하고, 공개키는 인증기기관에 등록. 이러한 키 관리 기능이 웹브라우저 보안기능에 내장되어 있다.**
- **대칭키(공통키)**: 암호화 및 복호화 시 사용하는 키가 동일하기 때문에 암호문을 주고 받는 대상간에 동일한 키를 보유. 
- **RSA**: 현재 SSL/TLS에 가장 많이 사용되는 **비대칭형 공개키 암호화 알고리즘**. 전세계 대부분의 인터넷 뱅킹이 이 RSA-2048 암호화를 사용. 공개키와 개인키가 한 쌍을 이루며, 공개키로 암호화한 내용은 개인키로만, 개인키로 암호화한 내용은 공개키로만 복호화. 1977년 이 알고리즘을 개발한 Ron Rivert, Adi Shamir, Leonard Adelman 세 사람의 성을 따서 RSA.
- **3DES**: 미국 상무국 표준국(NIST)이 1997년에 IBM사의 제안을 바탕으로 제정한 **대칭형 데이터 암호화 표준 규격** DES(**Data Encrytion Standard**: 평문(Plain Text)을 64비트로 나누고 그 중 56비트를 이용해 64비트 암호문 생성)을 각 데이터 블로게 세 번 적용한 트리플 데이터 암호화 알고리즘.(암호화->복호화->암호화)
- **AES(Advanced Encryption Standard Alorithm)**: DES의 안정성 문제로 1998년에 차세대 **대칭형 븡록 암호 알고리즘**으로 개발. 입력 평문 길이를 128비트로 고정하고 사용하는 암호화 키 길이를 128/192/256비트 중에서 선택.
- **Hash**: 복호화가 불가능하도록 암호화 하는 것. 암호화된 값은 **다이제스트(Digest)**. 복호화가 안되지만 동일한 입력에 대해서는 동일한 입력값이 나오기 때문에 동일한 평문에 Salt(임의 값)을 추가하여 암호화를 진행. MDS(Message Digest), SHA(Secure Hash Algorithm)

### SSL 인증서 파일 포맷
- .pem: PEM(Privacy Enhanced Mail). Base64 인코딩된 ASCII 텍스트. 파일 구분 확장자로 .pem을 주로 사용. 노트패드에서 열기/수정도 가능. 개인키, 서버인증서, 루트인증서, 체인인증서 및  SSL 발급 요청시 생성하는 CSR 등에 사용되는 포맷이며, 가장 광범위하고 거의 99% 대부분의 시스템에 호환되는 산업 표준 포맷.(대부분 텍스트 파일)​
- .crt: 거의 대부분 PEM 포맷. 주로 유닉스/리눅스 기반 시스템에서 인증서 파일임을 구분하기 위해 사용하는 확장자. .cer도 사용됨. 노트패드로 열었을 때 PEM 포맷인지 바이너리 포맷인지 바로 알 수 있지만 99%는 Base64 PEM 포맷.(대부분 텍스 타입)
- .cer: crt와 같은 역할.
- .csr: Certificate Signing Request. 거의 대부분 PEM 포맷. SSL 발급 신청을 
- .der: Dishtinguished Encoding Representation(DER). 바이너리 포맷. 노트패드 등으로 열어도 알아 볼 수 없다. 바이너리 인코딩 포맷을 읽을 수 잇는 인증서 라이브러리로 확인 가능.사설 또는 금융 등 특수 분야 및 아주 오래된 구형 시스템을 제외하고는 최근 웹서버 SSL 작동 시스템 에서는 흔히 사용되는 포맷은 아니다.(바이너리 이진 파일)
- .pfx / .p12: PKCS#12 바이너리 포맷. Personal Information Exchange Format. 주로 Windows IIS기반의 인증서 적용/이동시 활용. 장점은 개인키, 서버인증서, 루트인증서, 체인인증서를 모두 담을 수 있어 SSL 인증서 적용이나 이전시 상당히 유용하고 편리. Tomcat 등 요즘에는 pfx 설정을 지원하는 서버가 증가하는 추세(바이너리 이진 파일)
- .key: 주로 openssl 및 java에서 개인키 파일임을 구분하기 위해 사용되는 확장자. PEM 포맷 혹은 DER 바이너리 포맷. 열어봐야 확인 가능. 저장할 때 어떤 포맷으로 했는지에 따라 다르며 확장자는 붙이기 나름.
-. jks: Java Key Store. Java 기반 독자 인증서 바이너리 포맷. pfx와 마찬가지로 개인키, 서버인증서, 루트인증서, 체인인증서를 모두 담을 수 있어 SSL 인증서 파일 관리 시 유용. Tomcat에서 SSL 적용 시 가장 많이 사용되는 포맷.(바이너리 이진 파일)

### 아파치 톰캣만으로 웹서비스를 할 경우
- server.xml 주석 해제 후 아래와 같이 변경
    ```xml
    <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"​
                maxThreads="150" SSLEnabled="true">​

            <UpgradeProtocol className="org.apache.coyote.http2.Http2Protocol" />  <!--http/2 사용-->​

            <SSLHostConfig>​                                 <!--SSL/TLS 인증-->
                <Certificate certificateKeystoreFile="c:/OpenS니/bin/.keystore"
                        certificateKeystorePassword="12345"​
                        type="RSA"​
                />​
            </SSLHostConfig>​
    </Connector>
    ```

### 아파치 설정
- httpd.conf 설정
    - include conf/extra/httpd-ssl.conf 주석 제거
    - LoadModule ssl_module modules/mod_ssl.so 주석 제거
    - LoadModule socache_shmcb_module modules/mod_socache_shmcb.so 주석 제거
- httpd-ssl.conf 설정
    - VirtualHost 설정 변경
        - DocumentRoot "c:/webroot" 수정
        - ServerName 127.0.0.1:443 수정
        - JkMount /* study 추가
        - SSLCertificateFile "C:/OpenSSL/bin/server.crt" --> 인증서 경로 수정
        - SSLCertificateKeyFile "C:/OpenSSL/bin/server.key" --> 개인키 경로 수정
- HTTP/2 설정
    - httpd.conf
        - LoadModule http2_module modules/mod_http2.so  --> 주석 제거
        - 아래 구문 추가
        ```conf
        <IfModule http2_module>
          ProtocolsHonorOrder On
          Protocols h2 h2c http/1.1 // h2, h2c 프로토콜이 안되면 1.1로 가라
        </IfModule>
        ```
    - h2c: 웹브라우저 외에 서버에 접근하는 방법
    - HTTP/2는 TLS 위에서 동작하는 h2와 cleartext TCP 위에 동작하는 h2c로 구분.
    - 대부분의 웹 브라우저는 TLS위에서 동작하는 h2만을 지원.
    - h2c를 지원하는 것으로는 curl 등. h2는 TLS 1.2 이상에서 작동