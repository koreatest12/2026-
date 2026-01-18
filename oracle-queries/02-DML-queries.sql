-- ============================================
-- Oracle DML (Data Manipulation Language) 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 데이터 조회 (SELECT)
-- ============================================

-- 기본 조회
SELECT * FROM employees;

-- 특정 컬럼 조회
SELECT employee_id, first_name, last_name FROM employees;

-- 조건부 조회 (WHERE)
SELECT * FROM employees WHERE department_id = 10;
SELECT * FROM employees WHERE salary > 50000;
SELECT * FROM employees WHERE hire_date >= TO_DATE('2020-01-01', 'YYYY-MM-DD');

-- 복합 조건 조회
SELECT * FROM employees WHERE salary > 50000 AND department_id = 10;
SELECT * FROM employees WHERE department_id IN (10, 20, 30);
SELECT * FROM employees WHERE last_name LIKE 'S%';
SELECT * FROM employees WHERE email IS NOT NULL;

-- 정렬 (ORDER BY)
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY department_id ASC, salary DESC;

-- 중복 제거 (DISTINCT)
SELECT DISTINCT department_id FROM employees;

-- 제한 조회 (ROWNUM, FETCH)
SELECT * FROM employees WHERE ROWNUM <= 10;
SELECT * FROM employees ORDER BY salary DESC FETCH FIRST 10 ROWS ONLY;

-- ============================================
-- 2. 조인 (JOIN)
-- ============================================

-- INNER JOIN
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT OUTER JOIN
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- RIGHT OUTER JOIN
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- FULL OUTER JOIN
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id;

-- SELF JOIN
SELECT e1.employee_id, e1.first_name, e2.first_name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- ============================================
-- 3. 그룹화 및 집계 함수
-- ============================================

-- 기본 집계 함수
SELECT COUNT(*) AS total_employees FROM employees;
SELECT AVG(salary) AS average_salary FROM employees;
SELECT SUM(salary) AS total_salary FROM employees;
SELECT MAX(salary) AS max_salary FROM employees;
SELECT MIN(salary) AS min_salary FROM employees;

-- GROUP BY
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- HAVING
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 50000;

-- GROUP BY with ROLLUP
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id);

-- GROUP BY with CUBE
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE(department_id, job_id);

-- ============================================
-- 4. 서브쿼리 (Subquery)
-- ============================================

-- 단일 행 서브쿼리
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 다중 행 서브쿼리
SELECT * FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700);

-- 상관 서브쿼리
SELECT e1.employee_id, e1.first_name, e1.salary
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.department_id = e1.department_id);

-- EXISTS 서브쿼리
SELECT * FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id);

-- ============================================
-- 5. 집합 연산자
-- ============================================

-- UNION (중복 제거)
SELECT employee_id FROM employees WHERE department_id = 10
UNION
SELECT employee_id FROM employees WHERE salary > 50000;

-- UNION ALL (중복 포함)
SELECT employee_id FROM employees WHERE department_id = 10
UNION ALL
SELECT employee_id FROM employees WHERE salary > 50000;

-- INTERSECT (교집합)
SELECT employee_id FROM employees WHERE department_id = 10
INTERSECT
SELECT employee_id FROM employees WHERE salary > 50000;

-- MINUS (차집합)
SELECT employee_id FROM employees WHERE department_id = 10
MINUS
SELECT employee_id FROM employees WHERE salary > 50000;

-- ============================================
-- 6. 데이터 삽입 (INSERT)
-- ============================================

-- 기본 삽입
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, salary)
VALUES (1001, 'John', 'Doe', 'john.doe@example.com', SYSDATE, 60000);

-- 다중 행 삽입
INSERT ALL
    INTO employees (employee_id, first_name, last_name, email) VALUES (1002, 'Jane', 'Smith', 'jane.smith@example.com')
    INTO employees (employee_id, first_name, last_name, email) VALUES (1003, 'Bob', 'Johnson', 'bob.johnson@example.com')
