/* File: existence.js */
if (is_defined === undefined) {
   /*
      Function: is_defined
         Checks if a variable is undefined. This is a convenience method to enhance clarity in your conditions.

      Parameters:
         suspect - suspect variable to test

      Returns:
         bool

      See Also:

         <is_undefined>
   */
	var is_defined = function(suspect) {	
		return ((suspect === undefined) || (suspect === null)) ? false : true;
	};
}

if (!is_defined(is_undefined)) {
   /*
      Function: is_undefined
         Checks if a variable is defined. This is a convenience method to enhance clarity in your conditions.

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
         Strict type checking by comparing constructors.
         (Pro Javascript Techniques, John Resig, Apress p.24 Listing 2-8: Example of using the constructor property to determine the type of an object http://amzn.to/fTsDRg)
      Parameters:
         type - The type you expect (ie. String, Number, Array (note: without quotes): is_typeof(String, 'hello'): // true)
         suspect - The suspect variable to check against type

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
		if (is_undefined(type)) {
			throw new SyntaxError("is_typeof(Type, suspect): type is undefined");
		}
		if (is_undefined(suspect)) {
			throw new SyntaxError("is_typeof(Type, suspect): suspect is undefined");
		}

		return (suspect.constructor == type) ? true : false;
	};
}

if (is_undefined(is_numeric)) {
   /*
      Function: is_numeric
         Determine if the suspect string represents a numeric value.
         (JavaScript: The Good Parts, Douglas Crockford, O'Reilly p.69 Chapter 7: Regular Expressions An Example)
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
