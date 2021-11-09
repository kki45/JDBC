-- 21_11_02
-- Ctrl+Shift+Enter
-- SELECT (Projection + Selection)
/*
Projection : 컬럼명을 직접 지정함
          distinct 컬럼의 중복을 제거함
Selection : where 절을 추가해서 원하는 행만 검색
         ORDER BY정렬, ALIAS 지정방법

*/
/* 문제1. EMP 테이블에서 업무가 SALESMAN 사원과 사원의 이름이
       FORD인 사원의 이름, 업무, 급여를 검색 하시오.
*/
select ename, job, sal 
from emp 
where job='SALESMAN' or ename='FORD';

-- 위 결과에서 SAL값이 점점 높은순으로 출력되도록 결과를 정렬
-- order by 절이 필요
-- 1) 절의 작성 순서 : select -> from -> where -> order by
SELECT ename, job, sal 
from emp 
where job='SALESMAN' or ename='FORD' 
order by sal asc;


-- 문제 2.
-- EMP 테이블에서, 이름, 월금, 연봉을 출력, 이때 연봉순으로 내림차순정렬(DESC)
-- 왜 연봉이 null로 나왔을까??
-- null값은 연산이 되지않아서 null로 나옴.
-- 1. 
select ename, sal, sal * 12 + comm 
FROM emp 
order by sal * 12 + comm DESC;

-- 2-1. Alias를 지정(as를 사용)
select ename, sal, sal * 12 + comm as "Annual Salary"
FROM emp 
order by sal * 12 + comm DESC;

-- 2-2. AS를 생략 가능..
select ename, sal, sal * 12 + comm  "Annual Salary"
FROM emp 
order by sal * 12 + comm DESC;

-- 2-3. 원래는 한칸 띄우고 바로 별칭을 붙이면 된다.
-- 별칭에 공백이 있으면 안된다.
select ename, sal, sal * 12 + comm  AnnualSalary
FROM emp 
order by sal * 12 + comm DESC;

-- 정리 :: 1) 별칭을 지정할때 AS는 굳이 붙이지 않고 생략가능.
--        2) 별칭에 " "을 지정하는 경우는 별칭에 공백이 있을때만 붙인다.

/*
null값에 대해서
sql에서 null값은 연산이 적용되지 않는 값이다.

null을 다른 값으로 치환해서 계산을 해야한다.
ifNull()를 사용.

ifNull(comm,0)--comm이 null값이 아니면 그대로 리턴/comm이 null이면 0으로 리턴.
*/
-- 2-4. ifNull()사용
select ename, sal, sal * 12 + ifnull(comm,0)  AnnualSalary
FROM emp 
order by sal * 12 + comm DESC;

/*
SQL의 3가지
DML :
    1)INSERT INTO table명 VALUES(0,0,0,0)
    2)DELECT FROM table명 WHERE emomo=7786
      DELECT FROM table명; //table의 모든 데이터가 다 삭제되기때문에 주의!!
	3)UPDATE table명 SET sal=2000 WHERE ename='SMITH';
    4)SELECT * FROM table명;//모든데이터를 가지고옴.
      SELECT * FROM table명 WHERE deptno=10;//조건에 맞는 데이타 행을 가지고옴.
      
DDL : 
DCL :
*/
-- 1105 --
/*
limit
::
출력 갯수를 제한하는 기능
시작은 0부터...0,5....상위 5개만 출력
*/
-- 문제 1. emp 테이블에서, sal가 가장 많은 사원 3명을 출력(sal ORDER BY DESC)
SELECT * FROM emp ORDER BY sal DESC;
SELECT * FROM emp ORDER BY sal DESC limit 3;
/*
 SQL에서 NULL값은 제대로 다룰 수 있어야 함.
 1) comm값은 아직 정해지지 않았거나 / 자격이 없거나 일때 사용되는 값.
 2) 0을 의미하는 값이 아니다.
 3) 값이 없는 것도 아니다. 나름 의미를 가지는 값이다...1)에서 언급
 4) 0과는 전혀다른 값이기 때문에 비교, 연산 적용이 안된다.
    --> =, != 연산자 사용 못한다.
	--> +, -, *, / 사용 안된다. 대신에 ifNull()을 사용해서 값을 치환시키고 연산 적용 가능
*/

