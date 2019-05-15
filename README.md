# Arduino-Starter
Boilerplate for an arduino project. I don't particularly like the Arduino-ide, so I went searching for alternative options. Platform-io is the powerhouse here, it allows for uploading,building, and library management of programs for arduinos(and other boards!). I personally use emacs quite a bit, so this repo will be slightly biased towards that, with some helper scripts and config snippets to increase ease of use in emacs (auto-completion, compilation bindings, etc).

## Setup

### Conda env

``` shell
conda create -n arduino python=2.7 pip
conda activate arduino
```
### Platformio
During install we need to update udev rules so uploading can occur.  
``` shell
pip install -U platformio
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
### all in one

``` shell
conda create -n arduino python=2.7 pip \
conda activate arduino                 \
pip install -U platformio              \
platformio init                        \
platformio init --board uno            \
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
To regen flags:  

``` shell
platformio init --ide emacs
./ccls-reg.sh
```
