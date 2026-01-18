-- Oracle 샘플 스키마 생성 스크립트
-- 정보보안기사 실습용 데이터베이스 스키마

-- ============================================
-- 1. 테이블스페이스 생성
-- ============================================

-- 데이터 테이블스페이스
CREATE TABLESPACE security_data
DATAFILE 'security_data01.dbf' SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE 1G
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

-- 인덱스 테이블스페이스
CREATE TABLESPACE security_index
DATAFILE 'security_index01.dbf' SIZE 50M
AUTOEXTEND ON NEXT 10M MAXSIZE 500M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

-- ============================================
-- 2. 사용자 생성 및 권한 부여
-- ============================================

-- 보안 관리자 사용자 생성
CREATE USER security_admin IDENTIFIED BY SecurePass123
DEFAULT TABLESPACE security_data
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON security_data
QUOTA UNLIMITED ON security_index;

-- 기본 권한 부여
GRANT CONNECT, RESOURCE TO security_admin;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER TO security_admin;

-- 일반 사용자 생성
CREATE USER app_user IDENTIFIED BY AppPass123
DEFAULT TABLESPACE security_data
TEMPORARY TABLESPACE temp
QUOTA 50M ON security_data;

GRANT CONNECT, RESOURCE TO app_user;

-- ============================================
-- 3. 사용자 정보 테이블
-- ============================================

CREATE TABLE security_admin.users (
    user_id         NUMBER(10) PRIMARY KEY,
    username        VARCHAR2(50) NOT NULL UNIQUE,
    password_hash   VARCHAR2(128) NOT NULL,
    email           VARCHAR2(100),
    full_name       VARCHAR2(100),
    department      VARCHAR2(50),
    status          VARCHAR2(20) DEFAULT 'ACTIVE',
    created_date    DATE DEFAULT SYSDATE,
    last_login      TIMESTAMP,
    failed_attempts NUMBER(2) DEFAULT 0,
    locked_until    TIMESTAMP,
    CONSTRAINT chk_status CHECK (status IN ('ACTIVE', 'INACTIVE', 'LOCKED'))
) TABLESPACE security_data;

-- 시퀀스 생성
CREATE SEQUENCE security_admin.user_seq START WITH 1000 INCREMENT BY 1;

-- 인덱스 생성
CREATE INDEX security_admin.idx_username ON security_admin.users(username)
TABLESPACE security_index;

CREATE INDEX security_admin.idx_email ON security_admin.users(email)
TABLESPACE security_index;

-- ============================================
-- 4. 역할 및 권한 테이블
-- ============================================

CREATE TABLE security_admin.roles (
    role_id         NUMBER(10) PRIMARY KEY,
    role_name       VARCHAR2(50) NOT NULL UNIQUE,
    description     VARCHAR2(200),
    created_date    DATE DEFAULT SYSDATE
) TABLESPACE security_data;

CREATE SEQUENCE security_admin.role_seq START WITH 100 INCREMENT BY 1;

CREATE TABLE security_admin.user_roles (
    user_id         NUMBER(10),
    role_id         NUMBER(10),
    assigned_date   DATE DEFAULT SYSDATE,
    assigned_by     VARCHAR2(50),
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES security_admin.users(user_id),
    CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES security_admin.roles(role_id)
) TABLESPACE security_data;

CREATE TABLE security_admin.permissions (
    permission_id   NUMBER(10) PRIMARY KEY,
    permission_name VARCHAR2(100) NOT NULL UNIQUE,
    resource_type   VARCHAR2(50),
    action_type     VARCHAR2(50),
    description     VARCHAR2(200)
) TABLESPACE security_data;

CREATE SEQUENCE security_admin.permission_seq START WITH 1000 INCREMENT BY 1;

CREATE TABLE security_admin.role_permissions (
    role_id         NUMBER(10),
    permission_id   NUMBER(10),
    granted_date    DATE DEFAULT SYSDATE,
    PRIMARY KEY (role_id, permission_id),
    CONSTRAINT fk_rp_role FOREIGN KEY (role_id) REFERENCES security_admin.roles(role_id),
    CONSTRAINT fk_rp_perm FOREIGN KEY (permission_id) REFERENCES security_admin.permissions(permission_id)
) TABLESPACE security_data;

