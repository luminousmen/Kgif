Kgif
======

Tool for creating gif file from capturing active window.

![gif](https://camo.githubusercontent.com/38df9b507042dded48415dbb5a5a3c4966ea324c/687474703a2f2f692e696d6775722e636f6d2f3965743864614e2e6a7067)

Originally it was created for capturing tty output and creating preview for github projects :wink:


I needed to capture tty output on my Ubuntu 15.10. First I came up to using ```ttyrec``` with [ttygif](https://github.com/icholy/ttygif) or [tty2gif](https://bitbucket.org/antocuni/tty2gif) convertor, then find [showterm.io](http://showterm.io/). All this solutions didn't work for me :grimacing: Than I create this simple script that satisfies all my needs.

### Dependencies

* scrot
* imagemagick


### Installation

```bash
$ sudo apt-get install imagemagick && sudo apt-get install scrot
$ git clone https://github.com/luminousmen/Kgif
```

### Usage

Set ```delay``` in seconds to specify how long script will wait until start capturing.
```bash
$ delay=5 ./kgif.sh 
```

Set ```onclean``` if you don't want to delete source png screenshots (for example if you want to delete some of the screenshots).
```bash
$ onclean=true delay=5 ./kgif.sh 
```

### Preview

![preview](terminal.gif)

