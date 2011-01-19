module("existence tests");

test("existence sanity check", function() {
	ok(is_defined !== undefined, 'is_defined is defined');
	ok(is_undefined !== undefined, 'is_undefined is defined');
	ok(is_typeof !== undefined, 'is_typeof is defined');
});

test("can test for existence", function() {
	var nonexistent;
	var existent = 'I think';
	equals(is_defined(existent), true, 'existent variable is_defined');
	equals(is_defined(nonexistent), false, 'non-existent variable does not exist');
});

test("can test for non-existence", function() {
	var existent = 'I think';
	var nonexistent;
	equals(is_undefined(nonexistent), true, 'non-existent variable does not exist');
	equals(is_undefined(existent), false, 'existent variable does exist');
});

test("can check the type strictly with is_typeof", function() {
	var foo = function(){};
	var bar = {
		name: 'SomeObject',
		method: function() {}
	};
	var SomeClass = function(){};
	var some_instance = new SomeClass();
	equals(is_typeof(Number, 4), true, 'can check against Number');
	equals(is_typeof(String, 'Hello World'), true, 'can check against String');
	equals(is_typeof(Array, ['one', 'two', 'three']), true, 'can check against Array');
	equals(is_typeof(Function, foo), true, 'can check against Function');
	equals(is_typeof(Object, bar), true, 'can check against Object');
	equals(is_typeof(RegExp, /pattern/), true, 'can check against Regexp');
	equals(is_typeof(SomeClass, some_instance), true, 'can check against custom object');
});

module("typeof proxys");

test("can check for default types", function() {
	var today = new Date();
	var easy_as = [1,2,3];
	var pattern = new RegExp(/pattern/);
	
	ok(is_string('hello'), 'hello is_string');
	ok(is_number(42), '42 is_number');
	ok(is_array(easy_as), 'easy_as is_array');
	ok(is_bool(false), 'false is_bool');
	ok(is_date(today), 'today is_date');
	ok(is_regex(pattern), 'pattern is_regex');
	
	equals(is_regex('hello'), false, 'hello fails is_regex');
	equals(is_date(42), false, '42 fails is_date');
	equals(is_bool(easy_as), false, 'easy_as fails is_bool');
	equals(is_array(today), false, 'today fails is_array');
	equals(is_number(true), false, 'true fails is_number');
	equals(is_string(pattern), false, 'pattern fails is_string');
});

test("can determine a number", function() {
	ok(is_numeric(2), '2 is a number');
	ok(is_numeric(-2), '-2 is a number');
	ok(is_numeric(45.6), '45.6 is a number');
	ok(is_numeric(-45.6), '-45.6 is a number');
	equals(is_numeric('45.6'), true, "'45.6 is a number'");
	equals(is_numeric('Hello'), false, 'Hello is not a number');
});

module("extend tests");

test("can add a method to the prototype", function() {
	ok(is_defined(Function.prototype.method), "Object.prototype.method is defined");
	
	String.method('test_method', function() {
		return 'This is a test';
	});
	
	equals('Hello'.test_method(), 'This is a test', 'can create a prototype method with method');
});

module("Ninjs application tests");

test("can create a ninjs application object", function() {
	var testapp = new NinjsApplication();
	ok(is_defined(testapp), 'testapp is defined');
	ok(is_typeof(NinjsApplication, testapp), 'testapp is a valid NinjsApplication');
});

test("can create a NinjsModule", function() {
	var testapp = new NinjsApplication();
	testapp.add_module('testmodule');
	ok(is_defined(testapp.testmodule), 'testapp.testmodule is defined');
	ok(is_typeof(NinjsModule, testapp.testmodule), 'testapp.testmodule is a valid NinjsModule');
});

module('Ninjs Module tests');

test("module defaults", function() {
	var testapp = new NinjsApplication();
	testapp.add_module('testmodule');
	
	// properties
	ok(is_defined(testapp.testmodule.run_tests), 'testapp.testmodule.run_tests is defined');
	equals(testapp.testmodule.run_tests, false, 'testapp.testmodule.run_tests defaults to false');
	ok(is_defined(testapp.testmodule.data), "testapp.testmodule.data is defined");
	ok(is_defined(testapp.testmodule.name), 'testapp.testmodule.name is defined');
	equals(testapp.testmodule.name, 'testmodule', 'testapp.testmodule.name is correct');
	ok(is_defined(testapp.testmodule.tests), 'testapp.testmodule.tests is defined');
	ok(is_array(testapp.testmodule.tests), 'testapp.testmodule.tests is_array');
	ok(testapp.testmodule.tests.is_empty(), 'testapp.testmodule.tests is empty');
	ok(is_defined(_), '_ is defined');
	ok(is_defined(_.testmodule), '_.testmodule is defined');
	
	// methods
	ok(is_defined(testapp.testmodule.actions), 'testapp.testmodule.actions is defined');
	ok(is_typeof(Function, testapp.testmodule.actions), "testapp.testmodule.actions is a valid Function");
	ok(is_defined(testapp.testmodule.run), 'testapp.testmodule.run is defined');
	ok(is_typeof(Function, testapp.testmodule.run), "testapp.testmodule.run is a valid Function");
	ok(is_defined(testapp.testmodule.call_on_ready), 'testmodule.testapp.call_on_ready is defined');
	ok(is_defined(testapp.testmodule.execute), 'testmodule.testapp.execute is defined');
	ok(is_defined(testapp.testmodule.elements), 'testapp.testmodule.elements is defined');
	ok(is_defined(testapp.testmodule.set_data), 'testapp.testmodule.set_data is defined');
});

// Qunit waits for DOM to load before running tests
// to test DOM wait feature, we need to run some code outside the tests
(function() {
	var testapp = new NinjsApplication();
	testapp.add_module('testmodule');	
	testapp.testmodule.actions = function() {
		// append an element to be sure the DOM is ready for manipulation and test for the element's existence
		$('body').append('<div id="made-by-actions"/>');
		
		test("Ninjs module can run actions", function() { 
			equals($('#made-by-actions').length, 1,'testapp.test.actions ran after DOM was ready');
			ok(is_defined(__, '__ is defined'));
			equals(__.name, 'testmodule', '__ is testmodule');
		});
	};
	
	testapp.testmodule.run();
}());

// Qunit waits for DOM to load before running tests
// to test DOM wait feature, we need to run some code outside the tests
(function() {
	var testapp = new NinjsApplication();
	testapp.add_module('testmodule');	
	testapp.testmodule.elements(function() {
		testapp.testmodule.qunit_header = $('#qunit-header');
		testapp.testmodule.qunit_banner = $('#qunit-banner');
		
		test('Ninjs module can cache elements', function() {
			equals(testapp.testmodule.qunit_header[0].tagName, 'H1', '#qunit-header returns an h1');
			equals(testapp.testmodule.qunit_banner[0].tagName, 'H2', '#qunit-banner returns an h2');
		});
	});
}());