# 오라클 테이블 구조 ERD (Entity Relationship Diagram)

## 엔티티 관계도

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          정보보안 시스템 데이터베이스 ERD                     │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────┐
│        USERS             │
├──────────────────────────┤
│ PK  USER_ID              │
│     USERNAME             │◄────┐
│     PASSWORD_HASH        │     │
│     EMAIL                │     │
│     FULL_NAME            │     │
│     DEPARTMENT           │     │
│     IS_ACTIVE            │     │
│     ACCOUNT_LOCKED       │     │
│     FAILED_LOGIN_ATTEMPTS│     │
└──────────────────────────┘     │
       │                          │
       │ 1                        │
       │                          │
       │ N                        │
       ▼                          │
┌──────────────────────────┐     │
│     USER_ROLES           │     │
├──────────────────────────┤     │
│ PK  USER_ROLE_ID         │     │
│ FK  USER_ID              │     │
│ FK  ROLE_ID              │     │
│     ASSIGNED_DATE        │     │
│     EXPIRY_DATE          │     │
│     IS_ACTIVE            │     │
└──────────────────────────┘     │
       │                          │
       │ N                        │
       │                          │
       │ 1                        │
       ▼                          │
┌──────────────────────────┐     │
│        ROLES             │     │
├──────────────────────────┤     │
│ PK  ROLE_ID              │     │
│     ROLE_NAME            │     │
│     ROLE_DESC            │     │
│     IS_ACTIVE            │     │
└──────────────────────────┘     │
       │                          │
       │ 1                        │
       │                          │
       │ N                        │
       ▼                          │
┌──────────────────────────┐     │
│   ROLE_PERMISSIONS       │     │
├──────────────────────────┤     │
│ PK  ROLE_PERMISSION_ID   │     │
│ FK  ROLE_ID              │     │
│ FK  PERMISSION_ID        │     │
│     GRANTED_DATE         │     │
│     IS_ACTIVE            │     │
└──────────────────────────┘     │
       │                          │
       │ N                        │
       │                          │
       │ 1                        │
       ▼                          │
┌──────────────────────────┐     │
│     PERMISSIONS          │     │
├──────────────────────────┤     │
│ PK  PERMISSION_ID        │     │
│     PERMISSION_NAME      │     │
│     RESOURCE_TYPE        │     │
│     ACTION_TYPE          │     │
│     IS_ACTIVE            │     │
└──────────────────────────┘     │
                                  │
                                  │
┌──────────────────────────┐     │
│     AUDIT_LOGS           │     │
├──────────────────────────┤     │
│ PK  AUDIT_ID             │     │
│ FK  USER_ID              │─────┘
│     USERNAME             │
│     ACTION_TYPE          │
│     RESOURCE_TYPE        │
│     IP_ADDRESS           │
│     STATUS               │
│     CREATED_DATE         │
└──────────────────────────┘
                                  
┌──────────────────────────┐     
│    LOGIN_HISTORY         │     
├──────────────────────────┤     
│ PK  LOGIN_ID             │     
│ FK  USER_ID              │─────┐
│     USERNAME             │     │
│     LOGIN_TIME           │     │
│     IP_ADDRESS           │     │
│     LOGIN_STATUS         │     │
└──────────────────────────┘     │
                                  │
                                  │
┌──────────────────────────┐     │
│  PASSWORD_HISTORY        │     │
├──────────────────────────┤     │
│ PK  HISTORY_ID           │     │
│ FK  USER_ID              │─────┘
│     PASSWORD_HASH        │
│     CHANGED_DATE         │
└──────────────────────────┘

┌──────────────────────────┐
│  SECURITY_POLICIES       │
├──────────────────────────┤
│ PK  POLICY_ID            │
│     POLICY_NAME          │
│     POLICY_TYPE          │
│     SEVERITY_LEVEL       │
│     EFFECTIVE_DATE       │
└──────────────────────────┘

┌──────────────────────────┐
│  PASSWORD_POLICIES       │
├──────────────────────────┤
│ PK  PASSWORD_POLICY_ID   │
│     MIN_LENGTH           │
│     MAX_LENGTH           │
│     REQUIRE_UPPERCASE    │
│     MAX_LOGIN_ATTEMPTS   │
└──────────────────────────┘

┌──────────────────────────┐
│   VULNERABILITIES        │
├──────────────────────────┤
│ PK  VULNERABILITY_ID     │
│     CVE_ID               │
│     VULNERABILITY_NAME   │
│     SEVERITY_LEVEL       │
│     CVSS_SCORE           │
│     STATUS               │
└──────────────────────────┘

