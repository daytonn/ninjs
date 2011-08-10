var spec = new QSpec("Array Extensions"); 

spec.should("test for emptiness with is_empty and not_empty", function() {
	expect(4);
	
	ok([].is_empty(), "[].is_empty() is true");
	equals(['one', 'two', 'three'].is_empty(), false, "['one', 'two', 'three'].is_empty()");
	ok(['one', 'two', 'three'].not_empty(), "['one', 'two', 'three'].not_empty() is false");
	equals([].not_empty(), false, "[].not_empty() is false");
});

spec.should("iterate over each element with each", function() {
	expect(7);
	
	var iteration_count = 0;
	var test_array_values = [];
	var test_array_indices = [];
	
	['one', 'two', 'three'].each(function(value, index) {
		iteration_count++;
		test_array_values.push(value);
		test_array_indices.push(index);
	});
	
	equals(test_array_values[0], 'one', 'value at index 0 is correct');
	equals(test_array_values[1], 'two', 'value at index 1 is correct');
	equals(test_array_values[2], 'three', 'value at index 2 is correct');

	equals(test_array_indices[0], 0, 'first index is correct');
	equals(test_array_indices[1], 1, 'second index is correct');
	equals(test_array_indices[2], 2, 'third index is correct');
	
	equals(iteration_count, 3, 'made only three iterations');
});

spec.should("test if array contains an element", function() {
	var array = ['one', 'two', 'three'];
	var string = 'hello';
	var object = {
		name: 'some object'
	};
	var number = 45;
	var date = new Date();
	
	var test_array = [array, string, object, number, date];
	
	ok(test_array.contains(array), 'array.contains(array)');
	ok(test_array.contains(string), 'array.contains(string)');
	ok(test_array.contains(object), 'array.contains(object)');
	ok(test_array.contains(number), 'array.contains(number)');
	ok(test_array.contains(date), 'array.contains(date)');
	equals(test_array.contains('not in there'), false, 'non-existent value is false');
});

spec.run_all();