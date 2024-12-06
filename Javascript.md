# Javascript
- 자바스크립트는 객체 기반의 스크립트 언어
- 느슨한 타입(loosely typed)의 동적(dynamic)언어. 타입을 명시할 필요가 없는 인터프리터 언어
- 객체 지향형 프로그래밍과 함수형 프로그래밍을 모두 표현
- 자바스크립트는 프로토타입의 객체지향언어(최근에는 클래스 기반 객체지향도 가능)
- 이벤트 기반 싱글스레드 논블로킹 I/O 모델

## 데이터 타입
### 기본 타입(Primitive Type, 원시타입)
- 숫자, 문자열, 논리형, 심볼, undefined, BigInt
### 객체 타입
- 객체(object), Array
### null / undefined
- null: 자바스크립트에서 null은 object타입. 아직 **'값'**이 정해지지 않은 것을 의미.
- undefined: null과 달리 **'타입'**이 정해지지 않은 것을 의미.
- null과 undefined는 동등연산자(==)와 일치연산자(===)의 결과값이 다름.
    - 타입을 제외하면 같은 의미지만, 타입이 다르므로 일치하지 않음.
    - null == undefined; // true
    - null === undefined; // false

## 변수
### Variables lifecycle
- 선언 단계(Declaration phase): 변수를 실행 컨텍스트의 변수 객체에 등록하는 단계
- 초기화 단계(Initialization phase): 실행 컨텍스트에 존재하는 변수 객체에 선언 단계의 변수를 위한 메모리를 만드는 단계로 undefined 값으로 초기화
- 할당 단계(Assignment phase): 사용자가 undefined로 초기화된 메모리에 다른 값을 할당하는 단계
![img](/images/image114.png)

### var 변수
- 선언 단계와 초기화 단계를 동시에 진행.
- 실행 컨텍스트의 변수 객체에 변수를 등록하고 메모리를 undefined로 초기화.
![img](/images/image115.png)

### let 변수
- var와는 다르게 선언단계와 초기화 단계가 분리.
- 변수 초기화 이전에 변수가 참조되면 실행 컨텍스트에 변수를 등록했지만 메모리가 할당이 되질 않아 접근 불가해 참조에러(ReferenceError) 발생
![img](/images/image116.png)
- TDZ(Temporal dead zone)
```js
let a;
console.log(a); // 선언과 할당 사이에 참조를 했을 경우 에러 발생. 이러한 구간을 TDZ라고 함.
a = 10;

console.log(b);
let b = 20; // 호이스트로 선언부는 최상단으로 올라가고 할당은 참조 이후에 실행. TDZ가 존재.
```

### const 변수
- const는 반드시 선언과 초기화를 동시에 진행
- let가 마찬가지로 재선언 불가
- 재할당의 경우 원시 타입은 불가, 객체는 가능

### function 함수
- 변수 선언 3단계를 동시에 진행
![img](/images/image119.png)

### 식별자
- $ 식별자
- _ 식별자

## Scope

## 연산자/제어문/배열

## 함수

## 객체

## 생성자 함수

## 프로토타입

## Class

## 표준 객체

## JSON 객체
- 자바스크립트는 JSON 포맷의 데이터를 간편하게 다룰 수 있도록 JSON이라는 객체를 내장
- JSON 내장 객체는 자바스크립트 객체와 JSON 객체 간의 상호변환을 수행하는 JSON.parse()와 JSON.stringify()를 보유

## AJAX
- JavaScript의 라이브러리 중 하나로 Asynchronous Javascript And Xml(비동기식 자바스크립트와 xml)의 약자.
- 브라우저가 갖고 있는 XMLHttpRequest 객체를 이용해 페이지를 새로 고치지 않고 페이지 일부만을 위한 데이터를 로드하는 기법.
- JavaScript를 사용해 비동기 통신 방식으로 클라이언트와 서버간 데이터를 주고 받는 기술.
- 순수 JavaScript 라이브러리 AJAX를 이용하는 방식은 적고, 외부 함수(Jqeury, fetch 등)를 활용.

## 문서 객체 모델
- DOM(Document Object Model)은 XML이나 HTML 문서에 접근하기 위한 일종의 인터페이스.
- document.querySelector(#아이디)
- document.querySelectAll(.클래스)

## Hoist

## 실행 컨텍스트

## Lexical Scoping
- 스코프 체인
- 렉시컬 스코핑
- 네임스페이스

## Closure

## 브라우저 객체 모델

## 구조 분해 할당

## 전개 연산자(Spread Operator)
- 나머지 매개변수 처리
- 전개 구문 처리