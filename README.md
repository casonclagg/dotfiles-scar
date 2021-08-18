Installation
------------
```
# Default setup (vim, go, node, ctags, misc dev tools)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash

# Full install with errthang (default + i3wm, chrome, docker and other apps I use)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash -s -- -f

# Minimal install (just vim)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash -s -- -m
```

Refreshing after changes
------------------------

    homeshick pull
    homeshick link
    mod + shift + c (refreshes i3)


Git Config
----------
Some standard configuration for git is included in `~/.gitconfig`
For your custom settings that wont be shared (like `name` and `email`) can be put in `~/.gitconfig_local` thusly:
```
[user]
    name = "Your Name"
    email = "your@email.com"
```


Local Files
-----------
There's a special local files folder somewhere secret! Use it after setup.


TODO
-----
1. Setup multiple monitors for i3
    - Currently have to use `sudo nvidia-settings`
2. Turn on the nvidia whatever pipeline so there no screen tearing
3. Sound is absolute trash, not sure how to fix  

