# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "graphite/map.jinja" import graphite with context %}

graphite-config:
  file.managed:
    - name: {{ graphite.config }}
    - source: salt://graphite/files/example.tmpl
    - mode: 644
    - user: root
    - group: root
