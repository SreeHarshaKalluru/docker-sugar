# Sugar Docker Container


This is a basic docker container used to run Sugar.
It should work on GNU/Linux with X11 and pulseaudio.


### Requirements
You just need to have Docker launched

### Usage

#### Launch Sugar
```sh
$ sh run.sh
```

#### Launch Sugar and add an actvity from a folder located on the host

```sh
$ sh run.sh  MyActivity.Activity
```

#### Launch Sugar and add multiple actvities from folders located on the host

```sh
$ sh run.sh  MyActivity.Activity SecondActivity.Activity
```
