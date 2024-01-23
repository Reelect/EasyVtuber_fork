# EasyVtuber

이 포크는 원본 포크의 readme를 기계번역한 내용입니다.

> 스킨을 사는 데 사용한 돈으로 3080 그래픽 카드 하나 더 사세요!

![투명 가상 카메라 입력을 사용한 OBS 녹화](assets/new_sample.gif)

https://github.com/GunwooHan/EasyVtuber에서 포크되었습니다.
얼굴 캡처 품질 문제를 해결하기 위해 https://github.com/pkhungurn/talking-head-anime-2-demo에서 가져온 원본 데모의 iOS 얼굴 캡처 로직을 역공학하고 포팅했습니다. 이것은 PC 측 ifacialmocap을 생략하고 iOS 얼굴 캡처에 직접 UDP로 연결하여 최대 새로 고침률을 60fps까지 지원하고 얼굴 캡처 새로 고침률 병목 현상을 극복하는 데 성공했습니다. 마지막으로 EasyVtuber에서 사용되는 OBS 가상 카메라 솔루션에 셰이더 지원을 추가하여 그린 스크린 없이도 RGBA 출력 기능을 잠금 해제했습니다.

[비디오 소개 및 설치 지침 (중국어)](https://www.bilibili.com/video/BV1uu411r7DR)

## 요구 사항

### 하드웨어

- Face ID를 지원하는 iPhone (구매 및 안정적인 Wi-Fi 연결이 필요한 ifacialmocap 소프트웨어 사용) 또는 네트워크 카메라 (OpenCV 사용)
- PyTorch CUDA를 지원하는 NVIDIA 그래픽 카드 (예: 기본 설정에서 40FPS 및 80% 사용률로 TUF RTX3080)

### 소프트웨어

- Windows 10에서 테스트됨
- Python >= 3.8
- OBS 또는 Unity Capture (가상 카메라 솔루션용)
- Photoshop 또는 다른 이미지 처리 소프트웨어
- 차단된 웹 사이트에 액세스하는 솔루션 및 영어 웹 사이트 및 오류 메시지를 이해할 수 있는 능력

## 설치 (내장 Python 버전)
"bin" 폴더에는 Python 3.10.5를 기반으로 한 Win64용 경량 실행 환경이 포함되어 있습니다. 이 라이브러리를 체험하려는 사용자들에게는 이 설치 방법을 권장합니다.

### ZIP 다운로드 및 압축 해제 또는 이 저장소 복제
[`Download ZIP`](../../archive/master.zip)을 클릭하여 다운로드하고 압축 해제하거나 Git을 사용하여 이 저장소를 찾기 쉬운 위치에 복제합니다. venv 폴더를 확장하려면 약 5.5GB의 하드 디스크 공간이 필요합니다.

### 사전 훈련된 모델 다운로드
00B 바로 가기 또는 다음 링크를 사용하여 모델 파일을 다운로드합니다:
https://github.com/pkhungurn/talking-head-anime-3-demo#download-the-models
원본 리포지토리에서 압축 파일을 다운로드하고 "data/models" 폴더에 "placeholder.txt"와 동일한 수준에 푼 다음 압축을 해제합니다. 올바른 디렉토리 구조는 다음과 같아야 합니다:
```
+ models
  - separable_float
  - separable_half
  - standard_float
  - standard_half
  - placeholder.txt
```
올바른 위치에 압축을 푼지 확실하지 않은 경우 "00. 필수 파일 확인 및 완료.bat" 스크립트를 사용할 수 있습니다.

### 실행 환경 빌드
설치를 위해 지역에 따라 "01A. 실행 환경 빌드 (기본 소스)" 또는 "01B. 실행 환경 빌드 (국내 소스)" 중 하나를 실행합니다. 이러한 스크립트는 "bin" 디렉토리에 모든 필요한 종속성을 pip를 사용하여 설치합니다. 이러한 스크립트는 상호 대체 가능하며 중단된 설치에서 다시 시작할 수 있습니다. 네트워크 관련 오류가 발생하면 콘솔을 닫고 네트워크를 조정한 후 스크립트를 다시 실행하면 됩니다. 설치 중에 어떠한 빨간 글도 표시되지 않아야 합니다.

### 런처를 사용하여 결과 테스트
"02B. 런처 (디버그 출력) 실행.bat"을 실행합니다. 인터페이스에서 "Save & Launch"를 클릭하면 됩니다. 팝업되는 OpenCV 출력 창을 볼 수 있다면 설치가 성공한 것입니다.

### 입력 및 출력 장치 구성
디버그 출력을 성공적으로 생성한 후 입력 및 출력 장치 섹션으로 이동하여 OBS로 출력하도록 추가 구성합니다.

## 설치 (Venv 버전)
이전 Venv 솔루션을 계속 사용해야 하는 경우 다음 단계를 따릅니다.

### ZIP 다운로드 및 압축 해제 또는 이 저장소 복제
[`Download ZIP`](../../archive/master.zip)을 클릭하여 다운로드하고 압축 해제하거나 Git을 사용하여 이 저장소를 찾기 쉬운 위치에 복제합니다. venv 폴더를

 확장하려면 약 5.5GB의 하드 디스크 공간이 필요합니다.

### 가상 환경 생성
가상 환경을 생성하려면 프로젝트 디렉토리에서 다음 명령을 실행합니다:
```
python -m venv venv
```

### 가상 환경 활성화
이후의 모든 작업은 가상 환경 내에서 수행되어야 하며 명령 프롬프트에 "(venv)"로 표시됩니다. 가상 환경을 활성화하려면 다음 명령을 콘솔에서 실행합니다:
```
venv\Scripts\activate.bat
```
이후 Python 및 pip 작업은 가상 환경 내에서 진행됩니다.

### 종속성 설치
가상 환경 내에서 다음 명령을 실행합니다:
```
pip install -r .\requirements.txt
pip install torch --extra-index-url https://download.pytorch.org/whl/cu113
```

### 런처 실행
가상 환경 내에서 다음 명령을 실행합니다:
```
python launcher.py
```

## 설치 (Conda 버전)

### 이 저장소 복제
이 저장소를 복제한 후 PyCharm에서 열었다면 즉시 Python 인터프리터를 구성하지 마십시오.

### Python 및 Anaconda 환경
이 프로젝트는 패키지 관리를 위해 Anaconda를 사용합니다. 다음 단계를 따릅니다:

1. https://www.anaconda.com/를 방문하여 Anaconda를 설치합니다.
2. Anaconda Prompt 콘솔을 실행합니다.
3. 중국 사용자의 경우 Tsinghua 소스로 전환하는 것이 좋습니다 (pip 및 conda 소스를 모두 교체하며 특히 PyTorch 채널의 conda를 교체해야 합니다. PyTorch 자체가 상당히 크기 때문입니다).
4. 다음 명령을 실행하여 환경을 생성하고 모든 종속성을 설치합니다:
   ```
   conda env create -f env_conda.yaml
   ```
   오류가 발생하면 (일반적으로 네트워크 문제로 인한 것임) 부분적으로 생성된 환경을 삭제하고 `conda clean --all`을 사용하여 다운로드 캐시를 지우고 구성을 조정한 후 다시 시도하십시오.

설치가 완료되면 PyCharm에서 이 프로젝트를 엽니다. 오른쪽 하단의 인터프리터 메뉴를 클릭한 다음 "Add Interpreter..." -> "Conda Environment" -> "Existing environment"을 선택합니다. 컴퓨터의 `conda.exe` 및 이전에 만든 `talking-head-anime-2-demo` 환경의 `python.exe`를 선택합니다. 모두 선택되고 종속성이 나열되면 OK를 클릭합니다.

### 사전 훈련된 모델 다운로드
https://github.com/pkhungurn/talking-head-anime-3-demo#download-the-models에서 압축 파일을 다운로드하고 "data/models" 폴더에 "placeholder.txt"와 동일한 수준에 푼 다음 압축을 해제합니다. 올바른 디렉토리 구조는 다음과 같아야 합니다:
```
+ models
  - separable_float
  - separable_half
  - standard_float
  - standard_half
  - placeholder.txt
```

### 런처 실행
Conda 환경에서 다음 명령을 실행합니다:
```
python launcher.py
```

## 입력 및 출력 장치

#### OBS 가상 카메라

현재 이 솔루션을 권장하며 UnityCapture에 알려지지 않은 성능 병목 현상이 있을 수 있습니다. 크로마 키를 직접 수행하려는 경우 OBS로 직접 출력할 수 있습니다. RGBA 지원이 필요한 경우 추가 셰이더를 사용해야 합니다.
