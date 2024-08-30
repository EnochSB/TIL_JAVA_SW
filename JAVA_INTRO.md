# JAVA INTRO
## JAVA PLATFORM
### 자바 플랫폼 소개
![img](/images/image18.png)
- 자바 플랫폼: Java 언어로 프로그램을 작성/실행하기 위한 소프트웨어 또는 프로그램 모음
- Java Compiler(JAVAC)
    - 텍스트로 구성된 Java Source파일을 JVM이 해석할 수 있는 Java Byte Code(.class)로 변환
    - **Java Byte Code**: 컴파일러에 의해 변환된 코드의 각 명령어 크기가 1바이트라서 자바 바이트 코드라 명명
- Java Virtual Machine(JVM)
    - 자바 가상 머신: Java 클래스 파일을 로드/해석, 메모리 툴의 자원을 할당/관리, 정보를 처리하는 작업을 하는 프로그램
    - **Class Loader**: JVM 내에 class파일들을 Load, Load된 클래스들을 Runtime Data Area에 배치
    - **Execution Engine**: Load 된 클래스의 Bytecode를 JIT(Just-In-Time) 컴파일러를 사용해 네이티브 기계어 코드로 변환
- Garbage Collector
    - 사용하지 않는 메모리를 청소하는 역할(Managed Language)
    - C언어(3세대 언어)는 사용자가 직접 메모리를 할당하고 삭제했어야 했다.(Unmanaged Language)
- Library
    - 자바 클래스 파일을 JAR(Java Archive)라는 압축형태의 파일로 묶여서 배포
- Runtime Data Area
    - Method Area
        - 모든 Tread에게 공유되며. 클래스, 변수 , Method, static변수, 상수 정보 등이 저장되는 영역
    - Heap Area
        - 모든 Thread에게 공유되며, new 명령어로 생성된 인스턴스와 객체가 저장되는 구역으로 공간이 부족해지면 Garbage Collection이 실행.​
    - Stack Area
        - 각 스레드마다 하나씩 생성되며, Method안에서 사용되는 값들(매개변수, 지역변수, 리턴 값 등)이 저장되는 구역으로,  메서드가 호출될 때 LIFO로 하나씩 생성되고, 메서드 실행이 완료되면 LIFO로 하나씩 삭제​
    - PC Register
        - 각 스레드마다 하나씩 생성되며, 현재 수행 중인 JVM명령의 주소 값이 저장
    - Native Method Stack
        - 각 스레드마다 하나씩 생성되며, 다른 언어(C/C++ 등)의 메서드 호출을 위해 할당되는 구역으로 JNI(Java Native Interface)라는 표준 규약을 제공

### JDK
- JRE(Java Runtime Environment): 자바 컴파일러로 컴파일 된 클래스 파일을 자바 가상 머신으로 실행할 때 필요한 프로그램과 라이브러리 포함(Java 8 버전까지만 존재)
- JDK(Java Development Kit): Java 컴파일러, Java 디버거 및 기타 핵심 클래스와 함께 JRE가 포함(자바 응용프로그램 개발에 사용)
- 설치
    - Oracle의 홈페이지에 들어가서 OS에 맞는 JDK를 다운로드
    - LTS(long-term support)버전을 다운로드 하는 것을 추천
- 환경변수
    - 고급 시스템 설정 -> 환경변수
    - JAVA_HOME: jdk 설치 경로
        - ex. C:\JDK\jdk-17.0.6
        - IDE만을 사용할 경우 JAVA_HOME만 설정해도 무관
    - CLASSPATH: 클래스가 모이는 경로
        - ex. %JAVA_HOME%\lib;.;
        - .은 사용자가 생성한 클래스들을 가르킴
    - Path: JDK 실행 파일 경로를 추가
        - %JAVA_HOME%\bin;​

## Java 언어 구조
```java
package com.test.example; // 패키지 설정: 연관된 객체(class, interface)들을 그룹화하는 명령어로 물리적으로는 디렉토리를 의미

import java.util.Scanner;   // import: 패키지로 구성된 자바 라이브러리 내의 자바 클래스를 가져옴

public class JavaStructure {    // 클래스 선언 및 시작
    
    public static int sum(int a, int b){    // 메소드
        return a + b;
    }

    public static void main(String[] argv){ //Main() 메소드: 자바 Application의 Entry Point로 컴파일 시 정의, 호출하는 메소드 역시 static이어야함.
        // 멤버 변수 선언 및 초기화
        int i = 10;
        long l_value = 10L;
        double d_value = 10;
        float f_value = 10f;
        int j;
        char a;

        i = sum(i, 10);
        a = '가';

    }   // main 메소드 종료
}   // 클래스 종료
```
- 자바 프로젝트 구성
    - Work Space: 프로젝트의 모음
        - Project: 하나의 실행파일을 생성하기 위한 단위
            - Package: 클래스의 모음
                - Class: 객체를 표현하는 단위

    ![img](/images/image23.png)

- 네이밍 규칙
    - 공통 규칙
        - 대소문자 구분
        - 숫자로 시작 불가
        - 특수문자는 _, &만 가능
        - 예약어는 사용불가
        - Camel 표기법 권장
    - Work Space/Project
        - 시작문자는 대소문자 모두 가능하나 첫 문자를 포함한 모든 단어는 대문자로 시작 권장
    - Package
        - 소문자 권장. 상위 -> 하위-> 최하위 트리 구조 권장.
    - Class
        - 명사, 대문자 시작 권장. 두번째 단어도 대문자 시작 권장.
    - Method
        - 동사, 소문자 시작 권장. 두번째 단어 부터는 대문자 시작 권장.
    - 자바 파일(*****.Isp)
        - public 클래스 명과 동일.
        - public 클래스가 없을 때는 클래스들 중 하나의 이름과 통일