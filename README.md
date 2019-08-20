# Arduino-Starter
Boilerplate for an arduino project. I don't particularly like the Arduino-ide,
so I went searching for alternative options. Platform-io is the powerhouse here,
it allows for uploading,building, and library management of programs for
arduinos(and other boards!). I personally use emacs quite a bit, so this repo
will be slightly biased towards that, with some helper scripts and config
snippets to increase ease of use in emacs (auto-completion, compilation
bindings, etc).

## Setup

### Conda env
Unfortunately pio requires python 2.

``` shell
conda create -n arduino python=2.7 pip
conda activate arduino
```
### Platformio
During install we may need to update udev rules so uploading can occur.  
``` shell
pip install -r requirements.txt
wget https://raw.githubusercontent.com/platformio/platformio-core/develop/scripts/99-platformio-udev.rules
sudo cp 99-platformio-udev.rules /etc/udev/rules.d/99-platformio-udev.rules
sudo service udev restart
platformio init
```  
for an Arduino Uno:

``` shell
platformio init --board uno
platformio init --board uno --ide emacs
```
### for emacs ccls + lsp setup

Make the clang_complete file ready for ccls  
``` shell
platformio init --ide emacs
./ccls-reg.sh
```  
In the future we can hook this into platform IO's run command or something like that. I will also add details on the emacs config which allows for vs-code level intellisense!  
Emacs config(Here be dragons, beware) This is largely to point someone in the right direction,and doesn't constitute a great set of default configuration values:   

``` emacs-lisp
;; Install Melpa
(require 'package)
(setq-default package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                                 ("melpa" . "https://melpa.org/packages/")
                                 ("org" . "https://orgmode.org/elpa/"))
              package-enable-at-startup nil
							load-prefer-newer t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
	(package-install 'use-package))

(use-package projectile :ensure
	:config
	(projectile-global-mode))

(use-package platformio-mode :ensure)
(use-package arduino-mode :ensure)
(add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))
(add-hook 'c++-mode-hook (lambda ()
                           (lsp)
                           (platformio-conditionally-enable)))

(use-package ccls :ensure
	:config
	'(ccls-initialization-options (quote (compilationDatabaseDirectory :build)))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package lsp-mode
  :commands lsp)

(use-package lsp-ui :ensure)

(use-package company :ensure
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-idle-delay 0.1)
  (bind-key "<C-tab>" 'company-manual-begin))

(use-package company-lsp :ensure
	:config
	(push 'company-lsp company-backends))
```

### all in one

``` shell
conda create -n arduino python=2.7 pip                                                                      \
conda activate arduino                                                                                      \
pip install -U platformio                                                                                   \
wget https://raw.githubusercontent.com/platformio/platformio-core/develop/scripts/99-platformio-udev.rules  \
sudo cp 99-platformio-udev.rules /etc/udev/rules.d/99-platformio-udev.rules                                 \
sudo service udev restart                                                                                   \
platformio init                                                                                             \
platformio init --board uno                                                                                 \
```

## Usage

To build:  
``` shell
pio run
```  
To upload:  
``` shell
pio run --target upload
```  
To clean:  
``` shell
pio run --target clean
```  
To see serial:  
``` shell
platformio device monitor
```  
To regen flags for emacs:  

``` shell
platformio init --ide emacs
./ccls-reg.sh
```
