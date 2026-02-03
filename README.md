[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![JCS-ELPA](https://raw.githubusercontent.com/jcs-emacs/badges/master/elpa/v/elenv.svg)](https://jcs-emacs.github.io/jcs-elpa/#/elenv)
<a href="https://jcs-emacs.github.io/"><img align="right" src="https://raw.githubusercontent.com/jcs-emacs/badges/master/others/built-with/dark.svg" alt="Built with"></a>

# elenv
> Environment variable management

[![CI](https://github.com/jcs-elpa/elenv/actions/workflows/test.yml/badge.svg)](https://github.com/jcs-elpa/elenv/actions/workflows/test.yml)

The package name `elenv' stands for Emacs Lisp environment.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [elenv](#elenv)
  - [🔨 Usage](#-usage)
    - [🖥️ Operating System](#-operating-system)
      - [[v] elenv-windows](#v-elenv-windows)
      - [[v] elenv-darwin](#v-elenv-darwin)
      - [[v] elenv-macos](#v-elenv-macos)
      - [[v] elenv-linux](#v-elenv-linux)
      - [[v] elenv-bsd](#v-elenv-bsd)
      - [[v] elenv-unix](#v-elenv-unix)
      - [[v] elenv-system-type](#v-elenv-system-type)
      - [[m] elenv-with-os](#m-elenv-with-os)
      - [[m] elenv-with-windows](#m-elenv-with-windows)
      - [[m] elenv-with-macos](#m-elenv-with-macos)
      - [[m] elenv-with-linux](#m-elenv-with-linux)
      - [[m] elenv-with-bsd](#m-elenv-with-bsd)
      - [[m] elenv-with-unix](#m-elenv-with-unix)
    - [⛓️ Environment](#-environment)
      - [[v] elenv-user-home-dir](#v-elenv-user-home-dir)
      - [[m] elenv-if-env](#m-elenv-if-env)
      - [[m] elenv-when-env](#m-elenv-when-env)
      - [[m] elenv-unless-env](#m-elenv-unless-env)
    - [⚙️ Executable](#-executable)
      - [[m] elenv-if-exec](#m-elenv-if-exec)
      - [[m] elenv-when-exec](#m-elenv-when-exec)
      - [[m] elenv-unless-exec](#m-elenv-unless-exec)
    - [🖼️ Graphic](#-graphic)
      - [[v] elenv-graphic-p](#v-elenv-graphic-p)
    - [🔍 Debugging](#-debugging)
      - [[f] elenv-debugging-p](#f-elenv-debugging-p)
  - [🛠️ Contribute](#-contribute)
    - [🔬 Development](#-development)
  - [⚜️ License](#-license)

<!-- markdown-toc end -->

## 🔨 Usage

### 🖥️ Operating System

#### [v] elenv-windows

```elisp
(when elenv-windows ...  ; is windows
```

#### [v] elenv-darwin

```elisp
(when elenv-darwin ...  ; is darwin
```

#### [v] elenv-macos

```elisp
(when elenv-macos ...  ; is macos
```

#### [v] elenv-linux

```elisp
(when elenv-linux ...  ; is linux
```

#### [v] elenv-bsd

```elisp
(when elenv-bsd ...  ; is bsd
```

#### [v] elenv-unix

```elisp
(when elenv-unix ...  ; is unix
```

#### [v] elenv-system-type

```elisp
(cl-case elenv-system-type  ; return current OS in symbol
  (`windows ...
```

#### [m] elenv-with-os

```elisp
(elenv-with-os 'windows ...  ; accept list
```

#### [m] elenv-with-windows

```elisp
(elenv-with-windows ...  ; do stuff in windows
```

#### [m] elenv-with-macos

```elisp
(elenv-with-macos ...  ; do stuff in macos
```

#### [m] elenv-with-linux

```elisp
(elenv-with-linux ...  ; do stuff in linux
```

#### [m] elenv-with-bsd

```elisp
(elenv-with-bsd ...  ; do stuff in bsd
```

#### [m] elenv-with-unix

```elisp
(elenv-with-unix ...  ; do stuff in unix
```

### ⛓️ Environment

#### [v] elenv-user-home-dir

```elisp
(concat elenv-user-home-dir ".emacs")  ; ~/.emacs
```

#### [m] elenv-if-env

```elisp
(elenv-if-env "PATH"
                ...  ; do stuff when VARIABLE exists; expose it as `value'.
  ...                ; else we execute the ELSE block
```

#### [m] elenv-when-env

```elisp
(elenv-when-env "PATH" ...  ; do stuff when VARIABLE exists; expose it as `value'.
```

#### [m] elenv-unless-env

```elisp
(elenv-unless-env "PATH" ...  ; do stuff unless VARIABLE exists; expose it as `value'.
```

### ⚙️ Executable

#### [m] elenv-if-exec

```elisp
(elenv-if-exec "node" nil
                ...  ; do stuff if PROGRAM exists; expose it as `value'.
  ...                ; else we execute the ELSE block
```

#### [m] elenv-when-exec

```elisp
(elenv-when-exec "node" nil ...  ; do stuff when PROGRAM exists; expose it as `value'.
```

#### [m] elenv-unless-exec

```elisp
(elenv-unless-exec "node" nil ...  ; do stuff unless PROGRAM exists; expose it as `value'.
```

### 🖼️ Graphic

#### [v] elenv-graphic-p

```elisp
(when elenv-graphic-p ...  ; do stuff in graphic mode
```

### 🔍 Debugging

#### [f] elenv-debugging-p

```elisp
(when (elenv-debugging-p) ...  ; do stuff in debug mode
```

## 🛠️ Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Elisp styleguide](https://img.shields.io/badge/elisp-style%20guide-purple?logo=gnuemacs&logoColor=white)](https://github.com/bbatsov/emacs-lisp-style-guide)
[![Donate on paypal](https://img.shields.io/badge/paypal-donate-1?logo=paypal&color=blue)](https://www.paypal.me/jcs090218)
[![Become a patron](https://img.shields.io/badge/patreon-become%20a%20patron-orange.svg?logo=patreon)](https://www.patreon.com/jcs090218)

If you would like to contribute to this project, you may either
clone and make pull requests to this repository. Or you can
clone the project and establish your own branch of this tool.
Any methods are welcome!

### 🔬 Development

To run the test locally, you will need the following tools:

- [Eask](https://emacs-eask.github.io/)
- [Make](https://www.gnu.org/software/make/) (optional)

Install all dependencies and development dependencies:

```sh
eask install-deps --dev
```

To test the package's installation:

```sh
eask package
eask install
```

To test compilation:

```sh
eask compile
```

**🪧 The following steps are optional, but we recommend you follow these lint results!**

The built-in `checkdoc` linter:

```sh
eask lint checkdoc
```

The standard `package` linter:

```sh
eask lint package
```

*📝 P.S. For more information, find the Eask manual at https://emacs-eask.github.io/.*

## ⚜️ License

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

See [`LICENSE`](./LICENSE.txt) for details.
