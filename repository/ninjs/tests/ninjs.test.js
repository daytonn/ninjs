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
	var FauxClass = function(){};
	var fauxinstance = new FauxClass();
	equals(is_typeof(Number, 4), true, 'can check against Number');
	equals(is_typeof(String, 'Hello World'), true, 'can check against String');
	equals(is_typeof(Array, ['one', 'two', 'three']), true, 'can check against Array');
	equals(is_typeof(Function, foo), true, 'can check against Function');
	equals(is_typeof(Object, bar), true, 'can check against Object');
	equals(is_typeof(RegExp, /^_*/), true, 'can check against Regexp');
	equals(is_typeof(FauxClass, fauxinstance), true, 'can check against custom object');
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
	ok(is_defined(Object.prototype.method), "Object.prototype.method is defined");
	
	String.method('test_method', function() {
		return 'This is a test';
	});
	
	equals('Hello'.test_method(), 'This is a test', 'can create a prototype method with method');
});

test("can clone something", function() {
	var object = {
		hello: 'world',
		simple: 'object'
	};

	var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, object, 'one', 'two', 'three', 'four', 'five'];
	
	var clone_object = object.clone();
	var clone_array = array.clone();

	ok(object !== clone_object, 'cloned object is not a reference');
	ok(array !== clone_array, 'cloned array is not a reference');
	
	same(object, clone_object, "object successfully cloned");
	same(array, clone_array, "array successfully cloned");
});

module("Judo application tests");

test("can create a judo application object", function() {
	var MyApp = new JudoApplication();
	ok(is_defined(MyApp), 'MyApp is defined');
	ok(is_typeof(JudoApplication, MyApp), 'MyApp is a valid JudoApplication');
});

test("can create a JudoModule", function() {
	var MyApp = new JudoApplication();
	MyApp.add_module('Test');
	ok(is_defined(MyApp.Test), 'MyApp.Test is defined');
	ok(is_typeof(JudoModule, MyApp.Test), 'MyApp.Test is a valid Judo Module');
});

module('Judo Module tests');

test("can add actions to module", function() {
	var MyApp = new JudoApplication();
	MyApp.add_module('Test');
	ok(is_defined(MyApp.Test.actions), 'MyApp.Test.actions is defined');
	ok(is_typeof(Function, MyApp.Test.actions), "MyApp.Test.actions is a valid Function");
	ok(is_defined(MyApp.Test.run), 'MyApp.Test.run is defined');
	ok(is_typeof(Function, MyApp.Test.run), "MyApp.Test.run is a valid Function");
	
	MyApp.Test.actions = function() {
		ok(true, 'MyApp.Test.actions ran');
	};
	
	MyApp.Test.run();
});