SELECT * FROM DUAL;

-- 서브쿼리를 이용한 삽입
INSERT INTO emp_backup
SELECT * FROM employees WHERE department_id = 10;

-- ============================================
-- 7. 데이터 수정 (UPDATE)
-- ============================================

-- 기본 수정
UPDATE employees SET salary = 65000 WHERE employee_id = 1001;

-- 다중 컬럼 수정
UPDATE employees
SET salary = 70000, department_id = 20
WHERE employee_id = 1001;

-- 서브쿼리를 이용한 수정
UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees)
WHERE employee_id = 1001;

-- ============================================
-- 8. 데이터 삭제 (DELETE)
-- ============================================

-- 기본 삭제
DELETE FROM employees WHERE employee_id = 1001;

-- 조건부 삭제
DELETE FROM employees WHERE department_id = 10;

-- 서브쿼리를 이용한 삭제
DELETE FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700);

-- ============================================
-- 9. 병합 (MERGE)
-- ============================================

MERGE INTO employees e
USING (SELECT employee_id, salary FROM emp_updates) u
ON (e.employee_id = u.employee_id)
WHEN MATCHED THEN
    UPDATE SET e.salary = u.salary
WHEN NOT MATCHED THEN
    INSERT (employee_id, salary) VALUES (u.employee_id, u.salary);

-- ============================================
-- 10. 트랜잭션 제어
-- ============================================

-- 트랜잭션 시작 (암묵적)
INSERT INTO employees (employee_id, first_name, last_name) VALUES (1004, 'Test', 'User');

-- 커밋
COMMIT;

-- 롤백
ROLLBACK;

-- 세이브포인트
SAVEPOINT sp1;
DELETE FROM employees WHERE employee_id = 1004;
ROLLBACK TO sp1;

-- ============================================
-- 11. 문자열 함수
-- ============================================

-- 문자열 연결
SELECT first_name || ' ' || last_name AS full_name FROM employees;

-- 대소문자 변환
SELECT UPPER(first_name), LOWER(last_name) FROM employees;

-- 문자열 길이
SELECT LENGTH(first_name) FROM employees;

-- 문자열 자르기
SELECT SUBSTR(first_name, 1, 3) FROM employees;

-- 공백 제거
SELECT TRIM(first_name) FROM employees;

-- ============================================
-- 12. 숫자 함수
-- ============================================

-- 반올림
SELECT ROUND(salary, -3) FROM employees;

-- 절삭
SELECT TRUNC(salary, -3) FROM employees;

-- 나머지
SELECT MOD(salary, 1000) FROM employees;

-- ============================================
-- 13. 날짜 함수
-- ============================================

-- 현재 날짜
SELECT SYSDATE FROM DUAL;

-- 날짜 연산
SELECT hire_date + 30 FROM employees;
SELECT MONTHS_BETWEEN(SYSDATE, hire_date) FROM employees;
SELECT ADD_MONTHS(hire_date, 6) FROM employees;

-- 날짜 형식 변환
SELECT TO_CHAR(hire_date, 'YYYY-MM-DD') FROM employees;
SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD') FROM DUAL;

-- ============================================
-- 14. 변환 함수
-- ============================================

-- 문자를 숫자로
SELECT TO_NUMBER('12345') FROM DUAL;

-- 숫자를 문자로
SELECT TO_CHAR(salary, '999,999.99') FROM employees;

-- NULL 처리
SELECT NVL(commission_pct, 0) FROM employees;
SELECT NVL2(commission_pct, salary * commission_pct, 0) FROM employees;
SELECT COALESCE(commission_pct, bonus, 0) FROM employees;

-- ============================================
-- 15. 조건 함수
-- ============================================

-- CASE 문
SELECT employee_id, salary,
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_grade
FROM employees;

-- DECODE 함수
SELECT employee_id, department_id,
    DECODE(department_id, 10, 'Sales', 20, 'IT', 30, 'HR', 'Other') AS dept_name
FROM employees;