-- ============================================
-- 5. 감사 로그 테이블
-- ============================================

CREATE TABLE security_admin.audit_log (
    audit_id        NUMBER(19) PRIMARY KEY,
    user_id         NUMBER(10),
    username        VARCHAR2(50),
    action_type     VARCHAR2(50) NOT NULL,
    resource_type   VARCHAR2(50),
    resource_id     VARCHAR2(100),
    action_detail   VARCHAR2(500),
    ip_address      VARCHAR2(45),
    session_id      VARCHAR2(100),
    timestamp       TIMESTAMP DEFAULT SYSTIMESTAMP,
    status          VARCHAR2(20),
    error_message   VARCHAR2(500),
    CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES security_admin.users(user_id)
) TABLESPACE security_data
PARTITION BY RANGE (timestamp) INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
    PARTITION p_initial VALUES LESS THAN (TO_TIMESTAMP('2026-01-01', 'YYYY-MM-DD'))
);

CREATE SEQUENCE security_admin.audit_seq START WITH 1 INCREMENT BY 1;

CREATE INDEX security_admin.idx_audit_user ON security_admin.audit_log(user_id)
TABLESPACE security_index LOCAL;

CREATE INDEX security_admin.idx_audit_timestamp ON security_admin.audit_log(timestamp)
TABLESPACE security_index LOCAL;

-- ============================================
-- 6. 민감 데이터 테이블 (암호화 대상)
-- ============================================

CREATE TABLE security_admin.sensitive_data (
    data_id         NUMBER(10) PRIMARY KEY,
    user_id         NUMBER(10),
    ssn             VARCHAR2(20) ENCRYPT,  -- 주민등록번호 (암호화)
    credit_card     VARCHAR2(20) ENCRYPT,  -- 신용카드 (암호화)
    bank_account    VARCHAR2(50) ENCRYPT,  -- 계좌번호 (암호화)
    salary          NUMBER(15,2) ENCRYPT,  -- 급여 정보 (암호화)
    medical_info    CLOB ENCRYPT,          -- 의료 정보 (암호화)
    created_date    DATE DEFAULT SYSDATE,
    modified_date   DATE,
    CONSTRAINT fk_sd_user FOREIGN KEY (user_id) REFERENCES security_admin.users(user_id)
) TABLESPACE security_data;

CREATE SEQUENCE security_admin.sensitive_seq START WITH 1 INCREMENT BY 1;

-- ============================================
-- 7. 세션 관리 테이블
-- ============================================

CREATE TABLE security_admin.user_sessions (
    session_id      VARCHAR2(100) PRIMARY KEY,
    user_id         NUMBER(10),
    login_time      TIMESTAMP DEFAULT SYSTIMESTAMP,
    logout_time     TIMESTAMP,
    ip_address      VARCHAR2(45),
    user_agent      VARCHAR2(200),
    status          VARCHAR2(20) DEFAULT 'ACTIVE',
    CONSTRAINT fk_session_user FOREIGN KEY (user_id) REFERENCES security_admin.users(user_id),
    CONSTRAINT chk_session_status CHECK (status IN ('ACTIVE', 'EXPIRED', 'LOGGED_OUT'))
) TABLESPACE security_data;

-- ============================================
-- 8. 패스워드 히스토리 테이블
-- ============================================

CREATE TABLE security_admin.password_history (
    history_id      NUMBER(19) PRIMARY KEY,
    user_id         NUMBER(10),
    password_hash   VARCHAR2(128),
    changed_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_pwh_user FOREIGN KEY (user_id) REFERENCES security_admin.users(user_id)
) TABLESPACE security_data;

CREATE SEQUENCE security_admin.pwh_seq START WITH 1 INCREMENT BY 1;

-- ============================================
-- 9. 샘플 데이터 삽입
-- ============================================

-- 역할 데이터
INSERT INTO security_admin.roles VALUES (role_seq.NEXTVAL, 'ADMIN', '시스템 관리자', SYSDATE);
INSERT INTO security_admin.roles VALUES (role_seq.NEXTVAL, 'MANAGER', '부서 관리자', SYSDATE);
INSERT INTO security_admin.roles VALUES (role_seq.NEXTVAL, 'USER', '일반 사용자', SYSDATE);
INSERT INTO security_admin.roles VALUES (role_seq.NEXTVAL, 'AUDITOR', '감사자', SYSDATE);
INSERT INTO security_admin.roles VALUES (role_seq.NEXTVAL, 'SECURITY_OFFICER', '보안 담당자', SYSDATE);

