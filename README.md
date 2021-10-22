# EdgeX Config Provider Example
This is an example config provider for EdgeX service Snaps.

A good starting point to get familiar with the concepts is to visit [Content Interface](https://snapcraft.io/docs/content-interface) documentation and the given examples.


## Crafting config provider snap
To help understand how a provider can be setup to provide configurations to multiple snaps, this repository contains the following:
* [examples](examples) directory with sample config files for some services
* [snap/snapcraft.yaml](snap/snapcraft.yaml) file used to create the snap that can provide those config files

## Connect to the provided slots
The plugs of consumer snaps need to be manually connected to the slots provided by this snaps.
The plugs stay connected during updates. 

**Note** - content interfaces from snaps installed from the Snap Store that have the same publisher connect automatically. For more information on snap content interfaces please refer to the snapcraft.io [Content Interface](https://snapcraft.io/docs/content-interface) documentation.

In this example, the `config` plug from `edgex-device-gpio` is being connected to
the `device-gpio` slot from this snap (i.e. `edgex-config-provider`):
```bash
$ sudo snap connect edgex-device-gpio:config edgex-config-provider:device-gpio
```

Check the connections:
```bash
$ sudo snap connections edgex-config-provider 
Interface        Plug                      Slot                               Notes
content[config]  edgex-device-gpio:config  edgex-config-provider:device-gpio  manual
```

## Debugging Tips
### Mount points
The source directories defined on producers are mounted INSIDE (not on) the target path set in consumer's plug.

### List exposed file
E.g. `device-gpio`:
```
$ tree /snap/edgex-config-provider/current/device-gpio/
/snap/edgex-config-provider/current/device-gpio/
├── config
│   └── device-gpio
│       └── res
│           ├── configuration.toml
│           ├── devices
│           │   └── device.custom.gpio.toml
│           └── profiles
│               └── device.custom.gpio.yaml
└── device-gpio
    └── secrets-token.json
```

### List mounted files
**Note** - the mounted files will not be available on the host file system and trying to list `/var/snap/device-gpio/current` will not show anything. See https://askubuntu.com/a/841787/366811

The files can be listed from inside the consumer snap's shell environment. 
To enter the shell environment of `device-gpio` and list mounted paths: 
```
$ sudo snap run --shell edgex-device-gpio.device-gpio
root@***# find /var/snap/edgex-device-gpio/current/ 
/var/snap/edgex-device-gpio/current/
/var/snap/edgex-device-gpio/current/config
/var/snap/edgex-device-gpio/current/config/device-gpio
/var/snap/edgex-device-gpio/current/config/device-gpio/res
/var/snap/edgex-device-gpio/current/config/device-gpio/res/configuration.toml
/var/snap/edgex-device-gpio/current/config/device-gpio/res/devices
/var/snap/edgex-device-gpio/current/config/device-gpio/res/devices/device.custom.gpio.toml
/var/snap/edgex-device-gpio/current/config/device-gpio/res/profiles
/var/snap/edgex-device-gpio/current/config/device-gpio/res/profiles/device.custom.gpio.yaml
/var/snap/edgex-device-gpio/current/device-gpio
/var/snap/edgex-device-gpio/current/device-gpio/secrets-token.json
``` 