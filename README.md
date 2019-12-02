# Vagrant

```sh
vagrant up
```

## VSCode Remote SSH Over Vagrant

Set up vscode to have vagrant ssh host:

`F1 -> Remote-SSH: Open configuration File...`

Put there result of `vagrant ssh-config` with replaced hostname `default` to `purescript-playground` (or the name to your likings):

```ssh
Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile <yourpath>/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
```

Open `/vagrant` directory.
