# Oracle 성능 관련 뷰 목록

## 개요
Oracle의 성능 관련 뷰는 데이터베이스 성능 모니터링 및 튜닝에 필요한 정보를 제공합니다.
주로 V$ 접두사를 사용하는 동적 성능 뷰입니다.

## 세션 및 프로세스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$SESSION | 현재 세션 정보 |
| V$SESSION_WAIT | 세션 대기 정보 |
| V$SESSION_WAIT_HISTORY | 세션 대기 이력 |
| V$SESSION_EVENT | 세션 이벤트 통계 |
| V$SESSION_LONGOPS | 장기 실행 작업 |
| V$SESSION_CONNECT_INFO | 세션 연결 정보 |
| V$PROCESS | 프로세스 정보 |
| V$BGPROCESS | 백그라운드 프로세스 |
| V$SESS_IO | 세션 I/O 통계 |

## SQL 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$SQL | SQL 문장 정보 |
| V$SQLAREA | SQL 영역 통계 |
| V$SQLTEXT | SQL 텍스트 |
| V$SQLTEXT_WITH_NEWLINES | 줄바꿈 포함 SQL 텍스트 |
| V$SQL_PLAN | SQL 실행 계획 |
| V$SQL_PLAN_STATISTICS | SQL 계획 통계 |
| V$SQL_PLAN_STATISTICS_ALL | SQL 계획 상세 통계 |
| V$SQL_BIND_CAPTURE | 바인드 변수 캡처 |
| V$SQL_BIND_METADATA | 바인드 변수 메타데이터 |
| V$SQL_SHARED_CURSOR | 공유 커서 정보 |
| V$SQL_CURSOR | 커서 정보 |

## 메모리 관련 뷰

### SGA (System Global Area)

| 뷰 이름 | 설명 |
|---------|------|
| V$SGA | SGA 구성요소 크기 |
| V$SGAINFO | SGA 상세 정보 |
| V$SGASTAT | SGA 통계 |
| V$SGA_DYNAMIC_COMPONENTS | 동적 SGA 구성요소 |
| V$SGA_DYNAMIC_FREE_MEMORY | SGA 여유 메모리 |
| V$SHARED_POOL_RESERVED | 공유 풀 예약 영역 |

### PGA (Program Global Area)

| 뷰 이름 | 설명 |
|---------|------|
| V$PGASTAT | PGA 통계 |
| V$PGA_TARGET_ADVICE | PGA 타겟 권고 |
| V$PROCESS_MEMORY | 프로세스 메모리 사용량 |
| V$PROCESS_MEMORY_DETAIL | 프로세스 메모리 상세 |

### 버퍼 캐시

| 뷰 이름 | 설명 |
|---------|------|
| V$BUFFER_POOL | 버퍼 풀 정보 |
| V$BUFFER_POOL_STATISTICS | 버퍼 풀 통계 |
| V$DB_CACHE_ADVICE | DB 캐시 권고 |
| V$BH | 버퍼 헤더 정보 |

## 대기 이벤트 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$EVENT_NAME | 대기 이벤트 이름 |
| V$SYSTEM_EVENT | 시스템 대기 이벤트 |
| V$SESSION_EVENT | 세션 대기 이벤트 |
| V$WAITSTAT | 대기 통계 |
| V$SYSTEM_WAIT_CLASS | 시스템 대기 클래스 |
| V$SESSION_WAIT_CLASS | 세션 대기 클래스 |
| V$ACTIVE_SESSION_HISTORY | 활성 세션 이력 (ASH) |
| V$EVENT_HISTOGRAM | 이벤트 히스토그램 |

## I/O 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$FILESTAT | 파일 통계 |
| V$TEMPSTAT | 임시파일 통계 |
| V$DATAFILE | 데이터파일 정보 |
| V$TEMPFILE | 임시파일 정보 |
| V$IOSTAT_FILE | 파일 I/O 통계 |
| V$IOSTAT_FUNCTION | 기능별 I/O 통계 |
| V$IOSTAT_NETWORK | 네트워크 I/O 통계 |
| V$SEGMENT_STATISTICS | 세그먼트 통계 |

## 통계 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$SYSSTAT | 시스템 통계 |
| V$SESSTAT | 세션 통계 |
| V$STATNAME | 통계 이름 |
| V$MYSTAT | 현재 세션 통계 |
| V$SYS_TIME_MODEL | 시스템 시간 모델 |
| V$SESS_TIME_MODEL | 세션 시간 모델 |

## 락(Lock) 및 Latch 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$LOCK | 락 정보 |
| V$LOCKED_OBJECT | 잠긴 객체 |
| V$ENQUEUE_STAT | 큐 통계 |
| V$LATCH | Latch 정보 |
| V$LATCH_CHILDREN | Latch Children |
| V$LATCHHOLDER | Latch 보유자 |
| V$LATCHNAME | Latch 이름 |

