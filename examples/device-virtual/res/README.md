# Device Virtual Resources

The files are taken from https://github.com/edgexfoundry/device-virtual-go/tree/v3.0.0-dev.45/cmd/res

In this example following have been modified:
- Device is modified to contain only `Random-Float-Device` to reduce the number of resources and auto events.
- All unused profiles have been removed, leaving only `Random-Float-Device`.
- Startup message is set to `CONFIG BY EXAMPLE PROVIDER` for the sake of testing.
