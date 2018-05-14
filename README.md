# My own finance manager

This is a personal project that aims to be fun and make something I would do for
myself using an Excel or Calc sheet. I like the idea of making my own manager my
own way - feedback is welcome, but don't expect me to change ideas easily.

## ToDo list

- Data input validation
- Transfer all DB logic to a separate file --> OK for now
- Make a login kind of stuff work
- Understand how application icon works --> low prio
- Use the right console.something() instead of always console.log() and add file
and function name
- Currently uses the last rowid to position current selection, if I remember
right. This is a bad idea if entries are removed from the DB.
- Standardize error handling - throw, console.error(), console.trace(), etc
- Check Javascript code-behind vs shared library.
- Using a js as shared library allow to transfer data between JS applications - 
then an object or something like that can be created to hold login information
for other tabs
