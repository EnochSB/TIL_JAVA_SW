package com.test.oop;

// 스택 구현
class GStack<T>{   // 관례상 인자가 하나면 T, 2개면 K, V

    int tos;
    Object [] stck; // Object: 어떤 타입의 배열일지 안정해짐

    public GStack(){
        tos = 0;
        stck = new Object[10];
    }

    // 10개의 데이터를 채울 수 있는 스택에 데이터를 채운다(입력)
    public void push(T item){
        if(tos == 10) return;   // 조건문 종료
        stck[tos] = item;
        tos++;
    }

    // 10개의 데이터를 채울 수 있는 스택에서 데이터를 빼낸다.(출력)
    @SuppressWarnings("unchecked")
    public T pop(){
        if(tos == 0) return null;   // 조건문 종료
        tos--;
        return (T)stck[tos];
    }
}

public class GenericTest {
    public static void main(String[] args) {
        GStack<String> strinGStack = new GStack<String>();  // 어떤 타입의 데이터를 보낼지 <>안에 명시

        strinGStack.push("Seoul");
        strinGStack.push("Busan");
        strinGStack.push("LA");

        for (int i = 0; i < 3; i++) {
            System.out.println(strinGStack.pop());
        }

    }
}
