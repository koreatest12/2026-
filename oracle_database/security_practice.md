# Oracle 데이터베이스 보안 실습 가이드

## 정보보안기사 시험 준비용

### 실습 환경 설정

#### Oracle Database Express Edition (XE) 설치
```bash
# Oracle XE 21c 다운로드 (무료)
# https://www.oracle.com/database/technologies/xe-downloads.html

# 설치 후 환경변수 설정 (Linux/Mac)
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=XE
```

### 1. 사용자 및 권한 관리 실습

#### 1.1 사용자 생성 및 관리
```sql
-- 사용자 생성
CREATE USER test_user IDENTIFIED BY SecurePass123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 100M ON users;

-- 프로파일을 사용한 사용자 생성
CREATE PROFILE secure_profile LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    PASSWORD_LIFE_TIME 90
    PASSWORD_REUSE_TIME 365
    PASSWORD_REUSE_MAX 5
    PASSWORD_LOCK_TIME 1/24  -- 1시간
    PASSWORD_GRACE_TIME 7;

CREATE USER secure_user IDENTIFIED BY SecurePass123
PROFILE secure_profile;

-- 사용자 확인
SELECT username, account_status, profile, created
FROM dba_users
WHERE username IN ('TEST_USER', 'SECURE_USER');
```

#### 1.2 권한 부여 및 관리
```sql
-- 시스템 권한 부여
GRANT CREATE SESSION TO test_user;
GRANT CREATE TABLE TO test_user;
GRANT CREATE VIEW TO test_user;
GRANT CREATE PROCEDURE TO test_user;

-- 객체 권한 부여
GRANT SELECT, INSERT, UPDATE ON hr.employees TO test_user;
GRANT SELECT ON hr.departments TO test_user;

-- WITH ADMIN OPTION (시스템 권한)
GRANT CREATE SESSION TO test_user WITH ADMIN OPTION;

-- WITH GRANT OPTION (객체 권한)
GRANT SELECT ON hr.employees TO test_user WITH GRANT OPTION;

-- 권한 확인
SELECT * FROM dba_sys_privs WHERE grantee = 'TEST_USER';
SELECT * FROM dba_tab_privs WHERE grantee = 'TEST_USER';
```

#### 1.3 역할 생성 및 관리
```sql
-- 역할 생성
CREATE ROLE app_developer;
CREATE ROLE app_user;
CREATE ROLE app_admin;

-- 역할에 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO app_developer;
GRANT CREATE SESSION, CREATE PROCEDURE TO app_user;
GRANT CREATE SESSION, CREATE ANY TABLE, DROP ANY TABLE TO app_admin;

-- 사용자에게 역할 부여
GRANT app_developer TO test_user;

-- 기본 역할 설정
ALTER USER test_user DEFAULT ROLE app_developer;

-- 역할 확인
SELECT * FROM dba_role_privs WHERE grantee = 'TEST_USER';
SELECT * FROM role_sys_privs WHERE role = 'APP_DEVELOPER';
```

### 2. 감사(Audit) 실습

#### 2.1 표준 감사 설정
```sql
-- 감사 활성화 확인
SHOW PARAMETER audit_trail;

-- 감사 활성화 (DB 재시작 필요)
ALTER SYSTEM SET audit_trail = DB, EXTENDED SCOPE=SPFILE;

-- 로그온/로그오프 감사
AUDIT SESSION;
AUDIT SESSION WHENEVER NOT SUCCESSFUL;

-- DDL 감사
AUDIT TABLE BY test_user;
AUDIT INDEX BY test_user;
AUDIT VIEW BY test_user;

-- DML 감사 (특정 객체)
AUDIT SELECT, INSERT, UPDATE, DELETE ON hr.employees BY ACCESS;

-- 권한 감사
AUDIT CREATE ANY TABLE;
AUDIT DROP ANY TABLE;

-- 감사 레코드 조회
SELECT username, timestamp, action_name, obj_name, returncode
FROM dba_audit_trail
WHERE username = 'TEST_USER'
ORDER BY timestamp DESC;

-- 실패한 로그인 시도
SELECT username, timestamp, returncode, userhost
FROM dba_audit_trail
WHERE action_name = 'LOGON' AND returncode != 0
ORDER BY timestamp DESC;
```

#### 2.2 Fine-Grained Auditing (FGA)
```sql
-- FGA 정책 생성 (급여 정보 접근 감사)
BEGIN
    DBMS_FGA.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'SALARY_AUDIT',
        audit_condition => 'SALARY > 10000',
        audit_column    => 'SALARY, COMMISSION_PCT',
        statement_types => 'SELECT, UPDATE',
        enable          => TRUE
    );
END;
/

-- FGA 감사 레코드 조회
SELECT db_user, sql_text, timestamp, object_schema, object_name
FROM dba_fga_audit_trail
WHERE policy_name = 'SALARY_AUDIT'
ORDER BY timestamp DESC;

-- FGA 정책 삭제
BEGIN
    DBMS_FGA.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'SALARY_AUDIT'
    );
END;
/
```