## 트랜잭션 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$TRANSACTION | 트랜잭션 정보 |
| V$TRANSACTION_ENQUEUE | 트랜잭션 큐 |
| V$ROLLSTAT | 롤백 세그먼트 통계 |
| V$UNDOSTAT | UNDO 통계 |
| V$FAST_START_TRANSACTIONS | Fast Start 트랜잭션 |

## 로그 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$LOG | 리두 로그 그룹 |
| V$LOGFILE | 리두 로그 파일 |
| V$LOG_HISTORY | 로그 이력 |
| V$LOGHIST | 로그 히스토리 요약 |
| V$ARCHIVED_LOG | 아카이브 로그 |
| V$ARCHIVE_DEST | 아카이브 목적지 |
| V$ARCHIVE_PROCESSES | 아카이브 프로세스 |

## 리소스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$RESOURCE_LIMIT | 리소스 제한 |
| V$RSRC_CONS_GROUP_HISTORY | 리소스 소비자 그룹 이력 |
| V$RSRC_PLAN | 리소스 계획 |
| V$RSRC_PLAN_HISTORY | 리소스 계획 이력 |
| V$RSRC_SESSION_INFO | 리소스 세션 정보 |

## AWR (Automatic Workload Repository) 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_HIST_SNAPSHOT | AWR 스냅샷 |
| DBA_HIST_SYSSTAT | AWR 시스템 통계 |
| DBA_HIST_SQLSTAT | AWR SQL 통계 |
| DBA_HIST_ACTIVE_SESS_HISTORY | AWR ASH 데이터 |
| DBA_HIST_SQLTEXT | AWR SQL 텍스트 |
| DBA_HIST_SYSTEM_EVENT | AWR 시스템 이벤트 |
| DBA_HIST_OSSTAT | AWR OS 통계 |
| DBA_HIST_SGA | AWR SGA 정보 |
| DBA_HIST_PGASTAT | AWR PGA 통계 |

## Advisor 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_ADVISOR_TASKS | Advisor 작업 |
| DBA_ADVISOR_LOG | Advisor 로그 |
| DBA_ADVISOR_FINDINGS | Advisor 결과 |
| DBA_ADVISOR_RECOMMENDATIONS | Advisor 권고사항 |
| DBA_ADVISOR_ACTIONS | Advisor 액션 |
| DBA_ADVISOR_RATIONALE | Advisor 근거 |

## 옵티마이저 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$SQL_OPTIMIZER_ENV | 옵티마이저 환경 |
| V$SQL_FEATURE | SQL 기능 사용 |
| DBA_SQLSET | SQL 튜닝 셋 |
| DBA_SQLSET_STATEMENTS | SQL 튜닝 셋 문장 |

## 테이블스페이스 및 파일 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$TABLESPACE | 테이블스페이스 정보 |
| V$TABLESPACE_STAT | 테이블스페이스 통계 |
| DBA_TABLESPACE_USAGE_METRICS | 테이블스페이스 사용량 |
| DBA_THRESHOLDS | 테이블스페이스 임계값 |

## 데이터베이스 상태 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$DATABASE | 데이터베이스 정보 |
| V$INSTANCE | 인스턴스 정보 |
| V$VERSION | 데이터베이스 버전 |
| V$OPTION | 설치된 옵션 |
| V$PARAMETER | 초기화 파라미터 |
| V$SYSTEM_PARAMETER | 시스템 파라미터 |
| V$SPPARAMETER | 서버 파라미터 파일 |
| V$LICENSE | 라이센스 정보 |

## 유용한 성능 튜닝 쿼리

### 1. 현재 실행 중인 세션 조회
```sql
SELECT 
    s.sid,
    s.serial#,
    s.username,
    s.status,
    s.program,
    s.machine,
    s.sql_id,
    s.event,
    s.wait_class,
    s.seconds_in_wait
FROM v$session s
WHERE s.status = 'ACTIVE'
AND s.username IS NOT NULL
ORDER BY s.seconds_in_wait DESC;
```

### 2. Top SQL (CPU 사용량 기준)
```sql
SELECT 
    sql_id,
    executions,
    ROUND(elapsed_time/1000000, 2) AS elapsed_sec,
    ROUND(cpu_time/1000000, 2) AS cpu_sec,
    buffer_gets,
    disk_reads,
    SUBSTR(sql_text, 1, 100) AS sql_text
FROM v$sqlarea
ORDER BY cpu_time DESC
FETCH FIRST 20 ROWS ONLY;
```

