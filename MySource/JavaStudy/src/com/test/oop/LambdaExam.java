package com.test.oop;

import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;

@FunctionalInterface
interface MyLambdaFunction{
    int sum(int a, int b);
}

@FunctionalInterface
interface MyPrint{
    String printLambda();
}

public class LambdaExam {
    public static void main(String[] args) {
        
        // 람다식을 이용한 익명함수: 2개의 인자를 받아서 메서드로 계산 후 반환
        MyLambdaFunction lambdaFunction = (int a, int b) -> a + b;
        // 인터페이스의 인스턴스 객체를 생성하고 메서드를 오버라이딩
        // ->는 return을 의미
        // 꼭 써야하는 것은 아니지만 많은 곳에서 이용하고 있다.
        // Stream API를 사용할 때 람다식을 써야만 할 때도 있다.
        System.out.println("람다식을 이용한 익명함수: 2개의 인자를 받아서 메서드로 계산 후 반환하는 예: " + lambdaFunction.sum(3, 5));

        // 람다식을 이용한 익명함수: 인자 없이 문자열을 반환
        MyPrint myPrint = () -> "Hello World!";
        System.out.println("람다식을 이용한 익명함수: 인자 없이 문자열을 반환하는 예: " + myPrint.printLambda());

        // Supplier: 매개변수 없이 값만 반환하는 함수형 인터페이스
        Supplier<String> supplier = () -> "안녕하세요";
            // <>안은 반드시 객체형 타입
            // Supplier 객체는 사용자가 따로 메서드를 생성하지 않아도 get메서드를 사용해 호출 가능
        System.out.println("Supplier 매개변수 없이 값만 반환하는 함수형 인터페이스 사용 예: " + supplier.get());

        // Consumer: 객체 T를 매개변수로 받아서 사용하며, 반환값이 없는 함수형 인터페이스
        Consumer<String> consumer = (str) -> System.out.println(str.split(" ")[0]);
        consumer.andThen(s->System.out.println("Consumer: 객체 T를 매개변수로 받아서 사용하며, 반환값이 없는 함수형 인터페이스 사용 예: " + s))
                .accept("반갑습니다 안녕하세요");

        // Function: 객체 T를 매개변수로 받아서 처리한 후, R로 반환하는 함수형 인터페이스
        Function<String, Integer> function = str -> str.length();
        System.out.println("Function: 객체 T를 매개변수로 받아서 처리한 후, R로 반환하는 함수형 인터페이스 사용 예: " + function.apply("null"));

        // Predicate: 객체 T를 매개변수로 받아 처리한 후, Boolean을 반환하는 함수형 인터페이스
        Predicate<String> predicate = str -> str.equals("Hello");
        System.out.println("Predicate: 객체 T를 매개변수로 받아 처리한 후, Boolean을 반환하는 함수형 인터페이스 사용 예: " + predicate.test("Hello"));
        System.out.println("Predicate: 객체 T를 매개변수로 받아 처리한 후, Boolean을 반환하는 함수형 인터페이스 사용 예: " + predicate.test("Hel"));
        
        // 메서드 참조(Method Reference): 람다 표현식이 단 하나의 메서드 만을 호출 할 때에
        // 해당 람다 표현식에서 불필요한 매개변수를 제거하고 사용가능
        // 예) 클래스이름::메서드이름
        Function<String, Integer> func = str -> str.length();
        Function<String, Integer> func2 = String::length;
    }
}
