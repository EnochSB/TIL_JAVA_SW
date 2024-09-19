console.log(a); // undefined 출력 => Hoist: 변수 선언이 scope 최상단으로 올라감.
var a;  // var는 선언됨과 동시에 초기화되기 때문에 undefined가 들어감.

console.log(b); // ReferenceError
let b = 'hi'; // let은 선언만 먼저 한다. 초기화를 못한 상태로 출력을 하기 때문에 ReferenceError.
// let b;만 한 상태에서 출력한 것.