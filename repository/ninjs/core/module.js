var NinjsModule = function(name) {
	this.dom = {};
	this.data = {};
	this.name = name;
	this.run_tests = false;
	this.tests = [];
};

NinjsModule.method('actions', function() {});

NinjsModule.method('run', function() {
	this.call_on_ready(this.execute);
});

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

NinjsModule.method('execute', function() {	
	if (this.run_tests) {
		this._run_tests();
	}
	
	this.actions();
});

NinjsModule.method('elements', function(elements) {
	try {
		if (is_undefined(elements)) {
		   if (is_typeof(Object, elements)) {
		      throw new SyntaxError("NinjsModule.elements(elements): elements is undefined");
		   }
		   else if (is_string(elements)) {
		      throw new SyntaxError("NinjsModule.elements(name): name is undefined");
		   }
		}
		
		// If first argument is a string, retrieve the element
		if (is_string(elements)) {
			var name = elements;
			return is_defined(this.dom[name]) ? this.dom[name] : undefined;
		}
		// Set elements
		else {
			this.call_on_ready(function() {
				for(var key in elements) {
					if (elements.hasOwnProperty(key)) {
						this.dom[key] = elements[key];
					}
				}
			});
		}
	}
	catch(error) {
		alert(error.message);
	}
	
});

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

NinjsModule.method('add_test', function(test_file) {
	this.tests.push(test_file);
});

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
