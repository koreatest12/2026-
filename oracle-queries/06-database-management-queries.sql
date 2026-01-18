-- ============================================
-- Oracle 데이터베이스 관리 및 성능 쿼리 목록
-- 정보보안기사 시험 대비용
-- ============================================

-- ============================================
-- 1. 데이터베이스 정보 조회
-- ============================================

-- 데이터베이스 기본 정보
SELECT name, db_unique_name, created, log_mode, open_mode
FROM V$DATABASE;

-- 데이터베이스 버전 정보
SELECT * FROM V$VERSION;

-- 인스턴스 정보
SELECT instance_name, host_name, version, startup_time, status
FROM V$INSTANCE;

-- 데이터베이스 파라미터 조회
SELECT name, value, description
FROM V$PARAMETER
WHERE name LIKE '%audit%'
ORDER BY name;

-- 수정 가능한 파라미터 조회
SELECT name, value, isses_modifiable, issys_modifiable
FROM V$PARAMETER
WHERE isses_modifiable = 'TRUE' OR issys_modifiable = 'IMMEDIATE'
ORDER BY name;

-- ============================================
-- 2. 테이블스페이스 관리
-- ============================================

-- 테이블스페이스 목록
SELECT tablespace_name, status, contents, extent_management, 
       segment_space_management
FROM DBA_TABLESPACES
ORDER BY tablespace_name;

-- 테이블스페이스 사용률
SELECT tablespace_name,
       ROUND(used_space * 8192 / 1024 / 1024, 2) AS used_mb,
       ROUND(tablespace_size * 8192 / 1024 / 1024, 2) AS total_mb,
       ROUND(used_percent, 2) AS used_percent
FROM DBA_TABLESPACE_USAGE_METRICS
ORDER BY used_percent DESC;

-- 데이터 파일 정보
SELECT file_name, tablespace_name, 
       ROUND(bytes / 1024 / 1024, 2) AS size_mb,
       ROUND(maxbytes / 1024 / 1024, 2) AS max_mb,
       autoextensible, status
FROM DBA_DATA_FILES
ORDER BY tablespace_name, file_name;

-- 임시 테이블스페이스 사용률
SELECT tablespace_name,
       ROUND(used_space * 8192 / 1024 / 1024, 2) AS used_mb,
       ROUND(tablespace_size * 8192 / 1024 / 1024, 2) AS total_mb
FROM DBA_TEMP_FREE_SPACE;

-- ============================================
-- 3. 스키마 객체 정보
-- ============================================

-- 사용자별 객체 수
SELECT owner, object_type, COUNT(*) AS object_count
FROM DBA_OBJECTS
WHERE owner NOT IN ('SYS', 'SYSTEM', 'OUTLN', 'DBSNMP')
GROUP BY owner, object_type
ORDER BY owner, object_type;

-- 테이블 정보
SELECT owner, table_name, tablespace_name, num_rows, 
       last_analyzed
FROM DBA_TABLES
WHERE owner = 'HR'
ORDER BY table_name;

-- 인덱스 정보
SELECT owner, index_name, table_name, uniqueness, 
       status, tablespace_name
FROM DBA_INDEXES
WHERE owner = 'HR'
ORDER BY table_name, index_name;

-- 뷰 정보
SELECT owner, view_name, text_length
FROM DBA_VIEWS
WHERE owner = 'HR'
ORDER BY view_name;

-- 시퀀스 정보
SELECT sequence_owner, sequence_name, min_value, max_value, 
       increment_by, last_number
FROM DBA_SEQUENCES
WHERE sequence_owner = 'HR'
ORDER BY sequence_name;

-- 프로시저 및 함수 정보
SELECT owner, object_name, object_type, status, created, last_ddl_time
FROM DBA_OBJECTS
WHERE owner = 'HR'
  AND object_type IN ('PROCEDURE', 'FUNCTION', 'PACKAGE')
ORDER BY object_type, object_name;

-- ============================================
-- 4. 제약조건 조회
-- ============================================

-- 테이블의 제약조건 조회
SELECT constraint_name, constraint_type, search_condition, 
       status, validated
FROM DBA_CONSTRAINTS
WHERE owner = 'HR' AND table_name = 'EMPLOYEES'
ORDER BY constraint_type;

-- 외래키 관계 조회
SELECT a.constraint_name, a.table_name, a.column_name,
       c_pk.table_name AS referenced_table,
       b.column_name AS referenced_column
FROM DBA_CONS_COLUMNS a
JOIN DBA_CONSTRAINTS c ON a.constraint_name = c.constraint_name
JOIN DBA_CONSTRAINTS c_pk ON c.r_constraint_name = c_pk.constraint_name
JOIN DBA_CONS_COLUMNS b ON c_pk.constraint_name = b.constraint_name
WHERE c.constraint_type = 'R'
  AND a.owner = 'HR'
