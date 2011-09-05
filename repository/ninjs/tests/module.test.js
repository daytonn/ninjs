var spec = new QSpec('NinjsModule');

spec.should('return the module when adding a module', function() {
  var test_app = new NinjsApplication('myapp');
  var module = test_app.add_module('mymod');
  console.log(module);
  equals(module, test_app.mymod, 'returns the module when adding a module');
});

spec.should("have the correct defaults", function() {
  var testapp = new NinjsApplication();
  testapp.add_module('testmodule');
  
  // properties
  ok(is_defined(testapp.testmodule.data), "testapp.testmodule.data is defined");
  ok(is_defined(testapp.testmodule.name), 'testapp.testmodule.name is defined');
  equals(testapp.testmodule.name, 'testmodule', 'testapp.testmodule.name is correct');
  
  // methods
  ok(is_defined(testapp.testmodule.actions), 'testapp.testmodule.actions is defined');
  ok(is_typeof(Function, testapp.testmodule.actions), "testapp.testmodule.actions is a valid Function");
  ok(is_defined(testapp.testmodule.run), 'testapp.testmodule.run is defined');
  ok(is_typeof(Function, testapp.testmodule.run), "testapp.testmodule.run is a valid Function");
  ok(is_defined(testapp.testmodule.execute), 'testmodule.testapp.execute is defined');
  ok(is_defined(testapp.testmodule.elements), 'testapp.testmodule.elements is defined');
  ok(is_defined(testapp.testmodule.set_data), 'testapp.testmodule.set_data is defined');
});

spec.run_all();

// Qunit waits for DOM to load before running tests
// to test DOM wait feature, we need to run some code outside the tests
(function() {
  var spec = new QSpec('NinjsModule');
  
  var testapp = new NinjsApplication();
  testapp.add_module('testmodule'); 
  testapp.testmodule.actions = function() {
    // append an element to be sure the DOM is ready for manipulation and test for the element's existence
    $('body').append('<div id="made-by-actions"/>');
    
    spec.should("run the module actions", function() { 
      equals($('#made-by-actions').length, 1,'testapp.test.actions ran after DOM was ready');
    });
    
    spec.run_all();
  };
  
  testapp.testmodule.run();
}());

// Qunit waits for DOM to load before running tests
// to test DOM wait feature, we need to run some code outside the tests
(function() {
  spec.should('set elements', function() {
    this.app = new NinjsApplication('myapp');
    var mod = this.app.add_module('mymod');
    
    
    mod.dom.ready(function() {
      mod.elements({
        body: $('body')
      });
      
      equals(mod.elements('body').length, 1, 'mod.elements("body") has length of 1');
      equals(mod.elements('body').text(), $('body').text(), 'mod.elements("body").text() = $("body").text()');
    });
  });
  
  spec.run_all();
}());