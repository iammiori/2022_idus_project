# 2022_idus_project
2022 아이디어스 채용 과제 레포짓입니다.
<Blockquote>
- 과제 기간: 22.08.11 ~ 22.08.17 (7일)
</Blockquote>

## ⚙️ 개발환경
- Xcode: 13.4.1
- Swift: 5.6.1
- iOS: 13.0 ~ 

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

- [X] 네트워크 연결상태를 확인하여, 연결이 안되어있을 때 설정앱으로 이동할수 있게끔 구현했습니다.
- [X] 검색결과가 없을때, 유저가 인지할 수 있도록 검색결과가 없음을 표시했습니다.
- [X] `ByteCountFormatter`를 활용하여, Byte로 받아온 앱의 크기를 MB를 변환하여 표시했습니다.
- [X] 앱의 주요 장르를 받아와(영어), `Localizations` 설정을 통해 한글로 변환하여 표시했습니다
- [X] 버전정보와 최근 업데이트 내용을 불러오고, 몇일전에 업데이트를 진행하였는지 표시했습니다.
- [X] 스크린샷 이미지 페이징을 구현하였습니다.
- [X] `NSCache`를 활용해 이미지 캐싱을 구현하여, 캐시에 저장해서 빠르게 이미지를 처리할 수 있게 했습니다.
- [X] 스크린샷 이미지를 눌렀을 때, 해당 이미지를 크게볼 수 있는 화면을 구현했습니다.(선택한 index로 바로 띄어지게끔 하였습니다)

## 🛠 Architecture : MVVM
<Blockquote>
과제에서 사용하고 있는 프로젝트 구조 입니다.
</Blockquote>

## 🏋🏻‍♀️ 기술적 도전 
<Blockquote>
과제를 진행하면서 시도한 기술적 도전을 소개합니다.
</Blockquote>

### 🚜 Combine
- 애플에서 직접 제공하는 First Party Framework을 사용하여 비동기프로그래밍에 도전하였습니다.
- 네트워크 로직에 사용하여, 데이터를 받아오는 시점에서부터 뷰에 그려지기까지 하나의 스트림으로 데이터를 바인딩해주었습니다.

### 🛠 MVVM
- MVVM 패턴을 적용하여, 뷰는 화면을 그리는 역할/ 뷰모델은 데이터 가공과 로직을 실행하는 역할로 나누어 구현했습니다.
- 뷰에 뿌릴 값들을 뷰모델에서 가공하고, 이를 유닛 테스트를 통해 검증할 수 있었습니다. 

### ♻️ 재사용 가능한 Custom View
- 여러번 쓰이는 뷰들을 custom View 따로 구현하여 유지보수가 가능하게 코드를 작성하였습니다.

### ✏️ UnitTest 진행
- 테스트코드를 작성하여 뷰모델을 검증하였습니다. 

### ☄️ Extension을 활용하여, 필요한 기능을 쉽게 사용할 수 있게 구현했습니다.
- 색상, 날짜, 팝업창 띄위기등 자주 사용할 기능들을 extension으로 구현하여 유지보수에 용이한 코드를 작성하였습니다.

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
시뮬레이터: iPhone13ProMax, iOS15.5 로 진행하였습니다.<br>
네트워크 연결 확인을 위해 실제 디바이스(iphone 12pro, iOS15.6)을 사용했습니다.
</Blockquote>

<div align="left">

|<img width=240 src="https://user-images.githubusercontent.com/46439995/185067434-c71f35dd-3db5-41c9-ad73-39c3301043b1.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/185071000-b96ddd72-52df-45b8-858f-3a065a438708.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/185071150-71d08bb5-d9d5-430e-8fe7-44a39a07ff88.gif">|
|:-:|:-:|:-:|
|`네트워크 없을때 설정으로`|`검색버튼 입력시 활성`|`펼치기 접기기능`<br>`(글이 기준보다 적으면, 버튼숨김)`|
|<img width=240 src="https://user-images.githubusercontent.com/46439995/185071684-03fa47f5-17bd-4672-a5be-f825c17c5081.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/185071892-9c3ff182-39d9-4d46-bdbc-ab28a8218214.gif">|<img width=240 src="https://user-images.githubusercontent.com/46439995/185072009-8b842d21-069c-4410-8f67-6bb77481f96c.gif">|
|`이미지탐색`<br>`(페이징가능)`|`이미지확대`<br>`(해당인덱스로이동)`|`펼치기 접기기능`<br>`(새로운기능 글이 긴 앱은 버튼이 보임)`| 


## 🗓 프로젝트 일정 관리
<Blockquote>
프로젝트를 진행할 때, 지라를 사용하여 이슈와 일정을 관리하였습니다.<br>그리고 깃허브와 연동하여, PR과 커밋을 관리했습니다. (ex: 이슈넘버 feat: ...)
</Blockquote>
<img width="600" alt="스크린샷 2022-08-14 오후 4 33 59" src="https://user-images.githubusercontent.com/46439995/185040034-8fa12e10-5d61-491e-9985-d23f3fc47db0.png">

