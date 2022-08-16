# 2022_idus_project
2022 아이디어스 채용 과제 레포짓입니다.
<Blockquote>
- 과제 기간: 22.08.11 ~ 22.08.17 (7일)
</Blockquote>


## ✅ 필수 요구사항 구현 여부
<Blockquote>
과제 필수 요구사항 입니다.
</Blockquote>

- [X] APP_ID를 입력받고, 위 API를 호출하여 응답을 받는다.
- [X] 위 API의 응답이 validate하다면, App Detail 페이지로 이동한다.
- [X] 앱의 스크린샷 이미지들을 모두 탐색할 수 있다.
- [X] ‘펼치기/접기’ 버튼으로 앱 설명 영역을 펼치고 접을 수 있다.

## 🔥 추가 구현 내용
<Blockquote>
추가적으로 구현한 부분입니다. 
</Blockquote>

- [X] 검색결과가 없을때, 유저가 인지할 수 있도록 검색결과가 없음을 표시했습니다.
- [X] 스크린샷 이미지를 눌렀을 때, 해당 이미지를 크게볼 수 있는 화면을 구현했습니다.(선택한 index로 바로 띄어지게끔 하였습니다)
- [X] 버전정보와 최근 업데이트 내용을 불러오고, 몇일전에 업데이트를 진행하였는지 표시했습니다.
- [X] 앱의 크기를 MB를 변환하여 
- [X] 네트워크 연결상태를 확인하여, 연결이 안되어있을 때 설정앱으로 이동할수 있게끔 구현했습니다.

## 🛠 Architecture : MVVM
<Blockquote>
과제에서 사용하고 있는 프로젝트 구조 입니다.
</Blockquote>


## 🏋🏻‍♀️ 기술적 도전 
<Blockquote>
과제를 진행하면서 시도한 기술적 도전을 소개합니다.
</Blockquote>

### 🚜 Combine
- 애플에서 직접 제공하는 First Party Framework

### 🛠 MVVM
- MVVM

### ♻️ 재사용 가능한 Custom View
- 여러번 쓰이는 뷰들을 custom view 따로 구현했습니다.

### ✏️ UnitTest 진행
- 테스트코드를 작성하여 뷰모델을 검증하였습니다. 

## 👬 더 나은 UX에 대한 고민
<Blockquote>
과제를 진행하면서 고민한 더 나은 UX를 적용한 부분입니다.
</Blockquote>

### 1. 검색 시 키보드 타입을 넘버패드로 한정
- id 입력시 숫자로 입력을 받아오기 때문에, 숫자만 있는 패드로 변경하였습니다. 
- 이로인해, 숫자 이외의 문자를 입력해 발생하는 `"errorMessage": "Invalid value(s) for key(s): [itunesId]",` 응답오류에 대한 대응을 할 수 있습니다
### 2. 검색 버튼 활성
- 아무 것도 입력을 하지 않았을때 검색버튼을 비활성화시켜놓고, 입력을 시작하면 활성화(+색 변경)시켰습니다.
- 사용자는 입력을 했을때, 검색버튼이 색이 바뀜을 인식하고 검색버튼을 누를수 있다고 판단하였습니다.

## 📱 기능별 화면 GIF
<Blockquote>
시뮬레이터: iPhone13, iOS15.5 로 진행하였습니다
</Blockquote>

<div align="left">

|<img width=240 src="https://user-images.githubusercontent.com/46439995/184966346-d8d5933a-b8b2-4a1d-a65f-ab432affe327.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/184971827-ed35f56a-3b8a-4ed9-8861-acf7ef23289c.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/184972260-987c7224-7660-43df-88e1-8b94e25b02de.gif">|
|:-:|:-:|:-:|
|`네트워크 없을때 설정으로`|`검색버튼 입력시 활성`|`펼치기 접기기능`<br>`(글이 기준보다 적으면, 버튼숨김)`|
|<img width=240 src="https://user-images.githubusercontent.com/46439995/184972566-9642910f-0464-49b0-b491-e0fa7aa04169.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/184972686-dce7494f-f35a-4fc1-8fce-bcb617298b89.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/184973193-c3aadbc1-a1c8-4fcc-baa3-a26d6fb55b7c.gif">|
|`이미지탐색`|`이미지확대(해당인덱스로이동)`|`펼치기 접기기능`<br>`(새로운기능 글이 긴 카카오는 버튼이 보임)`| 




</div>
