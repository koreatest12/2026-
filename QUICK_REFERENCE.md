# 오라클 테이블 빠른 참조 가이드 (Quick Reference Guide)

## 📋 목차
1. [설치 명령어](#설치-명령어)
2. [기본 쿼리](#기본-쿼리)
3. [자주 사용하는 쿼리](#자주-사용하는-쿼리)
4. [관리 쿼리](#관리-쿼리)
5. [성능 최적화](#성능-최적화)
6. [문제 해결](#문제-해결)

---

## 설치 명령어

### SQL*Plus에서 실행
```sql
-- 테이블 생성
@oracle_tables.sql

-- 샘플 데이터 삽입
@oracle_sample_data.sql
```

### SQL Developer에서 실행
1. 파일 > 열기 > `oracle_tables.sql` 선택
2. F5 키 또는 "스크립트 실행" 버튼 클릭
3. 완료 후 `oracle_sample_data.sql` 동일하게 실행

---

## 기본 쿼리

### 사용자 조회
```sql
-- 모든 활성 사용자 조회
SELECT USER_ID, USERNAME, FULL_NAME, EMAIL, DEPARTMENT
FROM USERS
WHERE IS_ACTIVE = 'Y'
ORDER BY USERNAME;

-- 특정 부서 사용자 조회
SELECT USER_ID, USERNAME, FULL_NAME, POSITION
FROM USERS
WHERE DEPARTMENT = '정보보안팀' AND IS_ACTIVE = 'Y';

-- 잠긴 계정 조회
SELECT USERNAME, FULL_NAME, FAILED_LOGIN_ATTEMPTS, LAST_LOGIN
FROM USERS
WHERE ACCOUNT_LOCKED = 'Y';
```

### 역할 조회
```sql
-- 모든 역할 조회
SELECT ROLE_ID, ROLE_NAME, ROLE_DESC
FROM ROLES
WHERE IS_ACTIVE = 'Y'
ORDER BY ROLE_NAME;

-- 사용자별 역할 조회
SELECT 
    u.USERNAME,
    u.FULL_NAME,
    r.ROLE_NAME,
    ur.ASSIGNED_DATE
FROM USERS u
JOIN USER_ROLES ur ON u.USER_ID = ur.USER_ID
JOIN ROLES r ON ur.ROLE_ID = r.ROLE_ID
WHERE u.USERNAME = 'admin';
```

### 권한 조회
```sql
-- 모든 권한 조회
SELECT PERMISSION_ID, PERMISSION_NAME, RESOURCE_TYPE, ACTION_TYPE
FROM PERMISSIONS
ORDER BY RESOURCE_TYPE, ACTION_TYPE;

-- 역할별 권한 조회
SELECT 
    r.ROLE_NAME,
    p.PERMISSION_NAME,
    p.RESOURCE_TYPE,
    p.ACTION_TYPE
FROM ROLES r
JOIN ROLE_PERMISSIONS rp ON r.ROLE_ID = rp.ROLE_ID
JOIN PERMISSIONS p ON rp.PERMISSION_ID = p.PERMISSION_ID
WHERE r.ROLE_NAME = 'ADMIN';

-- 사용자의 모든 권한 조회
SELECT DISTINCT
    u.USERNAME,
    p.PERMISSION_NAME,
    p.RESOURCE_TYPE,
    p.ACTION_TYPE
FROM USERS u
JOIN USER_ROLES ur ON u.USER_ID = ur.USER_ID
JOIN ROLE_PERMISSIONS rp ON ur.ROLE_ID = rp.ROLE_ID
JOIN PERMISSIONS p ON rp.PERMISSION_ID = p.PERMISSION_ID
WHERE u.USERNAME = 'security01'
ORDER BY p.RESOURCE_TYPE, p.ACTION_TYPE;
```

---

## 자주 사용하는 쿼리

### 로그인 이력 분석
```sql
-- 오늘 로그인 현황
SELECT 
    USERNAME,
    LOGIN_TIME,
    IP_ADDRESS,
    LOGIN_STATUS
FROM LOGIN_HISTORY
WHERE TRUNC(LOGIN_TIME) = TRUNC(SYSDATE)
ORDER BY LOGIN_TIME DESC;

-- 최근 로그인 실패 조회 (최근 7일)
SELECT 
    USERNAME,
    LOGIN_TIME,
    IP_ADDRESS,
    FAILURE_REASON,
    LOGIN_STATUS
FROM LOGIN_HISTORY
WHERE LOGIN_STATUS = 'FAILED'
  AND LOGIN_TIME >= SYSTIMESTAMP - INTERVAL '7' DAY
ORDER BY LOGIN_TIME DESC;

-- IP별 로그인 시도 횟수
SELECT 
    IP_ADDRESS,
    COUNT(*) AS ATTEMPT_COUNT,
    SUM(CASE WHEN LOGIN_STATUS = 'SUCCESS' THEN 1 ELSE 0 END) AS SUCCESS_COUNT,
    SUM(CASE WHEN LOGIN_STATUS = 'FAILED' THEN 1 ELSE 0 END) AS FAILED_COUNT
FROM LOGIN_HISTORY
WHERE LOGIN_TIME >= SYSTIMESTAMP - INTERVAL '1' DAY
GROUP BY IP_ADDRESS
HAVING SUM(CASE WHEN LOGIN_STATUS = 'FAILED' THEN 1 ELSE 0 END) > 5
ORDER BY FAILED_COUNT DESC;
```

### 감사 로그 분석
```sql
-- 최근 감사 로그 조회
SELECT 
    USERNAME,
    ACTION_TYPE,
    RESOURCE_TYPE,
    ACTION_DESC,
    STATUS,
    CREATED_DATE
FROM AUDIT_LOGS
WHERE CREATED_DATE >= SYSTIMESTAMP - INTERVAL '1' DAY
ORDER BY CREATED_DATE DESC;

-- 실패한 작업 조회
SELECT 
    USERNAME,
    ACTION_TYPE,
    RESOURCE_TYPE,
    ERROR_MESSAGE,
    CREATED_DATE
FROM AUDIT_LOGS
WHERE STATUS = 'FAILURE'
  AND CREATED_DATE >= SYSTIMESTAMP - INTERVAL '7' DAY
ORDER BY CREATED_DATE DESC;

-- 사용자별 활동 통계
SELECT 
    USERNAME,
    COUNT(*) AS TOTAL_ACTIONS,
    SUM(CASE WHEN STATUS = 'SUCCESS' THEN 1 ELSE 0 END) AS SUCCESS_COUNT,
    SUM(CASE WHEN STATUS = 'FAILURE' THEN 1 ELSE 0 END) AS FAILURE_COUNT
FROM AUDIT_LOGS
WHERE CREATED_DATE >= SYSTIMESTAMP - INTERVAL '30' DAY
GROUP BY USERNAME
ORDER BY TOTAL_ACTIONS DESC;
```

### 취약점 관리
```sql
-- 미해결 취약점 조회 (심각도 높은 순)
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
    CVSS_SCORE DESC,
    DISCOVERY_DATE;

-- 심각도별 취약점 통계
SELECT 
    SEVERITY_LEVEL,
    COUNT(*) AS TOTAL_COUNT,
    SUM(CASE WHEN STATUS = 'OPEN' THEN 1 ELSE 0 END) AS OPEN_COUNT,
    SUM(CASE WHEN STATUS = 'IN_PROGRESS' THEN 1 ELSE 0 END) AS IN_PROGRESS_COUNT,
    SUM(CASE WHEN STATUS = 'RESOLVED' THEN 1 ELSE 0 END) AS RESOLVED_COUNT
FROM VULNERABILITIES
GROUP BY SEVERITY_LEVEL
ORDER BY 
    CASE SEVERITY_LEVEL
        WHEN 'CRITICAL' THEN 1
        WHEN 'HIGH' THEN 2
        WHEN 'MEDIUM' THEN 3
        WHEN 'LOW' THEN 4
    END;

-- 담당자별 취약점 현황
SELECT 
    ASSIGNED_TO,
    COUNT(*) AS ASSIGNED_COUNT,
    SUM(CASE WHEN STATUS = 'OPEN' THEN 1 ELSE 0 END) AS OPEN_COUNT,
    AVG(CVSS_SCORE) AS AVG_CVSS_SCORE
FROM VULNERABILITIES
WHERE STATUS IN ('OPEN', 'IN_PROGRESS')
GROUP BY ASSIGNED_TO
ORDER BY OPEN_COUNT DESC;
```

### 보안 사고 관리
```sql
-- 진행 중인 보안 사고 조회
SELECT 
    INCIDENT_TITLE,
    INCIDENT_TYPE,
    SEVERITY_LEVEL,
    STATUS,
    DETECTION_DATE,
    ASSIGNED_TO,
    AFFECTED_USERS
FROM SECURITY_INCIDENTS
WHERE STATUS IN ('OPEN', 'INVESTIGATING', 'CONTAINED')
ORDER BY 
    CASE SEVERITY_LEVEL
        WHEN 'CRITICAL' THEN 1
        WHEN 'HIGH' THEN 2
        WHEN 'MEDIUM' THEN 3
        WHEN 'LOW' THEN 4
    END,
    DETECTION_DATE DESC;

-- 사고 유형별 통계 (최근 30일)
SELECT 
    INCIDENT_TYPE,
    COUNT(*) AS INCIDENT_COUNT,
    SUM(CASE WHEN STATUS = 'RESOLVED' THEN 1 ELSE 0 END) AS RESOLVED_COUNT,
    SUM(AFFECTED_USERS) AS TOTAL_AFFECTED_USERS
FROM SECURITY_INCIDENTS
WHERE DETECTION_DATE >= SYSTIMESTAMP - INTERVAL '30' DAY
GROUP BY INCIDENT_TYPE
ORDER BY INCIDENT_COUNT DESC;

-- 평균 해결 시간 계산
SELECT 
    INCIDENT_TYPE,
    COUNT(*) AS RESOLVED_COUNT,
    AVG(EXTRACT(DAY FROM (RESOLUTION_DATE - DETECTION_DATE))) AS AVG_DAYS_TO_RESOLVE
FROM SECURITY_INCIDENTS
WHERE STATUS = 'RESOLVED'
  AND RESOLUTION_DATE IS NOT NULL
GROUP BY INCIDENT_TYPE
ORDER BY AVG_DAYS_TO_RESOLVE DESC;
```

---

## 관리 쿼리

### 사용자 관리
```sql
-- 새 사용자 생성
INSERT INTO USERS (
    USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, 
    DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY
) VALUES (
    SEQ_USER_ID.NEXTVAL, 'newuser', 'hashed_password', 'newuser@company.com', 
    '신규사용자', 'IT팀', '사원', 'Y', 'admin'
);

-- 사용자 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 10, 4, 'admin');

-- 사용자 비활성화
UPDATE USERS 
SET IS_ACTIVE = 'N', MODIFIED_DATE = SYSTIMESTAMP, MODIFIED_BY = 'admin'
WHERE USERNAME = 'olduser';

-- 계정 잠금 해제
UPDATE USERS 
SET ACCOUNT_LOCKED = 'N', FAILED_LOGIN_ATTEMPTS = 0, 
    MODIFIED_DATE = SYSTIMESTAMP, MODIFIED_BY = 'admin'
WHERE USERNAME = 'locked_user';
```

### 역할 및 권한 관리
```sql
-- 새 역할 생성
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'DATA_ANALYST', '데이터 분석가 역할', 'Y', 'admin');

-- 역할에 권한 부여
INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 5, 2, 'admin');

-- 역할에서 권한 제거
UPDATE ROLE_PERMISSIONS 
SET IS_ACTIVE = 'N'
WHERE ROLE_ID = 5 AND PERMISSION_ID = 10;
```

### 보안 정책 관리
```sql
-- 보안 정책 생성
INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL,
    '데이터 암호화 정책',
    'DATA',
    '민감한 데이터는 AES-256으로 암호화',
    'PII 데이터는 저장 시 AES-256 암호화 필수, 전송 시 TLS 1.2 이상 사용',
    'HIGH',
    'admin'
);

-- 패스워드 정책 업데이트
UPDATE PASSWORD_POLICIES
SET MIN_LENGTH = 12,
    MAX_AGE_DAYS = 60,
    MODIFIED_DATE = SYSTIMESTAMP,
    MODIFIED_BY = 'admin'
WHERE PASSWORD_POLICY_ID = 1;
```

---

## 성능 최적화

### 통계 수집
```sql
-- 특정 테이블 통계 수집
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'USERS');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'AUDIT_LOGS');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'LOGIN_HISTORY');

-- 스키마 전체 통계 수집
EXEC DBMS_STATS.GATHER_SCHEMA_STATS(USER);
```

### 인덱스 재구성
```sql
-- 인덱스 재구성
ALTER INDEX IDX_AUDIT_CREATED_DATE REBUILD;
ALTER INDEX IDX_LOGIN_TIME REBUILD;
ALTER INDEX IDX_USERS_USERNAME REBUILD;

-- 인덱스 사용 불가능한 것 조회
SELECT INDEX_NAME, TABLE_NAME, STATUS
FROM USER_INDEXES
WHERE STATUS = 'UNUSABLE';
```

### 테이블 분석
```sql
-- 테이블 크기 조회
SELECT 
    segment_name,
    ROUND(bytes/1024/1024, 2) AS SIZE_MB
FROM user_segments
WHERE segment_type = 'TABLE'
ORDER BY bytes DESC;

-- 인덱스 크기 조회
SELECT 
    segment_name,
    ROUND(bytes/1024/1024, 2) AS SIZE_MB
FROM user_segments
WHERE segment_type = 'INDEX'
ORDER BY bytes DESC;
```

---

## 문제 해결

### 시퀀스 확인 및 재설정
```sql
-- 시퀀스 목록 조회
SELECT sequence_name, last_number
FROM user_sequences
ORDER BY sequence_name;

-- 시퀀스 현재 값 확인
SELECT SEQ_USER_ID.CURRVAL FROM DUAL;

-- 시퀀스 다음 값 확인
SELECT SEQ_USER_ID.NEXTVAL FROM DUAL;
```

### 제약조건 확인
```sql
-- 제약조건 조회
SELECT 
    constraint_name,
    constraint_type,
    table_name,
    search_condition
FROM user_constraints
WHERE table_name = 'USERS'
ORDER BY constraint_type;

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
  AND a.table_name = 'USER_ROLES';
```

### 잠금 및 세션 확인
```sql
-- 현재 세션 조회
SELECT 
    sid,
    serial#,
    username,
    status,
    osuser,
    machine
FROM v$session
WHERE username IS NOT NULL;

-- 잠금 확인
SELECT 
    l.sid,
    s.serial#,
    s.username,
    o.object_name,
    l.locked_mode
FROM v$locked_object l
JOIN v$session s ON l.session_id = s.sid
JOIN dba_objects o ON l.object_id = o.object_id;
```

### 데이터 무결성 확인
```sql
-- 고아 레코드 확인 (USER_ROLES에 존재하나 USERS에 없는 경우)
SELECT ur.USER_ID
FROM USER_ROLES ur
LEFT JOIN USERS u ON ur.USER_ID = u.USER_ID
WHERE u.USER_ID IS NULL;

-- 중복 데이터 확인
SELECT USERNAME, COUNT(*)
FROM USERS
GROUP BY USERNAME
HAVING COUNT(*) > 1;
```

### 오래된 데이터 정리
```sql
-- 1년 이상 된 감사 로그 삭제
DELETE FROM AUDIT_LOGS
WHERE CREATED_DATE < SYSTIMESTAMP - INTERVAL '365' DAY;

-- 2년 이상 된 로그인 이력 삭제
DELETE FROM LOGIN_HISTORY
WHERE LOGIN_TIME < SYSTIMESTAMP - INTERVAL '730' DAY;

-- 삭제된 사용자의 패스워드 이력 정리
DELETE FROM PASSWORD_HISTORY
WHERE USER_ID IN (
    SELECT USER_ID FROM USERS WHERE IS_ACTIVE = 'N'
)
AND CHANGED_DATE < SYSTIMESTAMP - INTERVAL '1825' DAY;

COMMIT;
```

---

## 유용한 시스템 쿼리

### 테이블 정보
```sql
-- 테이블 목록 조회
SELECT table_name
FROM user_tables
ORDER BY table_name;

-- 테이블 컬럼 정보
SELECT 
    column_name,
    data_type,
    data_length,
    nullable,
    data_default
FROM user_tab_columns
WHERE table_name = 'USERS'
ORDER BY column_id;

-- 테이블 코멘트 조회
SELECT 
    table_name,
    comments
FROM user_tab_comments
WHERE comments IS NOT NULL
ORDER BY table_name;
```

### 인덱스 정보
```sql
-- 테이블별 인덱스 조회
SELECT 
    index_name,
    table_name,
    uniqueness,
    status
FROM user_indexes
WHERE table_name = 'USERS'
ORDER BY index_name;

-- 인덱스 컬럼 조회
SELECT 
    ic.index_name,
    ic.column_name,
    ic.column_position,
    i.uniqueness
FROM user_ind_columns ic
JOIN user_indexes i ON ic.index_name = i.index_name
WHERE ic.table_name = 'USERS'
ORDER BY ic.index_name, ic.column_position;
```

---

## 백업 및 복구

### 데이터 내보내기 (Export)
```sql
-- 특정 테이블 데이터 CSV로 내보내기 (SQL Developer 사용)
-- 1. 테이블 우클릭 > Export
-- 2. 형식 선택: CSV, Excel 등
-- 3. 저장 위치 지정

-- SQL*Plus에서 spool 사용
SPOOL /tmp/users_export.txt
SELECT * FROM USERS;
SPOOL OFF;
```

### 데이터 가져오기 (Import)
```sql
-- SQL*Plus에서 스크립트 실행
@import_data.sql

-- SQL Developer에서 Import Wizard 사용
-- 1. 테이블 우클릭 > Import Data
-- 2. 파일 선택
-- 3. 컬럼 매핑 확인
-- 4. Import 실행
```

---

## 보안 체크리스트

### 일일 점검
- [ ] 실패한 로그인 시도 확인
- [ ] 새로운 보안 사고 확인
- [ ] 미해결 치명적 취약점 확인
- [ ] 계정 잠금 상태 확인

### 주간 점검
- [ ] 사용자 권한 변경 이력 검토
- [ ] 감사 로그 이상 패턴 분석
- [ ] 보안 정책 준수 여부 확인
- [ ] 취약점 해결 진행 상황 확인

### 월간 점검
- [ ] 비활성 계정 정리
- [ ] 역할 및 권한 재검토
- [ ] 패스워드 만료 정책 준수 확인
- [ ] 오래된 로그 아카이빙
- [ ] 데이터베이스 성능 분석
- [ ] 통계 정보 업데이트

---

**버전:** 1.0.0  
**작성일:** 2026-01-18  
**마지막 업데이트:** 2026-01-18
