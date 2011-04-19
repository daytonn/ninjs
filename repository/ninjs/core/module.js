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
	if (this.run_tests) {
		this._run_tests();
	}
	
	this.actions();
});

/*
   Method: elements
      Method to define and retreive module elements.
      
   Parameters:
      elements or name - If the argument is an object, it will add elements to the module, if the argument is a string, it will retreive the element by name
      
   > MyModule.elements({
   >    some_element: $('#some-element'),
   >    another_element: $('#another-element')
   > });
   >
   > MyModule.elements('some_element');
*/
NinjsModule.method('elements', function(elements) {
	try {
		if (is_undefined(elements)) {
			throw new SyntaxError("NinjsModule.elements(elements): elements is undefined");
		}
		
		if (is_string(elements)) {
			var name = elements;
			return is_defined(this[name]) ? this[name] : undefined;
		}
		else {
			this.call_on_ready(function() {
				for(var key in elements) {
					if (elements.hasOwnProperty(key)) {
						this[key] = elements[key];
					}
				}
			});
		}
	}
	catch(error) {
		alert(error.message);
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
