# Ansible Java

A role to install Java packages. It currently supports:

* OpenJDK on either Ubunu/Debian, or CentOS/RHEL; or
* Oracle on Ubuntu/Debian.

## Requirements

None.

## Role Variables

* `java_type`: Can either be `openjdk` or `oracle` to install the selected
  type of Java on the system. *Note*: At this time `oracle` is only supported
  on Ubuntu or Debian systems.
* `java_version`: The version of the JDK to install; either `6`, `7`, `8`, or
  `9`. Not all versions are supports on all types for all releases and
  distributions.
* `java_debain_oracle_accept_licence`: If you are running on a `Debian` (or
  `Ubuntu` system), then you will need to accept a licence as part of the
  install process. This is set to `no` by default, so you will need to set this
  in the appropriate `group_vars/` or `host_vars/` file (or the play) to allow
  `debconf` to set the propery and therefore allow Oracle Java to be installed.

## Example Playbook

Here are some examples on how to use this role:

```yaml
- hosts: all
  vars:
    java_type: openjdk
    java_version: 8
  roles:
    - java
```

```yaml
- hosts: debian
  vars:
    java_debain_oracle_accept_licence: yes
  roles:
    - { role: java, java_type: oracle, java_version: 9 }
```

## License

GPLv3

## Author Information

Jonathan Wright <github@jon.than.io>
