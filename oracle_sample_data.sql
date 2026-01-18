-- ============================================================================
-- 오라클 샘플 데이터 삽입 스크립트 (Oracle Sample Data Insert Script)
-- 정보보안 시스템용 (For Information Security System)
-- ============================================================================

-- ============================================================================
-- 1. 역할 데이터 삽입 (Insert Role Data)
-- ============================================================================

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'ADMIN', '시스템 관리자 역할', 'Y', 'SYSTEM');

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'SECURITY_OFFICER', '보안 담당자 역할', 'Y', 'SYSTEM');

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'AUDITOR', '감사자 역할', 'Y', 'SYSTEM');

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'USER', '일반 사용자 역할', 'Y', 'SYSTEM');

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_ROLE_ID.NEXTVAL, 'GUEST', '게스트 사용자 역할', 'Y', 'SYSTEM');

-- ============================================================================
-- 2. 사용자 데이터 삽입 (Insert User Data)
-- 주의: 패스워드 해시는 예시용입니다. 실제 환경에서는 bcrypt, scrypt, Argon2 등
--       강력한 해싱 알고리즘을 사용하고 솔트를 추가해야 합니다.
-- ============================================================================

INSERT INTO USERS (USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, PHONE_NUMBER, DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_USER_ID.NEXTVAL, 'admin', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr.9U6FMe', 'admin@company.com', '김관리', '010-1111-2222', '정보보안팀', '팀장', 'Y', 'SYSTEM');

INSERT INTO USERS (USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, PHONE_NUMBER, DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_USER_ID.NEXTVAL, 'security01', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Ss7KIUgO2t0jWMUW', 'security01@company.com', '이보안', '010-2222-3333', '정보보안팀', '과장', 'Y', 'SYSTEM');

INSERT INTO USERS (USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, PHONE_NUMBER, DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_USER_ID.NEXTVAL, 'auditor01', '$2a$12$NyVH1w/xKqfC/iHTJHb8e.K0xHJN8oPP8I3Y8fQrJjK3zP8nQ9YeS', 'auditor01@company.com', '박감사', '010-3333-4444', '감사팀', '대리', 'Y', 'SYSTEM');

INSERT INTO USERS (USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, PHONE_NUMBER, DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_USER_ID.NEXTVAL, 'user01', '$2a$12$HdKL5ynFJCDJ8T8u8pQsIOSLp5rNVqLqhB6fRp7xZ9R3qY8YuF8Pe', 'user01@company.com', '최사용', '010-4444-5555', '개발팀', '사원', 'Y', 'SYSTEM');

INSERT INTO USERS (USER_ID, USERNAME, PASSWORD_HASH, EMAIL, FULL_NAME, PHONE_NUMBER, DEPARTMENT, POSITION, IS_ACTIVE, CREATED_BY)
VALUES (SEQ_USER_ID.NEXTVAL, 'user02', '$2a$12$VqJNc7xJ3Y9q8p9K5L3M8eP7R9S4T8U6V2W1X5Y4Z3A1B2C3D4E5F', 'user02@company.com', '정일반', '010-5555-6666', '영업팀', '사원', 'Y', 'SYSTEM');

-- ============================================================================
-- 3. 사용자-역할 매핑 삽입 (Insert User-Role Mapping)
-- ============================================================================

-- admin 사용자에게 ADMIN 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 1, 1, 'SYSTEM');

-- security01 사용자에게 SECURITY_OFFICER 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 2, 2, 'SYSTEM');

-- auditor01 사용자에게 AUDITOR 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 3, 3, 'SYSTEM');

-- user01 사용자에게 USER 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 4, 4, 'SYSTEM');

-- user02 사용자에게 USER 역할 할당
INSERT INTO USER_ROLES (USER_ROLE_ID, USER_ID, ROLE_ID, ASSIGNED_BY)
VALUES (SEQ_USER_ROLE_ID.NEXTVAL, 5, 4, 'SYSTEM');

