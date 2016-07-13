================
graphite-formula
================

Allows automatic installation and configuration of the various graphite components.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``graphite``
------------

Installs the graphite packages, and starts the associated graphite services.
This is a meta-state that does a default setup and configuration. If you don't need
any thing special, this might be the state for you. It does need a few pillar entries
to override the database settings so it can actually install itself with a working DB.

``graphite.carbon``
-------------------

Data store only.


``graphite.whisper``
--------------------

Database for Carbon only.

``graphite.web``
----------------

Web support only.

``graphite.nginx``
------------------

Connect web support to nginx.

``graphite.apache``
-------------------

Connect web support to apache.

``graphite.config``
-------------------

aggregation rules, blacklists, whitelists, amqp support, carbon, relay settings, rewrite settings, storage aggregation, storage schemas
