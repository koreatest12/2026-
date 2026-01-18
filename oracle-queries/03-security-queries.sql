-- ============================================
-- Oracle 보안 관련 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 사용자 계정 관리
-- ============================================

-- 사용자 생성
CREATE USER user01 IDENTIFIED BY password123;

-- 비밀번호 정책이 적용된 사용자 생성
CREATE USER user02 IDENTIFIED BY Complex#Pass1
PASSWORD EXPIRE
ACCOUNT UNLOCK;

-- 사용자 비밀번호 변경
ALTER USER user01 IDENTIFIED BY newpassword456;

-- 사용자 계정 잠금/잠금 해제
ALTER USER user01 ACCOUNT LOCK;
ALTER USER user01 ACCOUNT UNLOCK;

-- 사용자 비밀번호 만료
ALTER USER user01 PASSWORD EXPIRE;

-- 사용자 삭제
DROP USER user01;

-- 사용자와 소유 객체 모두 삭제
DROP USER user01 CASCADE;

-- ============================================
-- 2. 권한 관리 (Privilege Management)
-- ============================================

-- 시스템 권한 부여
GRANT CREATE SESSION TO user01;
GRANT CREATE TABLE TO user01;
GRANT CREATE VIEW TO user01;
GRANT CREATE SEQUENCE TO user01;
GRANT CREATE PROCEDURE TO user01;
GRANT UNLIMITED TABLESPACE TO user01;

-- 여러 시스템 권한 한번에 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO user01;

-- 시스템 권한 회수
REVOKE CREATE TABLE FROM user01;

-- WITH ADMIN OPTION (권한 재부여 가능)
GRANT CREATE SESSION TO user01 WITH ADMIN OPTION;

-- 객체 권한 부여
GRANT SELECT ON employees TO user01;
GRANT INSERT ON employees TO user01;
GRANT UPDATE ON employees TO user01;
GRANT DELETE ON employees TO user01;
GRANT ALL ON employees TO user01;

-- 특정 컬럼에 대한 권한 부여
GRANT UPDATE (salary, department_id) ON employees TO user01;

-- WITH GRANT OPTION (권한 재부여 가능)
GRANT SELECT ON employees TO user01 WITH GRANT OPTION;

-- 객체 권한 회수
REVOKE SELECT ON employees FROM user01;

-- CASCADE 옵션으로 권한 회수
REVOKE SELECT ON employees FROM user01 CASCADE CONSTRAINTS;

-- ============================================
-- 3. 롤(Role) 관리
-- ============================================

-- 롤 생성
CREATE ROLE app_developer;
CREATE ROLE app_user;

-- 롤에 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO app_developer;
GRANT CREATE SESSION TO app_user;

-- 사용자에게 롤 부여
GRANT app_developer TO user01;
GRANT app_user TO user02;

-- 기본 롤 설정
ALTER USER user01 DEFAULT ROLE app_developer;

-- 롤 활성화/비활성화
SET ROLE app_developer;
SET ROLE ALL;
SET ROLE NONE;

-- 롤 권한 회수
REVOKE app_developer FROM user01;

-- 롤 삭제
DROP ROLE app_developer;

-- ============================================
-- 4. 미리 정의된 롤
-- ============================================

-- CONNECT 롤 부여
GRANT CONNECT TO user01;

-- RESOURCE 롤 부여
GRANT RESOURCE TO user01;

-- DBA 롤 부여 (모든 시스템 권한)
GRANT DBA TO user01;

-- ============================================
-- 5. 프로파일(Profile) 관리 - 비밀번호 정책
-- ============================================

-- 프로파일 생성
CREATE PROFILE secure_profile LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    PASSWORD_LIFE_TIME 90
    PASSWORD_REUSE_TIME 365
    PASSWORD_REUSE_MAX 5
    PASSWORD_LOCK_TIME 1
    PASSWORD_GRACE_TIME 7
    SESSIONS_PER_USER 3
    IDLE_TIME 30
    CONNECT_TIME 480;

-- 사용자에게 프로파일 할당
ALTER USER user01 PROFILE secure_profile;

-- 프로파일 수정
ALTER PROFILE secure_profile LIMIT FAILED_LOGIN_ATTEMPTS 5;

-- 프로파일 삭제
DROP PROFILE secure_profile;

-- CASCADE 옵션으로 프로파일 삭제
DROP PROFILE secure_profile CASCADE;

-- ============================================
-- 6. 감사(Audit) 설정
-- ============================================

-- 감사 활성화 (시스템 파라미터)
ALTER SYSTEM SET audit_trail = DB SCOPE=SPFILE;

