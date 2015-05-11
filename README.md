# Sugar Docker Container


This is a basic docker container used to run Sugar.
It should work on GNU/Linux with X11 and pulseaudio.


### Requirements
You just need to have Docker launched

### Usage

#### Launch Sugar (auto detect .activity folders in current directory)
```sh
$ sh run.sh
```

#### Launch Sugar (auto detect .activity folders in other directories)

```sh
$ sh run.sh  folder1 folder2 . ../
```