-- 문제2. emp테이블에서 comm을 받지않는 사원을 검색...이름,업무,comm이 출력
SELECT ename, job, comm FROM emp WHERE comm = null; -- 비교연산자 = 사용안됨
SELECT ename, job, comm FROM emp WHERE comm is null;
SELECT ename, job, comm FROM emp WHERE comm is not null;
SELECT sal, sal*12 + ifnull(comm,0) AnnualSalary FROM emp;

/*
숫자함수 : abs(), round(), floor(), mod(),......

문자함수 : concat(), substr(), trim()

날짜함수 : now(), sysdate(), curdate()
         year(), month()
*/
-- 문제3. 업무가 사장 인 사람과 업무가 SALEMAN인 사람의 급여차이를 출력....abs()
SELECT * FROM emp;
SELECT sal FROM emp WHERE job ='PRESIDENT'; -- 5000
SELECT sal FROM emp WHERE job ='SALESMAN'; -- 1600, 1250, 1250, 1500

-- 스칼라 서버쿼리 :: one row, one col
SELECT DISTINCT ABS((SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename= 'ALLEN')) 급여차이
FROM emp;

-- 문제 4. 사원 번호중에서 홀수번호만 출력...mod()
SELECT ename, empno, job FROM emp WHERE MOD(empno,2) = 1;
SELECT ROUND(45.923); -- 46
SELECT ROUND(45.923, 2); -- 2의 의미는 소숫점 2번째자리까지 출력을 의미

SELECT now() today;
SELECT sysdate() today;
SELECT curdate() today;
-- 문제 5. emp테이블에서 사원들의 입사년도를 출력,,,이때 사원의 이름과 함께 출력, 별칭부여
-- year()를 사용
SELECT ename, year(hiredate) 입사년도 FROM emp;
SELECT ename, month(hiredate) 입사월 FROM emp;
SELECT ename, substr(hiredate,6,2) 입사월 FROM emp;

/*
like연산자와 와일드카드
ex) 훈련생들 중 김씨로 시작하는 학생들의 명단을 검색....
	제품중에서 삼성 2글자 포함되는 모든제품을 검색....
    특정 단어가 포함된 것을 검색할때 like연산자를 쓴다.
    와일드 카드 : %(0~many), _(정확하게 1대1 매핑)
*/
SELECT ename FROM emp;
-- 사원 이름중에서 S로 시작하는 사원의 이름을 검색
SELECT ename FROM emp WHERE ename LIKE 'S%';
-- 문제 6. 사원의 이름중에서 두번째 철자가 A인 사원을 검색..LIKE _A
SELECT ename FROM emp WHERE ename LIKE '_A%';
-- 사원의 이름중에서 R철자가 포함된 사원을 검색
SELECT ename FROM emp WHERE ename LIKE '%R%';

-- 1108
/*
그룹함수 
count() - 테이블 행의 갯수를 리턴
		  count(column)
          count(*) == count(-1)
avg() -  평균값을 리턴
sum() - 총합을 리턴
max() - 최대값 리턴
min() - 최소값 리턴
*/
-- 부서의 수를 출력
SELECT COUNT(deptno) FROM emp; -- 10,20,30...3개의 부서가 있다.
SELECT COUNT(distinct(deptno)) FROM emp;

-- emp 테이블의 전체 행의 수를 출력
SELECT COUNT(empno) FROM emp;
SELECT COUNT(*) FROM emp;
SELECT COUNT(-1) FROM emp;

-- 문제1 . emp 테이블에서 가장 최근에 입사한 사원의 입사일을 검색...그룹함수 사용
SELECT MAX(hiredate) FROM emp;
SELECT MIN(hiredate) FROM emp;