-- 문장 감사
AUDIT TABLE;
AUDIT SESSION;
AUDIT SELECT TABLE, UPDATE TABLE, DELETE TABLE;

-- 권한 감사
AUDIT CREATE TABLE;
AUDIT DROP ANY TABLE;

-- 객체 감사
AUDIT SELECT, INSERT, UPDATE, DELETE ON employees;
AUDIT ALL ON employees;

-- 특정 사용자 감사
AUDIT SELECT TABLE BY user01;

-- 성공/실패 감사
AUDIT DELETE ANY TABLE BY ACCESS WHENEVER SUCCESSFUL;
AUDIT DELETE ANY TABLE BY ACCESS WHENEVER NOT SUCCESSFUL;

-- 감사 해제
NOAUDIT TABLE;
NOAUDIT SELECT, INSERT, UPDATE, DELETE ON employees;

-- ============================================
-- 7. 감사 로그 조회
-- ============================================

-- 감사 설정 조회
SELECT * FROM DBA_STMT_AUDIT_OPTS;
SELECT * FROM DBA_PRIV_AUDIT_OPTS;
SELECT * FROM DBA_OBJ_AUDIT_OPTS;

-- 감사 기록 조회
SELECT username, timestamp, owner, obj_name, action_name, returncode
FROM DBA_AUDIT_TRAIL
ORDER BY timestamp DESC;

-- 특정 사용자의 감사 기록
SELECT timestamp, action_name, obj_name, returncode
FROM DBA_AUDIT_TRAIL
WHERE username = 'USER01'
ORDER BY timestamp DESC;

-- 실패한 로그인 시도 조회
SELECT username, timestamp, returncode, terminal
FROM DBA_AUDIT_SESSION
WHERE returncode != 0
ORDER BY timestamp DESC;

-- ============================================
-- 8. Fine-Grained Auditing (FGA)
-- ============================================

-- FGA 정책 생성
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'salary_audit_policy',
        audit_condition => 'SALARY > 100000',
        audit_column    => 'SALARY',
        statement_types => 'SELECT,UPDATE'
    );
END;
/

-- FGA 감사 기록 조회
SELECT db_user, timestamp, sql_text, object_name
FROM DBA_FGA_AUDIT_TRAIL
ORDER BY timestamp DESC;

-- FGA 정책 삭제
BEGIN
    DBMS_FGA.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'salary_audit_policy'
    );
END;
/

-- ============================================
-- 9. 데이터 암호화 (TDE - Transparent Data Encryption)
-- ============================================

-- 지갑 생성
ALTER SYSTEM SET ENCRYPTION KEY IDENTIFIED BY "WalletPassword123";

-- 테이블스페이스 암호화
CREATE TABLESPACE encrypted_ts
DATAFILE '/u01/app/oracle/oradata/encrypted01.dbf' SIZE 100M
ENCRYPTION USING 'AES256'
DEFAULT STORAGE(ENCRYPT);

-- 컬럼 암호화
CREATE TABLE secure_data (
    id NUMBER PRIMARY KEY,
    ssn VARCHAR2(11) ENCRYPT USING 'AES256',
    credit_card VARCHAR2(16) ENCRYPT
);

-- 기존 컬럼 암호화
ALTER TABLE employees MODIFY (salary ENCRYPT USING 'AES256');

-- 컬럼 암호화 해제
ALTER TABLE employees MODIFY (salary DECRYPT);

-- ============================================
-- 10. VPD (Virtual Private Database) - Row Level Security
-- ============================================

-- 보안 정책 함수 생성
CREATE OR REPLACE FUNCTION dept_security_policy(
    schema_var IN VARCHAR2,
    table_var IN VARCHAR2
)
RETURN VARCHAR2
AS
BEGIN
    RETURN 'department_id = SYS_CONTEXT(''USERENV'', ''CLIENT_IDENTIFIER'')';
END;
/

-- 보안 정책 적용
BEGIN
    DBMS_RLS.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'dept_security_policy',
        function_schema => 'HR',
        policy_function => 'dept_security_policy',
        statement_types => 'SELECT,UPDATE,DELETE'
    );
END;
/

-- 보안 정책 제거
BEGIN
    DBMS_RLS.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'dept_security_policy'
    );
END;
/

-- ============================================
-- 11. 권한 및 롤 조회
-- ============================================

-- 사용자 목록 조회
SELECT username, account_status, created, profile
FROM DBA_USERS
ORDER BY username;

-- 사용자에게 부여된 시스템 권한 조회
SELECT grantee, privilege, admin_option
FROM DBA_SYS_PRIVS
WHERE grantee = 'USER01'
ORDER BY privilege;

