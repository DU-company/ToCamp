# ToCamp - Refactor

> 기존 투캠 프로젝트를 7일간 리팩토링하며 구조 개선과 코드 품질 향상을 목표로 하는 프로젝트

---

## 주요 목표
- 코드 아키텍처 개선 (MVVM + Riverpod)
- 유지보수성과 확장성을 고려한 프로젝트 구조 적용
- HTTP 기반 REST API와의 안정적인 통신
- UI/UX 개선 및 성능 최적화

---

## 기술 스택
- **Framework**: Flutter (3.23)
- **State Management**: Riverpod
- **Networking**: HTTP
- **Database**: Hive(LocalDB), Supabase
- **CI/CD**: (추가 예정)

---

## 프로젝트 구조

- lib/
- ┣ common/      # 공통 유틸, 상수, 테마
- ┣ features/    # 데이터 계층 (model, service, repository, view, viewModel)
- ┣ main.dart

---

## 리팩토링 7일 플랜
- **Day 1**: 아키텍처 설정, 커스텀 테마, API호출을 위한 파라미터 및 모델링
- **Day 2**: Camping의 Repository, Service, Provider 구현 및 UI에 띄우기.
- **Day 3**: geolocator를 활용한 위치기반 페이지네이션
- **Day 4**: 키워드 기반 API요청 및 검색 엔진 구현
- **Day 5**: 좋아요 기능 구현 및 환경설정 화면
- **Day 6**: 다이나믹 링크 서비스 종료에 의한 마이그레이션
- **Day 7**: UI 총 정리(반응형 UI포함)

---

##  실행 방법
```bash
# 프로젝트 실행
flutter pub get
flutter run