### 3. 데이터 암호화 실습

#### 3.1 TDE (Transparent Data Encryption) 설정
```sql
-- Wallet 생성 (SYSDBA 권한 필요)
ALTER SYSTEM SET ENCRYPTION KEY IDENTIFIED BY "WalletPassword123";

-- Wallet 상태 확인
SELECT * FROM v$encryption_wallet;

-- 암호화된 테이블스페이스 생성
CREATE TABLESPACE encrypted_ts
DATAFILE 'encrypted_ts01.dbf' SIZE 100M
ENCRYPTION USING 'AES256'
DEFAULT STORAGE(ENCRYPT);

-- 특정 컬럼 암호화
CREATE TABLE secure_data (
    id NUMBER PRIMARY KEY,
    ssn VARCHAR2(20) ENCRYPT USING 'AES256',
    credit_card VARCHAR2(20) ENCRYPT,
    salary NUMBER ENCRYPT
);

-- 암호화된 컬럼 확인
SELECT table_name, column_name, encryption_alg
FROM dba_encrypted_columns
WHERE owner = USER;
```

#### 3.2 DBMS_CRYPTO 패키지 사용
```sql
-- 암호화/복호화 함수 생성
CREATE OR REPLACE FUNCTION encrypt_data(p_text VARCHAR2)
RETURN RAW IS
    l_key       RAW(32) := UTL_I18N.STRING_TO_RAW('MySecretKey12345678901234567890', 'AL32UTF8');
    l_encrypted RAW(2000);
BEGIN
    l_encrypted := DBMS_CRYPTO.ENCRYPT(
        src => UTL_I18N.STRING_TO_RAW(p_text, 'AL32UTF8'),
        typ => DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
        key => l_key
    );
    RETURN l_encrypted;
END;
/

CREATE OR REPLACE FUNCTION decrypt_data(p_raw RAW)
RETURN VARCHAR2 IS
    l_key       RAW(32) := UTL_I18N.STRING_TO_RAW('MySecretKey12345678901234567890', 'AL32UTF8');
    l_decrypted RAW(2000);
BEGIN
    l_decrypted := DBMS_CRYPTO.DECRYPT(
        src => p_raw,
        typ => DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
        key => l_key
    );
    RETURN UTL_I18N.RAW_TO_CHAR(l_decrypted, 'AL32UTF8');
END;
/

-- 사용 예제
SELECT encrypt_data('민감한 정보') AS encrypted FROM dual;
SELECT decrypt_data(encrypt_data('민감한 정보')) AS decrypted FROM dual;
```

### 4. VPD (Virtual Private Database) 실습

#### 4.1 RLS (Row Level Security) 정책 생성
```sql
-- 보안 정책 함수 생성
CREATE OR REPLACE FUNCTION employee_security_policy(
    p_schema VARCHAR2,
    p_object VARCHAR2
) RETURN VARCHAR2 IS
    v_user VARCHAR2(100);
    v_predicate VARCHAR2(1000);
BEGIN
    v_user := SYS_CONTEXT('USERENV', 'SESSION_USER');
    
    -- 관리자는 모든 데이터 접근
    IF v_user = 'HR_ADMIN' THEN
        RETURN NULL;
    -- 일반 사용자는 본인 부서 데이터만 접근
    ELSE
        v_predicate := 'DEPARTMENT_ID = (
            SELECT DEPARTMENT_ID 
            FROM HR.EMPLOYEES 
            WHERE EMAIL = ''' || v_user || ''')';
        RETURN v_predicate;
    END IF;
END;
/

-- 정책 적용
BEGIN
    DBMS_RLS.ADD_POLICY(
        object_schema   => 'HR',
        object_name     => 'EMPLOYEES',
        policy_name     => 'EMP_SECURITY_POLICY',
        function_schema => 'HR',
        policy_function => 'EMPLOYEE_SECURITY_POLICY',
        statement_types => 'SELECT, INSERT, UPDATE, DELETE'
    );
END;
/

-- 정책 확인
SELECT * FROM dba_policies WHERE object_name = 'EMPLOYEES';

-- 정책 삭제
BEGIN
    DBMS_RLS.DROP_POLICY(
        object_schema => 'HR',
        object_name   => 'EMPLOYEES',
        policy_name   => 'EMP_SECURITY_POLICY'
    );
END;
/
```

### 5. 네트워크 보안 실습

