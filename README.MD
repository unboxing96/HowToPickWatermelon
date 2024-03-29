# HowToPickWatermelon
![Group 257](https://github.com/unboxing96/WWDC24-SSC/assets/102353544/1beebe5f-58e7-4fea-a84b-4ecd0648f8e3)

### 🎉 앱스토어 출시 완료
출시 준비 중...

</br>

### 📈 앱스토어 관련 데이터
출시 준비 중...

</br>

### 🍉 맛있는 3D 수박 고르기 게임
HowToPickWatermelon은 맛있는 수박 고르는 기준을 알려주는 iOS 앱입니다. </br>
Tutorial에서는 더 달콤하고 맛있는 수박을 선택하기 위한 4가지 기준을 퀴즈 형식으로 안내합니다. 이 과정에서 3D로 생성된 수박을 Pan 제스처와 Tab 제스처를 통해 이리저리 돌려보거나, 울림 소리를 들어볼 수 있습니다. Game에서는 제한 시간 내에 맛있는 수박을 더 많이 골라내는 타임 어택 게임이 진행됩니다. 기록된 점수로 친구와 함께 게임을 즐겨보세요.

</br>

### 📆 개발 기간
2023.02.20 ~ 2023.02.26

</br>

### 👥 팀원
개인 프로젝트

</br>
</br>

## 1. Development Environment ⚙️
`iOS 17.0` `Playground 4.4.1`

</br>

## 2. Tech Stack ⚒️
- 언어: `Swift`
- 프레임워크: `SwiftUI` `UIKit`
- 동시성: `GCD`
- 3D 객체 생성: `SceneKit`

</br>

## 3. 화면 구성
|Tutorial|Game|
|---|---|
|![tutorial_2x](https://github.com/unboxing96/WWDC24-SSC/assets/102353544/7001644a-1b9f-4aab-9b04-ad95ebaae2fe)|![game_2x](https://github.com/unboxing96/WWDC24-SSC/assets/102353544/b0776336-cad1-4fe4-b4f8-7e471036e380)|

</br>

## 4. 기능 요약
- `Tutorial`
  - 저장된 데이터에서 랜덤하게 정답 1개와 오답 3개의 4지선다 제시
  - 정답 여부 확인 및 피드백 제공
  - 선택한 객체와 Tab, Pan 제스처로 상호 작용 가능
  - 'Sound' 카테고리에서 Tab 제스처 시에 Haptic 피드백 제공
 
- `Game`
  - 4가지 카테고리에서 랜덤하게 2지선다 문제 제시
  - GCD를 이용하여 Timer 관리
  - 정답 개수를 기록 후 게임이 종료되면 유저에게 제공하고, 최고 기록인 경우 UserDefaults에 저장

</br>

## 5. 업데이트 내역
출시 준비 중...

</br>

## 6. Folder Structure

```
├── ContentView.swift
├── Data
│   └── WatermelonData.swift
├── Extension
│   └── Color+Extension.swift
├── Model
│   ├── Answer.swift
│   ├── Page.swift
│   ├── Taste.swift
│   ├── Trial.swift
│   ├── TutorialPageContent.swift
│   └── Watermelon.swift
├── MyApp.swift
├── Package.swift
└── View
    ├── Background
    │   └── WatermelonBackgroundView.swift
    ├── Button
    │   ├── GoodBadButtonView.swift
    │   ├── HomeButtonView.swift
    │   ├── MoveToNextButtonView.swift
    │   ├── ScoreButtonView.swift
    │   └── TutorialButtonView.swift
    ├── Component
    │   ├── ArrowView.swift
    │   ├── FeedbackView.swift
    │   ├── HighScoreTitleView.swift
    │   ├── HomeTitleView.swift
    │   ├── OverlayView.swift
    │   ├── ScoreTitleView.swift
    │   ├── TimerView.swift
    │   ├── TopicView.swift
    │   └── WatermelonSceneView.swift
    ├── GameView.swift
    ├── HomeView.swift
    ├── ScoreView.swift
    ├── SplashView.swift
    └── TutorialView.swift
```

</br>
</br>