-- ============================================================================
-- 4. 권한 데이터 삽입 (Insert Permission Data)
-- ============================================================================

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'USER_CREATE', '사용자 생성 권한', 'USER', 'CREATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'USER_READ', '사용자 조회 권한', 'USER', 'READ', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'USER_UPDATE', '사용자 수정 권한', 'USER', 'UPDATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'USER_DELETE', '사용자 삭제 권한', 'USER', 'DELETE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'AUDIT_READ', '감사 로그 조회 권한', 'AUDIT', 'READ', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'POLICY_CREATE', '보안 정책 생성 권한', 'POLICY', 'CREATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'POLICY_UPDATE', '보안 정책 수정 권한', 'POLICY', 'UPDATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'INCIDENT_CREATE', '보안 사고 등록 권한', 'INCIDENT', 'CREATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'INCIDENT_UPDATE', '보안 사고 수정 권한', 'INCIDENT', 'UPDATE', 'SYSTEM');

INSERT INTO PERMISSIONS (PERMISSION_ID, PERMISSION_NAME, PERMISSION_DESC, RESOURCE_TYPE, ACTION_TYPE, CREATED_BY)
VALUES (SEQ_PERMISSION_ID.NEXTVAL, 'VULNERABILITY_READ', '취약점 조회 권한', 'VULNERABILITY', 'READ', 'SYSTEM');

-- ============================================================================
-- 5. 역할-권한 매핑 삽입 (Insert Role-Permission Mapping)
-- ============================================================================

-- ADMIN 역할에 모든 권한 할당
INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
SELECT SEQ_ROLE_PERMISSION_ID.NEXTVAL, 1, PERMISSION_ID, 'SYSTEM'
FROM PERMISSIONS;

-- SECURITY_OFFICER 역할에 보안 관련 권한 할당
INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 2, 'SYSTEM'); -- USER_READ

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 5, 'SYSTEM'); -- AUDIT_READ

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 6, 'SYSTEM'); -- POLICY_CREATE

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 7, 'SYSTEM'); -- POLICY_UPDATE

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 8, 'SYSTEM'); -- INCIDENT_CREATE

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 9, 'SYSTEM'); -- INCIDENT_UPDATE

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 2, 10, 'SYSTEM'); -- VULNERABILITY_READ

-- AUDITOR 역할에 감사 및 조회 권한 할당
INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 3, 2, 'SYSTEM'); -- USER_READ

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 3, 5, 'SYSTEM'); -- AUDIT_READ

INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 3, 10, 'SYSTEM'); -- VULNERABILITY_READ

-- USER 역할에 기본 조회 권한 할당
INSERT INTO ROLE_PERMISSIONS (ROLE_PERMISSION_ID, ROLE_ID, PERMISSION_ID, GRANTED_BY)
VALUES (SEQ_ROLE_PERMISSION_ID.NEXTVAL, 4, 2, 'SYSTEM'); -- USER_READ

-- ============================================================================
-- 6. 패스워드 정책 삽입 (Insert Password Policy)
-- ============================================================================

INSERT INTO PASSWORD_POLICIES (
    PASSWORD_POLICY_ID, MIN_LENGTH, MAX_LENGTH, 
    REQUIRE_UPPERCASE, REQUIRE_LOWERCASE, REQUIRE_DIGIT, REQUIRE_SPECIAL,
    MAX_AGE_DAYS, MIN_AGE_DAYS, PASSWORD_HISTORY_COUNT,
    MAX_LOGIN_ATTEMPTS, LOCKOUT_DURATION_MINUTES,
    IS_ACTIVE, CREATED_BY
) VALUES (
    SEQ_PASSWORD_POLICY_ID.NEXTVAL, 10, 128,
    'Y', 'Y', 'Y', 'Y',
    90, 1, 5,
    5, 30,
    'Y', 'SYSTEM'
);

-- ============================================================================
-- 7. 보안 정책 삽입 (Insert Security Policies)
-- ============================================================================

INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL, 
    '패스워드 복잡도 정책', 
    'PASSWORD',
    '안전한 패스워드 사용을 위한 복잡도 요구사항',
    '최소 10자 이상, 대소문자, 숫자, 특수문자 포함 필수',
    'HIGH',
    'SYSTEM'
);

INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL, 
    '접근 제어 정책', 
    'ACCESS',
    '시스템 접근에 대한 통제 정책',
    '역할 기반 접근 제어(RBAC) 적용, 최소 권한 원칙 준수',
    'CRITICAL',
    'SYSTEM'
);

INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL, 
    '네트워크 보안 정책', 
    'NETWORK',
    '네트워크 접근 및 통신 보안 정책',
    '내부망과 외부망 분리, 방화벽 규칙 적용, VPN 사용 권장',
    'HIGH',
    'SYSTEM'
);

INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL, 
    '데이터 보호 정책', 
    'DATA',
    '민감 데이터 보호를 위한 정책',
    '개인정보 암호화 저장, 전송 시 TLS 사용, 정기적 백업',
    'CRITICAL',
    'SYSTEM'
);

INSERT INTO SECURITY_POLICIES (
    POLICY_ID, POLICY_NAME, POLICY_TYPE, POLICY_DESC, 
    POLICY_RULES, SEVERITY_LEVEL, CREATED_BY
) VALUES (
    SEQ_POLICY_ID.NEXTVAL, 
    '감사 로깅 정책', 
    'AUDIT',
    '시스템 활동 감사를 위한 로깅 정책',
    '모든 인증 시도, 권한 변경, 데이터 접근 로그 기록',
    'MEDIUM',
    'SYSTEM'
);

-- ============================================================================
-- 8. 취약점 샘플 데이터 삽입 (Insert Sample Vulnerability Data)
-- ============================================================================

INSERT INTO VULNERABILITIES (
    VULNERABILITY_ID, CVE_ID, VULNERABILITY_NAME, DESCRIPTION,
    SEVERITY_LEVEL, CVSS_SCORE, AFFECTED_SYSTEM, AFFECTED_VERSION,
    STATUS, ASSIGNED_TO, CREATED_BY
) VALUES (
    SEQ_VULNERABILITY_ID.NEXTVAL,
    'CVE-2024-1234',
    'SQL Injection 취약점',
    '입력값 검증 미흡으로 인한 SQL Injection 공격 가능',
    'HIGH',
    8.5,
    'Web Application',
    'v1.2.3',
    'OPEN',
    'security01',
    'SYSTEM'
);

INSERT INTO VULNERABILITIES (
    VULNERABILITY_ID, CVE_ID, VULNERABILITY_NAME, DESCRIPTION,
    SEVERITY_LEVEL, CVSS_SCORE, AFFECTED_SYSTEM, AFFECTED_VERSION,
    STATUS, ASSIGNED_TO, CREATED_BY
) VALUES (
    SEQ_VULNERABILITY_ID.NEXTVAL,
    'CVE-2024-5678',
    'Cross-Site Scripting (XSS) 취약점',
    '출력값 인코딩 미흡으로 인한 XSS 공격 가능',
    'MEDIUM',
    6.5,
    'Web Application',
    'v1.2.3',
    'IN_PROGRESS',
    'security01',
    'SYSTEM'
);

INSERT INTO VULNERABILITIES (
    VULNERABILITY_ID, CVE_ID, VULNERABILITY_NAME, DESCRIPTION,
    SEVERITY_LEVEL, CVSS_SCORE, AFFECTED_SYSTEM, AFFECTED_VERSION,
    STATUS, ASSIGNED_TO, CREATED_BY
) VALUES (
    SEQ_VULNERABILITY_ID.NEXTVAL,
    'CVE-2024-9012',
    '인증 우회 취약점',
    '세션 관리 미흡으로 인한 인증 우회 가능',
    'CRITICAL',
    9.2,
    'Authentication Module',
    'v2.0.1',
    'OPEN',
    'security01',
    'SYSTEM'
);

-- ============================================================================
-- 9. 보안 사고 샘플 데이터 삽입 (Insert Sample Security Incident Data)
-- ============================================================================

INSERT INTO SECURITY_INCIDENTS (
    INCIDENT_ID, INCIDENT_TITLE, INCIDENT_TYPE, SEVERITY_LEVEL,
    DESCRIPTION, REPORTED_BY, ASSIGNED_TO, STATUS,
    IMPACT_ASSESSMENT, AFFECTED_USERS
) VALUES (
    SEQ_INCIDENT_ID.NEXTVAL,
    '비정상 로그인 시도 탐지',
    'UNAUTHORIZED_ACCESS',
    'MEDIUM',
    '단시간 내 여러 계정에 대한 로그인 시도 탐지됨',
    'security01',
    'security01',
    'INVESTIGATING',
    '계정 잠금 조치 완료, 추가 모니터링 진행 중',
    0
);

