# ToCamp - Refactor

> 기존 투캠의 아키텍처 변경

---

## 주요 목표
- 코드 아키텍처 개선 (MVVM + Riverpod)
- 유지보수성과 확장성을 고려한 프로젝트 구조 적용
- HTTP 기반 REST API와의 안정적인 통신
- UI/UX 개선 및 성능 최적화


---

## 기술 스택
- **Framework**: Flutter (3.23)
- **State Management**: Riverpod (3.x.x)
- **Networking**: HTTP, REST API
- **Database**: Sqflite(LocalDB), Supabase
- **CI/CD**: (추가 예정)

---

## MVVM 프로젝트 구조

- lib/
- ┣ core/            # 공통 유틸, 상수, 테마, 서비스
- ┣ data/            # 데이터 계층 (model, entity, dataSource, repository)
- ┣ presentation/    # UI 계층 (view(screen, widgets), viewModel, utils)
- ┣ main.dart

---


## 네이밍 컨벤션
- local에는 추가 네이밍(local)부여. remote는 별도의 추가 네이밍 없음.
- 파일 및 클래스 이름은 주체가 앞에 위치
- Screen은 화면 그 자체. View는 Screen을 가득 채우는 특정 UI
- ex) 삭제가 주체라면 DeleteCampingViewModel / 캠핑장이 주체라면 CampingListViewModel
- 버튼 액션 함수는 onTap~~ 로 시작

---

##  실행 방법
```bash
# 프로젝트 실행
flutter pub get
flutter run