-- ============================================
-- Oracle 사용자 및 권한 관리 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 사용자 생성 및 기본 설정
-- ============================================

-- 기본 사용자 생성
CREATE USER testuser IDENTIFIED BY TestPass123;

-- 기본 테이블스페이스 지정
CREATE USER testuser IDENTIFIED BY TestPass123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

-- 쿼터 제한
CREATE USER testuser IDENTIFIED BY TestPass123
DEFAULT TABLESPACE users
QUOTA 100M ON users;

-- 무제한 쿼터
CREATE USER testuser IDENTIFIED BY TestPass123
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

-- ============================================
-- 2. 사용자 정보 수정
-- ============================================

-- 비밀번호 변경
ALTER USER testuser IDENTIFIED BY NewPass456;

-- 기본 테이블스페이스 변경
ALTER USER testuser DEFAULT TABLESPACE user_data;

-- 임시 테이블스페이스 변경
ALTER USER testuser TEMPORARY TABLESPACE temp2;

-- 쿼터 변경
ALTER USER testuser QUOTA 200M ON users;

-- 계정 잠금
ALTER USER testuser ACCOUNT LOCK;

-- 계정 잠금 해제
ALTER USER testuser ACCOUNT UNLOCK;

-- 비밀번호 만료
ALTER USER testuser PASSWORD EXPIRE;

-- 프로파일 변경
ALTER USER testuser PROFILE secure_profile;

-- ============================================
-- 3. 시스템 권한 관리
-- ============================================

-- 기본 시스템 권한
GRANT CREATE SESSION TO testuser;                    -- 접속 권한
GRANT CREATE TABLE TO testuser;                      -- 테이블 생성 권한
GRANT CREATE VIEW TO testuser;                       -- 뷰 생성 권한
GRANT CREATE SEQUENCE TO testuser;                   -- 시퀀스 생성 권한
GRANT CREATE PROCEDURE TO testuser;                  -- 프로시저 생성 권한
GRANT CREATE TRIGGER TO testuser;                    -- 트리거 생성 권한
GRANT CREATE SYNONYM TO testuser;                    -- 동의어 생성 권한

-- 고급 시스템 권한
GRANT CREATE ANY TABLE TO testuser;                  -- 모든 스키마에 테이블 생성
GRANT ALTER ANY TABLE TO testuser;                   -- 모든 테이블 수정
GRANT DROP ANY TABLE TO testuser;                    -- 모든 테이블 삭제
GRANT SELECT ANY TABLE TO testuser;                  -- 모든 테이블 조회
GRANT INSERT ANY TABLE TO testuser;                  -- 모든 테이블 삽입
GRANT UPDATE ANY TABLE TO testuser;                  -- 모든 테이블 수정
GRANT DELETE ANY TABLE TO testuser;                  -- 모든 테이블 삭제

-- 데이터베이스 관리 권한
GRANT CREATE USER TO testuser;                       -- 사용자 생성
GRANT ALTER USER TO testuser;                        -- 사용자 수정
GRANT DROP USER TO testuser;                         -- 사용자 삭제
GRANT CREATE ROLE TO testuser;                       -- 롤 생성
GRANT CREATE TABLESPACE TO testuser;                 -- 테이블스페이스 생성

-- UNLIMITED TABLESPACE 권한
GRANT UNLIMITED TABLESPACE TO testuser;

-- WITH ADMIN OPTION
GRANT CREATE SESSION TO testuser WITH ADMIN OPTION;

-- 시스템 권한 회수
REVOKE CREATE TABLE FROM testuser;
REVOKE CREATE VIEW FROM testuser;

-- ============================================
-- 4. 객체 권한 관리
-- ============================================

-- 테이블 권한
GRANT SELECT ON employees TO testuser;               -- 조회 권한
GRANT INSERT ON employees TO testuser;               -- 삽입 권한
GRANT UPDATE ON employees TO testuser;               -- 수정 권한
GRANT DELETE ON employees TO testuser;               -- 삭제 권한
GRANT ALL ON employees TO testuser;                  -- 모든 권한

-- 특정 컬럼에 대한 권한
GRANT UPDATE (salary, commission_pct) ON employees TO testuser;

-- 뷰 권한
GRANT SELECT ON emp_view TO testuser;

-- 시퀀스 권한
GRANT SELECT ON emp_seq TO testuser;
GRANT ALTER ON emp_seq TO testuser;

-- 프로시저 권한
GRANT EXECUTE ON salary_procedure TO testuser;

-- WITH GRANT OPTION
GRANT SELECT ON employees TO testuser WITH GRANT OPTION;

-- 객체 권한 회수
REVOKE SELECT ON employees FROM testuser;
REVOKE ALL ON employees FROM testuser;

