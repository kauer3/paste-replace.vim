<p align="center">
  <img align="center" src="/images/prtitle.png">
</p>

---

### Vim plugin to replace text with registers

---

### Topics:
  - [Introduction](#introduction)
    - What is it?
    - How to use it?
    - Features
  - [Examples](#examples)
  - [Install](#install)

---

## Introduction

  Paste-Replace provides new operators to replace text objects with register contents in vim. In other words, it makes it much easier to replace text with another text you had copied. Like any default vim operator, they can be preceded by a count and followed by any motion or operator-pending mode command. Also, if you happen to use a plugin that adds custom text objects, like [targets](https://github.com/wellle/targets.vim), or custom motions like [easymotion](https://github.com/easymotion/vim-easymotion), Paste-Replace will be compatible with it.
  The two replace operators are `cr` (replace with system clipboard) and `yr` (replace with last yanked text), and there is also `cy`, that copies to the system clipboard.

---

## Examples

<details>-->
<summary><code>yriw</code></summary>-->
<img align="right" height="158" src="/images/dev.gif">
</details>-->

---

Installation
------------

### Pathogen (https://github.com/tpope/vim-pathogen)
```
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
```

### Vundle (https://github.com/gmarik/vundle)
```
Plugin 'easymotion/vim-easymotion'
```

### NeoBundle (https://github.com/Shougo/neobundle.vim)
```
NeoBundle 'easymotion/vim-easymotion'
```

---
