package com.test.exam01;

public class Sample {
    // 변수 선언
    int x, y;           // Instance Variable: 클래스 내부에 선언된 변수, main 메소드에 영향을 미치기 위해서는 인스턴스 선언이 필요.
    static int result;  // Class Variable: 클래스 내부에 선언된 static 변수
    
    void add(int a, int b){    // Local Variable이 매개변수(Parameter)로 활용
        // 변수에 값 할당
        x = a;
        y = b;
        int sum = x + y;    // 선언과 동시에 할당: 초기화
        result = 88;
        System.out.println("result = "+result);
        System.out.println("Sum = "+sum);
    }

    void add2(){
        int a = 3;
        int b = 5;
        // 로컬 변수는 위의 add 매소드 내에서 쓰이고 사라졌으므로 다시 선언 가능.
    }

    public static void main(String[] args) {
        Sample obj = new Sample();  // 인스턴스 선언
        obj.add(10, 20);

        System.out.println("x = " + obj.x);
        System.out.println("y = " + obj.y);
        System.out.println("result = " + result);
        result = 77;
        System.out.println("result = " + result);
        System.out.println("\"안녕\"");
        System.out.print("하이\n");
        System.out.print("네~\t");
        System.out.println("반가워");
        System.out.println("\105");
        
        System.out.println("10진수 -> 2진수");
        System.out.println(Integer.toBinaryString(result));
        System.out.println(Integer.toString(result,2));
    }
}

/*
 * 스코프: 변수에 접근하거나 접근할 수 있는 유효 범위. 일반적으로 변수가 선언된 블록 내.{}으로 구분.
 * 라이프타임: 변수가 메모리 내에서 존재할 수 있는 시간.
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