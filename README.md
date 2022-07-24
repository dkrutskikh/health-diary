# Health diary

The application can help you get fit, monitoring your progress along the way.

[![Build Status](https://shields.io/github/workflow/status/dkrutskikh/health-diary/build?logo=github&logoColor=white)](https://github.com/dkrutskikh/health-diary/)
[![Coverage Status](https://img.shields.io/codecov/c/github/dkrutskikh/health-diary?logo=codecov&logoColor=white)](https://codecov.io/gh/dkrutskikh/health-diary/)
[![License](https://img.shields.io/github/license/dkrutskikh/health-diary)](https://github.com/dkrutskikh/health-diary/blob/master/LICENSE)

## Golden tests

To regenerate goldens to capture your new reference images use command:

```bash
flutter test --update-goldens --tags=golden
```

## Upload on Tizen Device

* connect co device via Wi-Fi

```bash
$ sdb connect 192.168.1.61
connecting to 192.168.1.61:26101 ...
connected to 192.168.1.61:26101

$ sdb devices
List of devices attached
192.168.1.61:26101      device          SM-R850
```

* build and upload

```bash
# Build the project and run on a Tizen device (either in debug or release mode).
flutter-tizen run
flutter-tizen run --release
```
