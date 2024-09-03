# Web Server WAS
## Apache Web Server
### 설치 구성
- 다운로드: apachelounge.com
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
