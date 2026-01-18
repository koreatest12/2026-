# Oracle Massive Table & Data Generator (OMTDG)

![Version](https://img.shields.io/badge/version-1.0.0-blue) ![Oracle](https://img.shields.io/badge/Oracle-19c%2B-red) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen)

## 📖 개요 (Overview)

**Oracle Massive Table & Data Generator**는 Oracle 데이터베이스 환경에서 **초대량(Ultra Massive)**의 테이블 스키마와 더미 데이터를 고속으로 생성하기 위해 설계된 자동화 툴입니다.

수십억 건(Billions) 이상의 레코드 생성, 수천 개의 테이블 동시 생성, 그리고 쿼리 성능 테스트를 위한 복잡한 데이터 분포 시뮬레이션을 지원합니다. 대규모 성능 테스트(Stress Test), 실행 계획(Execution Plan) 분석, 스토리지 용량 산정 시뮬레이션에 최적화되어 있습니다.

## 🚀 주요 기능 (Key Features)

* **초대량 데이터 고속 생성 (Ultra-High Speed Bulk Insert):**
    * `APPEND` 힌트 및 `NOLOGGING` 모드를 활용한 Direct Path Load 지원.
    * PL/SQL `FORALL` 문을 이용한 Bulk Collect/Insert 처리.
    * 병렬 프로세싱(Parallel Execution)을 통한 테라바이트(TB) 급 데이터 생성.
* **대규모 스키마 자동화 (Massive Schema Automation):**
    * 설정 파일 하나로 1,000개 이상의 테이블 및 인덱스, 제약조건 자동 생성.
    * Range, Hash, List 파티셔닝(Partitioning) 테이블 자동 구성.
* **정교한 더미 데이터 (Realistic Mock Data):**
    * 실제 분포와 유사한 난수 생성 (정규 분포, 편향 분포 지원).
    * 한국어 이름, 주소, 전화번호 등 로컬라이즈된 데이터셋 내장.
* **쿼리 부하 테스트 (Query Stress Testing):**
    * 자동 생성된 테이블을 대상으로 한 복잡한 Join/Aggregation 쿼리 셋 제공.
    * 대량 동시 접속(Concurrency) 시뮬레이션 스크립트 포함.

## 🛠️ 기술 스택 (Tech Stack)

* **Database:** Oracle Database 19c, 21c, 23c (Enterprise Edition 권장)
* **Languages:** PL/SQL, Python (선택 사항: 데이터 생성기용), Shell Script
* **Tools:** SQL*Plus, SQLCl

## 📋 전제 조건 (Prerequisites)

이 프로젝트를 실행하기 위해 다음 권한이 필요합니다:
* `CREATE TABLE`, `CREATE PROCEDURE`, `CREATE SEQUENCE` 권한
* `UNLIMITED TABLESPACE` 권한
* (옵션) 대량 작업을 위한 `ALTER SESSION` 권한 (`ENABLE PARALLEL DML`)

## 💾 설치 및 설정 (Installation)

1. **저장소 클론**
   ```bash
   git clone [https://github.com/your-username/oracle-massive-generator.git](https://github.com/your-username/oracle-massive-generator.git)
   cd oracle-massive-generator
