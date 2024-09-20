// 공동 사용용 자바스크립트 객체
const user = {
    name: 'Mike',
    age: 30
};

// Symbol(유일한 식별자 생성)을 이용하여 타인이 만든 객체에 영향을 덜 주면서 개인이 자신의
// 프로퍼티(property) 또는 메서드를 객체에 추가할 때 사용

// 개별 작업자가 공동용 자바스크립트 객체인 user에 새로운 프로퍼티를 추가하고
// 그 영향을 다른 객체 사용자가 영향을 덜 받게 함.
const showName = Symbol('show name');   // 심볼 구분자를 만들고 심볼 선언
const showAge = Symbol('show id')
// 객체에 영향을 안 주면서 객체를 이용해 무엇인가를 할 함수 선언하여 추가.
user[showName] = function() {
    console.log(this.name);
}
user[showAge] = function() {
    console.log(this.age);
}

user[showName]();
user[showAge]();

for(let key in user){
    console.log(`His ${key} is ${user[key]}.`);
}