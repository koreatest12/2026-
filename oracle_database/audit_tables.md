# Oracle 감사(Audit) 관련 테이블 및 뷰

## 개요
Oracle의 감사 기능은 데이터베이스에서 발생하는 활동을 추적하고 기록하는 보안 메커니즘입니다.
정보보안기사 시험에서 중요한 데이터베이스 보안 주제입니다.

## 감사 유형

### 1. 표준 감사 (Standard Auditing)
- 문장 감사 (Statement Auditing)
- 권한 감사 (Privilege Auditing)
- 객체 감사 (Object Auditing)

### 2. Fine-Grained Auditing (FGA)
- 특정 조건에 맞는 데이터 접근을 감사
- 컬럼 레벨 감사 가능

### 3. 통합 감사 (Unified Auditing - 12c 이상)
- 모든 감사 유형을 통합
- 성능 향상 및 관리 간소화

## 표준 감사 관련 뷰

### 감사 추적 조회 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_AUDIT_TRAIL | 모든 감사 레코드 |
| USER_AUDIT_TRAIL | 현재 사용자 관련 감사 레코드 |
| DBA_AUDIT_SESSION | 세션 연결/종료 감사 |
| DBA_AUDIT_STATEMENT | 문장 감사 레코드 |
| DBA_AUDIT_OBJECT | 객체 접근 감사 레코드 |
| DBA_AUDIT_EXISTS | 존재 여부만 확인한 감사 |

### 감사 옵션 설정 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_STMT_AUDIT_OPTS | 문장 감사 옵션 |
| DBA_PRIV_AUDIT_OPTS | 권한 감사 옵션 |
| DBA_OBJ_AUDIT_OPTS | 객체 감사 옵션 |
| ALL_DEF_AUDIT_OPTS | 기본 감사 옵션 |

### 감사 관련 데이터 딕셔너리

| 뷰 이름 | 설명 |
|---------|------|
| AUDIT_ACTIONS | 감사 액션 코드 및 이름 매핑 |
| STMT_AUDIT_OPTION_MAP | 문장 감사 옵션 매핑 |
| ALL_AUDIT_POLICY_COLUMNS | 감사 정책 컬럼 |

## Fine-Grained Auditing (FGA) 관련 뷰

### FGA 감사 추적

| 뷰 이름 | 설명 |
|---------|------|
| DBA_FGA_AUDIT_TRAIL | FGA 감사 추적 레코드 |
| V$XML_AUDIT_TRAIL | XML 형식 감사 추적 |

### FGA 정책 관리

| 뷰 이름 | 설명 |
|---------|------|
| DBA_AUDIT_POLICIES | 모든 FGA 정책 |
| ALL_AUDIT_POLICIES | 접근 가능한 FGA 정책 |
| USER_AUDIT_POLICIES | 사용자 소유 FGA 정책 |
| DBA_AUDIT_POLICY_COLUMNS | FGA 정책의 감사 컬럼 |

## 통합 감사 (Unified Auditing) 관련 뷰

### 통합 감사 추적

| 뷰 이름 | 설명 |
|---------|------|
| UNIFIED_AUDIT_TRAIL | 통합 감사 추적 레코드 |
| DBA_AUDIT_MGMT_CLEANUP_JOBS | 감사 정리 작업 |

### 통합 감사 정책

| 뷰 이름 | 설명 |
|---------|------|
| AUDIT_UNIFIED_POLICIES | 통합 감사 정책 정의 |
| AUDIT_UNIFIED_ENABLED_POLICIES | 활성화된 통합 감사 정책 |
| AUDIT_UNIFIED_POLICY_COMMENTS | 통합 감사 정책 주석 |
| AUDIT_UNIFIED_CONTEXTS | 통합 감사 컨텍스트 |

## 감사 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_AUDIT_MGMT_CONFIG_PARAMS | 감사 관리 설정 파라미터 |
| DBA_AUDIT_MGMT_CLEAN_EVENTS | 감사 정리 이벤트 |
| DBA_AUDIT_MGMT_LAST_ARCH_TS | 마지막 아카이브 타임스탬프 |

## 감사 액션 코드

### 주요 감사 액션

