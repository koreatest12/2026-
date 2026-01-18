# 오라클 데이터베이스 테이블 설계 문서

## 개요
이 문서는 정보보안 시스템을 위한 오라클 데이터베이스 테이블 설계를 설명합니다.

## 목차
1. [테이블 구조](#테이블-구조)
2. [테이블 상세 설명](#테이블-상세-설명)
3. [관계도](#관계도)
4. [인덱스 전략](#인덱스-전략)
5. [설치 및 사용 방법](#설치-및-사용-방법)

---

## 테이블 구조

### 1. 사용자 관리 (User Management)
- **USERS**: 사용자 정보
- **ROLES**: 역할 정보
- **USER_ROLES**: 사용자-역할 매핑

### 2. 접근 제어 (Access Control)
- **PERMISSIONS**: 권한 정보
- **ROLE_PERMISSIONS**: 역할-권한 매핑

### 3. 감사 로그 (Audit Logging)
- **AUDIT_LOGS**: 시스템 감사 로그
- **LOGIN_HISTORY**: 로그인 이력

### 4. 보안 정책 (Security Policies)
- **SECURITY_POLICIES**: 보안 정책
- **PASSWORD_POLICIES**: 패스워드 정책
- **PASSWORD_HISTORY**: 패스워드 변경 이력

### 5. 취약점 관리 (Vulnerability Management)
- **VULNERABILITIES**: 취약점 정보
- **SECURITY_INCIDENTS**: 보안 사고

---

## 테이블 상세 설명

### USERS (사용자 정보)
사용자 계정 정보를 저장하는 핵심 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| USER_ID | NUMBER(10) | 사용자 고유 ID | Primary Key |
| USERNAME | VARCHAR2(50) | 사용자 이름 | Unique, Not Null |
| PASSWORD_HASH | VARCHAR2(256) | 암호화된 패스워드 | Not Null |
| EMAIL | VARCHAR2(100) | 이메일 주소 | Unique, Not Null |
| FULL_NAME | VARCHAR2(100) | 전체 이름 | Not Null |
| PHONE_NUMBER | VARCHAR2(20) | 전화번호 | |
| DEPARTMENT | VARCHAR2(50) | 부서명 | |
| POSITION | VARCHAR2(50) | 직급 | |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |
| ACCOUNT_LOCKED | CHAR(1) | 계정 잠금 여부 (Y/N) | Default 'N' |
| FAILED_LOGIN_ATTEMPTS | NUMBER(3) | 로그인 실패 횟수 | Default 0 |
| LAST_LOGIN | TIMESTAMP | 마지막 로그인 시간 | |
| PASSWORD_CHANGED_DATE | TIMESTAMP | 패스워드 변경 일자 | |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**주요 기능:**
- 사용자 인증 정보 관리
- 계정 잠금 메커니즘
- 로그인 실패 추적
- 패스워드 변경 이력 추적

---

### ROLES (역할 정보)
시스템 내 역할을 정의하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| ROLE_ID | NUMBER(10) | 역할 고유 ID | Primary Key |
| ROLE_NAME | VARCHAR2(50) | 역할 이름 | Unique, Not Null |
| ROLE_DESC | VARCHAR2(200) | 역할 설명 | |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**기본 역할:**
- ADMIN: 시스템 관리자
- SECURITY_OFFICER: 보안 담당자
- AUDITOR: 감사자
- USER: 일반 사용자
- GUEST: 게스트 사용자

---

### USER_ROLES (사용자-역할 매핑)
사용자와 역할 간의 다대다 관계를 관리하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| USER_ROLE_ID | NUMBER(10) | 매핑 고유 ID | Primary Key |
| USER_ID | NUMBER(10) | 사용자 ID | Foreign Key (USERS), Not Null |
| ROLE_ID | NUMBER(10) | 역할 ID | Foreign Key (ROLES), Not Null |
| ASSIGNED_DATE | TIMESTAMP | 할당 일시 | Not Null |
| ASSIGNED_BY | VARCHAR2(50) | 할당자 | Not Null |
| EXPIRY_DATE | TIMESTAMP | 만료 일시 | |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |

**주요 특징:**
- 한 사용자가 여러 역할을 가질 수 있음
- 역할 할당 만료일 설정 가능
- 역할 할당 이력 추적

---

### PERMISSIONS (권한 정보)
시스템 권한을 정의하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| PERMISSION_ID | NUMBER(10) | 권한 고유 ID | Primary Key |
| PERMISSION_NAME | VARCHAR2(100) | 권한 이름 | Unique, Not Null |
| PERMISSION_DESC | VARCHAR2(200) | 권한 설명 | |
| RESOURCE_TYPE | VARCHAR2(50) | 리소스 타입 | Not Null |
| ACTION_TYPE | VARCHAR2(50) | 액션 타입 | Not Null |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |

**ACTION_TYPE 값:**
- CREATE: 생성 권한
- READ: 조회 권한
- UPDATE: 수정 권한
- DELETE: 삭제 권한
- EXECUTE: 실행 권한

---

### ROLE_PERMISSIONS (역할-권한 매핑)
역할과 권한 간의 다대다 관계를 관리하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| ROLE_PERMISSION_ID | NUMBER(10) | 매핑 고유 ID | Primary Key |
| ROLE_ID | NUMBER(10) | 역할 ID | Foreign Key (ROLES), Not Null |
| PERMISSION_ID | NUMBER(10) | 권한 ID | Foreign Key (PERMISSIONS), Not Null |
| GRANTED_DATE | TIMESTAMP | 부여 일시 | Not Null |
| GRANTED_BY | VARCHAR2(50) | 부여자 | Not Null |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |

**특징:**
- RBAC (Role-Based Access Control) 구현
- 역할별 세밀한 권한 제어 가능

---

### AUDIT_LOGS (감사 로그)
시스템 내 모든 중요 활동을 기록하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| AUDIT_ID | NUMBER(20) | 감사 로그 ID | Primary Key |
| USER_ID | NUMBER(10) | 사용자 ID | Foreign Key (USERS) |
| USERNAME | VARCHAR2(50) | 사용자 이름 | Not Null |
| ACTION_TYPE | VARCHAR2(50) | 액션 타입 | Not Null |
| RESOURCE_TYPE | VARCHAR2(50) | 리소스 타입 | |
| RESOURCE_ID | VARCHAR2(100) | 리소스 ID | |
| ACTION_DESC | VARCHAR2(500) | 액션 설명 | |
| IP_ADDRESS | VARCHAR2(45) | IP 주소 | |
| USER_AGENT | VARCHAR2(500) | 사용자 에이전트 | |
| STATUS | VARCHAR2(20) | 상태 | |
| ERROR_MESSAGE | VARCHAR2(1000) | 오류 메시지 | |
| SESSION_ID | VARCHAR2(100) | 세션 ID | |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |

**STATUS 값:**
- SUCCESS: 성공
- FAILURE: 실패
- ERROR: 오류

**활용:**
- 보안 감사
- 컴플라이언스 준수
- 사고 조사

---

### LOGIN_HISTORY (로그인 이력)
사용자의 로그인 활동을 기록하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| LOGIN_ID | NUMBER(20) | 로그인 이력 ID | Primary Key |
| USER_ID | NUMBER(10) | 사용자 ID | Foreign Key (USERS) |
| USERNAME | VARCHAR2(50) | 사용자 이름 | Not Null |
| LOGIN_TIME | TIMESTAMP | 로그인 시간 | Not Null |
| LOGOUT_TIME | TIMESTAMP | 로그아웃 시간 | |
| IP_ADDRESS | VARCHAR2(45) | IP 주소 | Not Null |
| USER_AGENT | VARCHAR2(500) | 사용자 에이전트 | |
| LOGIN_STATUS | VARCHAR2(20) | 로그인 상태 | |
| FAILURE_REASON | VARCHAR2(200) | 실패 사유 | |
| SESSION_ID | VARCHAR2(100) | 세션 ID | |

**LOGIN_STATUS 값:**
- SUCCESS: 성공
- FAILED: 실패
- LOCKED: 계정 잠김

**활용:**
- 비정상 로그인 패턴 탐지
- 브루트포스 공격 탐지
- 사용자 활동 분석

---

### SECURITY_POLICIES (보안 정책)
시스템 보안 정책을 저장하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| POLICY_ID | NUMBER(10) | 정책 ID | Primary Key |
| POLICY_NAME | VARCHAR2(100) | 정책 이름 | Unique, Not Null |
| POLICY_TYPE | VARCHAR2(50) | 정책 타입 | Not Null |
| POLICY_DESC | VARCHAR2(500) | 정책 설명 | |
| POLICY_RULES | CLOB | 정책 규칙 상세 | |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |
| SEVERITY_LEVEL | VARCHAR2(20) | 심각도 수준 | |
| EFFECTIVE_DATE | TIMESTAMP | 시행 일시 | Not Null |
| EXPIRY_DATE | TIMESTAMP | 만료 일시 | |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**POLICY_TYPE 값:**
- PASSWORD: 패스워드 정책
- ACCESS: 접근 제어 정책
- NETWORK: 네트워크 보안 정책
- DATA: 데이터 보호 정책
- AUDIT: 감사 정책

**SEVERITY_LEVEL 값:**
- LOW: 낮음
- MEDIUM: 중간
- HIGH: 높음
- CRITICAL: 치명적

---

### PASSWORD_POLICIES (패스워드 정책)
패스워드 복잡도 및 관리 정책을 저장하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| PASSWORD_POLICY_ID | NUMBER(10) | 정책 ID | Primary Key |
| MIN_LENGTH | NUMBER(3) | 최소 길이 | Default 8, Not Null |
| MAX_LENGTH | NUMBER(3) | 최대 길이 | Default 128, Not Null |
| REQUIRE_UPPERCASE | CHAR(1) | 대문자 필수 여부 (Y/N) | Default 'Y' |
| REQUIRE_LOWERCASE | CHAR(1) | 소문자 필수 여부 (Y/N) | Default 'Y' |
| REQUIRE_DIGIT | CHAR(1) | 숫자 필수 여부 (Y/N) | Default 'Y' |
| REQUIRE_SPECIAL | CHAR(1) | 특수문자 필수 여부 (Y/N) | Default 'Y' |
| MAX_AGE_DAYS | NUMBER(4) | 최대 사용 기간(일) | Default 90 |
| MIN_AGE_DAYS | NUMBER(4) | 최소 사용 기간(일) | Default 1 |
| PASSWORD_HISTORY_COUNT | NUMBER(3) | 이력 저장 개수 | Default 5 |
| MAX_LOGIN_ATTEMPTS | NUMBER(3) | 최대 로그인 시도 횟수 | Default 5 |
| LOCKOUT_DURATION_MINUTES | NUMBER(5) | 잠금 시간(분) | Default 30 |
| IS_ACTIVE | CHAR(1) | 활성화 여부 (Y/N) | Default 'Y' |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**활용:**
- 강력한 패스워드 강제
- 패스워드 재사용 방지
- 브루트포스 공격 방어

---

### PASSWORD_HISTORY (패스워드 이력)
사용자의 패스워드 변경 이력을 저장하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| HISTORY_ID | NUMBER(20) | 이력 ID | Primary Key |
| USER_ID | NUMBER(10) | 사용자 ID | Foreign Key (USERS), Not Null |
| PASSWORD_HASH | VARCHAR2(256) | 암호화된 패스워드 | Not Null |
| CHANGED_DATE | TIMESTAMP | 변경 일시 | Not Null |
| CHANGED_BY | VARCHAR2(50) | 변경자 | Not Null |

**활용:**
- 패스워드 재사용 방지
- 패스워드 변경 이력 추적

---

### VULNERABILITIES (취약점 정보)
시스템 취약점을 관리하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| VULNERABILITY_ID | NUMBER(10) | 취약점 ID | Primary Key |
| CVE_ID | VARCHAR2(50) | CVE 식별자 | |
| VULNERABILITY_NAME | VARCHAR2(200) | 취약점 명칭 | Not Null |
| DESCRIPTION | CLOB | 취약점 설명 | |
| SEVERITY_LEVEL | VARCHAR2(20) | 심각도 수준 | Not Null |
| CVSS_SCORE | NUMBER(3,1) | CVSS 점수 | |
| AFFECTED_SYSTEM | VARCHAR2(200) | 영향받는 시스템 | |
| AFFECTED_VERSION | VARCHAR2(100) | 영향받는 버전 | |
| STATUS | VARCHAR2(20) | 처리 상태 | Default 'OPEN' |
| DISCOVERY_DATE | TIMESTAMP | 발견 일시 | Not Null |
| RESOLUTION_DATE | TIMESTAMP | 해결 일시 | |
| ASSIGNED_TO | VARCHAR2(50) | 담당자 | |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**STATUS 값:**
- OPEN: 미해결
- IN_PROGRESS: 처리 중
- RESOLVED: 해결됨
- CLOSED: 종료
- WONT_FIX: 수정 안함

**SEVERITY_LEVEL 값:**
- LOW: 낮음 (CVSS 0.1-3.9)
- MEDIUM: 중간 (CVSS 4.0-6.9)
- HIGH: 높음 (CVSS 7.0-8.9)
- CRITICAL: 치명적 (CVSS 9.0-10.0)

---

### SECURITY_INCIDENTS (보안 사고)
보안 사고를 기록하고 관리하는 테이블입니다.

| 컬럼명 | 데이터 타입 | 설명 | 제약조건 |
|--------|------------|------|----------|
| INCIDENT_ID | NUMBER(10) | 사고 ID | Primary Key |
| INCIDENT_TITLE | VARCHAR2(200) | 사고 제목 | Not Null |
| INCIDENT_TYPE | VARCHAR2(50) | 사고 유형 | Not Null |
| SEVERITY_LEVEL | VARCHAR2(20) | 심각도 수준 | Not Null |
| DESCRIPTION | CLOB | 사고 설명 | |
| DETECTION_DATE | TIMESTAMP | 탐지 일시 | Not Null |
| REPORTED_BY | VARCHAR2(50) | 보고자 | Not Null |
| ASSIGNED_TO | VARCHAR2(50) | 담당자 | |
| STATUS | VARCHAR2(20) | 처리 상태 | Default 'OPEN' |
| RESOLUTION_NOTES | CLOB | 해결 내용 | |
| RESOLUTION_DATE | TIMESTAMP | 해결 일시 | |
| IMPACT_ASSESSMENT | VARCHAR2(500) | 영향 평가 | |
| AFFECTED_USERS | NUMBER(10) | 영향받은 사용자 수 | |
| AFFECTED_SYSTEMS | VARCHAR2(500) | 영향받은 시스템 | |
| CREATED_DATE | TIMESTAMP | 생성 일시 | Not Null |
| CREATED_BY | VARCHAR2(50) | 생성자 | Not Null |
| MODIFIED_DATE | TIMESTAMP | 수정 일시 | |
| MODIFIED_BY | VARCHAR2(50) | 수정자 | |

**INCIDENT_TYPE 값:**
- BREACH: 침해 사고
- MALWARE: 악성코드
- PHISHING: 피싱
- DOS: 서비스 거부 공격
- UNAUTHORIZED_ACCESS: 무단 접근
- DATA_LEAK: 데이터 유출
- OTHER: 기타

**STATUS 값:**
- OPEN: 접수
- INVESTIGATING: 조사 중
- CONTAINED: 격리됨
- RESOLVED: 해결됨
- CLOSED: 종료

---

## 관계도

```
USERS (1) ----< (N) USER_ROLES (N) >---- (1) ROLES
                                              |
                                              | (1)
                                              |
                                              v
                                         ROLE_PERMISSIONS
                                              |
                                              | (N)
                                              |
                                              v
                                         PERMISSIONS

USERS (1) ----< (N) AUDIT_LOGS
USERS (1) ----< (N) LOGIN_HISTORY
USERS (1) ----< (N) PASSWORD_HISTORY
```

**주요 관계:**
- 사용자는 여러 역할을 가질 수 있음 (N:M)
- 역할은 여러 권한을 가질 수 있음 (N:M)
- 사용자는 여러 감사 로그를 가질 수 있음 (1:N)
- 사용자는 여러 로그인 이력을 가질 수 있음 (1:N)
- 사용자는 여러 패스워드 이력을 가질 수 있음 (1:N)

---

## 인덱스 전략

### 성능 최적화를 위한 인덱스

#### 1. USERS 테이블
```sql
CREATE INDEX IDX_USERS_USERNAME ON USERS(USERNAME);
CREATE INDEX IDX_USERS_EMAIL ON USERS(EMAIL);
CREATE INDEX IDX_USERS_IS_ACTIVE ON USERS(IS_ACTIVE);
CREATE INDEX IDX_USERS_DEPARTMENT ON USERS(DEPARTMENT);
```

**목적:**
- 사용자명 조회 성능 향상
- 이메일 검색 성능 향상
- 활성 사용자 필터링 성능 향상
- 부서별 조회 성능 향상

#### 2. AUDIT_LOGS 테이블
```sql
CREATE INDEX IDX_AUDIT_USER_ID ON AUDIT_LOGS(USER_ID);
CREATE INDEX IDX_AUDIT_USERNAME ON AUDIT_LOGS(USERNAME);
CREATE INDEX IDX_AUDIT_ACTION_TYPE ON AUDIT_LOGS(ACTION_TYPE);
CREATE INDEX IDX_AUDIT_CREATED_DATE ON AUDIT_LOGS(CREATED_DATE);
CREATE INDEX IDX_AUDIT_STATUS ON AUDIT_LOGS(STATUS);
```

**목적:**
- 사용자별 감사 로그 조회 성능 향상
- 액션 타입별 필터링 성능 향상
- 날짜 범위 검색 성능 향상
- 상태별 조회 성능 향상

#### 3. LOGIN_HISTORY 테이블
```sql
CREATE INDEX IDX_LOGIN_USER_ID ON LOGIN_HISTORY(USER_ID);
CREATE INDEX IDX_LOGIN_USERNAME ON LOGIN_HISTORY(USERNAME);
CREATE INDEX IDX_LOGIN_TIME ON LOGIN_HISTORY(LOGIN_TIME);
CREATE INDEX IDX_LOGIN_IP_ADDRESS ON LOGIN_HISTORY(IP_ADDRESS);
CREATE INDEX IDX_LOGIN_STATUS ON LOGIN_HISTORY(LOGIN_STATUS);
```

**목적:**
- 사용자별 로그인 이력 조회 성능 향상
- 시간대별 로그인 분석 성능 향상
- IP 주소 기반 검색 성능 향상
- 로그인 상태별 필터링 성능 향상

#### 4. VULNERABILITIES 테이블
```sql
CREATE INDEX IDX_VULN_CVE_ID ON VULNERABILITIES(CVE_ID);
CREATE INDEX IDX_VULN_SEVERITY ON VULNERABILITIES(SEVERITY_LEVEL);
CREATE INDEX IDX_VULN_STATUS ON VULNERABILITIES(STATUS);
CREATE INDEX IDX_VULN_DISCOVERY_DATE ON VULNERABILITIES(DISCOVERY_DATE);
```

**목적:**
- CVE ID 검색 성능 향상
- 심각도별 조회 성능 향상
- 상태별 필터링 성능 향상
- 발견일 기반 검색 성능 향상

#### 5. SECURITY_INCIDENTS 테이블
```sql
CREATE INDEX IDX_INCIDENT_TYPE ON SECURITY_INCIDENTS(INCIDENT_TYPE);
CREATE INDEX IDX_INCIDENT_SEVERITY ON SECURITY_INCIDENTS(SEVERITY_LEVEL);
CREATE INDEX IDX_INCIDENT_STATUS ON SECURITY_INCIDENTS(STATUS);
CREATE INDEX IDX_INCIDENT_DETECTION_DATE ON SECURITY_INCIDENTS(DETECTION_DATE);
```

**목적:**
- 사고 유형별 조회 성능 향상
- 심각도별 필터링 성능 향상
- 상태별 조회 성능 향상
- 탐지일 기반 검색 성능 향상

---

## 설치 및 사용 방법

### 1. 테이블 생성

Oracle SQL*Plus 또는 SQL Developer를 사용하여 테이블을 생성합니다:

```sql
-- SQL*Plus 사용 시
@oracle_tables.sql
```

또는 SQL Developer에서:
1. `oracle_tables.sql` 파일 열기
2. 스크립트 실행 (F5)

### 2. 샘플 데이터 삽입

테이블 생성 후 샘플 데이터를 삽입합니다:

```sql
-- SQL*Plus 사용 시
@oracle_sample_data.sql
```

또는 SQL Developer에서:
1. `oracle_sample_data.sql` 파일 열기
2. 스크립트 실행 (F5)

### 3. 테이블 확인

테이블이 정상적으로 생성되었는지 확인:

```sql
-- 테이블 목록 조회
SELECT table_name FROM user_tables ORDER BY table_name;

-- 테이블 구조 확인
DESC USERS;

-- 데이터 확인
SELECT * FROM USERS;
SELECT * FROM ROLES;
```

### 4. 시퀀스 확인

시퀀스가 정상적으로 생성되었는지 확인:

```sql
-- 시퀀스 목록 조회
SELECT sequence_name FROM user_sequences ORDER BY sequence_name;
```

### 5. 인덱스 확인

인덱스가 정상적으로 생성되었는지 확인:

```sql
-- 인덱스 목록 조회
SELECT index_name, table_name FROM user_indexes ORDER BY table_name, index_name;
```

---

## 보안 권장 사항

### 1. 패스워드 저장
- **절대 평문으로 저장하지 마세요**
- **bcrypt, scrypt, Argon2 등의 강력한 해싱 알고리즘 사용 권장**
- **SHA-256과 같은 단순 해시 함수는 레인보우 테이블 공격에 취약하므로 사용 금지**
- Salt 추가 필수 (각 사용자마다 고유한 salt 사용)
- 예시 (PL/SQL with DBMS_CRYPTO는 교육용이며, 실제로는 bcrypt 등 사용):
```sql
-- 주의: 이 예시는 교육 목적입니다. 실제 환경에서는 bcrypt, scrypt, Argon2를 사용하세요
CREATE OR REPLACE FUNCTION HASH_PASSWORD(p_password VARCHAR2, p_salt VARCHAR2)
RETURN VARCHAR2 IS
BEGIN
    RETURN DBMS_CRYPTO.HASH(
        UTL_RAW.CAST_TO_RAW(p_password || p_salt),
        DBMS_CRYPTO.HASH_SH256
    );
END;
```

**실제 운영 환경 권장사항:**
- 애플리케이션 레이어에서 bcrypt (cost factor 12 이상) 사용
- 또는 scrypt, Argon2 등 메모리 하드 알고리즘 사용
- PBKDF2를 사용할 경우 최소 100,000 iterations 설정
- 각 사용자마다 고유한 랜덤 salt 생성 및 저장

### 2. 권한 관리
- 최소 권한 원칙 적용
- 정기적인 권한 검토
- 불필요한 권한 제거

### 3. 감사 로그
- 모든 중요 작업 로깅
- 로그 무결성 보장
- 정기적인 로그 분석

### 4. 정기 점검
- 비활성 계정 정리
- 패스워드 만료 정책 적용
- 취약점 정기 스캔

---

## 데이터 사전 쿼리 예제

### 사용자별 역할 조회
```sql
SELECT 
    u.USERNAME,
    u.FULL_NAME,
    r.ROLE_NAME,
    ur.ASSIGNED_DATE
FROM USERS u
JOIN USER_ROLES ur ON u.USER_ID = ur.USER_ID
JOIN ROLES r ON ur.ROLE_ID = r.ROLE_ID
WHERE u.IS_ACTIVE = 'Y' AND ur.IS_ACTIVE = 'Y'
ORDER BY u.USERNAME, r.ROLE_NAME;
```

### 역할별 권한 조회
```sql
SELECT 
    r.ROLE_NAME,
    p.PERMISSION_NAME,
    p.RESOURCE_TYPE,
    p.ACTION_TYPE
FROM ROLES r
JOIN ROLE_PERMISSIONS rp ON r.ROLE_ID = rp.ROLE_ID
JOIN PERMISSIONS p ON rp.PERMISSION_ID = p.PERMISSION_ID
WHERE r.IS_ACTIVE = 'Y' AND rp.IS_ACTIVE = 'Y'
ORDER BY r.ROLE_NAME, p.RESOURCE_TYPE, p.ACTION_TYPE;
```

### 최근 로그인 실패 조회
```sql
SELECT 
    USERNAME,
    LOGIN_TIME,
    IP_ADDRESS,
    FAILURE_REASON
FROM LOGIN_HISTORY
WHERE LOGIN_STATUS = 'FAILED'
  AND LOGIN_TIME >= SYSTIMESTAMP - INTERVAL '7' DAY
ORDER BY LOGIN_TIME DESC;
```

### 미해결 취약점 조회
```sql
SELECT 
    CVE_ID,
    VULNERABILITY_NAME,
    SEVERITY_LEVEL,
    CVSS_SCORE,
    AFFECTED_SYSTEM,
    DISCOVERY_DATE,
    ASSIGNED_TO
FROM VULNERABILITIES
WHERE STATUS IN ('OPEN', 'IN_PROGRESS')
ORDER BY 
    CASE SEVERITY_LEVEL
        WHEN 'CRITICAL' THEN 1
        WHEN 'HIGH' THEN 2
        WHEN 'MEDIUM' THEN 3
        WHEN 'LOW' THEN 4
    END,
    DISCOVERY_DATE;
```

### 보안 사고 현황 조회
```sql
SELECT 
    INCIDENT_TYPE,
    COUNT(*) AS INCIDENT_COUNT,
    SUM(CASE WHEN STATUS = 'OPEN' THEN 1 ELSE 0 END) AS OPEN_COUNT,
    SUM(CASE WHEN STATUS = 'RESOLVED' THEN 1 ELSE 0 END) AS RESOLVED_COUNT,
    SUM(CASE WHEN STATUS = 'CLOSED' THEN 1 ELSE 0 END) AS CLOSED_COUNT
FROM SECURITY_INCIDENTS
WHERE DETECTION_DATE >= SYSTIMESTAMP - INTERVAL '30' DAY
GROUP BY INCIDENT_TYPE
ORDER BY INCIDENT_COUNT DESC;
```

---

## 유지보수

### 정기적인 작업

#### 1. 통계 업데이트
```sql
-- 테이블 통계 수집
EXEC DBMS_STATS.GATHER_TABLE_STATS('YOUR_SCHEMA', 'USERS');
EXEC DBMS_STATS.GATHER_TABLE_STATS('YOUR_SCHEMA', 'AUDIT_LOGS');
EXEC DBMS_STATS.GATHER_TABLE_STATS('YOUR_SCHEMA', 'LOGIN_HISTORY');
```

#### 2. 인덱스 재구성
```sql
-- 인덱스 재구성
ALTER INDEX IDX_AUDIT_CREATED_DATE REBUILD;
ALTER INDEX IDX_LOGIN_TIME REBUILD;
```

#### 3. 오래된 로그 아카이빙
```sql
-- 1년 이상 된 감사 로그 아카이빙 테이블로 이동
INSERT INTO AUDIT_LOGS_ARCHIVE
SELECT * FROM AUDIT_LOGS
WHERE CREATED_DATE < SYSTIMESTAMP - INTERVAL '365' DAY;

-- 원본에서 삭제
DELETE FROM AUDIT_LOGS
WHERE CREATED_DATE < SYSTIMESTAMP - INTERVAL '365' DAY;

COMMIT;
```

---

## 문제 해결

### 시퀀스 초기화
```sql
-- 시퀀스 현재 값 확인
SELECT SEQ_USER_ID.CURRVAL FROM DUAL;

-- 시퀀스 재생성
DROP SEQUENCE SEQ_USER_ID;
CREATE SEQUENCE SEQ_USER_ID START WITH 1 INCREMENT BY 1;
```

### 제약조건 확인
```sql
-- 제약조건 조회
SELECT 
    constraint_name,
    constraint_type,
    table_name
FROM user_constraints
WHERE table_name IN ('USERS', 'ROLES', 'PERMISSIONS')
ORDER BY table_name, constraint_type;
```

### 외래키 관계 확인
```sql
-- 외래키 관계 조회
SELECT 
    a.constraint_name,
    a.table_name,
    a.column_name,
    c_pk.table_name r_table_name,
    b.column_name r_column_name
FROM user_cons_columns a
JOIN user_constraints c ON a.constraint_name = c.constraint_name
JOIN user_constraints c_pk ON c.r_constraint_name = c_pk.constraint_name
JOIN user_cons_columns b ON c_pk.constraint_name = b.constraint_name
WHERE c.constraint_type = 'R'
ORDER BY a.table_name, a.constraint_name;
```

---

## 라이선스
이 테이블 설계는 정보보안 학습 목적으로 제공됩니다.

## 문의
질문이나 개선 사항이 있으시면 이슈를 등록해 주세요.

---

**작성일:** 2026-01-18  
**버전:** 1.0.0  
**작성자:** Copilot AI Agent
