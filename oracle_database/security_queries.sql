# Oracle Database 보안 관련 SQL 쿼리 모음

## 정보보안기사 시험 대비 실무 쿼리

### 1. 사용자 및 권한 관리 쿼리

#### 모든 사용자 목록 및 상태
```sql
SELECT 
    username,
    account_status,
    lock_date,
    expiry_date,
    default_tablespace,
    profile,
    created
FROM dba_users
ORDER BY created DESC;
```

#### 특정 사용자의 모든 권한 조회
```sql
-- 시스템 권한
SELECT 'SYSTEM PRIVILEGE' AS privilege_type, privilege
FROM dba_sys_privs
WHERE grantee = '&USERNAME'
UNION ALL
-- 역할
SELECT 'ROLE' AS privilege_type, granted_role
FROM dba_role_privs
WHERE grantee = '&USERNAME'
UNION ALL
-- 객체 권한
SELECT 'OBJECT PRIVILEGE' AS privilege_type, privilege || ' ON ' || owner || '.' || table_name
FROM dba_tab_privs
WHERE grantee = '&USERNAME'
ORDER BY privilege_type, privilege;
```

#### 역할별 권한 계층 구조
```sql
SELECT 
    LPAD(' ', 2 * (LEVEL - 1)) || granted_role AS role_hierarchy,
    grantee,
    admin_option
FROM (
    SELECT grantee, granted_role, admin_option
    FROM dba_role_privs
    UNION ALL
    SELECT granted_role, granted_role, NULL
    FROM dba_roles
)
START WITH grantee = '&ROLE_NAME'
CONNECT BY PRIOR granted_role = grantee;
```

### 2. 감사 분석 쿼리

#### 최근 로그인 실패 시도
```sql
SELECT 
    username,
    os_username,
    userhost,
    terminal,
    timestamp,
    returncode,
    COUNT(*) OVER (PARTITION BY username ORDER BY timestamp 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS failed_count
FROM dba_audit_trail
WHERE action_name = 'LOGON'
AND returncode != 0
AND timestamp >= SYSDATE - 7
ORDER BY timestamp DESC;
```

#### 사용자별 활동 통계 (최근 7일)
```sql
SELECT 
    username,
    action_name,
    COUNT(*) AS action_count,
    MIN(timestamp) AS first_action,
    MAX(timestamp) AS last_action
FROM dba_audit_trail
WHERE timestamp >= SYSDATE - 7
GROUP BY username, action_name
HAVING COUNT(*) > 10
ORDER BY action_count DESC;
```

#### DDL 변경 이력
```sql
SELECT 
    username,
    obj_name,
    action_name,
    timestamp,
    sql_text
FROM dba_audit_trail
WHERE action_name IN ('CREATE TABLE', 'ALTER TABLE', 'DROP TABLE', 
                      'CREATE INDEX', 'DROP INDEX',
                      'CREATE USER', 'ALTER USER', 'DROP USER')
AND timestamp >= SYSDATE - 30
ORDER BY timestamp DESC;
```

#### 의심스러운 권한 부여/회수 활동
```sql
SELECT 
    username,
    obj_name,
    action_name,
    timestamp,
    priv_used
FROM dba_audit_trail
WHERE action_name IN ('GRANT', 'REVOKE')
AND timestamp >= SYSDATE - 7
ORDER BY timestamp DESC;
```

### 3. 보안 취약점 점검 쿼리

#### 기본 패스워드를 사용하는 계정
```sql
SELECT 
    u.username,
    u.account_status,
    u.created,
    u.profile
FROM dba_users u
WHERE username IN (
    SELECT username 
    FROM dba_users_with_defpwd
)
ORDER BY u.created DESC;
```

#### 패스워드가 만료되지 않는 계정
```sql
SELECT 
    username,
    account_status,
    expiry_date,
    profile
FROM dba_users
WHERE expiry_date IS NULL
OR expiry_date > SYSDATE + 365
ORDER BY username;
```

#### 과도한 권한을 가진 사용자 (ANY 권한)
```sql
SELECT 
    grantee,
    privilege,
    admin_option
FROM dba_sys_privs
WHERE privilege LIKE '%ANY%'
AND grantee NOT IN ('SYS', 'SYSTEM', 'DBA', 'IMP_FULL_DATABASE', 'EXP_FULL_DATABASE')
ORDER BY grantee, privilege;
```

#### PUBLIC에 부여된 위험한 권한
```sql
SELECT 
    'SYSTEM' AS priv_type,
    privilege,
    admin_option
FROM dba_sys_privs
WHERE grantee = 'PUBLIC'
UNION ALL
SELECT 
    'OBJECT' AS priv_type,
    privilege || ' ON ' || owner || '.' || table_name,
    grantable
FROM dba_tab_privs
WHERE grantee = 'PUBLIC'
ORDER BY priv_type, privilege;
```