| 코드 | 액션 이름 | 설명 |
|------|----------|------|
| 2 | INSERT | 레코드 삽입 |
| 3 | SELECT | 데이터 조회 |
| 4 | CREATE TABLE | 테이블 생성 |
| 5 | CREATE CLUSTER | 클러스터 생성 |
| 6 | ALTER TABLE | 테이블 변경 |
| 7 | DELETE | 레코드 삭제 |
| 9 | CREATE INDEX | 인덱스 생성 |
| 10 | DROP INDEX | 인덱스 삭제 |
| 11 | ALTER INDEX | 인덱스 변경 |
| 12 | DROP TABLE | 테이블 삭제 |
| 15 | ALTER CLUSTER | 클러스터 변경 |
| 19 | CREATE VIEW | 뷰 생성 |
| 20 | DROP VIEW | 뷰 삭제 |
| 26 | LOCK TABLE | 테이블 잠금 |
| 28 | GRANT | 권한 부여 |
| 29 | REVOKE | 권한 취소 |
| 30 | CREATE DATABASE | 데이터베이스 생성 |
| 35 | ALTER DATABASE | 데이터베이스 변경 |
| 39 | CREATE TABLESPACE | 테이블스페이스 생성 |
| 40 | ALTER TABLESPACE | 테이블스페이스 변경 |
| 41 | DROP TABLESPACE | 테이블스페이스 삭제 |
| 42 | ALTER SESSION | 세션 변경 |
| 44 | COMMIT | 커밋 |
| 45 | ROLLBACK | 롤백 |
| 47 | PL/SQL EXECUTE | PL/SQL 실행 |
| 51 | CREATE USER | 사용자 생성 |
| 52 | ALTER USER | 사용자 변경 |
| 53 | DROP USER | 사용자 삭제 |
| 100 | LOGON | 로그온 |
| 101 | LOGOFF | 로그오프 |

## 감사 설정 예제

### 1. 표준 감사 설정

#### 문장 감사 활성화
```sql
-- 테이블 생성/삭제 감사
AUDIT TABLE;

-- 사용자 관리 감사
AUDIT USER;

-- 역할 관리 감사
AUDIT ROLE;

-- 프로파일 관리 감사
AUDIT PROFILE;
```

#### 권한 감사 활성화
```sql
-- 시스템 권한 감사
AUDIT CREATE ANY TABLE;
AUDIT DROP ANY TABLE;
AUDIT ALTER ANY TABLE;

-- 성공한 경우만 감사
AUDIT SELECT ANY TABLE BY ACCESS WHENEVER SUCCESSFUL;

-- 실패한 경우만 감사
AUDIT CREATE SESSION WHENEVER NOT SUCCESSFUL;
```

#### 객체 감사 활성화
```sql
-- 특정 테이블의 모든 DML 감사
AUDIT ALL ON hr.employees;

-- SELECT만 감사
AUDIT SELECT ON hr.employees;

-- INSERT, UPDATE, DELETE 감사
AUDIT INSERT, UPDATE, DELETE ON hr.employees;

-- 성공한 경우만 감사
AUDIT SELECT ON hr.employees BY ACCESS WHENEVER SUCCESSFUL;
```

### 2. Fine-Grained Auditing (FGA) 설정

```sql
-- FGA 정책 생성 (급여 조회 감사)
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'AUDIT_SALARY_ACCESS',
        audit_condition => 'SALARY > 10000',
        audit_column    => 'SALARY',
        statement_types => 'SELECT',
        enable          => TRUE
    );
END;
/

-- 핸들러 함수를 사용하는 FGA
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'AUDIT_SALARY_HANDLER',
        audit_condition => 'SALARY > 10000',
        handler_schema  => 'HR',
        handler_module  => 'SALARY_AUDIT_PKG.LOG_SALARY_ACCESS',
        enable          => TRUE
    );
END;
/
```

### 3. 통합 감사 설정 (12c 이상)

```sql
-- 통합 감사 정책 생성
CREATE AUDIT POLICY sensitive_data_access
    ACTIONS SELECT ON hr.employees,
            UPDATE ON hr.employees,
            DELETE ON hr.employees
    WHEN 'SYS_CONTEXT(''USERENV'', ''IP_ADDRESS'') != ''192.168.1.100'''
    EVALUATE PER SESSION;

-- 정책 활성화
AUDIT POLICY sensitive_data_access;

-- 특정 사용자에게만 정책 적용
AUDIT POLICY sensitive_data_access BY hr_manager;
```

## 감사 조회 쿼리

### 1. 표준 감사 추적 조회

```sql
-- 최근 감사 레코드 조회
SELECT 
    username,
    timestamp,
    owner,
    obj_name,
    action_name,
    returncode,
    userhost,
    terminal
FROM dba_audit_trail
ORDER BY timestamp DESC
FETCH FIRST 100 ROWS ONLY;

-- 실패한 로그인 시도 조회
SELECT 
    username,
    timestamp,
    returncode,
    userhost,
    terminal
FROM dba_audit_trail
WHERE action_name = 'LOGON'
AND returncode != 0
ORDER BY timestamp DESC;

-- 특정 사용자의 객체 접근 감사
SELECT 
    username,
    timestamp,
    obj_name,
    action_name,
    sql_text
FROM dba_audit_trail
WHERE username = 'HR'
AND obj_name = 'EMPLOYEES'
ORDER BY timestamp DESC;
```