┌──────────────────────────┐
│  SECURITY_INCIDENTS      │
├──────────────────────────┤
│ PK  INCIDENT_ID          │
│     INCIDENT_TITLE       │
│     INCIDENT_TYPE        │
│     SEVERITY_LEVEL       │
│     STATUS               │
│     DETECTION_DATE       │
└──────────────────────────┘
```

## 관계 설명

### 1:N 관계

1. **USERS → USER_ROLES** (1:N)
   - 한 명의 사용자는 여러 역할을 가질 수 있음
   
2. **ROLES → USER_ROLES** (1:N)
   - 한 개의 역할은 여러 사용자에게 할당될 수 있음
   
3. **ROLES → ROLE_PERMISSIONS** (1:N)
   - 한 개의 역할은 여러 권한을 가질 수 있음
   
4. **PERMISSIONS → ROLE_PERMISSIONS** (1:N)
   - 한 개의 권한은 여러 역할에 할당될 수 있음

5. **USERS → AUDIT_LOGS** (1:N)
   - 한 명의 사용자는 여러 감사 로그를 생성함
   
6. **USERS → LOGIN_HISTORY** (1:N)
   - 한 명의 사용자는 여러 로그인 이력을 가짐
   
7. **USERS → PASSWORD_HISTORY** (1:N)
   - 한 명의 사용자는 여러 패스워드 변경 이력을 가짐

### N:M 관계

1. **USERS ↔ ROLES** (N:M)
   - 중간 테이블: USER_ROLES
   - 한 사용자는 여러 역할을 가질 수 있고, 한 역할은 여러 사용자에게 할당될 수 있음

2. **ROLES ↔ PERMISSIONS** (N:M)
   - 중간 테이블: ROLE_PERMISSIONS
   - 한 역할은 여러 권한을 가질 수 있고, 한 권한은 여러 역할에 할당될 수 있음

## 데이터 흐름

### 사용자 인증 흐름
```
1. 사용자 로그인 시도
   ↓
2. USERS 테이블에서 사용자 정보 조회
   ↓
3. PASSWORD_HASH 검증
   ↓
4. LOGIN_HISTORY에 로그인 시도 기록
   ↓
5. 성공 시: SESSION 생성
   실패 시: FAILED_LOGIN_ATTEMPTS 증가
   ↓
6. AUDIT_LOGS에 인증 이벤트 기록
```

### 권한 확인 흐름
```
1. 사용자 액션 요청
   ↓
2. USER_ROLES에서 사용자의 역할 조회
   ↓
3. ROLE_PERMISSIONS에서 역할의 권한 조회
   ↓
4. PERMISSIONS에서 권한 상세 정보 확인
   ↓
5. 권한 검증 완료
   ↓
