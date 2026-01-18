# Oracle 보안 관련 테이블 및 뷰

## 개요
정보보안기사 시험을 위한 Oracle 데이터베이스 보안 관련 테이블 및 뷰 목록입니다.

## 사용자 및 권한 관련 뷰

### 사용자 관리

| 뷰 이름 | 설명 |
|---------|------|
| DBA_USERS | 모든 데이터베이스 사용자 정보 |
| ALL_USERS | 모든 사용자 이름 |
| USER_USERS | 현재 사용자 정보 |
| DBA_TS_QUOTAS | 테이블스페이스 할당량 |
| USER_TS_QUOTAS | 사용자 테이블스페이스 할당량 |

### 역할(Role) 관리

| 뷰 이름 | 설명 |
|---------|------|
| DBA_ROLES | 모든 역할 정보 |
| DBA_ROLE_PRIVS | 역할 권한 정보 |
| USER_ROLE_PRIVS | 사용자에게 부여된 역할 |
| ROLE_ROLE_PRIVS | 역할에 부여된 역할 |
| ROLE_SYS_PRIVS | 역할에 부여된 시스템 권한 |
| ROLE_TAB_PRIVS | 역할에 부여된 객체 권한 |
| SESSION_ROLES | 현재 세션에서 활성화된 역할 |

### 시스템 권한

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SYS_PRIVS | 시스템 권한 부여 정보 |
| USER_SYS_PRIVS | 사용자의 시스템 권한 |
| SESSION_PRIVS | 현재 세션의 권한 |
| SYSTEM_PRIVILEGE_MAP | 시스템 권한 코드 매핑 |

### 객체 권한

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TAB_PRIVS | 객체 권한 정보 |
| ALL_TAB_PRIVS | 접근 가능한 객체 권한 |
| USER_TAB_PRIVS | 사용자 소유 객체의 권한 |
| DBA_COL_PRIVS | 컬럼 레벨 권한 |
| ALL_COL_PRIVS | 접근 가능한 컬럼 권한 |
| USER_COL_PRIVS | 사용자 컬럼 권한 |
| TABLE_PRIVILEGES | 테이블 권한 정보 |

## 감사(Audit) 관련 뷰

### 표준 감사

| 뷰 이름 | 설명 |
|---------|------|
| DBA_AUDIT_TRAIL | 표준 감사 추적 정보 |
| USER_AUDIT_TRAIL | 사용자 감사 추적 |
| DBA_AUDIT_STATEMENT | 문장 감사 옵션 |
| DBA_AUDIT_OBJECT | 객체 감사 옵션 |
| DBA_STMT_AUDIT_OPTS | 문장 감사 옵션 설정 |
| DBA_PRIV_AUDIT_OPTS | 권한 감사 옵션 설정 |
| DBA_OBJ_AUDIT_OPTS | 객체 감사 옵션 설정 |
| ALL_DEF_AUDIT_OPTS | 기본 감사 옵션 |

### Fine-Grained Auditing (FGA)

| 뷰 이름 | 설명 |
|---------|------|
| DBA_FGA_AUDIT_TRAIL | FGA 감사 추적 |
| DBA_AUDIT_POLICIES | 감사 정책 정보 |
| ALL_AUDIT_POLICIES | 접근 가능한 감사 정책 |
| USER_AUDIT_POLICIES | 사용자 감사 정책 |
| DBA_AUDIT_POLICY_COLUMNS | 감사 정책 컬럼 |

### 통합 감사 (Unified Auditing - 12c 이상)

| 뷰 이름 | 설명 |
|---------|------|
| UNIFIED_AUDIT_TRAIL | 통합 감사 추적 |
| AUDIT_UNIFIED_POLICIES | 통합 감사 정책 |
| AUDIT_UNIFIED_ENABLED_POLICIES | 활성화된 감사 정책 |
| AUDIT_UNIFIED_POLICY_COMMENTS | 감사 정책 주석 |

### 감사 관련 동적 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$ENABLEDPRIVS | 활성화된 권한 |
| V$PWFILE_USERS | 패스워드 파일의 사용자 |

## 암호화 관련 뷰

### TDE (Transparent Data Encryption)

| 뷰 이름 | 설명 |
|---------|------|
| DBA_ENCRYPTED_COLUMNS | 암호화된 컬럼 정보 |
| ALL_ENCRYPTED_COLUMNS | 접근 가능한 암호화 컬럼 |
| USER_ENCRYPTED_COLUMNS | 사용자 암호화 컬럼 |
| V$ENCRYPTION_WALLET | 암호화 지갑 상태 |
| V$ENCRYPTION_KEYS | 암호화 키 정보 |
| DBA_TABLESPACES | 암호화된 테이블스페이스 정보 포함 |

