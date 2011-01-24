/*
   File: application.js
   
   Class: NinjsApplication
      An NinjsApplication object serves as your application's namespace and includes a utility to add modules to the application object.

   See Also:
      <NinjsModule>
*/
var NinjsApplication = function() {
	if (is_undefined(window._)) {
		window._ = this;
	}

	if (is_undefined(window.app)) {
		window.app = this;
	}
};

/*
   Method: add_module
      Adds a NinjsModule to the application.
   
   Parameters:
      name - the name of the module
      
   > myapp.add_module('my_module');
*/
NinjsApplication.method('add_module', function(name) {
	try {
		if (is_undefined(name)) {
			throw new SyntaxError("NinjsApplication.add_module(name): name is undefined");
		}

		if (is_defined(this[name])) {
			throw new SyntaxError("NinjsApplication.add_module(name): '" + name + "' already declared");
		}
		this[name] = new NinjsModule(name);
	}
	catch(error) {
		alert(error.message);
	}
});
