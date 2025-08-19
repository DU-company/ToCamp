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
- **Database**: Hive(LocalDB)
- **CI/CD**: (추가 예정)

---

## 📂 프로젝트 구조 (예시)

- lib/
- ┣ common/      # 공통 유틸, 상수, 테마
- ┣ features/    # 데이터 계층 (model, service, repository, view, viewModel)
- ┣ main.dart

---

## 🗓 리팩토링 7일 플랜
- **Day 1**: 프로젝트 세팅, 기본 의존성 설치, README 뼈대 작성
- **Day 2**: 프로젝트 구조 정리 (core, data, domain, presentation)
- **Day 3**: Auth 모듈 리팩토링 (API + 상태관리)
- **Day 4**: Chat 모듈 리팩토링 (모델, 서비스, provider 연결)
- **Day 5**: UI 개선 (공통 위젯, 테마, 에러 처리)
- **Day 6**: 로컬 저장소 및 캐싱 적용
- **Day 7**: 코드 리팩토링 마무리, 테스트, 문서 정리

---

## 🔧 실행 방법
```bash
# 프로젝트 실행
flutter pub get
flutter run
