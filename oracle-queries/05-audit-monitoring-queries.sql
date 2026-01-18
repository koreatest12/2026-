-- ============================================
-- Oracle 감사 및 모니터링 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 감사(Audit) 기능 활성화
-- ============================================

-- 감사 활성화 상태 확인
SHOW PARAMETER audit_trail;

-- 감사 활성화 (재시작 필요)
ALTER SYSTEM SET audit_trail = DB SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail = DB, EXTENDED SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail = XML SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail = XML, EXTENDED SCOPE=SPFILE;

-- 통합 감사 활성화 (Oracle 12c 이상)
ALTER SYSTEM SET audit_trail = 'OS' SCOPE=SPFILE;

-- ============================================
-- 2. 문장 감사 (Statement Auditing)
-- ============================================

-- 테이블 관련 문장 감사
AUDIT TABLE;                                          -- CREATE, DROP TABLE 감사
AUDIT TABLE BY ACCESS;                                -- 각 실행마다 감사
AUDIT TABLE BY SESSION;                               -- 세션당 한 번만 감사

-- 시스템 관련 문장 감사
AUDIT SESSION;                                        -- 로그인/로그아웃 감사
AUDIT SESSION BY testuser;                            -- 특정 사용자 세션 감사
AUDIT SESSION WHENEVER SUCCESSFUL;                    -- 성공한 세션만 감사
AUDIT SESSION WHENEVER NOT SUCCESSFUL;                -- 실패한 세션만 감사

-- DDL 문장 감사
AUDIT ALTER ANY TABLE;
AUDIT CREATE ANY TABLE;
AUDIT DROP ANY TABLE;
AUDIT TRUNCATE TABLE;

-- DML 문장 감사
AUDIT SELECT TABLE;
AUDIT INSERT TABLE;
AUDIT UPDATE TABLE;
AUDIT DELETE TABLE;

-- 여러 문장 한번에 감사
AUDIT SELECT TABLE, INSERT TABLE, UPDATE TABLE, DELETE TABLE BY testuser;

-- 문장 감사 해제
NOAUDIT TABLE;
NOAUDIT SESSION;

-- ============================================
-- 3. 권한 감사 (Privilege Auditing)
-- ============================================

-- 시스템 권한 감사
AUDIT CREATE SESSION;
AUDIT CREATE TABLE;
AUDIT CREATE USER;
AUDIT ALTER USER;
AUDIT DROP USER;
AUDIT CREATE ROLE;
AUDIT GRANT ANY PRIVILEGE;

-- 성공/실패 조건 감사
AUDIT CREATE SESSION WHENEVER SUCCESSFUL;
AUDIT CREATE SESSION WHENEVER NOT SUCCESSFUL;
AUDIT CREATE TABLE BY testuser WHENEVER SUCCESSFUL;

-- 권한 감사 해제
NOAUDIT CREATE SESSION;
NOAUDIT CREATE TABLE;

-- ============================================
-- 4. 객체 감사 (Object Auditing)
-- ============================================

-- 테이블 객체 감사
AUDIT SELECT ON employees;
AUDIT INSERT ON employees;
AUDIT UPDATE ON employees;
AUDIT DELETE ON employees;
AUDIT ALL ON employees;                               -- 모든 작업 감사

-- 성공/실패 조건 감사
AUDIT SELECT ON employees BY ACCESS WHENEVER SUCCESSFUL;
AUDIT DELETE ON employees BY ACCESS WHENEVER NOT SUCCESSFUL;

-- 특정 사용자에 대한 객체 감사
AUDIT SELECT ON employees BY testuser;

-- 객체 감사 해제
NOAUDIT SELECT ON employees;
NOAUDIT ALL ON employees;

-- ============================================
-- 5. 감사 설정 조회
-- ============================================

-- 문장 감사 설정 조회
SELECT user_name, audit_option, success, failure
FROM DBA_STMT_AUDIT_OPTS
ORDER BY user_name, audit_option;

-- 권한 감사 설정 조회
SELECT user_name, privilege, success, failure
FROM DBA_PRIV_AUDIT_OPTS
ORDER BY user_name, privilege;

-- 객체 감사 설정 조회
SELECT owner, object_name, object_type, 
       alt, aud, com, del, gra, ind, ins, loc, ren, sel, upd