-- 권한 데이터
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'USER_CREATE', 'USER', 'CREATE', '사용자 생성 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'USER_READ', 'USER', 'READ', '사용자 조회 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'USER_UPDATE', 'USER', 'UPDATE', '사용자 수정 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'USER_DELETE', 'USER', 'DELETE', '사용자 삭제 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'ROLE_MANAGE', 'ROLE', 'MANAGE', '역할 관리 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'AUDIT_VIEW', 'AUDIT', 'VIEW', '감사 로그 조회 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'DATA_EXPORT', 'DATA', 'EXPORT', '데이터 내보내기 권한');
INSERT INTO security_admin.permissions VALUES (permission_seq.NEXTVAL, 'SENSITIVE_DATA_ACCESS', 'DATA', 'ACCESS', '민감 정보 접근 권한');

-- 사용자 데이터
INSERT INTO security_admin.users (user_id, username, password_hash, email, full_name, department, status)
VALUES (user_seq.NEXTVAL, 'admin', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', 'admin@company.com', '시스템 관리자', 'IT', 'ACTIVE');

INSERT INTO security_admin.users (user_id, username, password_hash, email, full_name, department, status)
VALUES (user_seq.NEXTVAL, 'jsmith', 'EF92B778BAFE771E89245B89ECBC08A44A4E166C06659911881F383D4473E94F', 'jsmith@company.com', 'John Smith', 'HR', 'ACTIVE');

INSERT INTO security_admin.users (user_id, username, password_hash, email, full_name, department, status)
VALUES (user_seq.NEXTVAL, 'mjohnson', '5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5', 'mjohnson@company.com', 'Mary Johnson', 'Finance', 'ACTIVE');

INSERT INTO security_admin.users (user_id, username, password_hash, email, full_name, department, status)
VALUES (user_seq.NEXTVAL, 'bwilliams', '3F39D5C348E5B79D06E842C114E6CC571583BBF44E4B0EBFDA1A01EC05745D43', 'bwilliams@company.com', 'Bob Williams', 'Sales', 'ACTIVE');

COMMIT;

-- ============================================
-- 10. 뷰 생성
-- ============================================

-- 사용자 권한 뷰
CREATE OR REPLACE VIEW security_admin.v_user_permissions AS
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    r.role_name,
    p.permission_name,
    p.resource_type,
    p.action_type
FROM security_admin.users u
JOIN security_admin.user_roles ur ON u.user_id = ur.user_id
JOIN security_admin.roles r ON ur.role_id = r.role_id
JOIN security_admin.role_permissions rp ON r.role_id = rp.role_id
JOIN security_admin.permissions p ON rp.permission_id = p.permission_id;

-- 활성 세션 뷰
CREATE OR REPLACE VIEW security_admin.v_active_sessions AS
SELECT 
    s.session_id,
    u.username,
    u.full_name,
    s.login_time,
    s.ip_address,
    ROUND((SYSTIMESTAMP - s.login_time) * 24 * 60, 0) AS duration_minutes
FROM security_admin.user_sessions s
JOIN security_admin.users u ON s.user_id = u.user_id
WHERE s.status = 'ACTIVE';

-- 감사 로그 요약 뷰
CREATE OR REPLACE VIEW security_admin.v_audit_summary AS
SELECT 
    username,
    action_type,
    COUNT(*) AS action_count,
    MIN(timestamp) AS first_action,
    MAX(timestamp) AS last_action
FROM security_admin.audit_log
WHERE timestamp >= SYSTIMESTAMP - INTERVAL '7' DAY
GROUP BY username, action_type;

-- ============================================
-- 완료 메시지
-- ============================================

SELECT '샘플 스키마 생성이 완료되었습니다.' AS MESSAGE FROM DUAL;
SELECT '생성된 테이블: ' || COUNT(*) || '개' AS TABLE_COUNT 
FROM user_tables WHERE table_name LIKE '%SECURITY%';
