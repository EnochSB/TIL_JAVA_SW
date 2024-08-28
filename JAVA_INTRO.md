# JAVA INTRO
## JAVA PLATFORM
### 자바 플랫폼 소개
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