FROM DBA_OBJ_AUDIT_OPTS
WHERE object_name = 'EMPLOYEES';

-- ============================================
-- 6. 감사 로그 조회
-- ============================================

-- 전체 감사 로그 조회
SELECT username, timestamp, owner, obj_name, action_name, returncode, priv_used
FROM DBA_AUDIT_TRAIL
ORDER BY timestamp DESC
FETCH FIRST 100 ROWS ONLY;

-- 특정 사용자 감사 로그
SELECT timestamp, action_name, obj_name, returncode
FROM DBA_AUDIT_TRAIL
WHERE username = 'TESTUSER'
ORDER BY timestamp DESC;

-- 특정 객체 감사 로그
SELECT username, timestamp, action_name, returncode, sql_text
FROM DBA_AUDIT_TRAIL
WHERE obj_name = 'EMPLOYEES'
ORDER BY timestamp DESC;

-- 실패한 작업 감사 로그
SELECT username, timestamp, action_name, obj_name, returncode
FROM DBA_AUDIT_TRAIL
WHERE returncode != 0
ORDER BY timestamp DESC;

-- 오늘 발생한 감사 로그
SELECT username, timestamp, action_name, obj_name
FROM DBA_AUDIT_TRAIL
WHERE TRUNC(timestamp) = TRUNC(SYSDATE)
ORDER BY timestamp DESC;

-- ============================================
-- 7. 세션 감사 로그 조회
-- ============================================

-- 로그인/로그아웃 감사 로그
SELECT username, timestamp, action_name, returncode, 
       terminal, os_username, userhost
FROM DBA_AUDIT_SESSION
ORDER BY timestamp DESC
FETCH FIRST 50 ROWS ONLY;

-- 실패한 로그인 시도
SELECT username, timestamp, returncode, terminal, os_username
FROM DBA_AUDIT_SESSION
WHERE returncode != 0
ORDER BY timestamp DESC;

-- 특정 사용자의 로그인 이력
SELECT timestamp, action_name, returncode, terminal
FROM DBA_AUDIT_SESSION
WHERE username = 'TESTUSER'
ORDER BY timestamp DESC;

-- 최근 24시간 로그인 이력
SELECT username, timestamp, terminal, os_username
FROM DBA_AUDIT_SESSION
WHERE timestamp > SYSDATE - 1
ORDER BY timestamp DESC;

-- ============================================
-- 8. Fine-Grained Auditing (FGA)
-- ============================================

-- FGA 정책 추가
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'audit_salary_policy',
        audit_condition => 'SALARY > 100000',
        audit_column    => 'SALARY',
        handler_schema  => NULL,
        handler_module  => NULL,
        enable          => TRUE,
        statement_types => 'SELECT,UPDATE',
        audit_trail     => DBMS_FGA.DB + DBMS_FGA.EXTENDED,
        audit_column_opts => DBMS_FGA.ANY_COLUMNS
    );
END;
/

-- 컬럼 단위 FGA 정책
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'audit_sensitive_columns',
        audit_column    => 'SALARY, COMMISSION_PCT',
        statement_types => 'SELECT'
    );
END;
/

-- 조건부 FGA 정책
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'audit_high_salary_access',
        audit_condition => 'DEPARTMENT_ID = 10 AND SALARY > 50000',
        statement_types => 'SELECT,UPDATE,DELETE'
    );
END;
/

-- FGA 정책 비활성화
BEGIN
    DBMS_FGA.DISABLE_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'audit_salary_policy'
    );
END;
/

-- FGA 정책 활성화
BEGIN
    DBMS_FGA.ENABLE_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'audit_salary_policy'
    );
END;
/

-- FGA 정책 삭제
BEGIN
    DBMS_FGA.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'audit_salary_policy'
    );
END;
/

-- ============================================
-- 9. FGA 감사 로그 조회
-- ============================================

-- FGA 감사 로그 전체 조회
SELECT db_user, object_schema, object_name, policy_name, 
       sql_text, timestamp, statement_type
FROM DBA_FGA_AUDIT_TRAIL
ORDER BY timestamp DESC
FETCH FIRST 100 ROWS ONLY;

