# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "graphite/map.jinja" import graphite with context %}

graphite-pkg:
  pkg.installed:
    - name: {{ graphite.pkg }}