### 3. 대기 이벤트 분석
```sql
SELECT 
    event,
    total_waits,
    total_timeouts,
    ROUND(time_waited/100, 2) AS time_waited_sec,
    ROUND(average_wait/100, 2) AS avg_wait_sec
FROM v$system_event
WHERE wait_class != 'Idle'
ORDER BY time_waited DESC
FETCH FIRST 20 ROWS ONLY;
```

### 4. 버퍼 캐시 히트율
```sql
SELECT 
    ROUND((1 - (phy.value / (db.value + cons.value))) * 100, 2) AS buffer_cache_hit_ratio
FROM 
    v$sysstat phy,
    v$sysstat db,
    v$sysstat cons
WHERE 
    phy.name = 'physical reads'
    AND db.name = 'db block gets'
    AND cons.name = 'consistent gets';
```

### 5. 테이블 풀 스캔 발생 Top SQL
```sql
SELECT 
    s.sql_id,
    s.executions,
    t.operation,
    t.options,
    t.object_name,
    s.buffer_gets,
    SUBSTR(s.sql_text, 1, 100) AS sql_text
FROM v$sql s,
     v$sql_plan t
WHERE s.sql_id = t.sql_id
AND t.operation = 'TABLE ACCESS'
AND t.options = 'FULL'
AND s.executions > 0
ORDER BY s.buffer_gets DESC
FETCH FIRST 20 ROWS ONLY;
```

### 6. 세그먼트별 I/O 통계
```sql
SELECT 
    owner,
    object_name,
    object_type,
    statistic_name,
    value
FROM v$segment_statistics
WHERE statistic_name IN ('logical reads', 'physical reads', 'physical writes')
ORDER BY value DESC
FETCH FIRST 30 ROWS ONLY;
```

### 7. 블로킹 세션 조회
```sql
SELECT 
    blocking.sid AS blocking_sid,
    blocking.serial# AS blocking_serial,
    blocking.username AS blocking_user,
    blocked.sid AS blocked_sid,
    blocked.serial# AS blocked_serial,
    blocked.username AS blocked_user,
    blocked.event AS blocked_event,
    blocked.seconds_in_wait
FROM v$session blocking
JOIN v$session blocked ON blocking.sid = blocked.blocking_session
WHERE blocking.blocking_session IS NULL
ORDER BY blocked.seconds_in_wait DESC;
```

### 8. PGA 메모리 사용량
```sql
SELECT 
    name,
    ROUND(value/1024/1024, 2) AS value_mb
FROM v$pgastat
WHERE name IN (
    'total PGA allocated',
    'total PGA inuse',
    'total PGA freeable memory'
);
```

### 9. SGA 구성요소
```sql
SELECT 
    name,
    ROUND(bytes/1024/1024, 2) AS size_mb
FROM v$sgainfo
ORDER BY bytes DESC;
```

### 10. 테이블스페이스 I/O 통계
```sql
SELECT 
    ts.name AS tablespace_name,
    f.phyrds AS physical_reads,
    f.phywrts AS physical_writes,
    f.readtim AS read_time,
    f.writetim AS write_time
FROM v$filestat f
JOIN v$datafile df ON f.file# = df.file#
JOIN v$tablespace ts ON df.ts# = ts.ts#
ORDER BY f.phyrds + f.phywrts DESC;
```

### 11. SQL 실행 계획 조회
```sql
SELECT 
    plan_table_output
FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('&sql_id', NULL, 'ALLSTATS LAST'));
```

### 12. ASH 최근 대기 이벤트
```sql
SELECT 
    sample_time,
    session_id,
    sql_id,
    event,
    wait_class,
    p1text,
    p1
FROM v$active_session_history
WHERE sample_time >= SYSDATE - INTERVAL '5' MINUTE
ORDER BY sample_time DESC;
```

## 성능 튜닝 팁

### 1. 모니터링 포인트
- CPU 사용률
- 메모리 사용률 (SGA, PGA)
- 디스크 I/O
- 대기 이벤트
- SQL 실행 통계

### 2. 주요 성능 지표
- 버퍼 캐시 히트율 (> 90%)
- 라이브러리 캐시 히트율 (> 95%)
- Soft Parse 비율 (> 95%)
- Latch Free 대기 시간
- DB File Sequential/Scattered Read

### 3. 튜닝 우선순위
1. 느린 SQL 식별 및 튜닝
2. 인덱스 최적화
3. 통계 정보 업데이트
4. 메모리 파라미터 조정
5. I/O 분산

## 참고사항
- V$ 뷰는 인스턴스가 시작될 때 초기화됩니다
- GV$ 뷰는 RAC 환경에서 모든 인스턴스의 정보를 제공합니다
- AWR 데이터는 기본적으로 8일간 보관됩니다
- ASH 데이터는 메모리에 1시간, AWR에는 7일간 보관됩니다
