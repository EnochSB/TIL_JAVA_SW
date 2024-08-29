package com.test.exam01;

public class ForExam01 {
    public static void main(String[] args) {
        int i = 0;
        int sum = 0;

        for (i = 0; i <= 100; i++) {// 이미 i가 초기화 되어있기 때문에 공란으로 두어도 된다.for(;i<=0;sum+=i++)
            sum = sum + i;
        }
        System.out.println("\n" + "#1 For문을 이용한 계산1 : sum = " + sum);
        
        i = 0;
        sum = 0;
        for (i = 0; i <= 100; sum += i++); // 실행문을 집어넣어서 단순화 가능

        System.out.println("\n" + "#2 For문을 이용한 계산2 : sum = " + sum);
        
        i = 0;
        sum = 0;
        while (i<=100) {
            sum += i;
            i++;
        }
        System.out.println("\n" + "#3 While문을 이용한 계산1 : sum = " + sum);

        i = 0;
        sum = 0;
        while (i<=100) sum += i++;  // 실행문이 한 줄이라면 블록을 안쓰기 가능(for문도 마찬가지)
        System.out.println("\n" + "#4 While문을 이용한 계산1 : sum = " + sum);

        i = 0;
        sum = 0;
        while (true){
            sum += i++;
            if (i>100) break;
        }
        System.out.println("\n" + "#5 While문 + break를 이용한 계산 : sum = " + sum);

        i = 0;
        sum = 0;
        while (true){
            sum += i++;
            if (i<=100) continue;
                else break;
        }
        System.out.println("\n" + "#6 While문 + continue + break를 이용한 계산 : sum = " + sum);
        
        i = 0;
        sum = 0;
        do { sum += i++;
        } while (i<=100);
        System.out.println("\n" + "#7 do-While문을 이용한 계산 : sum = " + sum);

    }
}
