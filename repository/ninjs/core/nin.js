//= require "extend"

var NinjsModule = function(name) {
	this.data = {};
	this.run_tests = false;
	this.tests = [];
	this.name = name;
};

NinjsModule.method('actions', function() {});

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
	
	$('body').append(test_template.join("\n"));
	
	this.tests.each(function(test) {
		$.getScript('http://localhost/jexample/js/tests/some.test.js', function() {
			var test_results_dialog = $('.test-results');
			var height = test_results_dialog.height() + 130;
			var width = $(window).width() - 300;
			var maxHeight = $(window).height() - 200;
			try {
				test_results_dialog.dialog({
					width: width,
					height: height,
					maxHeight: maxHeight,
					buttons: {
						"Thanks buddy": function() {
							test_results_dialog.dialog('close');
						}
					}
				});
			}
			catch(error) {
				alert("Test harness requires jQueryUI");
			}
		});
	});
});

NinjsModule.method('run', function() {
	if(this.run_tests) {
		this._run_tests();
	}
	this.actions();
});

NinjsModule.method('set_data', function(key, value) {
	try {
		if(is_undefined(key)) {
			throw new SyntaxError('NinjsModule.set_data(key, value): key is undefined');
		}
		if(is_typeof(String, key) && is_undefined(value)) {
			throw new SyntaxError('NinjsModule.set_data(key, value): value is undefined');
		}
		
		if(is_typeof(String, key)) {
			this.data[key] = value;
		}
		else if(is_typeof(Object, key)) {
			var data = key;
			for(var property in data) {
				if(!this.data.hasOwnProperty(property)) {
					this.data[property] = key[property];
				}
			}
		}
		
		return this;
	}
	catch(error) {
		alert(error.message);
		return false;
	}
});

var NinjsApplication = function() {};

NinjsApplication.method('add_module', function(name) {
	try {
		if (is_undefined(name)) {
			throw new SyntaxError("NinjsApplication.add_module(name): name is undefined");
		}
		
		if (is_defined(this[name])) {
			throw new SyntaxError("NinjsApplication.add_module(name): '" + name + "' already declared");
		}
		
		this[name] = new NinjsModule();
	}
	catch(error) {
		alert(error.message);
	}
});