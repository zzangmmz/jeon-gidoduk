# 🔌 [전기도둑 팀] 팀원 소개 앱

프로젝트 소개
------------
- 우리 팀 전기도둑의 멤버들을 소개하는 앱입니다.
- 멤버 목록을 통해 팀 구성원을 확인할 수 있습니다.
- 목록에서 궁금한 멤버를 선택하면 해당 팀원의 인삿말과 MBTI를 확인할 수 있습니다.
- 새로운 멤버가 들어왔다면 목록에서 멤버 추가('+') 버튼을 눌러 멤버를 추가할 수 있습니다.

개발 기간
------------
2024.10.21~2024.10.24

목차
------------

[1.개발 환경](#개발_환경)

[2. 협업 툴](#협업_툴)

[3. 커밋 컨벤션](#커밋_컨벤션)

[4. 실행화면](#실행화면)

[5. 트러블 슈팅](#트러블_슈팅)



개발 환경
------------
`xCode` `Swift6` `UIKit` `CoreData` `MVC`



협업 툴
------------
![github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white) ![figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)


커밋 컨벤션
-------------
- feat : Screen, Component, 기능 추가 및 수정 (큰 변경사항 위주) / 이미지 추가
- update : 간단한 변경 사항
- refactor : 코드 정리 및 단순화 / 간단한 스타일 수정 / 폴더 및 파일 이름이나 위치 변경 / 주석 및 콘솔 관리 / fontello 변경
- fix : 버그 수정
- delete : 폴더, 파일 삭제
- docs : 문서 추가, 수정, 삭제 (ex. README.md)
- test : 테스트 코드 작성, 수정, 삭제
- chore : 패키지/라이브러리 추가, 버전 변경, 삭제



실행화면
-------------


| 메인 화면| 멤버 추가|
| --- | --- | 
| <img width="200" alt="메인" src="https://github.com/user-attachments/assets/c26bc26b-06fd-4f82-a181-3adac4a548ef">|<img width="200" alt="멤버_추가" src="https://github.com/user-attachments/assets/4b1c4fd6-4d4f-4d62-bd61-662124fc9ac3"> |


| 멤버 상세| 멤버 삭제|
| --- | --- | 
|<img width="200" alt="멤버_상세" src="https://github.com/user-attachments/assets/a4bd3bb2-e7e6-4305-8c01-0b7698699438"> | <img width="200" alt="멤버_삭제" src="https://github.com/user-attachments/assets/3aecc38e-d4fa-466f-a9be-d88f3e59c422">|



트러블 슈팅
-------------

<details><summary> 1. 스택뷰가 화면에 표시되지 않는 문제
</summary>

**구현하고자 했던 부분**

- 컴포넌트 배치를 위해 관련 컴포넌트를 하나의 스택뷰로 묶고, 여러 StackView를 totalStackView에 올려 화면에 totalStackView만 add.

 **발생한 이슈**
- totalStackView는 화면에 표시되지만 내부의 스택뷰들이 표시되지 않음.

**시도한 방법**
- 내부 스택뷰의 constraints 조정.
- 버튼, 텍스트 필드에 width, height 크기 지정.

**원인**
- 스택뷰를 lazy로 선언해서 totalStackView가 load된 후에 내부 스택뷰가 생성되는 문제.

**해결 방법**
- lazy 선언 삭제 후 스택뷰 생성 메서드를 따로 생성

**실행 결과**
- totalStackView에 내부 스택뷰 정상 생성되어 화면에 표시됨.

<img width="268" alt="트러블_슈팅_1" src="https://github.com/user-attachments/assets/55970a2b-f935-4a9e-aa4c-2b100d346afb">

</details>


<details><summary> 2. 서브 뷰컨트롤러에서 메인 뷰컨트롤러로 화면 전환이 안되는 문제
</summary>

**구현하고자 했던 부분**
- 서브 뷰컨트롤러에서 저장 버튼을 누르면 메인 뷰컨트롤러로 화면 전환.

**발생한 이슈**
- 저장 버튼은 눌러도 메인 뷰컨트롤러로 돌아가지 않음.

**시도한 방법**
- 저장 버튼이 눌리는 게 맞는지 입력받은 정보를 출력하여 확인 → 저장 버튼 정상 작동.

**원인**
- 메인 뷰컨트롤러, 서브 뷰컨트롤러 두 곳에서 같은 메서드 정의.

**해결 방법**
- 메인 뷰컨트롤러의 메서드 삭제 후 서브 뷰컨트롤러 메서드 수정.

**실행 결과**
- 서브 뷰컨트롤러가 정상적으로 닫힘.

<img width="268" alt="트러블_슈팅_1" src="https://github.com/user-attachments/assets/807e3ab2-8397-4749-81b6-319623490ba7">

</details>


<details><summary>3. 저장 버튼이 활성화되지 않는 문제
</summary>

**구현하고자 했던 부분**
- 모든 선택 사항이 정상적으로 입력이 되어야 저장 버튼 활성화

**발생한 이슈**
- 모든 선택을 완료 후에 프로필 선택취소 or 텍스트 필드 초기화해도 저장 버튼 활성화

**시도한 방법**
- 완료 조건 수정

**원인**
- 저장 버튼 활성화 조건을 텍스트 필드 함수에만 설정한 것이 원인.
- 함수를 정의만 해놓고 .addTarget()으로 액션을 추가해주지 않음.

** 해결 방법**
- 버튼을 눌렀을 때, 텍스트 필드를 수정했을 때 모두 저장 버튼 활성화 함수가 호출되도록 addTarget().

**실행 결과**

| 정상 선택 | mbti 선택 안함 |
| --- | --- |
| <img width="268" alt="모두_선택" src="https://github.com/user-attachments/assets/7496f371-ef64-46dc-b8c2-1b2d69bd729a"> | <img width="268" alt="mbti" src="https://github.com/user-attachments/assets/21f6ddca-91a4-4595-be8c-236a9b850284"> |

| 텍스트 필드 입력 안함 | 프로필 선택 안함 |
| --- | --- |
| <img width="268" alt="mbti" src="https://github.com/user-attachments/assets/04753677-9409-43b2-9360-6dc182465aa1"> |  <img width="268" alt="mbti" src="https://github.com/user-attachments/assets/ccb4c194-0eae-4129-b560-6c38377a5f0c">|

</details>
