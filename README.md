## About
Ninjs (No Inheritance Necessary) is a command line application written in ruby that leverages the [Sprockets](http://getsprockets.org/) JavaScript compiler to create modular javascript applications without having to compile your scripts manually. Ninjs also contains a very barebones JavaScript framework to enforce best practices like namespacing and modular separation.

## Installation

You can install Ninjs using RubyGems. This is the easiest way of installing and recommended for most users.

	$ gem install ninjs


If you want to use the development code you should clone the Git repository and add the binary to your path:

	$ git clone git://github.com/textnotspeech/ninjs.git
	$ export PATH=/path/to/ninjs/bin:$PATH