-- 문제2. 모든 사원의 평균급여를 구하는데 소숫점 두자리까지 출력되도록
SELECT ROUND(AVG(sal),2) 평균급여 FROM emp;

-- 문제3. 
/*
그룹함수와 null값
::
null값은 그룹함수에서 제외시킨다.
*/
SELECT COUNT(deptno) FROM emp; -- 14..컬럼에 대한 행의수(결국 전체 행의 수가 리턴)
SELECT COUNT(empno) FROM emp;
SELECT COUNT(comm) FROM emp;

-- 문제4. 모든 사원의 보너스(comm)의 평균을 구하세요.
SELECT AVG(comm) FROM emp; -- 550...잘못된 결과
SELECT ROUND(AVG(ifnull(comm,0))) 보너스평균 FROM emp; -- 157...올바른 결과

/*
GROUP BY 절
1.
그룹함수에서 적용되지 않는 컬럼이
SELECT절에 명시되어서는 안된다.
2.
그룹함수에서 적용되지 않는 컬럼이
SELECT절에 명시되기 위해서는 GROUP BY절에 나열되어져야 한다.
3.
SELECT deptno, AVG(sal) FROM emp;
그룹함수에서 적용되지 않는 컬럼이 있다는 것은
해당 컬럼으로 그룹함수를 세분화시키겠다는 정의...
*/
-- emp테이블에서 모든 사원의 급여의 평균을 검색..
SELECT deptno, AVG(sal) FROM emp; -- X

SELECT deptno, ROUND(AVG(sal)) 
FROM emp
GROUP BY deptno;

SELECT deptno, ROUND(AVG(sal)) 
FROM emp
GROUP BY deptno
ORDER BY ROUND(AVG(sal));

SELECT deptno, ROUND(AVG(sal)) avgsal
FROM emp
GROUP BY deptno
ORDER BY avgsal;
/*
HAVING절
1. where절에서는 그룹함수를 사용할 수 없다.
   where절은 일종의 조건을 부여해서 select하는 절이기 때문에
  grouping이 일어나기전에 먼저 실행된다.
2. 문제 5번의 경우,
   "부서별 평균급여를 구했다"
   10 ---- 2517
   20 ---- 1790
   30 ---- 2190
   
   "이중에서 평균급여가 2000이상인 부서와 그 부서의 평균급여를 구하라"
   포인트는 group by 절의 결과를 다시 조건을 줘서 디스플레이하려고 한다.
   
    이때 HAVING절을 사용한다,
    HAVING절은 GROUPB BY절 뒤에 나온다.
*/
SELECT deptno, ROUND(AVG(sal)) avgsal
FROM emp
WHERE ROUND(AVG(sal))>2000
GROUP BY deptno; -- X

SELECT deptno, ROUND(AVG(sal)) avgsal
FROM emp
GROUP BY  deptno
HAVING avgsal>2000;

-- //////////////////////SUB QUERY////////////////////////
/*
CLARK의 급여보다 더 많은 급여를 받는 사원의 이름과 급여를 검색.

-- 1) 
SELECT sal FROM emp WHERE ename = 'CLARK';
-- 2) 1)결과의 값을 가지고 다시 쿼리문으로 질의를 진행한다.
SELECT ename,sal FROM emp WHERE sal >2450;

위 결과처럼 먼저 질의를 통해서 값을 받은 후에
그 값을 다시 전체 쿼리문에 넣어서 돌릴때 
우리는 Sub Query문을 사용해서 하나의 쿼리문으로 진행할 수 있다.
::

- 서브쿼리는 반드시( )안에 싸여져야 한다.
- ()의 의미는 우선 먼저진행된다는 뜻이다.
- 서브쿼리로 진행된 결과값이 전체 메인쿼리에서 돌아간다
- SUB QUERY 	VS 		MAIN QUERY
  Inner QUERY 	VS 		Outer QUERY
*/
SELECT * FROM emp;
SELECT ename, sal
FROM emp
WHERE sal>(SELECT sal FROM emp WHERE ename='CLACK');