## 프로파일 및 패스워드 관리

| 뷰 이름 | 설명 |
|---------|------|
| DBA_PROFILES | 프로파일 정보 |
| USER_PASSWORD_LIMITS | 사용자 패스워드 제한 |
| DBA_USERS_WITH_DEFPWD | 기본 패스워드를 사용하는 사용자 |
| USER_RESOURCE_LIMITS | 사용자 리소스 제한 |

## VPD (Virtual Private Database) 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_POLICIES | RLS 정책 정보 |
| ALL_POLICIES | 접근 가능한 RLS 정책 |
| USER_POLICIES | 사용자 RLS 정책 |
| DBA_POLICY_GROUPS | 정책 그룹 정보 |
| DBA_POLICY_CONTEXTS | 정책 컨텍스트 정보 |

## 네트워크 암호화 및 접근 제어

| 뷰 이름 | 설명 |
|---------|------|
| V$SESSION_CONNECT_INFO | 세션 연결 정보 (암호화 포함) |
| V$CRYPTO_CLIENT_INFO | 클라이언트 암호화 정보 |

## 레이블 보안 (Label Security)

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SA_POLICIES | 레이블 보안 정책 |
| DBA_SA_LABELS | 레이블 정의 |
| DBA_SA_LEVELS | 레이블 레벨 |
| DBA_SA_COMPARTMENTS | 레이블 구획 |
| DBA_SA_GROUPS | 레이블 그룹 |
| DBA_SA_USER_LABELS | 사용자 레이블 권한 |

## Database Vault 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DVSYS.DBA_DV_REALM | Database Vault Realm |
| DVSYS.DBA_DV_REALM_AUTH | Realm 권한 부여 |
| DVSYS.DBA_DV_RULE_SET | 규칙 세트 |
| DVSYS.DBA_DV_COMMAND_RULE | 명령 규칙 |
| DVSYS.DBA_DV_FACTOR | 팩터 정의 |

## 보안 관련 주요 쿼리 예제

### 1. 사용자 권한 조회
```sql
-- 사용자의 시스템 권한 조회
SELECT * FROM dba_sys_privs WHERE grantee = 'HR';

-- 사용자의 역할 조회
SELECT * FROM dba_role_privs WHERE grantee = 'HR';

-- 사용자의 객체 권한 조회
SELECT * FROM dba_tab_privs WHERE grantee = 'HR';
```

### 2. 감사 설정 조회
```sql
-- 현재 감사 옵션 조회
SELECT * FROM dba_stmt_audit_opts;
SELECT * FROM dba_priv_audit_opts;
SELECT * FROM dba_obj_audit_opts;

-- 감사 추적 조회
SELECT username, timestamp, action_name, returncode
FROM dba_audit_trail
WHERE username = 'HR'
ORDER BY timestamp DESC;
```

### 3. 암호화된 컬럼 조회
```sql
SELECT owner, table_name, column_name, encryption_alg
FROM dba_encrypted_columns
ORDER BY owner, table_name;
```

### 4. 패스워드 정책 조회
```sql
SELECT profile, resource_name, limit
FROM dba_profiles
WHERE resource_type = 'PASSWORD'
ORDER BY profile, resource_name;
```

### 5. 활성 세션 및 권한 조회
```sql
SELECT s.username, s.sid, s.serial#, s.status, s.osuser, s.machine
FROM v$session s
WHERE s.username IS NOT NULL
ORDER BY s.username;
```

### 6. 기본 패스워드 사용자 확인
```sql
SELECT username, account_status
FROM dba_users_with_defpwd;
```

## 보안 베스트 프랙티스

### 권한 관리
1. 최소 권한 원칙 적용
2. 역할(Role)을 사용한 권한 관리
3. 불필요한 PUBLIC 권한 제거
4. 정기적인 권한 검토

### 감사 설정
1. 민감한 데이터 접근 감사
2. 권한 변경 감사
3. 실패한 로그인 시도 감사
4. DDL 문장 감사

### 패스워드 정책
1. 복잡성 요구사항 설정
2. 패스워드 만료 정책
3. 계정 잠금 정책
4. 패스워드 재사용 방지

### 암호화
1. 민감한 데이터 TDE 암호화
2. 네트워크 트래픽 암호화
3. 백업 암호화
4. 정기적인 암호화 키 로테이션

## 참고사항
- 정보보안기사 시험에서는 데이터베이스 보안 개념이 중요합니다
- Oracle의 다층 보안 모델을 이해해야 합니다
- 감사(Auditing) 기능의 설정 및 관리 방법을 숙지해야 합니다
- 암호화(TDE) 및 접근 제어(VPD) 개념을 이해해야 합니다
