# Flutter 測試範例

[![English Version](https://img.shields.io/badge/README-English-blue)](README.md)

一個展示和實現各種測試方法的 Flutter 項目，包括 **單元測試**、**元件測試** 和 **整合測試**。

## 目錄

- [Flutter 測試範例](#flutter-測試範例)
  - [目錄](#目錄)
  - [介紹](#介紹)
  - [功能](#功能)
  - [開始使用](#開始使用)
    - [安裝](#安裝)
  - [專案結構](#專案結構)
  - [運行應用](#運行應用)
  - [測試](#測試)
    - [單元測試](#單元測試)
    - [元件測試](#元件測試)
    - [整合測試](#整合測試)
  - [貢獻](#貢獻)
  - [許可證](#許可證)

## 介紹

這個 Flutter 專案作為實現和管理不同類型測試的綜合範例。它包括：

- **單元測試**：驗證單一類別、方法或函數的功能。
- **小工具測試**：獨立測試 UI 元件。
- **整合測試**：確保應用的所有部分無縫協作。

## 功能

- 模組化架構，方便測試。
- 涵蓋各種組件的全面測試套件。
- 使用 Flutter 的 Material Design 建立的響應式 UI。
- 範例測驗功能，示範狀態管理和使用者互動。

## 開始使用

請按照以下說明在本機上設定和執行項目。

### 安裝

1. **克隆倉庫**
 ```bash
 git clone https://github.com/yourusername/flutter-testing-project.git
 ```

2. **導航至專案目錄**
 ```bash
 cd flutter-testing-project
 ```

3. **獲取依賴**
 ```bash
 flutter pub get
 ```

## 專案結構

- **lib/**:
  - **main.dart**：應用程式的入口點。
  - **home_screen.dart**：應用程式的主畫面。
  - **quiz_screen.dart**：具有狀態管理的測驗功能。
  - **data/posts.dart**：資料模型或服務。

- **test/**：包含所有測試檔案。
  - **unit/**：單一元件的單元測試。
  - **widget/**：UI 元件的小工具測試。

- **integration_test/**：包含與完整應用互動的整合測試。

## 運行應用

要在調試模式下運行應用：

```bash
flutter run
```

確保您有一個模擬器/模擬器正在運作或連接了實體設備。

## 測試

該項目包括各種類型的測試，以確保應用程式的可靠性和功能性。

### 單元測試

單元測試專注於單一組件或類別。

- **位置**：`test/unit/`
- **範例測試**：`home_screen_test.dart`

**執行單元測試：**

```bash
flutter test test/unit/
```

### 元件測試

元件測試驗證獨立的 UI 元件。

- **位置**：`test/widget/`
- **範例測試**：`quiz_screen_test.dart`

**執行小工具測試：**

```bash
flutter test test/widget/
```

### 整合測試

整合測試確保應用程式的不同部分按預期協同工作。

- **位置**：`integration_test/`

**執行整合測試：**

```bash
flutter test integration_test/
```

確保在運行整合測試之前連接了模擬器或實體設備。

## 貢獻

歡迎貢獻！請遵循以下步驟：

1. **分叉倉庫**
2. **建立新分支**
 ```bash
 git checkout -b feature/YourFeature
 ```
3. **提交更改**
 ```bash
 git commit -m "新增您的功能"
 ```
4. **推送到分支**
 ```bash
 git push origin feature/YourFeature
 ```
5. **打開拉取請求**

請確保在提交之前適當更新測試並確保所有測試都通過。

## 許可證

本專案根據 MIT 許可證進行許可 - 詳見 [LICENSE](LICENSE) 文件。