-- 문제 6. ename이 KIING인 사원과 같은 부서에서 일하는 사원을 검색
-- 위 문제에서의 ?
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'KING');

-- 문제 7. 사원중에서 급여를 2000이상받는 사원과 동일한 부서에서 일하는 사원을 검색
SELECT * FROM emp
WHERE deptno=(SELECT DISTINCT(deptno) FROM emp WHERE sal > 2000);
-- 오류이유 :: 서브쿼리에서 값이 3개나왔는데 =로 비교해서 오류 -> IN을 쓰면 해결
-- 위에서 에러가 나는 이유 다중행 서브쿼리인데 =라는 단일행연산자와 비교해서이다.
-- 다중행 서브쿼리 결과는 다중행 연산자 IN으로 연결해줘야 한다.
SELECT * FROM emp
WHERE deptno IN (SELECT DISTINCT(deptno) FROM emp WHERE sal > 2900);

SELECT * FROM emp; -- 7369, 7566, 7782
-- emp 테이블에서 사원번호가 7369이거나 7566이거나 7782인 사원을 검색
-- 1)성능이 가장 안좋은 방법
SELECT ename, empno FROM emp WHERE empno = 7369;
SELECT ename, empno FROM emp WHERE empno = 7566;
SELECT ename, empno FROM emp WHERE empno = 7782;

-- 2) OR로 연결해준다.
SELECT ename, empno FROM emp WHERE empno = 7369 OR empno = 7566 OR empno = 7782;

-- 3) IN 연산자 
SELECT ename, empno FROM emp WHERE empno IN (7369,7566,7782);

-- 문제 8.
-- 사원번호가 7369가 아니고 7566도 아니고 7782도 아닌 사원을 검색
-- 1)
SELECT ename, empno FROM emp WHERE empno NOT IN(7369,7566,7782);

-- 2) 
SELECT ename, empno FROM emp WHERE empno!=7369 AND empno!=7756 AND empno!=7782;
/*
JOIN
::
2개이상(하나이상)의 테이블에서 질의를 던지는 경우
각각의 사원이 어느 부서에서 일하는지를 검색....사원의 이름, 업무, 부서위치를 검색...join
SELECT * FROM emp; -- 사원의 정보를 검색
SELECT * FROM dept; -- 사원이 소속된 부서의 정보를 검색

SELECT * FROM emp, dept; ...56줄
SELECT ename, dname,loc FROM emp,dept; ...56줄
이렇게 나온 결과를 Cartesian Product라 부른다.
Cartesian Product는 두 테이블의 단순한 연산결과를 의미한다.
emp --> 14
dept --> 4
Cartesian Product 14 * 4 = 56
Cartesian Product는 언제 발생할까?
1) 조인조건을 안줬거나
2) 조인조건을 잘못줬거나

*/
SELECT * FROM emp;
SELECT * FROM dept;

-- 문제 8. emp, dept테이블에서 사원의 이름과 부서명, 부서위치를 검색하세요
SELECT ename, dname, loc FROM emp,dept 
WHERE emp.deptno = dept.deptno; -- 14줄

-- 1) 성능에 가장 안좋다. 모든 테이블을 일일히 다 검색해서 컬럼을 찾아낸다.
SELECT ename, dname, loc FROM emp,dept 
WHERE emp.deptno = dept.deptno; 

-- 2) 각각의 컬럼을 어느 테이블에서 검색하는지를 지정하는 것이 좋다. --테이블 Alias
SELECT e.ename, d.dname, d.loc FROM emp e, dept d 
WHERE e.deptno = d.deptno;

-- 문제 9. WEHRE절에는 조인조건과 함께 비조인조건이 당연히 같이 사용된다.
/*
사원이름, 급여, 부서번호, 부서이름, 부서위치를 검색
단, 급여가 2000달러 이상이고 30번 부서에 한해서만 검색을 합니다.
*/
SELECT e.sal , e.deptno, d.dname, d.loc 
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND 
e.sal>2000
AND
e.deptno = 30;





