# SQL
## Oracle
### 뷰
#### PL/SQL 프로시저
```sql
-- 1. 입력 매개변수가 있는 프로시저
CREATE OR REPLACE PROCEDURE greet_user(p_name IN VARCHAR2)
AS
BEGIN
    DBMS_OUTPUT.put_line('Hello World!!!'||' '||p_name);
END;

exec greet_user('김철수');

-- 2. 출력 매개변수가 있는 프로시저
CREATE OR REPLACE PROCEDURE add_numbers(p_num1 IN number, p_num2 IN number, p_result OUT number)
AS
BEGIN
    p_result := p_num1 + p_num2;
END;

DECLARE
    v_result NUMBER;
BEGIN
    add_numbers(5, 10, v_result);
    dbms_output.put_line('Result = ' || v_result);
end;

-- 3. IN OUT (Oracle에서만 지원)
CREATE OR REPLACE PROCEDURE increament_number(p_num IN OUT number)
AS
BEGIN
    p_num := p_num + 1;
END;

DECLARE
    v_num number := 20;
BEGIN
    increament_number(v_num);
    dbms_output.put_line('p_num = '|| v_num);
END;
```

#### PL/SQL 함수
```sql
-- Oracle
create or replace FUNCTION f_grade (in_value number)
    RETURN varchar2
AS
    v_grade varchar2(20);
begin
    v_grade := 'Low salary';
    if in_value > 2500 then
        v_grade := 'High salary';
    end if;
    return v_grade;
end;

select ename, sal, f_grade(sal)
from emp;

-- mySQL
DELIMITER $$
CREATE OR REPLACE FUNCTION f_hitno(v_seqno INT)
RETURNS INT
BEGIN
	UPDATE tbl_board
	SET hitno = (
		SELECT IFNULL(hitno, 0)
		FROM tbl_board
		WHERE seqno = v_seqno
		) + 1
	WHERE seqno = v_seqno;
	RETURN 0;
END $$
```

#### PL/SQL 트리거
```sql
--mySQL
DELIMITER &&
CREATE OR REPLACE TRIGGER tbl_board_log
AFTER INSERT ON tbl_board FOR EACH ROW
BEGIN
	INSERT INTO tbl_board_log (userid, bseqno)
	VALUES (NEW.userid, NEW.seqno);
END &&
```

### 트랜잭션
- 데이터베이스의 상태를 변화시키는 업무처리의 논리적 단위

#### 트랜잭션의 특성
1. 원자성
    - 트랜잭션을 구성하는 작업들은 전부 수행이 되거나 전혀 수행이 되지 않아야 한다.
2. 일관성
    - 트랜잭션을 수행하기 이전의 데이터베이스와 수행한 이후의 데이터베이스가 논리적으로 일관된 상태.
3. 격리성
    - 여러 트랜잭션들이 병렬적으로 수행되는 상황에서 트랜잭션들 간에 상호 간섭에 의한 문제를 일으키지 않는 성질.
4. 지속성
    - 트랜잭션이 성공적으로 완료된 후에는 트랜잭션의 수행 결과가 데이터 베이스에 영구적으로 유지되는 특성.

#### 장애와 회복
- 백업과 로그
    - 시스템 종료에 따른 백업 구분
        1. 콜드 백업
            - 실행 중인 운영 시스템을 중지한 후 백업 실시
        2. 핫 백업
            - 운영시스템을 중지하지 않고 백업을 수행
        3. 웜 백업
            - 위 두 방법을 조합한 형태.
            - 운영시스템을 중지하지는 않으나, 외부 사용자가 데이터베이스를 변경하는 것을 막아 유사 중지 효과
    - 백업 범위에 따른 백업 구분
        1. 전체 백업
        2. 증분 백업
            - 과거의 백업 시점 이후 변화된 부분만 백업

### 데이터베이스 설계
- 응용 SW 개발을 위해 기반이 되는 데이터베이스의 구조(스키마)를 설계하는 과정
- mySQL에서는 데이터베이스와 동의어처럼 사용.(create database = create schema)
- Oracle에서는 특정 사용자가 생성한 모든 데이터베이스 객체(테이블, 뷰, 인덱스,...)의 집합(테이블스페이스)
- 사용자 이름을 스키마 이름으로 설정하는 경우가 많다보니 사용자와 스키마를 동일시 하는 것은 오해.

#### 응용 SW의 개발 절차(Methodology, 방법론)
- 업무(정보시스템 구축)를 잘 하기 위한 방법론
    - 개발 방법론
    - 프로젝트 관리 방법론: PM이 프로젝트를 관리하는 방법. 회의 주기, 보고서 주기 등
    - 품질관리 방법론: 테스트, 보안(화면 보호기, 전산실 출입 ...) 등
- 요구사항 분석 -> 설계(내용설계, 구성설계, 항해설계) -> 구현(빌드-테스트-배포, Build-Test-Distribution) -> 테스트(통합/단위) -> 유지보수
- Analysis -> Design -> Implementation -> Test -> maintenance

1. (분석) 개발 계획 수립
2. (분석) 업무 분석

3. (설계) 데이터 모델링, 프로세스 모델링
    - ER(Entity Relationship) Diagram
4. (설계) 상관 모델링
    - 데이터 모델과 프로세스 모델의 비교 검토
5. (설계) 물리 DB 설계, 프로그램(로직) 설계

6. (구현) DB 구축, 프로그램 개발
7. (테스트) DB 튜닝, 프로그램 테스트
    - 튜닝: 데이터베이스가 일정한 성능을 유지할 수 있도록 비효율적인 요소를 제거하고 성능 개선을 위해 sql문 등 여러 요소를 조정하는 작업
8. (유지보수) RUN & 유지보수

- 산출물(Deliverables): 위 과정들을 통해 나오는 보고서, 프로그램 소스 등

##### 활용 분야
- HR(Human Resource, 인사): 조직 운영
- 컨설팅 BPR/ISP
    - BPR: Business Process Re-Engineering(업무혁신설계), PI(Process Innovation)
    - ISP: Information Strategic Planning(정보전략기획)

#### ERD
- 시스템의 엔티티들이 무엇이 있는지 어떤 관계가 있는지를 나타내는 다이어그램
- 선택(Optional)
- 필수(Mandatory)
