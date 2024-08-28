# JAVA cmd
## Java cmd로 시작
- 폴더 생성 후 이동
```cmd
C:\>mkdir JavaTest

C:\>cd JavaTest
```
```java
// C:\JavaTest\HelloWorld.java
// 메모장으로 작성
class HelloWorld {
    public static void main(String[] argv){
        System.out.println("Hello World!");
    }
}
```
- javac 명령어로 java 소스코드를 컴파일 => 자바 바이트 코드(.class)로 변환후 파일 생성
```cmd
C:\JavaTest\>javac HelloWorld.java

C:\JavaTest\>dir

2024-08-28  오후 02:57    <DIR>          .
2024-08-28  오후 02:57    <DIR>          ..
2024-08-28  오후 02:57               443 HelloWorld.class
2024-08-28  오후 01:18               149 HelloWorld.java
               2개 파일                 592 바이트
               2개 디렉터리  931,381,882,880 바이트 남음
```
- java 명령어로 자바 바이트 코드 파일을 실행. 파일명만 작성(.class는 작성X)
```cmd
C:\JavaTest\>java HelloWorld
Hello World!
```
- java는 기본적으로 영어만 인식하고 그 외 언어가 나올 시 에러.
```java
// C:\JavaTest\HelloWorld.java
// Hello World를 한글로 변경
class HelloWorld {
    public static void main(String[] argv){
        System.out.println("안녕하세요");
    }
}
```
- IDE에서는 자동으로 인코딩을 하지만 cmd에서는 "-encoding UTF8" 명령어를 추가해서 인코딩.
```cmd
C:\JavaTest\>javac -encoding UTF8 HelloWorld.java
```
- 소스코드 디렉토리와 클래스 디렉토리 나누기
```cmd
C:\MySource\JavaTest>tree
C:.
├─classes
└─src

C:\MySource\JavaTest\src>javac -d ../classes -encoding UTF8 HelloWorld.java
```
- -d 명령어로 class가 생길 디렉토리를 지정
- 패키지 설정: 코드 제일 위에 작성. 팀마다 정해진 규칙에 의해 작성.
```java
// C:\JavaTest\src\HelloWorld.java
// 
package com.test.java;

class HelloWorld {
    public static void main(String[] argv){
        System.out.println("안녕하세요");
    }
}
```
```cmd
C:\MySource\JavaTest\src>javac -encoding UTF8 HelloWrold.java
C:\MySource\JavaTest>tree
C:.
├─classes
│  └─com
│      └─test
│          └─java
└─src
```
- 패키지를 이용하면 쉽게 바이트 코드 파일들을 한 곳에 모을 수가 있다.
## cmd 명령어 모음
- mkdir
- cd
- dir
- del
- tree