-- CASCADE CONSTRAINTS로 권한 회수
REVOKE SELECT ON employees FROM testuser CASCADE CONSTRAINTS;

-- ============================================
-- 5. 롤 생성 및 관리
-- ============================================

-- 롤 생성
CREATE ROLE hr_clerk;
CREATE ROLE hr_manager;
CREATE ROLE developer;

-- 롤에 시스템 권한 부여
GRANT CREATE SESSION TO hr_clerk;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO developer;

-- 롤에 객체 권한 부여
GRANT SELECT ON employees TO hr_clerk;
GRANT SELECT, INSERT, UPDATE ON employees TO hr_manager;

-- 롤에 다른 롤 부여
GRANT hr_clerk TO hr_manager;

-- 사용자에게 롤 부여
GRANT hr_clerk TO testuser;
GRANT hr_manager TO testuser;

-- WITH ADMIN OPTION으로 롤 부여
GRANT hr_clerk TO testuser WITH ADMIN OPTION;

-- 사용자로부터 롤 회수
REVOKE hr_clerk FROM testuser;

-- 롤 삭제
DROP ROLE hr_clerk;

-- ============================================
-- 6. 기본 제공 롤
-- ============================================

-- CONNECT 롤 (기본 접속 권한)
GRANT CONNECT TO testuser;

-- RESOURCE 롤 (객체 생성 권한)
GRANT RESOURCE TO testuser;

-- DBA 롤 (데이터베이스 관리자 권한)
GRANT DBA TO testuser;

-- SELECT_CATALOG_ROLE (데이터 딕셔너리 조회)
GRANT SELECT_CATALOG_ROLE TO testuser;

-- EXECUTE_CATALOG_ROLE (데이터 딕셔너리 실행)
GRANT EXECUTE_CATALOG_ROLE TO testuser;

-- ============================================
-- 7. 기본 롤 설정
-- ============================================

-- 기본 롤 설정
ALTER USER testuser DEFAULT ROLE hr_clerk;

-- 모든 롤을 기본 롤로 설정
ALTER USER testuser DEFAULT ROLE ALL;

-- 특정 롤만 기본 롤로 설정
ALTER USER testuser DEFAULT ROLE hr_clerk, developer;

-- 기본 롤 제외 설정
ALTER USER testuser DEFAULT ROLE ALL EXCEPT hr_manager;

-- 기본 롤 없음
ALTER USER testuser DEFAULT ROLE NONE;

-- ============================================
-- 8. 세션 롤 제어
-- ============================================

-- 특정 롤 활성화
SET ROLE hr_clerk;

-- 여러 롤 활성화
SET ROLE hr_clerk, developer;

-- 모든 롤 활성화
SET ROLE ALL;

-- 특정 롤 제외하고 모두 활성화
SET ROLE ALL EXCEPT hr_manager;

-- 모든 롤 비활성화
SET ROLE NONE;

-- ============================================
-- 9. 권한 및 롤 조회
-- ============================================

-- 모든 사용자 조회
SELECT username, account_status, created, default_tablespace, profile
FROM DBA_USERS
ORDER BY username;

-- 특정 사용자의 정보 조회
SELECT username, account_status, created, profile, default_tablespace, temporary_tablespace
FROM DBA_USERS
WHERE username = 'TESTUSER';

-- 사용자의 테이블스페이스 쿼터 조회
SELECT tablespace_name, bytes/1024/1024 AS mb_used, max_bytes/1024/1024 AS mb_max
FROM DBA_TS_QUOTAS
WHERE username = 'TESTUSER';

-- 사용자에게 부여된 시스템 권한 조회
SELECT grantee, privilege, admin_option
FROM DBA_SYS_PRIVS
WHERE grantee = 'TESTUSER'
ORDER BY privilege;

-- 사용자에게 부여된 객체 권한 조회
SELECT grantee, owner, table_name, privilege, grantable
FROM DBA_TAB_PRIVS
WHERE grantee = 'TESTUSER'
ORDER BY owner, table_name;

-- 사용자에게 부여된 롤 조회
SELECT grantee, granted_role, admin_option, default_role
FROM DBA_ROLE_PRIVS
WHERE grantee = 'TESTUSER';

-- 롤 목록 조회
SELECT role, password_required
FROM DBA_ROLES
ORDER BY role;

-- 롤에 부여된 시스템 권한 조회
SELECT role, privilege
FROM ROLE_SYS_PRIVS
WHERE role = 'HR_CLERK'
ORDER BY privilege;

-- 롤에 부여된 객체 권한 조회
SELECT role, owner, table_name, privilege
FROM ROLE_TAB_PRIVS
WHERE role = 'HR_CLERK'
ORDER BY owner, table_name;

-- 롤에 부여된 다른 롤 조회
SELECT granted_role, grantee
FROM DBA_ROLE_PRIVS
WHERE granted_role = 'HR_CLERK';

