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
		$.getScript('tests/' + some + '.test.js', function() {
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

NinjsModule.method('execute', function() {
	this.__ = is_defined(window.__) ? window.__ : undefined;
	window.__ = this;
	if (this.run_tests) {
		this._run_tests();
	}
	this.actions();
	window.__ = is_defined(this.__) ? this.__ : undefined;
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

NinjsModule.method('run', function() {
	this.call_on_ready(this.execute);
});

NinjsModule.method('elements', function(callback) {
	this.call_on_ready(callback);
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
			this.data = data;
		}
		
		return this;
	}
	catch(error) {
		alert(error.message);
		return false;
	}
});

var NinjsApplication = function() {
	if (is_undefined(window._)) {
		window._ = this;
	}
	
	if (is_undefined(window.app)) {
		window.app = this;
	}
};

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
