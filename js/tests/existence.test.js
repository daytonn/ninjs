var spec = new QSpec("Existence");

spec.should("test for existence with is_defined", function() {
	var nonexistent;
	var existent = 'I think';
	equals(is_defined(existent), true, 'existent variable is_defined');
	equals(is_defined(nonexistent), false, 'non-existent variable does not exist');
});

spec.should("test for non-existence with is_undefined", function() {
	var existent = 'I think';
	var nonexistent;
	equals(is_undefined(nonexistent), true, 'non-existent variable does not exist');
	equals(is_undefined(existent), false, 'existent variable does exist');
});

spec.should("check the type strictly with is_typeof", function() {
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

spec.should("check for default types", function() {
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

spec.should("determine if a string is a number", function() {
	ok(is_numeric(2), '2 is a number');
	ok(is_numeric(-2), '-2 is a number');
	ok(is_numeric(45.6), '45.6 is a number');
	ok(is_numeric(-45.6), '-45.6 is a number');
	equals(is_numeric('45.6'), true, "'45.6 is a number'");
	equals(is_numeric('Hello'), false, 'Hello is not a number');
});

spec.run_all();