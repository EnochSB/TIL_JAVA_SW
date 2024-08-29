package com.test.data;

import java.util.Arrays;

public class BubbleSort {
    public static void main(String[] args) {
        System.out.println("<정렬전>");
        int[] nums = {1, 7, 2, 4, 10, 3, 4, 55, 33};

        System.out.println(Arrays.toString(nums));

        for(int i = nums.length - 1; i>0; i--){
            for(int j = 0; j < i; j++){
                if (nums[j] > nums[j+1]) {
                    int tmp = nums[j];
                    nums[j] = nums[j+1];
                    nums[j+1] = tmp;
                }
            }
        }
        System.out.println("<정렬후>");
        System.out.println(Arrays.toString(nums));

    }
}