#### 계정 잠금 정책이 없는 프로파일
```sql
SELECT 
    profile,
    resource_name,
    limit
FROM dba_profiles
WHERE resource_type = 'PASSWORD'
AND resource_name = 'FAILED_LOGIN_ATTEMPTS'
AND (limit = 'UNLIMITED' OR limit = 'DEFAULT')
ORDER BY profile;
```

### 4. 세션 및 잠금 모니터링 쿼리

#### 현재 활성 세션 및 실행 중인 SQL
```sql
SELECT 
    s.sid,
    s.serial#,
    s.username,
    s.status,
    s.osuser,
    s.machine,
    s.program,
    s.logon_time,
    s.last_call_et AS seconds_since_last_call,
    q.sql_text
FROM v$session s
LEFT JOIN v$sql q ON s.sql_id = q.sql_id
WHERE s.username IS NOT NULL
AND s.status = 'ACTIVE'
ORDER BY s.last_call_et DESC;
```

#### 블로킹 세션 조회 (데드락 분석)
```sql
SELECT 
    s1.username AS blocking_user,
    s1.sid AS blocking_sid,
    s1.serial# AS blocking_serial,
    s1.machine AS blocking_machine,
    s2.username AS waiting_user,
    s2.sid AS waiting_sid,
    s2.serial# AS waiting_serial,
    s2.machine AS waiting_machine,
    s2.event AS waiting_event,
    s2.seconds_in_wait,
    lo.object_id,
    do.object_name,
    do.object_type
FROM v$session s1
JOIN v$session s2 ON s1.sid = s2.blocking_session
LEFT JOIN v$locked_object lo ON s2.sid = lo.session_id
LEFT JOIN dba_objects do ON lo.object_id = do.object_id
WHERE s1.blocking_session IS NULL
ORDER BY s2.seconds_in_wait DESC;
```

#### 장기 실행 세션
```sql
SELECT 
    s.sid,
    s.serial#,
    s.username,
    s.status,
    s.machine,
    ROUND((SYSDATE - s.logon_time) * 24 * 60, 0) AS session_duration_minutes,
    s.last_call_et AS idle_seconds,
    q.sql_text
FROM v$session s
LEFT JOIN v$sql q ON s.sql_id = q.sql_id
WHERE s.username IS NOT NULL
AND (SYSDATE - s.logon_time) * 24 * 60 > 60  -- 1시간 이상
ORDER BY session_duration_minutes DESC;
```

### 5. 암호화 및 민감 데이터 관리 쿼리

#### 암호화된 테이블스페이스 목록
```sql
SELECT 
    tablespace_name,
    encrypted,
    status,
    contents,
    extent_management,
    allocation_type
FROM dba_tablespaces
WHERE encrypted = 'YES'
ORDER BY tablespace_name;
```

#### 암호화된 컬럼 목록
```sql
SELECT 
    owner,
    table_name,
    column_name,
    encryption_alg AS algorithm,
    salt,
    integrity_alg
FROM dba_encrypted_columns
ORDER BY owner, table_name, column_name;
```

#### Wallet 상태 확인
```sql
SELECT 
    wrl_type,
    wrl_parameter,
    status,
    wallet_type,
    wallet_order,
    fully_backed_up
FROM v$encryption_wallet;
```

### 6. 네트워크 보안 쿼리

#### 세션별 암호화 상태
```sql
SELECT 
    s.sid,
    s.serial#,
    s.username,
    s.osuser,
    s.machine,
    s.program,
    sci.network_service_banner
FROM v$session s
JOIN v$session_connect_info sci ON s.sid = sci.sid
WHERE s.username IS NOT NULL
AND sci.network_service_banner LIKE '%Encryption%'
OR sci.network_service_banner LIKE '%Crypto%'
ORDER BY s.username;
```

#### 클라이언트 IP 주소별 접속 현황
```sql
SELECT 
    machine,
    COUNT(*) AS connection_count,
    MIN(logon_time) AS first_login,
    MAX(logon_time) AS last_login,
    LISTAGG(DISTINCT username, ', ') WITHIN GROUP (ORDER BY username) AS users
FROM v$session
WHERE username IS NOT NULL
GROUP BY machine
ORDER BY connection_count DESC;
```

### 7. 리소스 사용량 및 할당량 쿼리

#### 테이블스페이스 할당량 사용 현황
```sql
SELECT 
    username,
    tablespace_name,
    ROUND(bytes/1024/1024, 2) AS used_mb,
    ROUND(max_bytes/1024/1024, 2) AS quota_mb,
    CASE 
        WHEN max_bytes = -1 THEN 0
        ELSE ROUND((bytes/max_bytes) * 100, 2)
    END AS usage_percent
FROM dba_ts_quotas
ORDER BY bytes DESC;
```

