setup-ignorefile:
  file.managed:
    - source: salt://file/ignore.Debian.jessie
    - name: /home/vagrant/buildroot/ignore.Debian.jessie
