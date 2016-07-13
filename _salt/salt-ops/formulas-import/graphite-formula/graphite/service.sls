# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "graphite/map.jinja" import graphite with context %}

graphite-name:
  service.running:
    - name: {{ graphite.service.name }}
    - enable: True