### 2. FGA 감사 추적 조회

```sql
-- FGA 감사 레코드 조회
SELECT 
    db_user,
    object_schema,
    object_name,
    policy_name,
    sql_text,
    timestamp
FROM dba_fga_audit_trail
ORDER BY timestamp DESC;

-- 특정 정책의 감사 기록
SELECT 
    db_user,
    sql_text,
    timestamp,
    statement_type
FROM dba_fga_audit_trail
WHERE policy_name = 'AUDIT_SALARY_ACCESS'
ORDER BY timestamp DESC;
```

### 3. 통합 감사 조회

```sql
-- 통합 감사 추적 조회
SELECT 
    event_timestamp,
    dbusername,
    action_name,
    object_schema,
    object_name,
    sql_text,
    return_code
FROM unified_audit_trail
WHERE event_timestamp >= SYSDATE - 1
ORDER BY event_timestamp DESC;

-- 실패한 작업 조회
SELECT 
    event_timestamp,
    dbusername,
    action_name,
    return_code,
    userhost
FROM unified_audit_trail
WHERE return_code != 0
ORDER BY event_timestamp DESC;
```

### 4. 현재 감사 옵션 조회

```sql
-- 문장 감사 옵션
SELECT * FROM dba_stmt_audit_opts;

-- 권한 감사 옵션
SELECT * FROM dba_priv_audit_opts;

-- 객체 감사 옵션
SELECT 
    owner,
    object_name,
    object_type,
    alt, aud, com, del, gra, ind, ins, 
    loc, ren, sel, upd, ref, exe
FROM dba_obj_audit_opts
WHERE owner = 'HR';
```

## 감사 비활성화

### 표준 감사 비활성화
```sql
-- 문장 감사 비활성화
NOAUDIT TABLE;

-- 권한 감사 비활성화
NOAUDIT CREATE ANY TABLE;

-- 객체 감사 비활성화
NOAUDIT ALL ON hr.employees;
```

### FGA 정책 삭제
```sql
BEGIN
    DBMS_FGA.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'AUDIT_SALARY_ACCESS'
    );
END;
/
```

### 통합 감사 정책 비활성화
```sql
NOAUDIT POLICY sensitive_data_access;
```

## 감사 레코드 관리

### 감사 추적 정리
```sql
-- 표준 감사 추적 삭제 (신중하게 사용)
DELETE FROM sys.aud$ WHERE timestamp < SYSDATE - 90;
COMMIT;

-- 통합 감사 정리 작업 생성
BEGIN
    DBMS_AUDIT_MGMT.CREATE_PURGE_JOB(
        audit_trail_type         => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
        audit_trail_purge_interval => 24,
        audit_trail_purge_name     => 'DAILY_AUDIT_PURGE',
        use_last_arch_timestamp    => TRUE
    );
END;
/
```

## 감사 베스트 프랙티스

### 1. 감사해야 할 항목
- 로그인/로그아웃 (특히 실패)
- 권한 있는 사용자의 활동 (DBA, SYSDBA)
- DDL 문장 (CREATE, ALTER, DROP)
- 민감한 데이터 접근
- 권한 부여/취소
- 사용자/역할 생성/변경/삭제

### 2. 감사 정책 설계
- 명확한 감사 목표 설정
- 과도한 감사는 성능 저하 유발
- 정기적인 감사 로그 검토
- 감사 데이터 보존 정책 수립
- 중요 감사 로그는 별도 저장

### 3. 보안 고려사항
- 감사 추적 테이블에 대한 접근 제한
- 감사 로그의 무결성 보장
- 감사 로그 아카이빙
- 실시간 알림 설정 (의심스러운 활동)

## 참고사항
- 표준 감사는 SYS.AUD$ 테이블에 저장됩니다
- FGA는 SYS.FGA_LOG$ 테이블에 저장됩니다
- 통합 감사는 전용 감사 추적에 저장됩니다
- AUDIT_TRAIL 파라미터로 감사 활성화 제어
  - NONE: 감사 비활성화
  - DB: 데이터베이스 감사 테이블에 저장
  - OS: 운영체제 파일에 저장
  - XML: XML 파일에 저장
  - DB,EXTENDED: 확장 정보 포함