6. AUDIT_LOGS에 액션 기록
```

## 테이블 그룹별 색인

### 🔐 인증 및 권한 관리
- USERS
- ROLES
- USER_ROLES
- PERMISSIONS
- ROLE_PERMISSIONS

### 📝 감사 및 로그
- AUDIT_LOGS
- LOGIN_HISTORY
- PASSWORD_HISTORY

### 🛡️ 보안 정책
- SECURITY_POLICIES
- PASSWORD_POLICIES

### ⚠️ 보안 관리
- VULNERABILITIES
- SECURITY_INCIDENTS

## 시퀀스 목록

| 시퀀스 이름 | 용도 | 시작값 | 증가값 |
|------------|------|--------|--------|
| SEQ_USER_ID | 사용자 ID 생성 | 1 | 1 |
| SEQ_ROLE_ID | 역할 ID 생성 | 1 | 1 |
| SEQ_USER_ROLE_ID | 사용자-역할 매핑 ID 생성 | 1 | 1 |
| SEQ_PERMISSION_ID | 권한 ID 생성 | 1 | 1 |
| SEQ_ROLE_PERMISSION_ID | 역할-권한 매핑 ID 생성 | 1 | 1 |
| SEQ_AUDIT_ID | 감사 로그 ID 생성 | 1 | 1 |
| SEQ_LOGIN_ID | 로그인 이력 ID 생성 | 1 | 1 |
| SEQ_POLICY_ID | 보안 정책 ID 생성 | 1 | 1 |
| SEQ_PASSWORD_POLICY_ID | 패스워드 정책 ID 생성 | 1 | 1 |
| SEQ_PASSWORD_HISTORY_ID | 패스워드 이력 ID 생성 | 1 | 1 |
| SEQ_VULNERABILITY_ID | 취약점 ID 생성 | 1 | 1 |
| SEQ_INCIDENT_ID | 보안 사고 ID 생성 | 1 | 1 |

## 제약 조건 요약

### Primary Keys
- 모든 테이블에 숫자형 Primary Key 존재
- 시퀀스를 사용한 자동 증가

### Foreign Keys
- USER_ROLES.USER_ID → USERS.USER_ID
- USER_ROLES.ROLE_ID → ROLES.ROLE_ID
- ROLE_PERMISSIONS.ROLE_ID → ROLES.ROLE_ID
- ROLE_PERMISSIONS.PERMISSION_ID → PERMISSIONS.PERMISSION_ID
- AUDIT_LOGS.USER_ID → USERS.USER_ID
- LOGIN_HISTORY.USER_ID → USERS.USER_ID
- PASSWORD_HISTORY.USER_ID → USERS.USER_ID

### Unique Constraints
- USERS.USERNAME
- USERS.EMAIL
- ROLES.ROLE_NAME
- PERMISSIONS.PERMISSION_NAME
- SECURITY_POLICIES.POLICY_NAME
- USER_ROLES (USER_ID, ROLE_ID) 조합
- ROLE_PERMISSIONS (ROLE_ID, PERMISSION_ID) 조합

### Check Constraints
- IS_ACTIVE 컬럼: 'Y' 또는 'N'
- ACCOUNT_LOCKED 컬럼: 'Y' 또는 'N'
- ACTION_TYPE: 'CREATE', 'READ', 'UPDATE', 'DELETE', 'EXECUTE'
- STATUS: 테이블별 정의된 값만 허용
- SEVERITY_LEVEL: 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL'

## 인덱스 전략 요약

### 검색 성능 향상 인덱스
- USERNAME, EMAIL (로그인 및 사용자 검색)
- IS_ACTIVE (활성 사용자 필터링)
- CREATED_DATE (날짜 범위 검색)
- IP_ADDRESS (보안 분석)

### 조인 성능 향상 인덱스
- Foreign Key 컬럼
- USER_ID (다중 테이블 조인)

### 정렬 성능 향상 인덱스
- LOGIN_TIME, DETECTION_DATE, DISCOVERY_DATE

## 카디널리티 예상

| 테이블 | 예상 레코드 수 | 증가율 |
|--------|---------------|--------|
| USERS | 1,000 ~ 10,000 | 느림 |
| ROLES | 5 ~ 50 | 매우 느림 |
| USER_ROLES | 2,000 ~ 20,000 | 느림 |
| PERMISSIONS | 20 ~ 200 | 느림 |
| ROLE_PERMISSIONS | 100 ~ 1,000 | 느림 |
| AUDIT_LOGS | 100,000+ | 매우 빠름 |
| LOGIN_HISTORY | 50,000+ | 빠름 |
| PASSWORD_HISTORY | 10,000 ~ 50,000 | 보통 |
| SECURITY_POLICIES | 10 ~ 100 | 느림 |
| PASSWORD_POLICIES | 1 ~ 10 | 매우 느림 |
| VULNERABILITIES | 100 ~ 1,000 | 보통 |
| SECURITY_INCIDENTS | 50 ~ 500 | 보통 |

## 파티셔닝 권장사항

### Range Partitioning 권장 테이블
- **AUDIT_LOGS**: CREATED_DATE 기준 월별 파티션
- **LOGIN_HISTORY**: LOGIN_TIME 기준 월별 파티션

예시:
```sql
CREATE TABLE AUDIT_LOGS (
    -- 컬럼 정의
)
PARTITION BY RANGE (CREATED_DATE)
(
    PARTITION P_2026_01 VALUES LESS THAN (TO_DATE('2026-02-01', 'YYYY-MM-DD')),
    PARTITION P_2026_02 VALUES LESS THAN (TO_DATE('2026-03-01', 'YYYY-MM-DD')),
    -- ...
);
```

## 백업 및 아카이빙 전략

### 정기 백업 대상
- **전체 백업**: 주 1회 (일요일 새벽)
- **증분 백업**: 매일 (새벽 2시)

### 아카이빙 대상
- **AUDIT_LOGS**: 1년 경과 데이터
- **LOGIN_HISTORY**: 2년 경과 데이터
- **PASSWORD_HISTORY**: 사용자 삭제 후 5년 경과 데이터

### 데이터 보관 기간
- 감사 로그: 최소 5년
- 로그인 이력: 최소 2년
- 보안 사고: 영구 보관
- 취약점 정보: 해결 후 3년

---

**버전:** 1.0.0  
**작성일:** 2026-01-18