INSERT INTO SECURITY_INCIDENTS (
    INCIDENT_ID, INCIDENT_TITLE, INCIDENT_TYPE, SEVERITY_LEVEL,
    DESCRIPTION, REPORTED_BY, ASSIGNED_TO, STATUS,
    IMPACT_ASSESSMENT, AFFECTED_USERS, AFFECTED_SYSTEMS
) VALUES (
    SEQ_INCIDENT_ID.NEXTVAL,
    '피싱 메일 유포',
    'PHISHING',
    'HIGH',
    '직원 대상 피싱 메일 다수 발송 확인',
    'auditor01',
    'security01',
    'CONTAINED',
    '메일 필터링 강화, 전 직원 주의 공지 발송',
    15,
    'Email System'
);

-- ============================================================================
-- 10. 로그인 이력 샘플 데이터 삽입 (Insert Sample Login History)
-- ============================================================================

INSERT INTO LOGIN_HISTORY (
    LOGIN_ID, USER_ID, USERNAME, LOGIN_TIME, 
    IP_ADDRESS, USER_AGENT, LOGIN_STATUS, SESSION_ID
) VALUES (
    SEQ_LOGIN_ID.NEXTVAL, 
    1, 
    'admin', 
    SYSTIMESTAMP - INTERVAL '1' DAY,
    '192.168.1.100',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
    'SUCCESS',
    'SESSION001'
);

INSERT INTO LOGIN_HISTORY (
    LOGIN_ID, USER_ID, USERNAME, LOGIN_TIME, 
    IP_ADDRESS, USER_AGENT, LOGIN_STATUS, SESSION_ID
) VALUES (
    SEQ_LOGIN_ID.NEXTVAL, 
    2, 
    'security01', 
    SYSTIMESTAMP - INTERVAL '12' HOUR,
    '192.168.1.101',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)',
    'SUCCESS',
    'SESSION002'
);

INSERT INTO LOGIN_HISTORY (
    LOGIN_ID, USER_ID, USERNAME, LOGIN_TIME, 
    IP_ADDRESS, USER_AGENT, LOGIN_STATUS, FAILURE_REASON
) VALUES (
    SEQ_LOGIN_ID.NEXTVAL, 
    NULL, 
    'unknown_user', 
    SYSTIMESTAMP - INTERVAL '6' HOUR,
    '203.0.113.45',
    'curl/7.68.0',
    'FAILED',
    'Invalid username'
);

-- ============================================================================
-- 11. 감사 로그 샘플 데이터 삽입 (Insert Sample Audit Log)
-- ============================================================================

INSERT INTO AUDIT_LOGS (
    AUDIT_ID, USER_ID, USERNAME, ACTION_TYPE, RESOURCE_TYPE, RESOURCE_ID,
    ACTION_DESC, IP_ADDRESS, STATUS, SESSION_ID
) VALUES (
    SEQ_AUDIT_ID.NEXTVAL,
    1,
    'admin',
    'CREATE',
    'USER',
    '5',
    '새로운 사용자 생성: user02',
    '192.168.1.100',
    'SUCCESS',
    'SESSION001'
);

INSERT INTO AUDIT_LOGS (
    AUDIT_ID, USER_ID, USERNAME, ACTION_TYPE, RESOURCE_TYPE, RESOURCE_ID,
    ACTION_DESC, IP_ADDRESS, STATUS, SESSION_ID
) VALUES (
    SEQ_AUDIT_ID.NEXTVAL,
    2,
    'security01',
    'UPDATE',
    'POLICY',
    '1',
    '보안 정책 수정: 패스워드 복잡도 정책',
    '192.168.1.101',
    'SUCCESS',
    'SESSION002'
);

INSERT INTO AUDIT_LOGS (
    AUDIT_ID, USER_ID, USERNAME, ACTION_TYPE, RESOURCE_TYPE, RESOURCE_ID,
    ACTION_DESC, IP_ADDRESS, STATUS, ERROR_MESSAGE
) VALUES (
    SEQ_AUDIT_ID.NEXTVAL,
    4,
    'user01',
    'DELETE',
    'USER',
    '3',
    '사용자 삭제 시도: auditor01',
    '192.168.1.105',
    'FAILURE',
    'Insufficient privileges'
);

-- ============================================================================
-- COMMIT 실행
-- ============================================================================

COMMIT;

-- ============================================================================
-- 완료 메시지
-- ============================================================================

SELECT '샘플 데이터 삽입이 완료되었습니다.' AS MESSAGE FROM DUAL;
