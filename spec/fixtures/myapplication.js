//-- Ninjs 2011-02-02 22:51:04 -0600  --//
/* File: nin.js */
/* File: extend.js */
/* File: existence.js */
if (is_defined === undefined) {
   /*
      Function: is_defined
         Checks if a variable is undefined.

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:

         <is_undefined>
   */
	var is_defined = function(suspect) {
		return (suspect === undefined) ? false : true;
	};
}

if (!is_defined(is_undefined)) {
   /*
      Function: is_undefined
         Checks if a variable is defined.

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:

         <is_defined>
   */
	var is_undefined = function(suspect) {
		return (suspect === undefined) ? true : false;
	};
}

if (is_undefined(is_typeof)) {
   /*
      Function: is_typeof
         Determine an object's type strictly by comparing constructors.

      Parameters:
         type - The type you expect (ie. String, Number, Array without quotes: is_typeof(String, 'hello'): // true)
         suspect - The variable to check against type

      Returns:
         bool

      See Also:
         <is_numeric>,
         <is_string>,
         <is_array>,
         <is_number>,
         <is_date>,
         <is_bool>,
         <is_regex>
   */
	var is_typeof = function(type, suspect) {
		try {
			if (is_undefined(type)) {
				throw new SyntaxError("is_typeof(Type, suspect): type is undefined");
			}
			if (is_undefined(suspect)) {
				throw new SyntaxError("is_typeof(Type, suspect): suspect is undefined");
			}

			return (suspect.constructor == type) ? true : false;
		}
		catch(error) {
			alert(error.message);
		}
	};
}

if (is_undefined(is_numeric)) {
   /*
      Function: is_numeric
         Determine if the suspect string represents a numeric value.

      Parameters:
         suspect - variable to check for numeric value

      Returns:
         bool

      See Also:
         <is_number>
   */
	var is_numeric = function(suspect) {
		if(is_typeof(Number, suspect)) {
			return true;
		}
		else {
			var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
			return pattern.test(suspect);
		}
	};
}

if (is_undefined(is_string)) {
   /*
      Function: is_string
         Determine the suspect is a String. This is a proxy method for is_typeof(String, suspect).

      Parameters:
         suspect - supect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_array>,
         <is_number>,
         <is_date>,
         <is_bool>,
         <is_regex>
   */
  var is_string = function(suspect) {
    return is_typeof(String, suspect);
  };
}

if (is_undefined(is_array)) {
   /*
      Function: is_array
         Determine if the suspect is an Array. This is a proxy method for is_typeof(Array, suspect).

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_string>,
         <is_number>,
         <is_date>,
         <is_bool>,
         <is_regex>
   */
  var is_array = function(suspect) {
    return is_typeof(Array, suspect);
  };
}

if (is_undefined(is_number)) {
   /*
      Function: is_number
         Determines if the suspect is a Number. This is a proxy method for is_typeof(Number, suspect).

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_string>,
         <is_array>,
         <is_date>,
         <is_bool>,
         <is_regex>
   */
  var is_number = function(suspect) {
    return is_typeof(Number, suspect);
  };
}

if (is_undefined(is_date)) {
   /*
      Function: is_date
         Determines if the suspect is a Date. This is a proxy method for is_typeof(Date, suspect).

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_string>,
         <is_array>,
         <is_number>,
         <is_bool>,
         <is_regex>
   */
  var is_date = function(suspect) {
    return is_typeof(Date, suspect);
  };
}

if (is_undefined(is_bool)) {
   /*
      Function: is_bool
         Determines if the suspect is a Boolean. This is a proxy method for is_typeof(Boolean, suspect).

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_string>,
         <is_array>,
         <is_number>,
         <is_regex>
   */
  var is_bool = function(suspect) {
    return is_typeof(Boolean, suspect);
  };
}

if (is_undefined(is_regex)) {
   /*
      Function: is_regex
         Determines if the suspect is a RegExp. This is a proxy method for is_typeof(RegExp, suspect).

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:
         <is_typeof>,
         <is_numeric>,
         <is_string>,
         <is_array>,
         <is_number>,
         <is_bool>
   */
  var is_regex = function(suspect) {
    return is_typeof(RegExp, suspect);
  };
}

