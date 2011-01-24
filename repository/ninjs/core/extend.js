/* File: extend.js */
//= require "existence"

if (is_undefined(Function.prototype['method'])) {
   /*   
      Function: method
         Method to add a method to an object (ie. String.method('my_method', my_func); //-> 'hello'.my_func())

      Parameters:
         name - name of the method
         func - function definition

      Returns:
         this === Function
         
      > String.method('custom_method', function() {
      >    // define custom_method
      > });
      >
      > "hello".custom_method();
   */
	Function.prototype.method = function(name, func) {
		try {
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
		}
		catch(error) {
			alert(error.message);
		}
	};
}