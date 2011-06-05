var spec = new QSpec("string utility tests");

spec.should("test for emptiness with is_empty and not_empty", function() {
	ok(''.is_empty(), "''.is_empty() is true");
	equals('hey there'.is_empty(), false, "'hey there'.is_empty() is false");
	ok('hey there'.not_empty(), "'hey there'.not_empty() is false");
	equals(''.not_empty(), false, "''.not_empty() is false");
});

spec.should('test for numeric value', function() {
	equals('34'.is_numeric(), true, "34 is numeric");
	equals('0.5'.is_numeric(), true, ".5 is numeric");
	equals('-34'.is_numeric(), true, '-34 is numeric');
	equals('-0.5'.is_numeric(), true, '-.05 is numeric');
	equals('hello'.is_numeric(), false, 'hello is numeric');
});

spec.should('trim a string with trim, ltrim, and rtrim', function() {
	equals(' hello '.trim(), 'hello', "' hello '.trim()");
	equals(' hello '.ltrim(), 'hello ', "' hello '.ltrim()");
	equals(' hello '.rtrim(), ' hello', "' hello '.rtrim()");
});

spec.should("iterate over each character with each", function() {
	var iteration_count = 0;
	var test_chars = [];
	var test_indices = [];
	'123'.each(function(character, index) {
		test_chars.push(character);
		test_indices.push(index);
		iteration_count++;
	});
	
	equals(test_chars[0], '1', 'first character of 123 is 1');
	equals(test_chars[1], '2', 'second character of 123 is 2');
	equals(test_chars[2], '3', 'second character of 123 is 3');
	
	equals(test_indices[0], 0, 'first index is correct');
	equals(test_indices[1], 1, 'second index is correct');
	equals(test_indices[2], 2, 'third index is correct');
	
	equals(iteration_count, 3, 'made only three iterations');
});

spec.should('capitalize a string with capitalize', function() {
	equals('hello world'.capitalize(), 'Hello world', 'capitalized string correctly');
});

spec.should('reverse a string with reverse', function() {
	equals('hello world'.reverse(), 'dlrow olleh', 'reversed string correctly');
	equals('satan oscillate my metallic sonatas'.reverse(), 'satanos cillatem ym etallicso natas', 'fucking palindromes, how do they work?');
});

spec.should("convert to number", function() {
	var whole_number = '32';
	var decimal = '0.08';
	var negative_number = '-32';
	var negative_float = '-0.08';
	
	same(whole_number.to_n(), 32, "whole_number.to_n() is 32");
	same(decimal.to_n(), 0.08, "decimal.to_n() is 0.08");
	same(negative_number.to_n(), -32, "negative_number.to_n() is -32");
	same(negative_float.to_n(), -0.08, "negative_float.to_n() -0.08");
}); 

spec.should("pluck all instances of a sub-string within a string ", function() {
	equals('one, two, three'.pluck(','), 'one two three', "'one, two, three'.pluck(',')");
});

spec.should("compress a string to single spaces", function() {
	var hard_space = 'one&nbsp;two&nbsp;&nbsp;three&nbsp;&nbsp;&nbsp;four&nbsp;&nbsp;&nbsp;&nbsp;five&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;six';
	var soft_space = 'one two  three   four    five     six';
	var mixed_space = 'one two &nbsp; three &nbsp;&nbsp;four &nbsp;&nbsp;&nbsp;five &nbsp;&nbsp;&nbsp;&nbsp;six';
	
	equals(hard_space.single_space(), 'one two three four five six', 'correctly spaced &nbsp;');
	equals(soft_space.single_space(), 'one two three four five six', "correctly spaced soft spaces");
	equals(mixed_space.single_space(), 'one two three four five six', "correctly spaced mixed spaces");
});

spec.should("compress a string, removing all whitespace", function() {
	var string = "satan\n\t oscillate\n\t my\n\t metallic\n sonatas";
	same(string.compress(), 'satanoscillatemymetallicsonatas', "string is compressed correctly");
});

spec.run_all();