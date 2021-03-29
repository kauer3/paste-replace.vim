<p align="center">
  <img align="center" src="/images/pr.png">
</p>

---

### Vim plugin to replace text with registers

---

### Topics:
  - [Introduction](#introduction)
  - [Installation](#installation)
  - [Documentation](#documentation)

---

## Introduction

  Paste-Replace provides new operators to replace text objects with register contents in vim. In other words, it makes it much easier to replace text with another text you had copied. Like any default vim operator, they can be preceded by a count and followed by any motion or operator-pending mode command. Also, if you happen to use a plugin that adds custom text objects, like [targets](https://github.com/wellle/targets.vim), or custom motions like [easymotion](https://github.com/easymotion/vim-easymotion), Paste-Replace will be compatible with it.
  The two replace operators are `cr` (replace with system clipboard) and `yr` (replace with last yanked text), and there is also `cy`, that copies to the system clipboard.

---

## Installation

### [Vim-Plug](https://github.com/junegunn/vim-plug)
```
Plug 'kauer3/paste-replace.vim'
```

### [Vundle](https://github.com/gmarik/vundle)
```
Plugin 'kauer3/paste-replace.vim'
```

### [NeoBundle](https://github.com/Shougo/neobundle.vim)
```
NeoBundle 'kauer3/paste-replace.vim'
```

### [Pathogen](https://github.com/tpope/vim-pathogen)
```
git clone https://github.com/kauer3/paste-replace.vim ~/.vim/bundle/paste-replace.vim
```

---

## Documentation

  To access Paste-Replace documentation, in Vim command mode, enter:

```
:help paste-replace
```

---