-- 특정 정책의 FGA 로그
SELECT db_user, timestamp, sql_text, statement_type
FROM DBA_FGA_AUDIT_TRAIL
WHERE policy_name = 'AUDIT_SALARY_POLICY'
ORDER BY timestamp DESC;

-- 특정 사용자의 FGA 로그
SELECT timestamp, object_name, policy_name, sql_text
FROM DBA_FGA_AUDIT_TRAIL
WHERE db_user = 'TESTUSER'
ORDER BY timestamp DESC;

-- FGA 정책 설정 조회
SELECT object_schema, object_name, policy_name, 
       enabled, sel, ins, upd, del
FROM DBA_AUDIT_POLICIES
WHERE object_name = 'EMPLOYEES';

-- ============================================
-- 10. 데이터베이스 활동 모니터링
-- ============================================

-- 현재 세션 정보
SELECT sid, serial#, username, status, osuser, machine, program, 
       logon_time, last_call_et
FROM V$SESSION
WHERE username IS NOT NULL
ORDER BY logon_time DESC;

-- 활성 세션 수
SELECT status, COUNT(*) AS session_count
FROM V$SESSION
WHERE username IS NOT NULL
GROUP BY status;

-- 사용자별 세션 수
SELECT username, COUNT(*) AS session_count
FROM V$SESSION
WHERE username IS NOT NULL
GROUP BY username
ORDER BY session_count DESC;

-- 장시간 실행 중인 세션
SELECT sid, serial#, username, status, last_call_et/60 AS minutes_idle
FROM V$SESSION
WHERE username IS NOT NULL
  AND status = 'ACTIVE'
  AND last_call_et > 3600
ORDER BY last_call_et DESC;

-- ============================================
-- 11. SQL 실행 이력 모니터링
-- ============================================

-- 현재 실행 중인 SQL
SELECT s.sid, s.serial#, s.username, s.status, q.sql_text
FROM V$SESSION s
JOIN V$SQL q ON s.sql_id = q.sql_id
WHERE s.username IS NOT NULL
  AND s.status = 'ACTIVE';

-- 자주 실행되는 SQL
SELECT sql_text, executions, disk_reads, buffer_gets
FROM V$SQL
WHERE executions > 100
ORDER BY executions DESC
FETCH FIRST 20 ROWS ONLY;

-- 오래 실행되는 SQL
SELECT sql_text, elapsed_time/1000000 AS elapsed_seconds, executions
FROM V$SQL
WHERE elapsed_time > 10000000
ORDER BY elapsed_time DESC
FETCH FIRST 20 ROWS ONLY;

-- ============================================
-- 12. 잠금(Lock) 모니터링
-- ============================================

-- 현재 잠금 정보
SELECT s.sid, s.serial#, s.username, o.object_name, l.locked_mode
FROM V$LOCKED_OBJECT l
JOIN V$SESSION s ON l.session_id = s.sid
JOIN DBA_OBJECTS o ON l.object_id = o.object_id;

-- 잠금 대기 세션
SELECT s1.username || '@' || s1.machine AS waiting_user,
       s2.username || '@' || s2.machine AS locking_user,
       o.object_name,
       s1.sid AS waiting_sid,
       s2.sid AS locking_sid
FROM V$LOCKED_OBJECT l1
JOIN V$SESSION s1 ON l1.session_id = s1.sid
JOIN V$LOCKED_OBJECT l2 ON l1.object_id = l2.object_id
JOIN V$SESSION s2 ON l2.session_id = s2.sid
JOIN DBA_OBJECTS o ON l1.object_id = o.object_id
WHERE s1.lockwait IS NOT NULL;

-- ============================================
-- 13. 데이터베이스 리소스 사용 모니터링
-- ============================================

-- 테이블스페이스 사용률
SELECT tablespace_name, 
       ROUND((used_space * 8192) / 1024 / 1024, 2) AS used_mb,
       ROUND((tablespace_size * 8192) / 1024 / 1024, 2) AS total_mb,
       ROUND(used_percent, 2) AS used_percent
FROM DBA_TABLESPACE_USAGE_METRICS
ORDER BY used_percent DESC;

-- 사용자별 테이블스페이스 사용량
SELECT owner, tablespace_name, 
       ROUND(SUM(bytes) / 1024 / 1024, 2) AS mb_used
FROM DBA_SEGMENTS
GROUP BY owner, tablespace_name
ORDER BY mb_used DESC;

