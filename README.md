# Device Snap Content Provider
This is an example config provider for EdgeX Device Snaps.
The config files and secrets are provided as examples under `/examples` directory.

## Connect to the provided slots
The plugs of consumer snaps need to be manually connected to the slots provided by this snaps.
The plugs stay connected during updates. 

**Note** - content interfaces from snaps installed from the Snap Store that have the same publisher connect automatically. For more information on snap content interfaces please refer to the snapcraft.io [Content Interface](https://snapcraft.io/docs/content-interface) documentation.

In this example, the `config` plug from `edgex-device-gpio` is being connected to
the `device-gpio` slot from this snap (i.e. `edgex-device-config`):
```bash
$ sudo snap connect edgex-device-gpio:config edgex-device-config:device-gpio
```

```bash
$ sudo snap connections | grep device-gpio
content[config]           edgex-device-gpio:config                  edgex-device-config:device-gpio  manual
network                   edgex-device-gpio:network                 :network                         -
network-bind              edgex-device-gpio:network-bind            :network-bind                    -
```

## Debugging Notes
* The exposed files can be accessed from the host at: `/snap/my-producer/config`
* The mounted files will not be available on the host file system and trying to list `/var/snap/my-consumer/current/config` will not show anything. The files can be listed from inside the snap's shell environment (snap run --shell my-consumer). See https://askubuntu.com/a/841787/366811
* The target directory defined on producer is mounted INSIDE (and not on) the target path in consumer's plug