-- 사용자에게 부여된 객체 권한 조회
SELECT grantee, owner, table_name, privilege, grantable
FROM DBA_TAB_PRIVS
WHERE grantee = 'USER01'
ORDER BY table_name;

-- 사용자에게 부여된 롤 조회
SELECT grantee, granted_role, admin_option
FROM DBA_ROLE_PRIVS
WHERE grantee = 'USER01';

-- 롤에 부여된 권한 조회
SELECT role, privilege
FROM ROLE_SYS_PRIVS
WHERE role = 'APP_DEVELOPER';

-- 현재 사용자의 권한 조회
SELECT * FROM SESSION_PRIVS;

-- 현재 사용자의 롤 조회
SELECT * FROM SESSION_ROLES;

-- ============================================
-- 12. 비밀번호 검증 함수
-- ============================================

-- 비밀번호 검증 함수 생성
CREATE OR REPLACE FUNCTION verify_password_function(
    username VARCHAR2,
    password VARCHAR2,
    old_password VARCHAR2
)
RETURN BOOLEAN
IS
    n BOOLEAN := FALSE;
    m INTEGER := 0;
    differ INTEGER := 0;
    db_name VARCHAR2(40);
BEGIN
    -- 비밀번호 최소 길이 검사
    IF LENGTH(password) < 8 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Password must be at least 8 characters');
    END IF;
    
    -- 사용자명과 동일한 비밀번호 검사
    IF UPPER(password) = UPPER(username) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Password cannot be same as username');
    END IF;
    
    -- 복잡성 검사 (영문자, 숫자, 특수문자 포함)
    IF NOT (REGEXP_LIKE(password, '[A-Z]') AND 
            REGEXP_LIKE(password, '[a-z]') AND 
            REGEXP_LIKE(password, '[0-9]') AND 
            REGEXP_LIKE(password, '[^A-Za-z0-9]')) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Password must contain uppercase, lowercase, number, and special character');
    END IF;
    
    RETURN TRUE;
END;
/

-- 프로파일에 비밀번호 검증 함수 적용
ALTER PROFILE secure_profile LIMIT PASSWORD_VERIFY_FUNCTION verify_password_function;

-- ============================================
-- 13. 데이터 마스킹 (Data Redaction)
-- ============================================

-- 데이터 마스킹 정책 생성
BEGIN
    DBMS_REDACT.ADD_POLICY(
        object_schema    => 'HR',
        object_name      => 'EMPLOYEES',
        column_name      => 'SALARY',
        policy_name      => 'mask_salary_policy',
        function_type    => DBMS_REDACT.PARTIAL,
        function_parameters => '9,1,5',
        expression       => 'SYS_CONTEXT(''USERENV'', ''SESSION_USER'') != ''HR_ADMIN'''
    );
END;
/

-- 데이터 마스킹 정책 제거
BEGIN
    DBMS_REDACT.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'mask_salary_policy'
    );
END;
/

-- ============================================
-- 14. 리소스 제한 (Resource Limits)
-- ============================================

-- 프로파일에 리소스 제한 설정
CREATE PROFILE limited_profile LIMIT
    SESSIONS_PER_USER 2
    CPU_PER_SESSION 10000
    CPU_PER_CALL 1000
    CONNECT_TIME 480
    IDLE_TIME 30
    LOGICAL_READS_PER_SESSION 100000
    PRIVATE_SGA 15M
    COMPOSITE_LIMIT 5000000;

-- ============================================
-- 15. 보안 관련 데이터 딕셔너리 뷰
-- ============================================

-- 사용자 정보
SELECT * FROM DBA_USERS WHERE username = 'USER01';

-- 권한 정보
SELECT * FROM DBA_SYS_PRIVS WHERE grantee = 'USER01';
SELECT * FROM DBA_TAB_PRIVS WHERE grantee = 'USER01';
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee = 'USER01';

-- 롤 정보
SELECT * FROM DBA_ROLES;
SELECT * FROM ROLE_SYS_PRIVS WHERE role = 'APP_DEVELOPER';
SELECT * FROM ROLE_TAB_PRIVS WHERE role = 'APP_DEVELOPER';

-- 프로파일 정보
SELECT * FROM DBA_PROFILES WHERE profile = 'SECURE_PROFILE';

-- 감사 정보
SELECT * FROM DBA_AUDIT_TRAIL ORDER BY timestamp DESC;

-- 접속 정보
SELECT username, sid, serial#, status, osuser, machine, program
FROM V$SESSION
WHERE username IS NOT NULL;

-- 잠긴 계정 조회
SELECT username, account_status, lock_date, expiry_date
FROM DBA_USERS
WHERE account_status LIKE '%LOCKED%';
