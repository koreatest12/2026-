# Oracle Database 시험 대비 요약 가이드

## 정보보안기사 Oracle Database 핵심 요약

### 1. 주요 시스템 테이블 (필수 암기)

#### 핵심 베이스 테이블
| 테이블 | 용도 |
|--------|------|
| USER$ | 데이터베이스 사용자 정보 (암호화된 패스워드) |
| TAB$ | 모든 테이블의 기본 정보 |
| COL$ | 모든 컬럼 정보 |
| OBJ$ | 모든 데이터베이스 객체 정보 |
| IND$ | 인덱스 정보 |
| AUD$ | 표준 감사 레코드 저장 |

### 2. 데이터 딕셔너리 뷰 접두사 (필수)

| 접두사 | 범위 | 설명 |
|--------|------|------|
| DBA_* | 전체 | 데이터베이스의 모든 객체 (DBA 권한 필요) |
| ALL_* | 접근 가능 | 현재 사용자가 접근 가능한 객체 |
| USER_* | 소유 | 현재 사용자가 소유한 객체 |
| V$ | 동적 | 동적 성능 뷰 (실시간 정보) |
| GV$ | RAC | RAC 환경의 전체 인스턴스 정보 |

### 3. 권한 관리 (핵심 개념)

#### 시스템 권한 vs 객체 권한
```
시스템 권한:
- CREATE SESSION (접속)
- CREATE TABLE (테이블 생성)
- CREATE USER (사용자 생성)
- SELECT ANY TABLE (모든 테이블 조회)

객체 권한:
- SELECT, INSERT, UPDATE, DELETE (DML)
- ALTER, INDEX, REFERENCES (DDL)
- EXECUTE (프로시저/함수 실행)
```

#### WITH 옵션
```
WITH ADMIN OPTION (시스템 권한)
- 권한을 받은 사용자가 다른 사용자에게 재부여 가능
- 권한 회수 시 연쇄 회수 안됨

WITH GRANT OPTION (객체 권한)
- 권한을 받은 사용자가 다른 사용자에게 재부여 가능
- 권한 회수 시 연쇄 회수됨
```

### 4. 역할(Role) 관리

#### 기본 역할
| 역할 | 설명 |
|------|------|
| CONNECT | 데이터베이스 접속 권한 |
| RESOURCE | 객체 생성 권한 |
| DBA | 데이터베이스 관리자 권한 (모든 권한) |
| SELECT_CATALOG_ROLE | 데이터 딕셔너리 조회 권한 |

#### 역할 관리 명령
```sql
CREATE ROLE role_name;
GRANT privilege TO role_name;
GRANT role_name TO user_name;
SET ROLE role_name;  -- 세션에서 역할 활성화
```

### 5. 감사(Audit) 유형 (필수)

#### 3가지 주요 감사 유형
```
1. 표준 감사 (Standard Auditing)
   - 문장 감사: AUDIT TABLE
   - 권한 감사: AUDIT CREATE SESSION
   - 객체 감사: AUDIT SELECT ON table_name

2. Fine-Grained Auditing (FGA)
   - 특정 조건의 데이터 접근 감사
   - DBMS_FGA 패키지 사용
   - 컬럼 레벨 감사 가능

3. 통합 감사 (Unified Auditing - 12c 이상)
   - 모든 감사 유형 통합
   - UNIFIED_AUDIT_TRAIL 뷰
```

#### 감사 활성화
```sql
-- AUDIT_TRAIL 파라미터
ALTER SYSTEM SET AUDIT_TRAIL = DB SCOPE=SPFILE;
-- DB: 데이터베이스 테이블에 저장
-- OS: 운영체제 파일에 저장
-- XML: XML 파일에 저장
-- NONE: 비활성화
```

### 6. 암호화 (TDE)

#### TDE 암호화 유형
```
1. 컬럼 암호화
   - 특정 컬럼만 암호화
   - CREATE TABLE ... (column ENCRYPT)
   
2. 테이블스페이스 암호화
   - 전체 테이블스페이스 암호화
   - CREATE TABLESPACE ... ENCRYPTION USING 'AES256'
```