ORDER BY a.table_name;

-- ============================================
-- 5. 통계 정보 관리
-- ============================================

-- 테이블 통계 조회
SELECT table_name, num_rows, blocks, avg_row_len, 
       last_analyzed
FROM DBA_TABLES
WHERE owner = 'HR'
ORDER BY num_rows DESC;

-- 인덱스 통계 조회
SELECT index_name, table_name, blevel, leaf_blocks, 
       distinct_keys, last_analyzed
FROM DBA_INDEXES
WHERE owner = 'HR'
ORDER BY table_name;

-- 컬럼 통계 조회
SELECT table_name, column_name, num_distinct, density, 
       num_nulls, last_analyzed
FROM DBA_TAB_COL_STATISTICS
WHERE owner = 'HR' AND table_name = 'EMPLOYEES'
ORDER BY column_name;

-- 통계 수집
EXEC DBMS_STATS.GATHER_TABLE_STATS('HR', 'EMPLOYEES');
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('HR');
EXEC DBMS_STATS.GATHER_DATABASE_STATS;

-- ============================================
-- 6. 세그먼트 및 익스텐트 정보
-- ============================================

-- 세그먼트 크기 조회
SELECT owner, segment_name, segment_type, tablespace_name,
       ROUND(bytes / 1024 / 1024, 2) AS size_mb
FROM DBA_SEGMENTS
WHERE owner = 'HR'
ORDER BY bytes DESC;

-- 큰 테이블 TOP 10
SELECT owner, segment_name,
       ROUND(bytes / 1024 / 1024, 2) AS size_mb
FROM DBA_SEGMENTS
WHERE segment_type = 'TABLE'
ORDER BY bytes DESC
FETCH FIRST 10 ROWS ONLY;

-- 익스텐트 정보
SELECT owner, segment_name, extent_id, 
       ROUND(bytes / 1024 / 1024, 2) AS extent_mb
FROM DBA_EXTENTS
WHERE owner = 'HR' AND segment_name = 'EMPLOYEES'
ORDER BY extent_id;

-- ============================================
-- 7. 무효화된 객체 관리
-- ============================================

-- 무효화된 객체 조회
SELECT owner, object_name, object_type, status
FROM DBA_OBJECTS
WHERE status = 'INVALID'
  AND owner NOT IN ('SYS', 'SYSTEM')
ORDER BY owner, object_type, object_name;

-- 객체 재컴파일
ALTER PROCEDURE hr.salary_procedure COMPILE;
ALTER FUNCTION hr.get_salary COMPILE;
ALTER PACKAGE hr.emp_package COMPILE;
ALTER VIEW hr.emp_view COMPILE;

-- 스키마 전체 재컴파일
EXEC DBMS_UTILITY.COMPILE_SCHEMA('HR');

-- ============================================
-- 8. 의존성(Dependency) 조회
-- ============================================

-- 객체가 참조하는 객체들 조회
SELECT name, type, referenced_name, referenced_type
FROM DBA_DEPENDENCIES
WHERE owner = 'HR' AND name = 'EMP_VIEW'
ORDER BY referenced_type, referenced_name;

-- 객체를 참조하는 객체들 조회
SELECT name, type, owner
FROM DBA_DEPENDENCIES
WHERE referenced_owner = 'HR' 
  AND referenced_name = 'EMPLOYEES'
ORDER BY type, name;

-- ============================================
-- 9. Redo 로그 관리
-- ============================================

-- Redo 로그 파일 정보
SELECT group#, member, status, type
FROM V$LOGFILE
ORDER BY group#;

-- Redo 로그 그룹 정보
SELECT group#, thread#, sequence#, bytes/1024/1024 AS size_mb, 
       members, status
FROM V$LOG
ORDER BY group#;

-- 현재 Redo 로그 그룹
SELECT group#, sequence#, status, archived
FROM V$LOG
WHERE status = 'CURRENT';

-- 로그 스위치 이력
SELECT TO_CHAR(first_time, 'YYYY-MM-DD HH24') AS hour,
       COUNT(*) AS log_switches
FROM V$LOG_HISTORY
WHERE first_time > SYSDATE - 7
GROUP BY TO_CHAR(first_time, 'YYYY-MM-DD HH24')
ORDER BY hour DESC;

-- ============================================
-- 10. 아카이브 로그 관리
-- ============================================

-- 아카이브 모드 확인
SELECT log_mode FROM V$DATABASE;

-- 아카이브 로그 정보
SELECT name, sequence#, first_time, next_time,
       ROUND(blocks * block_size / 1024 / 1024, 2) AS size_mb
