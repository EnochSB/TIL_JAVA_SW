# React
## React 개요
### React 특징
- **SPA**(Single Page Application)의 UI를 생성하는데 집중한 자바스크립트 라이브러리
- JSX(JavaScript XML)이라는 간단한 문법
- **단방향 데이터 바인딩**(One-way Data Binding): 부모에서 자식에게만 데이터 전송
- **가상 돔**(Virtual DOM)이라는 개념을 사용.
- ES6 문법 기반.
- Node.js의 V8엔진과 NPM(Node Package Manager)를 이용하기 때문에 Node.js에 대한 기초 지식 필요(npm 대신 yarn 이용 가능)
- 프레임 워크가 아닌 라이브러리이기 때문에 다른 필요한 라이브러리 추가 설치 필요
### SPA
- 규모가 큰 웹사이트가 수많은 페이지들을 관리하기 위해 하나의 페이지를 정하고 그 안에 내용을 다르게 채워 여러 페이지를 생산.
### DOM
- DOM(Document Object Model)이란 html, head, body와 같은 태그들을 javascript가 이용할 수 있도록 메모리에 보관할 수 잇는 객체.
- HTML과 스크립팅언어를 서로 이어주는 역할.
### Rendering
![img](/images/image9.png)
1. 웹 브라우저가 네트워크를 통해 HTML을 수신.
2. 브라우저의 렌더링 엔진인 HTML을 파싱. DOM Node로 이루어진 DOM Tree 생성.
3. CSS 파일과 HTML의 요소들(Element)의 인라인 스타일 파싱. 스타일 정보를 가진 스타일 트리 생성.
4. 렌더 트리로 생성된 모든 노드들은 attach라는 함수를 가지고 있음.
    - Attachment 과정에서 이 메소드들이 호출.
    - 메소드가 스타일 정보를 계산하고 결과값을 객체 형태로 반환.
    - 이 계산과정은 모두 동기적으로 동작.
    - 만약 렌더 트리에 새로운 노드가 추가된다면 해당 노드의 attach 메소드가 실행되어 재계산.
5. 렌더 트리는 Attachment 과정을 거친 후 레이아웃이라는 과정을 거친다.
    - 이 레이아웃 과정에서는 브라우저가 렌더 트리의 각 노드들에 좌표를 부여하고 정확히 어디에 어떻게 표시되는지를 결정.
6. 마지막으로 페인팅(Painting)
    - 각 노드들에 paint 함수를 호출하여 렌더링된 요소들에 색상을 입히게 됨.

### 리플로우/리페인트
- 리플로우(Reflow): DOM 조작(자바스크립트)으로 레이아웃 과정이 다시 진행되는 것.
- 리페인트(Repaint): 새로운 레이아웃을 다시 페인팅.
- DOM 조작 시 마다 리플로우와 리페인트가 수행되어 웹 서비스 성능이 저하.

### Virtual DOM
- 리액트는 리플로우와 리페인트를 해결하기 위해 화면에 표시되는 DOM과 동일한 Virtual DOM을 메모리상에 만들고 DOM 조작이 발생하면 메모리상에 생성한 Virtual DOM에서 모든 연산을 수행한 후 실제 DOM을 Re-Rendering 해서 리플로우/리페인트 최소화.
- 변경 전/후 2개의 Virtual DOM을 관리하면, 두 개의 DOM을 비교하여(Diffing) 바뀐 부분만 실제 DOM에 일괄 적용(Batch Update)해 레이아웃 계산은 한번만 이행.
- Diffing, Batch Update 과정을 **Reconsilidation**이라 함.
![img](/images/image10.png)

## 리액트 설치 및 프로젝트 생성
### Yarn
- 기존에는 자바스크립트 프로젝트 패키지 관리 툴로 npm(Node Package Manager)를 사용.
- 지금은 성능과 보안이 향상된 Yarn이 대중적.

### 프로젝트 시작
1. yarn 설치
    ```bash
    #전역모드로 npm을 이용해 yarn 설치
    npm install --global yarn

    #설치후 버전확인
    yarn --version
    ```
2. VS Code Extention 설치
    ![img](/images/image11.png)
    ![img](/images/image12.png)
    ![img](/images/image13.png)
3. 프로젝트 생성
    ```bash
    #프로젝트명은 반드시 영어소문자, 특수문자 사용금지.
    yarn create react-app 프로젝트명

    # 프로젝트 시작
    yarn start
    ```
## 리액트 문법
### 주요 문법
1. Component: 리액트를 구성하는 프로그램의 기본 단위. JSX 문법에 기반한 함수 또는 클래스 모듈.
2. JSX: ES6 문법에 기반하여 확장된 리액트 문법.
3. Props(Properties): Component 사이에 State를 전달하는 방식을 규정한 리액트 문법.
4. State: Component 내에 운영되는 State를 관리하는 리액트 문법.
5. Hooks: State 관리를 위한 리액트 함수들.

### Component
```bash
import './App.css';

const App = () => {
​
    const name = '김민수';

    return (
        <div className='react'>
            <h1>저의 이름은 {name}입니다.</h1>
        </div>
    );
}
export default App;
```

### Props
- 부모에서 자식으로만 값 전달이 가능.(단방향 데이터 바인딩, One-way Data Binding)
    ![img](/images/image14.png)

### State
- 렌더링 될 때마다 모든 변수는 초기화. 따라서, 어떤 값이 변화될 때마다 렌더링을 유발시키면서 그 값을 화면에 보여주고 보존할 필요 발생.
- 자바스크립트의 비구조 할당(Destructuring Assignment) 문법을 사용하여 State와 State의 setter 함수에 값을 할당.
- const [name, setName] = "kim;

## SSR(Server Side Rendering)
- 서버에 있는 웹 애플리케션이 요청을 받아 처리한 후 그 결과를 HTML로 변환
- 클라이언트의 웹브라우저로 전송
- HTML이 서버에서 생성됨.
## CSR(Client Side Rendering)
- 서버에 있는 웹 애플리케션이 요청을 받아 처리한 후 그 결과값을 JSON으로 클라이언트 PC로 전송
- 이 전송된 값을 클라이언트의 웹 브라우저 내에 있는 리액트 앱에서 받아 렌더링 후 웹브라우저 화면에 보여짐.
- 속도가 빠르지만 검색엔진으로 검색이 안된다는 단점.
- next.js로 소스가 보이게 설정 가능(Search Engine Optimizing: SEO, 검색엔진 최적화)