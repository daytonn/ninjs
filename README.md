Readme
======

About
-----

ninjs is a new way of building JavaScript applications that allows you to write modular, testable, and reusable JavaScript. ninjs is not really a framework. It provides three essential JavaScript development tools in one coherent package.

1. ninjs uses the "Sprockets" (http://getsprockets.org) JavaScript compiler to package and include scripts. This provides a way to manage all 3rd party and custom libraries and require them directly into your scripts.
2. ninjs includes a small JavaScript framework, based on the module pattern (http://javascript.crockford.com/private.html) and "JavaScript: The Good Parts" (http://www.amazon.com/gp/product/B0026OR2ZY/ref=s9_bbs_gw_d6_ir01?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-2&pf_rd_r=0HQ3A0RDW9269GPJRGW8&pf_rd_t=101&pf_rd_p=470938631&pf_rd_i=507846), which provides a solid foundation for any JavaScript application.
3. The "ninjs" command line application eases the pain of repetitive tasks like compiling, scaffolding, and updating your application.

ninjs is written in Ruby (http://ruby-lang.org) and packaged as a Ruby gem (http://rubygems.org). However, it is not specific to Ruby or Rails development. While it certainly is usable in Rails or Ruby based projects, it is not designed for any one particular language or framework.

Installation
------------

You will need Ruby (1.8.x or 1.9.x) and RubyGems installed on your system to install ninjs using RubyGems. This is the easiest way of installing and recommended for most users.

```sh
gem install ninjs
```

For development, clone the project and add bin/ninjs to your path (or my favorite trick which is to put it in my development folder and make symbolic link in /usr/local/bin or wherever you put your scripts):

```sh
git clone git://github.com/textnotspeech/ninjs.git
ln -s ninjs/bin/ninjs /usr/local/bin/ninjs
```

Using the Command Line Application
==================================

The ninjs command line application is a simple way to quickly develop and manage your application. With it you can create an application, generate scaffolding, compile, and upgrade your application.

Create a ninjs application
==========================

The first ninjs command you'll need is the "create" command. As it's name implies, this command creates a brand new ninjs application template, creating the necessary files and directories. The create command accepts two arguments. The first argument is the name of your application object which is required. The second argument, which is optional, is a sub directory in which to install the application. For example, from the root of your project, you may wish to put your application in a "js" or "javascripts" directory (creating the directory if it does not exist). Omitting the directory option will create the application in your current working directory. Here is an example of creating a ninjs application in a sub directory named "js" in the current working directory:

```sh
ninjs create myapplication js
```

This will create a ninjs application in a directory named "js" in the current working directory. Now we can begin developing our application.

Create a ninjs module
=====================

Using the generate command we can create a module scafoold. The generate command takes two arguments, the first is the type of file you'd like to generate (module, elements, or model) and the second is the name of the file/module the scaffold is for. Here's some examples of using the generate command with a module named hello:

```sh
ninjs generate module hello
ninjs generate elements hello
ninjs generate model hello
```

If you'd like to generate a module with elements and a model all in one go you can pass the -e and -m flags respectively:

```sh
ninjs generate module hello -em
````

Although the generate method is very convenient, you may choose to create a module file manually in the /modules directory. By convention the file name ends with a suffix of .module. An example of a module named hello would look like this:

```sh
/modules/hello.module.js
```

The basic functionality of a module is to encapsulate specific pieces of logic into a namespace. You may think of a module as a class in the sense that it allows you to namespace properties and behavior within your application. Typically, a module encapsulates the behavior on a specific page. A ninjs module is an extremely lightweight object with a simple API which helps you write clear, concise code. Here's what an empty module scaffold looks like (generated with ninjs generate model hello -em):
   
```js
(function() {
    var self = myapplication.add_module('hello');
    
    //= require "../models/hello.model"
    //= require "../elements/hello.elements"

    myapplication.hello.actions = function() {

    };

    myapplication.hello.run();
})();
```

Notice the module is wrapped in a closure. This allows us to make a private reference to the current module named "self" due to the fact that the add_module method returns the module it creates. This gives us a consistent way to reference the module without having to use the entire namespace. We may also decide to put private variables and functions available to the module but not exposed to the rest of the application.  

The actions method is the main method of your module. Also known as the composed method pattern, the actions method should simply be a list of other module methods. This makes it easy to scan the actions method to get a sense of what a given module does. It also encourages the "single responsibility principle" (http://en.wikipedia.org/wiki/Single_responsibility_principle).

The run method will execute the actions method when the DOM is ready to be manipulated. This is similar to jQuery's $(document).ready() method. If you wish to execute your modules actions as soon as the script is parsed you may call the execute method instead of run:

```js
myapplication.hello.execute();
```

This pattern allows you to write in a literate style, making your intentions clear and methods succinct. It's idiomatic to use the module namespace (instead of using self) when defining your module methods to enhance clarity. Another advantage of wrapping your modules in a closure is that you may choose to define an alias for your application object which makes it easier to type while avoiding creation of another global variable. To do this, simply pass in the application object as an argument to the outer function and then name the alias in the argument to the closure like so:

```js
(function(app) {
	
    var self = app.add_module('hello');

    app.hello.actions = function() {

    };

    app.hello.run();

})(myapplication);
```

You can also generate a scaffold with an alias using the -a option of the generate command. The previous example can be generated like so:

```sh
ninjs generate module hello -a
```

By default, the alias option will use "app" as the alias. To create a custom alias simply pass the name after the -a option like so:

```sh
ninjs generate module hello -a myalias
```

This will generate a file using an alias defined as "myalias". This is simply a convenience and a bit of syntactic sugar, although there are practical benefits to this as well. For example using this pattern, any module can be ported to another application simply by swapping out the application object passed to the closure.

Let's take a closer look at the "actions" composed method pattern. Let's define a simple module which demonstrates this:
   
```js
(function() {
    var self = myapplication.add_module('hello');

    myapplication.hello.actions = function() {
        self.set_defaults();
        self.say_hello();
    };
    
    myapplication.hello.set_defaults = function() {
        self.greeting = 'Hello';
        self.guest = 'World';
    };
    
    myapplication.hello.say_hello = function() {
        alert(self.get_greeting());
    };
    
    myapplication.get_greeting = function() {
        return self.greeting + ' ' + self.guest + '!';
    };

    myapplication.hello.run();
})();
```

Although the complexity of this module is contrived, we can easily see what this module does simply by glancing at the actions method. This will make your application logic easier to write, understand, modify, and test

Create module elements
======================

Another common best practice that ninjs encourages is cacheing your element selectors. For example, when using jQuery to select a DOM element, it's typical to assign the result of the selection to a variable in case you need it again. Here's what this looks like in practice:
   
```js
// Bad no-caching
$('#some-element').css({ 'background-color': '#FF0000' });
$('#some-element').html("I turned red");

// Good caching
var some_element = $('#some-element');

some_element.css({ 'background-color': '#FF0000' });
some_element.html("I turned red");
```
   
When we cache our selections, we only have to search the DOM once, improving performance.

The only problem with this is that we tend to manipulate a lot of elements and our code can become littered with them. At worst, they're strewn about the file wherever they are used, making it easy to accidentally re-assign them. At best, all selections are cached in one place and easy to see, which prevents us from accidentally caching them twice but it becomes a fair amount of boilerplate that crufts up the file. ninjs goes a step further by putting these cached selectors in their own file in the elements folder. This gives us one place to manage all the cached selectors available to our module.

Elements belong to a module and can be added using the elements method. To add elements to the hello module, let's add a hello.elements.js with the generate command:

```sh
ninjs generate elements hello
```

This will create a hello.elements.js file inside the elements directory. The elements scaffold looks like this:

```js
myapplication.hello.elements({

});
```

The elements method facilitates both setting and getting cached elements (violating the single responsibility principle for convenience). When passed an object, the elements method maps the key/value pairs of name/selector to the modules dom object. When passed a string, the elements method pulls the selector via it's name. To set a module's elements, pass an object of key value pairs like so:

```js
myapplication.hello.elements({
	message_box: $('#message-box')
});
```

Now these cached jQuery selectors will be available via the elements command by passing it's name into the method like so:

```js
myapplication.hello.some_method = function() {
	self.elements('message_box');
};
```

This pattern provides a consistent way to access and create elements and also creates an opportunity to add logic to the process (as in the ninjs.jquery.elements.js plugin). That's all there is to creating module elements. Now we require the file in the module using the "Sprockets require directive" (http://getsprockets.org/installation_and_usage#specifying_dependencies_with_the_require_directive) in hello.module.js. 
   
```js
(function() {
	var self = myapplication.add_module('hello');

	//= require "../elements/hello.elements"

	...
})();
```
   
Be sure to require the elements file after the "add_module" method is called. Now all elements defined in the elements method will be available to the module. Let's take our hello example and instead of alerting the greeting, let's put it in the message_box element (assuming an html page containing this element):
   
```js
...

myapplication.hello.say_hello = function() {
    self.elements('message_box').html(self.get_greeting());
};

...
```
   
Again, this pattern keeps the logic very clear and our code very concise. It's easy to read, test, and refactor. With time, you'll develop your own naming conventions and standards. The important thing is to focus on good semantic names that accurately describe the properties and behavior of your application.

Most modules will be exactly like the one we just created, only with more methods. However, there is one more piece that helps you achieve greater modularity, which is ninjs models.

Create a ninjs model
====================

ninjs models are simply files in the /models directory that define a data structure for the module. Every module has a data object that stores properties for reuse or configuration.

Let's suppose I have a plugin that I want to use in my module. The plugin takes a configuration object, but I want to be able to set a default configuration for my module. I'll use the generate command to create a model:

```sh
ninjs generate model hello
```

This will create an empty model scaffold that looks like this:

```js
myapplication.hello.set_data({
    
});
```

The set_data method takes either an object or a string as the first argument. When an object is used as the first argument, the key value pairs contained in the object will be copied to the module's "data" object. When a string is used, the first argument is a string representing the name of the property to assign and the second is the value to assign to that property. Using the string method, we could define a configuration object for the plugin like so:

```js
myapplication.hello.set_data('plugin_config', {
	width: 300,
	height: 250
});
```

If we wish to set several properties at once we can use just an object as the first argument:

```js
myapplication.hello.set_data({
	plugin_config: {
		width: 300,
		height: 250
	},
	another_property: 'some value'
});
```

Next we include the model in the module file:

```js
(function() {
	var self = myapplication.add_module('hello');

	//= require "../elements/hello.model.js"
	//= require "../elements/hello.elements"

	...
})();
```

Now whenever I use the plugin in my module, I can mix in the config object like so:
   
```js
...

myapplication.hello.setup_plugin = function() {
	self.some_element.some_plugin(self.data.plugin_config);
	self.another_element.some_plugin(self.data.plugin_config);
};

...
```

This way, we don't have to keep redefining the same properties each time we use this plugin. If we want to extend the defaults, we can use something like jQuery's extend method:
   
```js
...

myapplication.hello.setup_plugin = function() {
	self.some_element.some_plugin(self.data.plugin_config);
	self.another_element.some_plugin($.extend(self.data.plugin_config, {
		height: 300,
		color: #FF0000
	}));
};

...
```

The model provides a foundation we can build from, helping use to keep our code DRY.

Compiling the application
=========================

Now that we have a complete module including elements and a model, we need to compile these into one coherent file to use in our html. To do so, we have 2 options. Open up a terminal and navigate to the root of your ninjs application. We can compile our application with one of 2 commands. The first choice is the compile command. From the root of your ninjs application type:

```sh
ninjs compile
```

This will compile all the files in the modules folder, resolving all dependencies using the Sprockets engine, and finally outputting them into the /application directory with the .module suffix removed.  Our hello example module would compile into the application folder as hello.js. Now we can include the hello.js file (along with the myapplication.js) in our html document. Since running compile every time we make a change to any one of our module source files would quickly become a tedious chore, ninjs also has a watch command which will watch your project directory for changes and automatically compile when a file is changed. This speeds up development considerably and frankly makes ninjs usable in a daily development context. To watch a ninjs project simply navigate to the project root and issue the watch command:

```sh
ninjs watch
```

That's it! you've created a basic ninjs application! The only step left is to include the compiled script files in our markup:

```html
    <!DOCTYPE html>
     <head>
        <title>ninjs Demo</title>
    </head>
    <body>
        <script src="js/application/myapplication.js"></script>
        <script src="js/application/hello.js"></script>
    </body>
    </html>
    ...
```