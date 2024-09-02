package com.test.oop;

import java.util.Optional;

public class OptionalExam {
    public static void main(String[] args) {
        
        String str = "Hello";
        String isNullString = null;
        int a;

        /*
        try {
            if (isNullString.equals(str)) {
                a = 4;
            }
        } catch (NullPointerException e) {
            System.out.println("Null이 들어 왔어요");
        }
        */

        String retValue = Optional.ofNullable(isNullString).orElse("Null이다");
        System.out.println(retValue);

        String retValue1 = isNullString == null?"NULL이다":isNullString;
        System.out.println(retValue1);
        
    }
}
