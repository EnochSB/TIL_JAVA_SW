package com.test.oop;

import java.util.HashMap;
import java.util.Map;

public class MapExam {
    public static void main(String[] args) {
        
        Map<String, String> map = new HashMap<>();
        map.put("key01", "사과");
        map.put("key02", "포도");
        map.put("key03", "망고");
        map.put("key04", "오렌지");
        
        System.out.println(map.get("key01"));

        map.forEach((key, value) -> {
            System.out.println("[key]: " + key + ", [value]: " + value);
        });
    }
}
