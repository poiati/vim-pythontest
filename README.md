vim-pythontest
==============

This is basically a version of the excellent https://github.com/skalnik/vim-vroom for python projects. 
This script is context aware, if you are in the root of a Django project (the directory where `manage.py` is located) it will run the Django test runner, otherwise it will run the command `python -m unittest`.

# Installation

### Vundle

`Bundle 'poiati/vim-pythontest'`

### Pathogen

`cd ~/.vim/bundle && git clone git://github.com/poiati/vim-pythontest`

# Usage

There are two mapped keys:

`<leader>r`
Run all the tests of the current vim buffer.

`<leader>R`
Run the method the cursor is currently located.

- Currently there is no support custom mapping support.

The plugin also remember the last ran test file so you can run your test again from a non test file. 
For instance, you go to the `test_models.py` buffer, run the tests, change to `models.py` file, do some changes and run the tests again.

- The test file name need to start with `test`, e.g: `test_views.py`.
- The vim mappings runs only on python buffers (FileType python).
