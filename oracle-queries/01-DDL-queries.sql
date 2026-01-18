-- ============================================
-- Oracle DDL (Data Definition Language) 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 테이블 생성 (CREATE TABLE)
-- ============================================

-- 기본 테이블 생성
CREATE TABLE employees (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    hire_date DATE DEFAULT SYSDATE,
    salary NUMBER(8,2),
    department_id NUMBER(4)
);

-- 제약조건과 함께 테이블 생성
CREATE TABLE departments (
    department_id NUMBER(4) PRIMARY KEY,
    department_name VARCHAR2(50) NOT NULL,
    manager_id NUMBER(6),
    location_id NUMBER(4),
    CONSTRAINT dept_name_uk UNIQUE(department_name)
);

-- 외래키 제약조건이 있는 테이블 생성
CREATE TABLE job_history (
    employee_id NUMBER(6) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT jhist_pk PRIMARY KEY (employee_id, start_date),
    CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- CHECK 제약조건이 있는 테이블 생성
CREATE TABLE products (
    product_id NUMBER(6) PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    price NUMBER(8,2),
    stock_quantity NUMBER(6),
    CONSTRAINT price_check CHECK (price > 0),
    CONSTRAINT stock_check CHECK (stock_quantity >= 0)
);

-- ============================================
-- 2. 테이블 수정 (ALTER TABLE)
-- ============================================

-- 컬럼 추가
ALTER TABLE employees ADD phone_number VARCHAR2(20);

-- 컬럼 수정
ALTER TABLE employees MODIFY salary NUMBER(10,2);

-- 컬럼 삭제
ALTER TABLE employees DROP COLUMN phone_number;

-- 제약조건 추가
ALTER TABLE employees ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- 제약조건 삭제
ALTER TABLE employees DROP CONSTRAINT emp_dept_fk;

-- 제약조건 비활성화/활성화
ALTER TABLE employees DISABLE CONSTRAINT emp_dept_fk;
ALTER TABLE employees ENABLE CONSTRAINT emp_dept_fk;

-- ============================================
-- 3. 테이블 삭제 (DROP TABLE)
-- ============================================

-- 테이블 삭제
DROP TABLE job_history;

-- CASCADE 옵션으로 테이블 삭제 (외래키 제약조건 함께 삭제)
DROP TABLE departments CASCADE CONSTRAINTS;

-- ============================================
-- 4. 테이블 초기화 (TRUNCATE TABLE)
-- ============================================

-- 테이블 데이터 전체 삭제 (구조는 유지)
TRUNCATE TABLE employees;

-- ============================================
-- 5. 인덱스 생성 및 관리
-- ============================================

-- 인덱스 생성
CREATE INDEX emp_name_idx ON employees(last_name, first_name);

-- 유니크 인덱스 생성
CREATE UNIQUE INDEX emp_email_idx ON employees(email);

-- 비트맵 인덱스 생성
CREATE BITMAP INDEX emp_dept_idx ON employees(department_id);

-- 함수 기반 인덱스 생성
CREATE INDEX emp_upper_name_idx ON employees(UPPER(last_name));

-- 인덱스 삭제
DROP INDEX emp_name_idx;

-- 인덱스 재생성
ALTER INDEX emp_email_idx REBUILD;

-- ============================================
-- 6. 뷰 생성 및 관리
-- ============================================

-- 단순 뷰 생성
CREATE VIEW emp_dept_view AS
SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 복합 뷰 생성
CREATE VIEW dept_summary_view AS
SELECT d.department_name, COUNT(e.employee_id) AS emp_count, AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 읽기 전용 뷰 생성
CREATE VIEW emp_salary_view AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WITH READ ONLY;

-- 뷰 수정
CREATE OR REPLACE VIEW emp_dept_view AS
SELECT e.employee_id, e.first_name, e.last_name, e.email, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 뷰 삭제
DROP VIEW emp_dept_view;

-- ============================================
-- 7. 시퀀스 생성 및 관리
-- ============================================

-- 시퀀스 생성
CREATE SEQUENCE emp_seq
START WITH 1000
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
CACHE 20;

-- 시퀀스 수정
ALTER SEQUENCE emp_seq INCREMENT BY 10;

-- 시퀀스 사용
SELECT emp_seq.NEXTVAL FROM DUAL;
SELECT emp_seq.CURRVAL FROM DUAL;

-- 시퀀스 삭제
DROP SEQUENCE emp_seq;

-- ============================================
-- 8. 동의어 (Synonym) 생성 및 관리
-- ============================================

-- 동의어 생성
CREATE SYNONYM emp FOR employees;

-- 공용 동의어 생성
CREATE PUBLIC SYNONYM dept FOR departments;

-- 동의어 삭제
DROP SYNONYM emp;
DROP PUBLIC SYNONYM dept;

-- ============================================
-- 9. 테이블스페이스 관리
-- ============================================

-- 테이블스페이스 생성
CREATE TABLESPACE user_data
DATAFILE '/u01/app/oracle/oradata/user_data01.dbf' SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- 테이블스페이스 수정
ALTER TABLESPACE user_data ADD DATAFILE '/u01/app/oracle/oradata/user_data02.dbf' SIZE 100M;

-- 테이블스페이스 삭제
DROP TABLESPACE user_data INCLUDING CONTENTS AND DATAFILES;

-- ============================================
-- 10. 주석 추가
-- ============================================

-- 테이블 주석
COMMENT ON TABLE employees IS '직원 정보 테이블';

-- 컬럼 주석
COMMENT ON COLUMN employees.employee_id IS '직원 ID (기본키)';
COMMENT ON COLUMN employees.salary IS '급여 정보';
