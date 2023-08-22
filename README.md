<h1 align="center">Robot API Test</h1></br>

<p align="center">
:sparkles: API Automation Testing using Robot Framework with Requests Library, Python, & POM Design Pattern :sparkles:
</p>

## Preparation

What will be used in this project

| Item           | Source                                                         |
| -------------- | ------------------------------------------------------------ |
| Editor         | VS Code (https://code.visualstudio.com/download) |
| Package Manager| PIP (https://pip.pypa.io/en/stable/getting-started/) |
| UI Test Tools  | Robot Framework with Python (https://robotframework.org/#getting-started) |
|                | Requests Library (https://docs.robotframework.org/docs/different_libraries/requests) |
| Design Pattern | POM or Page Object Model |
| Test Reporter  | Robot Framework with Python (https://robotframework.org/#getting-started)|
| Run on         | Terminal or Command Prompt  |

## Pre-Requisite Installation

Install VS Code Editor, Python, and PIP

To check whether you already installed Python & PIP

```Bash
python --version
```

```Bash
python -m pip --version
```

## Testing Tools Installation

Install Robot Framework

```Bash
python -m pip install robotframework
```

Install Request

```Bash
python -m pip install requests
```

Install Robot Framework Request

```Bash
pip install robotframework-requests
```

Robot Framework Jsonlibrary

```Bash
pip install robotframework-jsonlibrary
```

## Setting up Project

### Clone

**👉 [Clone this Repository](https://github.com/Fatimazza/RobotAPITest/)** through Terminal or Command Prompt

### Open the Project on Editor

Open this Automation Project using VS Code Editor.

### Run the Automation Project 

Change to Project directory on Terminal or Command Prompt

```Bash
cd RobotAPITest
```

Run All Tests on Terminal

```Bash
robot --outputdir output/ .
```

Run Specific Test

```Bash
robot --outputdir output/ step/Suite01_GetRequest.robot
```

### Test Execution HTML Report

:white_check_mark: Report available on <b> RobotAPITest/output/report.html </b>
