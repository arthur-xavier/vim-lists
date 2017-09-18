# vim-lists

Interchangeable management of QuickFix and Location lists.

This plugin defines a set of commands for working with the QuickFix and
Location lists.  The commands prefer the QuickFix list if it's open, falling
back to the Location list if the other one does not exists or isn't visible.

## Commands

- `:Lo[pen]` - Open the quickfix list if a quickfix buffer exists. If not,
attempt to open the location list.

- `:Lc[lose]` - Close the quickfix list if it's open, or else, attemp to
close the location list.

- `:Lw[indow]` - Open the quickfix list when there exists a quickfix
buffer, or else attempt open the location list window. If the location list
window is already open, close it; but if the quickfix window is open, close
it instead.

- `:Ll[ist]` - If the quickfix window is open, display the currently
focused item in the quickfix list and jump to the specified buffer and line.
If the quickfix window is closed, attempt to do the same for the location
list.

- `:Ln[ext]` - Display the next error in the quickfix list that includes
a file name, if the quickfix window is open. If it's not, then display the
next error in the location list that includes a file name.

- `:Lp[rev]` - Display the previous error in the quickfix list that
includes a file name, if the quickfix window is open. If it's not, then
display the previous error in the location list that includes a file name.
