# Device Snap Content Provider
This is an example config provider for EdgeX Device Snaps.

## Connect plugs to the slots provided by this snap
In this example, the `config` plug from `edgex-device-gpio` is being connected to
`device-gpio` slot from `edgex-device-config`:
```bash
$ sudo snap connect edgex-device-gpio:config edgex-device-config:device-gpio
```

```bash
$ sudo snap connections | grep device-gpio
content[config]           edgex-device-gpio:config                  edgex-device-config:device-gpio  manual
network                   edgex-device-gpio:network                 :network                         -
network-bind              edgex-device-gpio:network-bind            :network-bind                    -
```

Notes:
* The exposed files can be accessed from the host at /snap/my-producer/config.
* The mounted files will not be available on the file system of the host, so listing /var/snap/my-consumer/current/config will not show anything. The files can be listed from inside the snap's shell environment (snap run --shell my-consumer). See https://askubuntu.com/a/841787/366811
* The target directory defines on producer is mounted INSIDE (and not on) the target on consumer.