#### 암호화 알고리즘
- AES128, AES192, AES256
- 3DES168
- ARIA128, ARIA192, ARIA256

### 7. VPD/RLS (Row Level Security)

#### 개념
- 행 레벨 보안
- 사용자별로 다른 데이터 접근 제어
- DBMS_RLS 패키지 사용

#### 구현
```sql
-- 1. 보안 함수 생성
CREATE FUNCTION security_policy(...) RETURN VARCHAR2

-- 2. 정책 추가
DBMS_RLS.ADD_POLICY(
    object_schema => 'HR',
    object_name => 'EMPLOYEES',
    policy_name => 'EMP_POLICY',
    policy_function => 'SECURITY_POLICY'
);
```

### 8. 프로파일 (Profile)

#### 리소스 제한
```sql
CREATE PROFILE app_profile LIMIT
    SESSIONS_PER_USER 3          -- 동시 세션 수
    CPU_PER_SESSION UNLIMITED    -- CPU 시간
    IDLE_TIME 30                 -- 유휴 시간(분)
    CONNECT_TIME 480;            -- 접속 시간(분)
```

#### 패스워드 정책
```sql
CREATE PROFILE secure_profile LIMIT
    FAILED_LOGIN_ATTEMPTS 3      -- 로그인 실패 횟수
    PASSWORD_LIFE_TIME 90        -- 패스워드 유효기간(일)
    PASSWORD_REUSE_TIME 365      -- 재사용 금지기간(일)
    PASSWORD_REUSE_MAX 5         -- 재사용 금지 개수
    PASSWORD_LOCK_TIME 1         -- 계정 잠금 시간(일)
    PASSWORD_GRACE_TIME 7;       -- 만료 유예기간(일)
```

### 9. 주요 동적 성능 뷰 (V$)

| 뷰 | 용도 |
|----|------|
| V$SESSION | 현재 세션 정보 |
| V$SQL | SQL 문장 정보 |
| V$LOCK | 락 정보 |
| V$LOCKED_OBJECT | 잠긴 객체 |
| V$DATABASE | 데이터베이스 정보 |
| V$INSTANCE | 인스턴스 정보 |
| V$PARAMETER | 초기화 파라미터 |
| V$SYSSTAT | 시스템 통계 |

### 10. 보안 관련 주요 뷰

#### 사용자 및 권한
```sql
DBA_USERS           -- 모든 사용자
DBA_SYS_PRIVS       -- 시스템 권한
DBA_TAB_PRIVS       -- 객체 권한
DBA_ROLE_PRIVS      -- 역할 권한
DBA_ROLES           -- 모든 역할
```

#### 감사
```sql
DBA_AUDIT_TRAIL         -- 표준 감사 추적
DBA_FGA_AUDIT_TRAIL     -- FGA 감사 추적
UNIFIED_AUDIT_TRAIL     -- 통합 감사 추적
DBA_AUDIT_POLICIES      -- 감사 정책
```

#### 암호화
```sql
DBA_ENCRYPTED_COLUMNS   -- 암호화된 컬럼
V$ENCRYPTION_WALLET     -- Wallet 상태
DBA_TABLESPACES         -- 테이블스페이스 (암호화 정보 포함)
```

### 11. 보안 취약점 점검 항목

#### 계정 보안
- [ ] 기본 패스워드 사용 계정 (DBA_USERS_WITH_DEFPWD)
- [ ] 패스워드 정책 미적용 계정
- [ ] 만료되지 않는 계정
- [ ] 불필요한 계정

#### 권한 보안
- [ ] 과도한 DBA 권한
- [ ] ANY 권한 부여 (SELECT ANY TABLE 등)
- [ ] PUBLIC에 부여된 권한
- [ ] 불필요한 시스템 권한

#### 감사
- [ ] 감사 활성화 여부
- [ ] 로그인 실패 감사
- [ ] DDL 감사
- [ ] 민감 데이터 접근 감사

