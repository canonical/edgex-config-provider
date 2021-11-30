# EdgeX Config Provider Example
This is an example config provider for EdgeX service Snaps.

A good starting point to get familiar with the concepts is to visit [Content Interface](https://snapcraft.io/docs/content-interface) documentation and the given examples.


## Crafting config provider snap
To help understand how a provider can be setup to provide configurations to multiple snaps, this repository contains the following:
* [examples](examples) directory with sample config files for some services
* [snap/snapcraft.yaml](snap/snapcraft.yaml) file used to create the snap that can provide those config files

Build and install the snap:
```bash
snapcraft
sudo snap install ./edgex-config-provider_example_amd64.snap --dangerous
```

## Connect to the provided slots
The plugs of consumer snaps need to be manually connected to the slots provided by this snaps.
The plugs stay connected during updates. 

**Note** - content interfaces from snaps installed from the Snap Store that have the same publisher connect automatically. For more information on snap content interfaces please refer to the snapcraft.io [Content Interface](https://snapcraft.io/docs/content-interface) documentation.

In this example, the `device-config` plug from `edgex-device-mqtt` is being connected to
the `device-mqtt` slot of this snap (i.e. `edgex-config-provider`):
```bash
sudo snap connect edgex-device-mqtt:device-config edgex-config-provider:device-mqtt
```

Check the connections:
```
$ sudo snap connections edgex-config-provider
Interface               Plug                             Slot                               Notes
content[device-config]  edgex-device-mqtt:device-config  edgex-config-provider:device-mqtt  manual
```

## Debugging Tips
### Mount points
The source directories defined on producers are mounted INSIDE (not on) the target path set in consumer's plug.

### List exposed file
E.g. `device-mqtt`:
```
$ tree /snap/edgex-config-provider/current/device-mqtt/
/snap/edgex-config-provider/current/device-mqtt/
└── res
    ├── configuration.toml
    ├── devices
    │   └── mqtt.test.device.toml
    └── profiles
        └── mqtt.test.device.profile.yml
```

### List mounted files
**Note** - the mounted files will not be available on the host file system and trying to list `/var/snap/device-mqtt/current` will not show anything. See https://askubuntu.com/a/841787/366811

The files can be listed from inside the consumer snap's shell environment. 
To enter the shell environment of `device-mqtt` and list mounted paths: 
```
$ sudo snap run --shell edgex-device-mqtt.device-mqtt
root@***# find /var/snap/edgex-device-mqtt/current/config
...
``` 