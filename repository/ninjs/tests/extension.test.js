var spec = new QSpec("Extensions");

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