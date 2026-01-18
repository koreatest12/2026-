# 2026-
2026년도 정보보안기사 공부

## 프로젝트 소개
정보보안기사 자격증 시험 준비를 위한 학습 자료 저장소입니다.

## 학습 자료

### Oracle Database 보안
Oracle Database 관련 테이블, 뷰, 보안 설정 등 데이터베이스 보안 전반에 대한 자료입니다.

📁 [oracle_database](/oracle_database) 디렉토리에서 확인하세요.

#### 주요 내용
- **시스템 테이블**: Oracle 핵심 시스템 테이블 목록
- **데이터 딕셔너리**: DBA_*, ALL_*, USER_* 뷰 상세 설명
- **보안 관리**: 사용자, 권한, 역할, 감사 관련 테이블 및 뷰
- **성능 모니터링**: V$ 동적 성능 뷰 목록
- **실습 자료**: SQL 스크립트 및 보안 실습 가이드
- **시험 대비**: 정보보안기사 핵심 요약 가이드

#### 문서 목록
1. [README.md](oracle_database/README.md) - 개요
2. [system_tables.md](oracle_database/system_tables.md) - 시스템 테이블
3. [data_dictionary_views.md](oracle_database/data_dictionary_views.md) - 데이터 딕셔너리 뷰
4. [security_tables.md](oracle_database/security_tables.md) - 보안 관련 테이블/뷰
5. [dba_views.md](oracle_database/dba_views.md) - DBA 뷰 목록
6. [user_views.md](oracle_database/user_views.md) - USER 뷰 목록
7. [performance_views.md](oracle_database/performance_views.md) - 성능 뷰 목록
8. [audit_tables.md](oracle_database/audit_tables.md) - 감사 관련 테이블/뷰
9. [table_catalog.md](oracle_database/table_catalog.md) - 전체 테이블 카탈로그
10. [sample_schemas.sql](oracle_database/sample_schemas.sql) - 샘플 스키마 SQL
11. [security_practice.md](oracle_database/security_practice.md) - 보안 실습 가이드
12. [security_queries.sql](oracle_database/security_queries.sql) - 보안 점검 쿼리
13. [exam_guide.md](oracle_database/exam_guide.md) - 시험 대비 요약

## 학습 방법

### 1. 이론 학습
- 각 문서를 순서대로 읽으며 개념 이해
- 중요 테이블 및 뷰 암기

### 2. 실습
- Oracle Database Express Edition(XE) 설치
- sample_schemas.sql 실행하여 실습 환경 구성
- security_practice.md의 예제 따라하기

### 3. 복습
- exam_guide.md로 핵심 개념 정리
- security_queries.sql의 쿼리 실습

## 기여 방법
이슈 및 풀 리퀘스트 환영합니다.

## 라이선스
MIT License