-- 큰 테이블 TOP 20
SELECT owner, segment_name, segment_type,
       ROUND(bytes / 1024 / 1024, 2) AS mb_size
FROM DBA_SEGMENTS
WHERE segment_type = 'TABLE'
ORDER BY bytes DESC
FETCH FIRST 20 ROWS ONLY;

-- ============================================
-- 14. 에러 로그 모니터링
-- ============================================

-- Alert Log 조회 (Oracle 11g 이상)
SELECT originating_timestamp, message_text
FROM V$DIAG_ALERT_EXT
WHERE message_text LIKE '%ORA-%'
ORDER BY originating_timestamp DESC
FETCH FIRST 50 ROWS ONLY;

-- 최근 에러 발생 이력
SELECT timestamp, username, action_name, returncode
FROM DBA_AUDIT_TRAIL
WHERE returncode != 0
ORDER BY timestamp DESC
FETCH FIRST 50 ROWS ONLY;

-- ============================================
-- 15. 보안 이벤트 모니터링
-- ============================================

-- 계정 잠금 이벤트
SELECT username, account_status, lock_date, expiry_date
FROM DBA_USERS
WHERE account_status LIKE '%LOCKED%'
ORDER BY lock_date DESC;

-- 실패한 로그인 시도 (최근 24시간)
SELECT username, timestamp, os_username, userhost, terminal, returncode
FROM DBA_AUDIT_SESSION
WHERE returncode != 0
  AND timestamp > SYSDATE - 1
ORDER BY timestamp DESC;

-- 권한 변경 이력
SELECT username, timestamp, action_name, obj_name, priv_used
FROM DBA_AUDIT_TRAIL
WHERE action_name IN ('GRANT', 'REVOKE')
ORDER BY timestamp DESC
FETCH FIRST 50 ROWS ONLY;

-- DDL 변경 이력
SELECT username, timestamp, owner, obj_name, action_name
FROM DBA_AUDIT_TRAIL
WHERE action_name IN ('CREATE', 'ALTER', 'DROP')
ORDER BY timestamp DESC
FETCH FIRST 50 ROWS ONLY;

-- 비정상 접속 시간 탐지 (업무 시간 외)
SELECT username, timestamp, os_username, terminal
FROM DBA_AUDIT_SESSION
WHERE TO_CHAR(timestamp, 'HH24') NOT BETWEEN '09' AND '18'
   OR TO_CHAR(timestamp, 'D') IN ('1', '7')  -- 주말
ORDER BY timestamp DESC;

-- ============================================
-- 16. 통합 감사 (Unified Auditing) - Oracle 12c 이상
-- ============================================

-- 통합 감사 정책 생성
CREATE AUDIT POLICY sensitive_data_policy
ACTIONS SELECT ON hr.employees,
        UPDATE ON hr.employees,
        DELETE ON hr.employees;

-- 통합 감사 정책 활성화
AUDIT POLICY sensitive_data_policy;

-- 특정 사용자에게만 정책 적용
AUDIT POLICY sensitive_data_policy BY testuser;

-- 통합 감사 정책 조회
SELECT policy_name, enabled_option
FROM AUDIT_UNIFIED_ENABLED_POLICIES;

-- 통합 감사 로그 조회
SELECT event_timestamp, dbusername, action_name, object_name, sql_text
FROM UNIFIED_AUDIT_TRAIL
ORDER BY event_timestamp DESC
FETCH FIRST 100 ROWS ONLY;

-- 통합 감사 정책 비활성화
NOAUDIT POLICY sensitive_data_policy;

-- 통합 감사 정책 삭제
DROP AUDIT POLICY sensitive_data_policy;

-- ============================================
-- 17. 감사 로그 정리
-- ============================================

-- 감사 로그 삭제 (조심해서 사용)
DELETE FROM SYS.AUD$ WHERE timestamp < SYSDATE - 90;
COMMIT;

-- 감사 로그 아카이브 (백업)
CREATE TABLE audit_archive AS
SELECT * FROM DBA_AUDIT_TRAIL
WHERE timestamp < SYSDATE - 365;

-- 오래된 감사 로그 삭제
DELETE FROM SYS.AUD$ 
WHERE timestamp < SYSDATE - 365;
COMMIT;
