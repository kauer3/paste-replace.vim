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
  - [Demo](#demo)
  - [Install](#install)

---

## Introduction

  <p>Paste-Replace provides new operators to replace text objects with register contents in vim. In other words, it makes it much easier to replace text with another text you had copied. Like any default vim operator, they can be preceded by a count and followed by any motion or operator-pending mode command. Also, if you happen to use a plugin that adds custom text objects, like [targets](#addlinkhere), or custom motions like [easymotion](#addlinkhere), Paste-Replace will be compatible with it.</p>
  <p>The two replace operators are `cr` (replace with system clipboard) and `yr` (replace with last yanked text), and there is also `cy`, an operator that copies to the system clipboard.</p>

---

## Demo
<p align="center">
  <img src="/images/readme/popup.gif">
  <br>
  <em>Example of how to use Slang through the pop-up...</em>
  <br>
  <br>
  <img src="/images/readme/context-menu.gif">
  <br>
  <em>...and through the right click menu.</em><br>
  <br>
</p>

#### Also, check out the [Youtube video](https://youtu.be/RYb9BEUVTdY) for a more complete demo!

---

## Download

[Slang is available to download at the Chrome Web Store](https://chrome.google.com/webstore/detail/slang-text-to-speech/enkmbkhkbdiaafkmofbmdahclajelgfh).

---

## License and copyright

MIT License

Copyright (c) 2020 Kauê R A Pereira

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
