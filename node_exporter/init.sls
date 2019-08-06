{% set version = salt['pillar.get']('node_exporter:version') %}

node_exporter:
  version
# Download release from github
# * = version
node_exporter_download:
  archive.extracted:
    - name: /opt/node_exporter
    - source: https://github.com/prometheus/node_exporter/releases/download/v{{ version }}/node_exporter-{{ version }}.linux-amd64.tar.gz
    {% if salt['pillar.get']('node_exporter:checksum') == 'ignore' %}
    - skip_verify: true
    {% else %}
    - source_hash: sha256={{ salt['pillar.get']('node_exporter:checksum') }}
    {% endif %}

# AmazonLinux2 uses SystemD
{% if salt['grains.get']('init') == 'systemd' %}
node_exporter_service_systemd:
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - source: salt://node_exporter/files/systemd/node_exporter.service
    - user: root
    - group: root
    - mode: '0644'
# AmazonLinux1 uses upstart with sysvinit, the same way that Ubuntu pre 15.04 used it
{% elif salt['grains.get']('init') == 'upstart' %}
node_exporter_service_upstart:
  file.managed:
    - name: /etc/init/node_exporter.conf
    - source: salt://node_exporter/files/upstart/node_exporter.conf
    - user: root
    - group: root
    - mode: '0644'
# Include sysvinit incase salt picks it up from AmazonLinux1
{% elif salt['grains.get']('init') == 'sysvinit' %}
node_exporter_service_upstart:
  file.managed:
    - name: /etc/init.d/node_exporter
    - source: salt://node_exporter/files/init/node_exporter
    - user: root
    - group: root
    - mode: '0755'
{% endif %}

start_node_exporter:
  service.running:
    - name: node_exporter
    - enable: True
    - reload: True