-- 현재 세션의 권한 조회
SELECT * FROM SESSION_PRIVS ORDER BY privilege;

-- 현재 세션의 롤 조회
SELECT * FROM SESSION_ROLES ORDER BY role;

-- 현재 사용자 정보 조회
SELECT user FROM DUAL;
SELECT sys_context('USERENV', 'SESSION_USER') FROM DUAL;
SELECT sys_context('USERENV', 'CURRENT_USER') FROM DUAL;

-- ============================================
-- 10. 프로파일 생성 및 관리
-- ============================================

-- 기본 프로파일 생성
CREATE PROFILE app_user_profile LIMIT
    SESSIONS_PER_USER 5
    IDLE_TIME 30
    CONNECT_TIME 600;

-- 보안 강화 프로파일 생성
CREATE PROFILE secure_profile LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    PASSWORD_LIFE_TIME 60
    PASSWORD_REUSE_TIME 365
    PASSWORD_REUSE_MAX 10
    PASSWORD_LOCK_TIME 1
    PASSWORD_GRACE_TIME 7
    SESSIONS_PER_USER 3
    IDLE_TIME 15
    CONNECT_TIME 480
    CPU_PER_SESSION 10000
    LOGICAL_READS_PER_SESSION 100000;

-- 프로파일 수정
ALTER PROFILE secure_profile LIMIT FAILED_LOGIN_ATTEMPTS 5;

-- 프로파일 목록 조회
SELECT DISTINCT profile FROM DBA_PROFILES ORDER BY profile;

-- 프로파일 설정 조회
SELECT profile, resource_name, resource_type, limit
FROM DBA_PROFILES
WHERE profile = 'SECURE_PROFILE'
ORDER BY resource_type, resource_name;

-- 프로파일 삭제
DROP PROFILE app_user_profile;

-- CASCADE로 프로파일 삭제 (해당 프로파일 사용자들을 DEFAULT 프로파일로 변경)
DROP PROFILE app_user_profile CASCADE;

-- ============================================
-- 11. 동의어(Synonym) 관리
-- ============================================

-- 개인 동의어 생성
CREATE SYNONYM emp FOR hr.employees;

-- 공용 동의어 생성 (CREATE PUBLIC SYNONYM 권한 필요)
CREATE PUBLIC SYNONYM dept FOR hr.departments;

-- 동의어 조회
SELECT owner, synonym_name, table_owner, table_name
FROM DBA_SYNONYMS
WHERE synonym_name = 'EMP';

-- 동의어 삭제
DROP SYNONYM emp;
DROP PUBLIC SYNONYM dept;

-- ============================================
-- 12. 사용자 삭제
-- ============================================

-- 사용자 삭제 (소유 객체가 없을 때만 가능)
DROP USER testuser;

-- 사용자와 소유한 모든 객체 삭제
DROP USER testuser CASCADE;

-- ============================================
-- 13. 접속 세션 관리
-- ============================================

-- 현재 접속 세션 조회
SELECT sid, serial#, username, status, osuser, machine, program, logon_time
FROM V$SESSION
WHERE username IS NOT NULL
ORDER BY logon_time DESC;

-- 특정 사용자의 세션 조회
SELECT sid, serial#, status, osuser, machine, program
FROM V$SESSION
WHERE username = 'TESTUSER';

-- 세션 종료 (ALTER SYSTEM 권한 필요)
ALTER SYSTEM KILL SESSION 'sid,serial#';

-- 예: ALTER SYSTEM KILL SESSION '123,45678';

-- ============================================
-- 14. 잠긴 계정 관리
-- ============================================

-- 잠긴 계정 조회
SELECT username, account_status, lock_date, expiry_date
FROM DBA_USERS
WHERE account_status LIKE '%LOCKED%'
ORDER BY username;

-- 계정 잠금 해제
ALTER USER testuser ACCOUNT UNLOCK;

-- 비밀번호 재설정 및 잠금 해제
ALTER USER testuser IDENTIFIED BY NewPass123 ACCOUNT UNLOCK;

-- ============================================
-- 15. 권한 체인 조회
-- ============================================

-- 특정 권한이 어떤 롤을 통해 부여되었는지 조회
SELECT grantee, granted_role, admin_option
FROM DBA_ROLE_PRIVS
START WITH grantee = 'TESTUSER'
CONNECT BY PRIOR granted_role = grantee;

-- 계층적 권한 구조 조회
SELECT LPAD(' ', 2*LEVEL-2) || grantee AS privilege_tree, granted_role
FROM DBA_ROLE_PRIVS
START WITH grantee = 'TESTUSER'
CONNECT BY PRIOR granted_role = grantee
ORDER SIBLINGS BY granted_role;