#### 5.1 SQL*Net 암호화 설정
```bash
# sqlnet.ora 파일 설정
SQLNET.ENCRYPTION_SERVER = REQUIRED
SQLNET.ENCRYPTION_TYPES_SERVER = (AES256, AES192, AES128)
SQLNET.CRYPTO_CHECKSUM_SERVER = REQUIRED
SQLNET.CRYPTO_CHECKSUM_TYPES_SERVER = (SHA256, SHA384, SHA512)
```

#### 5.2 연결 암호화 확인
```sql
-- 현재 세션의 암호화 상태 확인
SELECT network_service_banner
FROM v$session_connect_info
WHERE sid = (SELECT DISTINCT sid FROM v$mystat);

-- 모든 세션의 암호화 정보
SELECT 
    s.username,
    s.sid,
    s.serial#,
    i.network_service_banner
FROM v$session s
JOIN v$session_connect_info i ON s.sid = i.sid
WHERE s.username IS NOT NULL;
```

### 6. 보안 점검 쿼리

#### 6.1 기본 패스워드 사용자 확인
```sql
SELECT username, account_status
FROM dba_users_with_defpwd;
```

#### 6.2 DBA 권한 사용자 확인
```sql
SELECT grantee, granted_role
FROM dba_role_privs
WHERE granted_role = 'DBA';
```

#### 6.3 과도한 권한 확인
```sql
-- ANY 권한을 가진 사용자
SELECT grantee, privilege
FROM dba_sys_privs
WHERE privilege LIKE '%ANY%'
AND grantee NOT IN ('SYS', 'SYSTEM', 'DBA')
ORDER BY grantee, privilege;
```

#### 6.4 PUBLIC에 부여된 권한 확인
```sql
SELECT * FROM dba_tab_privs WHERE grantee = 'PUBLIC';
SELECT * FROM dba_sys_privs WHERE grantee = 'PUBLIC';
```

#### 6.5 패스워드 정책 확인
```sql
SELECT profile, resource_name, limit
FROM dba_profiles
WHERE resource_type = 'PASSWORD'
ORDER BY profile, resource_name;
```

### 7. 실습 시나리오

#### 시나리오 1: 보안 관리자 역할 구현
```sql
-- 1. 보안 관리자 사용자 생성
CREATE USER security_admin IDENTIFIED BY SecAdmin123;

-- 2. 필요한 권한만 부여
GRANT CREATE SESSION TO security_admin;
GRANT SELECT ON dba_users TO security_admin;
GRANT SELECT ON dba_sys_privs TO security_admin;
GRANT SELECT ON dba_tab_privs TO security_admin;
GRANT SELECT ON dba_audit_trail TO security_admin;

-- 3. 감사 권한 부여
GRANT AUDIT ANY TO security_admin;
GRANT AUDIT SYSTEM TO security_admin;
```

#### 시나리오 2: 애플리케이션 계정 보안 설정
```sql
-- 1. 애플리케이션 전용 프로파일 생성
CREATE PROFILE app_profile LIMIT
    SESSIONS_PER_USER 5
    CPU_PER_SESSION UNLIMITED
    IDLE_TIME 30
    CONNECT_TIME 480
    FAILED_LOGIN_ATTEMPTS 5
    PASSWORD_LIFE_TIME 60
    PASSWORD_LOCK_TIME 1;

-- 2. 애플리케이션 사용자 생성
CREATE USER app_account IDENTIFIED BY AppPass123
PROFILE app_profile
ACCOUNT LOCK;

-- 3. 필요한 최소 권한만 부여
GRANT CREATE SESSION TO app_account;
GRANT SELECT, INSERT, UPDATE, DELETE ON app_schema.app_table TO app_account;

-- 4. 계정 활성화
ALTER USER app_account ACCOUNT UNLOCK;
```

## 보안 체크리스트

### 데이터베이스 보안 점검 항목
- [ ] 기본 패스워드 사용 계정 확인
- [ ] 불필요한 DBA 권한 확인
- [ ] PUBLIC 권한 검토
- [ ] 감사 활성화 상태 확인
- [ ] 패스워드 정책 적용 확인
- [ ] 네트워크 암호화 설정 확인
- [ ] 민감 데이터 암호화 확인
- [ ] 불필요한 서비스 계정 확인
- [ ] 로그 파일 접근 권한 확인
- [ ] 정기적인 패스워드 변경 정책 확인

## 참고 자료

### 공식 문서
- Oracle Database Security Guide
- Oracle Database Administrator's Guide
- Oracle Database SQL Language Reference

### 정보보안기사 관련 주제
1. 데이터베이스 접근 제어
2. 암호화 및 키 관리
3. 감사 및 모니터링
4. 사용자 인증 및 권한 관리
5. 네트워크 보안
6. 백업 및 복구 보안
