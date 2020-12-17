# Raymond Doran's dotfiles - forked from jldeen dotfiles - forked from holman's repo

### macOS Configuration
Run the following to configure macOS from scratch...
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/thedanielfactor/dotfiles/mac-dev/configure.sh)"
```

It should go without saying, you should never run a script on your system without reading it to understand what changes it will make to your system. My scripts and code samples are no exception to the rule.

If you choose to use my dotfiles, my configure script will backup your current dotfiles, but will also make changes to your crontab - it's in your best interest to understand these changes prior to opting in.

### Notes
Your dotfiles are how you personalize your system. These are mine, albeit I 
borrowed inspriation from jldeen, which borrowed from Holmes and Ryan bates.

As jldeen said in her [README](https://github.com/jldeen/dotfiles/README.md), which 
I have shamelessly just updated with my own thoughts, I was a little tired of 
having long alias files and everything strewn about (which is extremely common 
on other dotfiles projects, too). 

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read Holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork holman's](https://github.com/holman/dotfiles/fork), [Fork jdeen's](htps://github.com/jldeen/dotfiles/fork), or [Fork mine](https://github.com/thedanielfactor/dotfiles/fork) and remove what you don't use, 
and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your **dotfiles**
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install
In jldeen's original repo there are two "master" branches: WSL and MacOS; there are two "dev" branches here wsl-dev and mac-dev.  As I currently only use mac-os I am not keeping up the WSL and might eventually remove them from mine.  I am also considering movig to a Linux setup and will add a linux branch for things that will be different.  If you would like a WSL version please [fork jldee's](https://github.com/jldeen/dotfiles/fork) repository.

Run this:

```sh
git clone https://github.com/thedanielfactor/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine. You also might want to configure `.tmux.conf` since I run a few scripts in the status bar.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/thedanielfactor/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

Thank you [jldeen](http://github.com/jldeen)' for putting your awesome 
[dotfiles](http://github.com/jldeen/dotfiles) online and writing a great article
about them which I am unable to locate online anymore.  I decided to update my own
fork as I plan on adding Zim as well as of oh-my-zsh for others to compare.  Thank
you [holman](https://github.com/holman) as well for inspiring jldeen.  Thanks also to
[Ryan Bates](http://github.com/ryanb)' for your [contribution](https://github.com/jldeen/dotfiles#thanks)
to this chain also.
