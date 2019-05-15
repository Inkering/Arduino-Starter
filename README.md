# Arduino-Starter
Boilerplate for an arduino project

## Setup

### Conda env

``` shell
conda create -n arduino python=2.7 pip
conda activate arduino
```
### Platformio

``` shell
pip install -U platformio
platformio init
```  
for an Arduino Uno:

``` shell
platformio init --board uno
```
### for emacs ccls + lsp setup

Make the clang_complete file ready for ccls  
``` shell
platformio init --ide
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
platformio init --ide
./ccls-reg.sh
```
