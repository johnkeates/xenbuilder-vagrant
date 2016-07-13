# Relay destination rules for carbon-relay. Entries are scanned in order,
# and the first pattern a metric matches will cause processing to cease after sending
# unless `continue` is set to true
#
#  [name]
#  pattern = <regex>
#  destinations = <list of destination addresses>
#  continue = <boolean>  # default: False
#
#  name: Arbitrary unique name to identify the rule
#  pattern: Regex pattern to match against the metric name
#  destinations: Comma-separated list of destinations.
#    ex: 127.0.0.1, 10.1.2.3:2004, 10.1.2.4:2004:a, myserver.mydomain.com
#  continue: Continue processing rules if this rule matches (default: False)

# You must have exactly one section with 'default = true'
# Note that all destinations listed must also exist in carbon.conf
# in the DESTINATIONS setting in the [relay] section
[default]
default = true
destinations = 127.0.0.1:2004:a, 127.0.0.1:2104:b
vagrant@debian-jessie:/etc/default$ cat /usr/share/doc/graphite-carbon/examples/rewrite-rules.conf.example
# This file defines regular expression patterns that can be used to
# rewrite metric names in a search & replace fashion. It consists of two
# sections, [pre] and [post]. The rules in the pre section are applied to
# metric names as soon as they are received. The post rules are applied
# after aggregation has taken place.
#
# The general form of each rule is as follows:
#
# regex-pattern = replacement-text
#
# For example:
#
# [post]
# _sum$ =
# _avg$ =
#
# These rules would strip off a suffix of _sum or _avg from any metric names
# after aggregation.
