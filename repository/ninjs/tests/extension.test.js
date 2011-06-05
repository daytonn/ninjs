var spec = new QSpec("Extensions");

spec.should("add 'method' to the Function prototype", function() {
	ok(is_defined(Function.prototype.method), "Object.prototype.method is defined");
	
	String.method('test_method', function() {
		return 'This is a test';
	});
	
	equals('Hello'.test_method(), 'This is a test', 'can create a prototype method with method');
});

spec.should("test a condition with unless", function() {
   var is_true = false;
   
   unless (false,
      function() {
         is_true = true;
      }
   );
   
   ok(is_true, "unless works");
   
   var does_fallback_work = false;
   
   unless (true,
      function() {
      
      },
      function() {
         does_fallback_work = true;
      }
   );
   
   ok(does_fallback_work, 'fallback works');
});

spec.run_all();