function outerFunc() {
    var x = 10;
    var innerFunc = function(){
        console.log(x);
    }
    return innerFunc;
}

// 내부함수 innerFunc가 변수 inner에게로 반환됨.
// 그러고나서, outerFunc는 Lifecycle을 마치고 종료.
// 종료 이후에 변수 x 또한 사라지는 것이 정상이지만
// x=10을 기억하여(Lexical Environment 내에 기억되어 있다.)
// innerFunc가 실행할 때 값을 전달해 줌.
// 이런 역할을 하는 함수를 클로저(Closure)라고 함.
// 클로저는 자신이 생성될 때의 환경(Lexical Environment)을 기억하는 함수
// 즉시 실행 함수(IIFE: Immediately-invoked Function Expression)에서
// 클로저를 반환하는 형태로 운영되며
// 상태유지, 전역변수의 사용 억제, 정보 은닉 등의 용도로 사용
var inner = outerFunc();
inner();