#### 네트워크
- [ ] SQL*Net 암호화 설정
- [ ] 리스너 보안 설정
- [ ] 접근 제어 (listener.ora, sqlnet.ora)

### 12. 주요 SQL 명령어 정리

#### 사용자 관리
```sql
CREATE USER username IDENTIFIED BY password;
ALTER USER username IDENTIFIED BY new_password;
ALTER USER username ACCOUNT LOCK;
DROP USER username CASCADE;
```

#### 권한 관리
```sql
GRANT privilege TO user;
REVOKE privilege FROM user;
GRANT role TO user;
REVOKE role FROM user;
```

#### 감사
```sql
AUDIT action;
NOAUDIT action;
AUDIT action ON object;
```

#### 프로파일
```sql
CREATE PROFILE profile_name LIMIT ...;
ALTER USER username PROFILE profile_name;
DROP PROFILE profile_name CASCADE;
```

### 13. 시험 빈출 개념

#### 인증 방식
1. **Database 인증**: Oracle 내부 패스워드 관리
2. **OS 인증**: 운영체제 계정 연동
3. **외부 인증**: LDAP, Kerberos 등

#### 보안 모델
1. **임의 접근 제어 (DAC)**: GRANT/REVOKE
2. **강제 접근 제어 (MAC)**: Label Security
3. **역할 기반 접근 제어 (RBAC)**: ROLE 사용

#### 암호화 키 관리
- **Wallet**: TDE 암호화 키 저장소
- **Master Key**: 데이터 암호화 키를 암호화
- **Tablespace Key**: 테이블스페이스 암호화 키

### 14. 자주 나오는 오류 및 해결

| 오류 코드 | 의미 | 해결 |
|----------|------|------|
| ORA-00942 | 테이블/뷰가 존재하지 않음 | 권한 확인 또는 객체 생성 |
| ORA-01017 | 잘못된 사용자명/패스워드 | 패스워드 확인 |
| ORA-01031 | 권한 불충분 | 필요한 권한 부여 |
| ORA-28000 | 계정 잠김 | ALTER USER ... ACCOUNT UNLOCK |
| ORA-28001 | 패스워드 만료 | 패스워드 변경 |

### 15. 정보보안기사 핵심 체크리스트

#### 이론 개념
- [ ] CIA Triad (기밀성, 무결성, 가용성)
- [ ] 접근 제어 모델 (DAC, MAC, RBAC)
- [ ] 암호화 알고리즘 (대칭키, 비대칭키)
- [ ] 인증 vs 인가
- [ ] 감사 추적의 중요성

#### Oracle 실무
- [ ] 사용자 생성 및 권한 관리
- [ ] 역할 생성 및 할당
- [ ] 감사 설정 및 모니터링
- [ ] TDE 암호화 구현
- [ ] VPD/RLS 정책 설정
- [ ] 프로파일 정책 수립
- [ ] 보안 취약점 점검

#### 데이터 딕셔너리
- [ ] DBA_USERS 활용
- [ ] DBA_SYS_PRIVS, DBA_TAB_PRIVS 이해
- [ ] DBA_AUDIT_TRAIL 분석
- [ ] V$SESSION, V$SQL 모니터링
- [ ] DBA_ENCRYPTED_COLUMNS 확인

## 학습 팁

### 1. 실습 중심 학습
- Oracle XE 설치하여 직접 실습
- 각 명령어를 직접 실행해보기
- 에러 메시지 분석 및 해결 경험

### 2. 쿼리 암기
- 자주 사용하는 보안 점검 쿼리 암기
- 데이터 딕셔너리 뷰 활용법 숙지

### 3. 시나리오 학습
- 실제 보안 사고 사례 분석
- 취약점 발견 및 해결 과정 이해

### 4. 연관 개념 학습
- 데이터베이스 보안과 네트워크 보안 연계
- 암호학 기초 이론 학습
- 정보보호 관리체계 이해

## 참고 자료
- Oracle Database Security Guide (공식 문서)
- 정보보안기사 데이터베이스 보안 단원
- CIS Oracle Database Benchmark
- OWASP Database Security Cheat Sheet
