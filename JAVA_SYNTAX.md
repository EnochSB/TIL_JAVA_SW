# JAVA_SYNTAX
## Variables 변수
- 하나의 값을 저장하기 위해 확보한 메모리 공간 자체 또는 그 메모리 공간을 식별하기 위해 붙인 이름(식별자-Identifier)
- Mangaged Language: 자바는 개발자가 직접 메모리를 제어하지 못함. 직접 메모리 주소를 통해 값을 저장하고 참조할 필요 없이 변수를 통해 안전하게 값에 접근이 가능
- 식별자(변수명)는 변수의 값이 아닌 메모리 주소를 기억. 변수명을 사용하면 변수명과 매핑된 메모리 주소를 통해 메모리에 저장된 값을 반환
- 선언(deciaration): 변수명을 컴파일러에 알리는 행위
- 할당(assignment, 대입, 저장): 변수에 값을 저장하는 행위
- 참조(reference): 변수에 저장된 값을 읽어들이는 행위

### 변수 스코프
- 스코프: 변수에 접근하거나 접근할 수 있는 유효 범위. 일반적으로 변수가 선언된 블록 내.{}으로 구분.
- 라이프타임: 변수가 메모리 내에서 존재할 수 있는 시간.
```java
public class Sample {
    // 변수 선언
    int x, y;           // Instance Variable: 클래스 내부에 선언된 변수, main 메소드에 영향을 미치기 위해서는 인스턴스 선언이 필요.
    static int result;  // Class Variable: 클래스 내부에 선언된 static 변수
    
    void add(int a, int b){    // Local Variable이 매개변수(Parameter)로 활용
        // 변수에 값 할당
        x = a;
        y = b;
        int sum = x + y;    // 선언과 동시에 할당: 초기화
        System.out.println("Sum = "+sum);
    }

    public static void main(String[] args) {
        Sample obj = new Sample();  // 인스턴스 선언
        obj.add(10, 20);
    }
}

/*
 * Instance Variable
 *  - 클래스 내부와 모든 메소드 및 블록 위부에서 선언된 변수
 *  - scope: 정적 메소드를 제외한 클래스 전체
 *  - 라이프타임: 객체가 메모리에 존재할 때까지
 * 
 * Class Variable
 *  - 클래스 내부, 모든 외부 블로에서 선언되고 static으로 표시된 변수
 *  - scope: 클래스 전체
 *  - 라이프타임: 프로그램이 끝날 때까지
 *
 * Local Variable(지역변수)
 *  - 인스턴스 및 클래스 변수가 아닌 모든 변수
 *  - scope: 선언된 블록 내
 *  - 라이프타임: 컨트롤이 선언 된 블록을 떠날 때까지
 */
```

## 데이터 타입