#### 사용자별 객체 및 공간 사용량
```sql
SELECT 
    owner,
    COUNT(*) AS object_count,
    ROUND(SUM(bytes)/1024/1024, 2) AS total_mb
FROM dba_segments
WHERE owner NOT IN ('SYS', 'SYSTEM', 'XDB', 'MDSYS', 'CTXSYS', 'WMSYS')
GROUP BY owner
ORDER BY total_mb DESC;
```

### 8. 정책 및 컴플라이언스 쿼리

#### VPD/RLS 정책 목록
```sql
SELECT 
    object_owner,
    object_name,
    policy_name,
    policy_group,
    pf_owner,
    package || '.' || function AS policy_function,
    sel, ins, upd, del,
    enable,
    static_policy,
    policy_type
FROM dba_policies
ORDER BY object_owner, object_name, policy_name;
```

#### FGA 정책 목록 및 설정
```sql
SELECT 
    object_schema,
    object_name,
    policy_name,
    policy_column,
    audit_condition,
    statement_types,
    audit_trail,
    enabled
FROM dba_audit_policies
ORDER BY object_schema, object_name, policy_name;
```

#### 프로파일별 리소스 및 패스워드 제한
```sql
SELECT 
    profile,
    resource_type,
    resource_name,
    limit
FROM dba_profiles
WHERE profile != 'DEFAULT'
ORDER BY profile, resource_type, resource_name;
```

### 9. 성능 및 통계 쿼리

#### 가장 많이 실행된 SQL (Top 20)
```sql
SELECT 
    sql_id,
    executions,
    ROUND(elapsed_time/1000000, 2) AS elapsed_sec,
    ROUND(cpu_time/1000000, 2) AS cpu_sec,
    ROUND(elapsed_time/executions/1000000, 4) AS avg_elapsed_sec,
    buffer_gets,
    disk_reads,
    rows_processed,
    SUBSTR(sql_text, 1, 100) AS sql_text
FROM v$sqlarea
WHERE executions > 0
ORDER BY executions DESC
FETCH FIRST 20 ROWS ONLY;
```

#### 비효율적인 SQL (Full Table Scan)
```sql
SELECT DISTINCT
    s.sql_id,
    s.executions,
    s.buffer_gets,
    s.disk_reads,
    t.object_name,
    SUBSTR(s.sql_text, 1, 100) AS sql_text
FROM v$sql s
JOIN v$sql_plan t ON s.sql_id = t.sql_id
WHERE t.operation = 'TABLE ACCESS'
AND t.options = 'FULL'
AND s.executions > 100
ORDER BY s.buffer_gets DESC
FETCH FIRST 20 ROWS ONLY;
```

### 10. 백업 및 복구 보안 쿼리

#### RMAN 백업 이력
```sql
SELECT 
    session_key,
    input_type,
    status,
    start_time,
    end_time,
    ROUND((end_time - start_time) * 24 * 60, 2) AS duration_minutes,
    input_bytes/1024/1024 AS input_mb,
    output_bytes/1024/1024 AS output_mb
FROM v$rman_backup_job_details
WHERE start_time >= SYSDATE - 30
ORDER BY start_time DESC;
```

## 보안 모니터링 대시보드 쿼리

### 종합 보안 대시보드
```sql
SELECT '활성 세션 수' AS metric, TO_CHAR(COUNT(*)) AS value
FROM v$session WHERE status = 'ACTIVE' AND username IS NOT NULL
UNION ALL
SELECT '오늘 실패한 로그인', TO_CHAR(COUNT(*))
FROM dba_audit_trail 
WHERE action_name = 'LOGON' AND returncode != 0 
AND TRUNC(timestamp) = TRUNC(SYSDATE)
UNION ALL
SELECT '잠긴 계정 수', TO_CHAR(COUNT(*))
FROM dba_users WHERE account_status LIKE '%LOCKED%'
UNION ALL
SELECT '기본 패스워드 사용 계정', TO_CHAR(COUNT(*))
FROM dba_users_with_defpwd
UNION ALL
SELECT 'DBA 권한 사용자', TO_CHAR(COUNT(DISTINCT grantee))
FROM dba_role_privs WHERE granted_role = 'DBA'
UNION ALL
SELECT '활성 FGA 정책', TO_CHAR(COUNT(*))
FROM dba_audit_policies WHERE enabled = 'YES'
UNION ALL
SELECT '암호화된 컬럼 수', TO_CHAR(COUNT(*))
FROM dba_encrypted_columns;
```

## 참고사항
- 이 쿼리들은 DBA 또는 적절한 SELECT 권한이 필요합니다
- 프로덕션 환경에서는 성능 영향을 고려하여 실행하세요
- 정기적인 보안 점검 스크립트로 활용 가능합니다