FROM V$ARCHIVED_LOG
WHERE first_time > SYSDATE - 7
ORDER BY first_time DESC;

-- 아카이브 로그 목적지
SELECT dest_id, destination, status, log_sequence
FROM V$ARCHIVE_DEST
WHERE status = 'VALID';

-- ============================================
-- 11. 백업 및 복구 정보
-- ============================================

-- RMAN 백업 정보 (RMAN 사용 시)
SELECT session_key, input_type, status, 
       start_time, end_time, 
       ROUND(input_bytes / 1024 / 1024, 2) AS input_mb
FROM V$RMAN_BACKUP_JOB_DETAILS
ORDER BY start_time DESC
FETCH FIRST 20 ROWS ONLY;

-- 최근 백업 세트
SELECT bs.recid, bs.set_stamp, bs.set_count,
       bs.backup_type, TO_CHAR(bs.completion_time, 'YYYY-MM-DD HH24:MI:SS') AS completed
FROM V$BACKUP_SET bs
ORDER BY bs.completion_time DESC
FETCH FIRST 20 ROWS ONLY;

-- ============================================
-- 12. 성능 관련 뷰
-- ============================================

-- 대기 이벤트 통계
SELECT event, total_waits, time_waited, average_wait
FROM V$SYSTEM_EVENT
WHERE wait_class != 'Idle'
ORDER BY time_waited DESC
FETCH FIRST 20 ROWS ONLY;

-- 세션 대기 이벤트
SELECT sid, event, seconds_in_wait, state
FROM V$SESSION_WAIT
WHERE wait_class != 'Idle'
ORDER BY seconds_in_wait DESC;

-- 시스템 통계
SELECT name, value
FROM V$SYSSTAT
WHERE name IN ('user commits', 'user rollbacks', 'physical reads', 
               'physical writes', 'redo size')
ORDER BY name;

-- ============================================
-- 13. SGA 및 PGA 메모리 정보
-- ============================================

-- SGA 구성 요소
SELECT name, ROUND(value / 1024 / 1024, 2) AS size_mb
FROM V$SGA
ORDER BY value DESC;

-- SGA 상세 정보
SELECT pool, name, ROUND(bytes / 1024 / 1024, 2) AS size_mb
FROM V$SGASTAT
WHERE bytes > 1048576
ORDER BY bytes DESC
FETCH FIRST 20 ROWS ONLY;

-- PGA 메모리 통계
SELECT name, ROUND(value / 1024 / 1024, 2) AS size_mb
FROM V$PGASTAT
WHERE name IN ('total PGA inuse', 'total PGA allocated', 
               'maximum PGA allocated');

-- 세션별 PGA 사용량
SELECT s.sid, s.username, ROUND(p.value / 1024 / 1024, 2) AS pga_mb
FROM V$SESSION s
JOIN V$SESSTAT st ON s.sid = st.sid
JOIN V$STATNAME n ON st.statistic# = n.statistic#
JOIN V$PROCESS p ON s.paddr = p.addr
WHERE n.name = 'session pga memory'
  AND s.username IS NOT NULL
ORDER BY p.value DESC;

-- ============================================
-- 14. 실행 계획 및 SQL 튜닝
-- ============================================

-- SQL 실행 계획 확인
EXPLAIN PLAN FOR
SELECT * FROM employees WHERE department_id = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- SQL 바인드 변수 조회
SELECT sql_id, name, position, datatype_string, value_string
FROM V$SQL_BIND_CAPTURE
WHERE sql_id = 'xxxxxxxxxxxxxx';

-- 커서 공유 통계
SELECT sql_id, version_count, executions, invalidations
FROM V$SQLAREA
WHERE version_count > 5
ORDER BY version_count DESC;

-- ============================================
-- 15. 데이터베이스 링크
-- ============================================

-- 데이터베이스 링크 목록
SELECT db_link, username, host, created
FROM DBA_DB_LINKS
ORDER BY db_link;

-- 데이터베이스 링크 생성
CREATE DATABASE LINK remote_db
CONNECT TO remote_user IDENTIFIED BY password
USING 'remote_tns';

-- 데이터베이스 링크 삭제
DROP DATABASE LINK remote_db;

-- ============================================
-- 16. 리소스 그룹 및 플랜
-- ============================================

-- 리소스 소비자 그룹
SELECT consumer_group, cpu_method, status, comments
FROM DBA_RSRC_CONSUMER_GROUPS;

-- 리소스 플랜
SELECT plan, num_plan_directives, cpu_method, status
FROM DBA_RSRC_PLANS;

-- 현재 활성화된 리소스 플랜
SELECT name, value
FROM V$PARAMETER
WHERE name = 'resource_manager_plan';
