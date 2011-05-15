/* File: extend.js */
//= require "existence"

if (is_undefined(Function.prototype['method'])) {
   /*   
      Function: method
         Method to add a method to an object (ie. String.method('my_method', my_func); // 'hello'.my_method())

      Parameters:
         name - name of the method
         func - function definition

      Returns:
         this (chainable)
         
      > String.method('custom_method', function() {
      >    // define custom_method
      > });
      >
      > "hello".custom_method();
   */
	Function.prototype.method = function(name, func) {
		if (is_undefined(name)) {
			throw new SyntaxError("Object.method(name, func): name is undefined");
		}
		
		if (is_undefined(func)) {
			throw new SyntaxError("Object.method(name, func): func is undefined");
		}

		if (is_undefined(this.prototype[name])) {
			this.prototype[name] = func;
			return this;
		}
	};
}

if (is_undefined(unless)) {
   /*   
      Function: unless
         Function to better express negative conditions (ie. if (!something))

      Parameters:
         expression - expression to be tested
         callback - function to be executed unless expression is true (see how that works)
         fallback - function to be executed if the expression is false (optional)

      Returns:
         undefined
         
      > unless(test_expression === 'some condition',
      >   function() {
      >         alert('we do something');
      >    },
      >    function() {
      >        alert('we can do something if it meets the condition too');
      >    }
      > );
   */
   var unless = function(expression, callback, fallback) {
		if (is_undefined(expression)) {
			throw new SyntaxError("unless(expression, callback[, fallback]): expression is undefined");
		}

		if (is_undefined(callback)) {
			throw new SyntaxError("unless(expression, callback[, fallback]): callback is undefined");
		}

		// This kind of expression is exactly why we NEED unless
		if (!expression) {
			callback.call(this);
		}
		else if (is_defined(fallback)) {
			fallback.call(this);
		}
   };
}