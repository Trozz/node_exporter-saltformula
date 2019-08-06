# node

This formula installs [Node Exporter](https://github.com/prometheus/node_exporter).

## Installing with Checksum

An example of install Node Exporter with a checksum check:
```yaml
node_exporter:
  version: 0.18.1
  checksum: b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424
  config:
    listen-address: ':9100'
    collectors:
      - filesystem
      - netdev
      - cpu
      - diskstats
      - mdadm
      - loadavg
      - time
      - uname
      - logind
```

## Installing without Checksum

An example of installing Node Exporter without the checksum, this specifies a `skip_verify`:
```yaml
node:
  version: 0.18.1
  checksum: ignore
  config:
    listen-address: ':9100'
    collectors:
      - filesystem
      - netdev
      - cpu
      - diskstats
      - mdadm
      - loadavg
      - time
      - uname
      - logind
```

Available versions can be found on [node_exporter/releases](https://github.com/prometheus/node_exporter/releases); the checksums are listed in the file `sha256sums.txt` in the respective version’s release.
