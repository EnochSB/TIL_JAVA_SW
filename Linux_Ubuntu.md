# Linux Ubuntu
## 자바 설치
### 저장소 업데이트 및 업그레이드
- $sudo apt update && apt upgrade

### 자바 Open JDK 11버전 설치
- $sudo apt -y install openjdk-11-jdk

### 설치 확인
- $java -version
- $javac -version
- $which java: 자바 실행파일 위치 확인
- /usr/bin/java: 그러나 해당 위치는 심폴릭 링크로 만들어진 가상 위치. 실 경로 파악 필요.


## 여러 버전의 자바 설치
### 버전 전환
- update-alternatives --list java: 설치된 자바 버전들 확인
- 환경 변수 변경
    - .bashrc 내 JAVA_HOME 설정 변경
    - 변경 전: /ust/lib/jvm/java-11-openjdk-amd64
    - 변경 후: $(readlink -f $(whichjava) | sed "s:/bin/java::")
    - Shell Script를 활용한 방법
    - $: String
    - sed "s:~::" : ~문자열을 지우기
    - .bashrc 저장 후 $source .bashrc
- 버전 전환
    - $sudo update-alternatives --config java
    - $sudo update-alternatives --config javac


## OpenSSH 서버 설치
### OpenSSH 서버 설치
- $sudo apt -y install openssh-server
- $sudo systemctl status ssh: 서버 작동 확인
- 이러한 종류를 백그라운드 서비스, 서버 프로그램, 데몬 등이라 지칭

### OpenSSH 클라이언트 설치
- [mobaxterm](https://mobaxterm.mobatek.net/download.html)
- 상단 아이콘 중 Session => SSH 선택
- 가상컴퓨터로 가서 ifconfig로 ip확인(동적이라 종료하면 바뀜)
- 가상컴퓨터로 가지 않더라도 mobaxterm에서 모든 작업 가능

## MariaDB 설치
-use mysql; : mysql이 따로 설치 필요가 없는 시스템 DB

## Samba Client
- 윈도우에서 파일 공유를 위한 프로토콜: NetBeau => 리눅스에서는 Samba
- 보안상 취약점 때문에 막아놓은 회사들이 많다.

## 고정 IP 
- 가상스위치 관리자: Internal Switch 생성

## FTP 서버

## 외부 IP 설정


## shell script
### 파일 관리
- 파일 소유자 변경
    - $ sudo (옵션) chown 사용자명:그룹명 파일명
