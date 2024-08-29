package com.test.data;
import java.util.Scanner;

public class Pyramid {

    public static boolean isNumberic(String str) {
        return str.chars().allMatch(Character::isDigit);
    }

    public static void main(String[] args) {
        System.out.println("값을 입력하세요.");
        Scanner put = new Scanner(System.in);

        int num;
        String input = put.nextLine();

        if (isNumberic(put.nextLine())) {
            num = Integer.parseInt(input);
        } else {
            num = 0;
        }

        for(int i=0; i<num; i++){
            for(int j=0; j<num; j++){
                if (j<=i) {
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                }
            }
            System.out.println();
        }

        System.out.println();

        for(int i=0; i<num; i++){
            for(int j=0; j<num; j++){
                if (j < num - i - 1) {
                    System.out.print(" ");
                } else {
                    System.out.print("*");
                }
            }
            System.out.println();
        }

        System.out.println();

        for(int i=0; i<num; i++){
            for(int j=0; j<num; j++){
                if (j < num - i - 1) {
                    System.out.print(" ");
                } else {
                    System.out.print("*");
                }
            }
            for(int j=1; j<num; j++){
                if (j<=i) {
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                }
            }
            System.out.println();
        }
        for (int i = 1; i < num; i++) {
            for(int j=1; j<num; j++){
                if (j<=i) {
                    System.out.print(" ");
                } else {
                    System.out.print("*");
                }
            }
            for(int j=0; j<num; j++){
                if (j < num - i) {
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                }
            }

            System.out.println();
        }


    }
}