if (is_undefined(Function.prototype['method'])) {
   /*
      Function: method
         Method to add a method to an object (ie. String.method('my_method', my_func); //-> 'hello'.my_func())

      Parameters:
         name - name of the method
         func - function definition

      Returns:
         this === Function

      > String.method('custom_method', function() {
      >    // define custom_method
      > });
      >
      > "hello".custom_method();
   */
	Function.prototype.method = function(name, func) {
		try {
			if (is_undefined(name)) {
				throw new SyntaxError("Object.method(name, func): name is undefined");
			}
			if (is_undefined(func)) {
				throw new SyntaxError("Object.method(name, func): func is undefined");
			}

			if (is_undefined(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		}
		catch(error) {
			alert(error.message);
		}
	};
}
/*
   File: module.js

   Class: NinjsModule
      A NinjsModule is an object which encapsulates a certain behavior or functionality.

   Parameters:
      name - the name of the module

   See Also:
      <NinjsApplication>
*/
var NinjsModule = function(name) {
   /*
      Variable: data
         The module's data object
   */
	this.data = {};
	/*
      Variable: name
         The module's name (string)
   */
	this.name = name;
	/*
      Variable: run_tests (beta)
         Boolean to turn tests on/off
   */
	this.run_tests = false;
	/*
      Variable: tests (beta)
         Array of test files to run
   */
	this.tests = [];
};

/*
   Method: actions
      The actions method contains code to be executed when run is called. This method is a placeholder to be overwritten.

   > MyModule.actions = function() {
   >  // define actions here
   >};
*/
NinjsModule.method('actions', function() {});


/*
   Method: run
      Waits for the DOM to load then calls execute.

   > MyModule.run();
*/
NinjsModule.method('run', function() {
	this.call_on_ready(this.execute);
});

/*
   Method: call_on_ready
      Waits for the DOM to be ready and then executes a callback.

   Parameters:
      callback - function to be called when the DOM is ready

   > MyModule.call_on_ready(function() {
   >    // some code to execute when the DOM is ready
   > });
*/
NinjsModule.method('call_on_ready', function(callback) {
	var timer;
	var module = this;

	function check_ready() {
		timer = setInterval(is_ready, 13);
	}

	function is_ready() {
		if (document && document.getElementsByTagName && document.getElementById && document.body) {
			clearInterval(timer);
			timer = null;
			callback.call(module);
		}
	}

	check_ready();
});

/*
   Method: execute
      Wrapper method that set's up the environment and then calls actions.

   > MyModule.execute();
*/
NinjsModule.method('execute', function() {
	this.old__ = is_defined(window.__) ? window.__ : undefined;
	window.__ = this;

	if (this.run_tests) {
		this._run_tests();
	}
	this.actions();

	if(is_defined(this.old__)) {
		window.__ = this.old__;
	}
});

/*
   Method: elements
      Method to define module elements.

   Parameters:
      callback - function to define a module's elements

   > MyModule.elements(function() {
   >    // element definitions go here
   > });
*/
NinjsModule.method('elements', function(callback) {
	this.old__ = is_defined(window.__) ? window.__ : undefined;
	window.__ = this;

	this.call_on_ready(callback);

	if(is_defined(this.old__)) {
		window.__ = this.old__;
	}
});


/*
   Method: set_data
      Adds properties to the module's data object.

   Parameters:
      key - string or object (if string = key, if object sets multiple properties)
      value - value of key if key is string

   > MyModule.set_data('some_key', 'some_value');
   > MyModule.data.some_key === 'some_value'

   > MyModule.set_data({
   >    'property_one': 'value_one',
   >    'property_two': 'value_two'
   > });
   > MyModule.data.property_one === 'value_one'
   > MyModule.data.property_two === 'value_two'
*/
NinjsModule.method('set_data', function(key, value) {
	try {
		if (is_undefined(key)) {
			throw new SyntaxError('NinjsModule.set_data(key, value): key is undefined');
		}

		if (is_typeof(String, key) && is_undefined(value)) {
			throw new SyntaxError('NinjsModule.set_data(key, value): value is undefined');
		}

		if (is_typeof(String, key)) {
			this.data[key] = value;
		}
		else if (is_typeof(Object, key)) {
			var data = key;
			for(var property in data) {
				this.data[property] = data[property];
			}
		}

		return this;
	}
	catch(error) {
		alert(error.message);
	}
});

/*
   Method: add_test
      Adds a test file to the tests array (beta).

   Parameters:
      test_file - File to add to the tests array

   > MyModule.add_test('mytest.test.js');
*/
NinjsModule.method('add_test', function(test_file) {
	this.tests.push(test_file);
});

/*
   Method: _run_tests
      Runs the test files in the test array. This method is automatically called by the execute method if run_tests === true
*/
NinjsModule.method('_run_tests', function() {
	var test_template = [];
	test_template.push('<div class="test-results" title="Test Results">');
	test_template.push('<h1 id="qunit-header">' + this.name + ' module tests</h1>');
	test_template.push('<h2 id="qunit-banner"></h2>');
	test_template.push('<h2 id="qunit-userAgent"></h2>');
	test_template.push('<ol id="qunit-tests"></ol>');
	test_template.push('</div>');

	var qunit_dependencies = '<script src="' + _.tests_path +'qunit/qunit.js"></script>';
	$.getScript(_.tests_path + 'qunit/qunit.js');
	var qunit_styles = '<link rel="stylesheet" href="' + _.tests_path + 'qunit/qunit.css">';
	$('body').append(qunit_styles);
	$('body').append(test_template.join("\n"));

	this.tests.each(function(test) {
		$.getScript(_.tests_path + test + '.test.js', function() {
			var test_results_dialog = $('.test-results');
			var height = $(window).height() - 200;
			var width = $(window).width() - 300;
			try {
				test_results_dialog.dialog({
					width: width,
					height: height,
					autoOpen: false,
					buttons: {
						"Thanks buddy": function() {
							test_results_dialog.dialog('close');
						}
					}
				});
				var failed = $('.failed');
				console.log(failed.html());
				test_results_dialog.dialog('open');
			}
			catch(error) {
				alert("Test harness requires jQueryUI");
			}
		});
	});
});
/*
   File: application.js

   Class: NinjsApplication
      An NinjsApplication object serves as your application's namespace and includes a utility to add modules to the application object.

   See Also:
      <NinjsModule>
*/
var NinjsApplication = function(base_url, tests_path) {
	if (is_undefined(window._)) {
		window._ = this;
	}

	if(is_defined(tests_path)) {
		this.tests_path = tests_path;
	}

	if(is_defined(base_url)) {
		this.site_url = function(path) {
			var path = path || '';
			return base_url + path;
		}
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

var MyApplication = new NinjsApplication('http://www.example.com/', 'tests/');