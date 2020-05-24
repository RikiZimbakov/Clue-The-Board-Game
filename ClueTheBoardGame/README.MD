In UNIX, there is no standard ruby editor. Use whatever text editor you typically use (pico is likely the simplest, but if you're going to do any work in UNIX it pays to learn a more complex editor, such as emacs).

For example, if you typed the following and saved it into a file called fact.rb (e.g. pico fact.rb) :

you could run this program by invoking the ruby interpreter on it:

mira% ruby fact.rb 3

6

mira% ruby fact.rb 7

5040

mira%

This program defines a function (factorial - and it's really a method) implementing a recursive factorial algorithm. Following the function definition is a line calling that function using the argument supplied on the command line.

Do the same with my program to run Main just type ruby main.rb

Thanks!

Risto
