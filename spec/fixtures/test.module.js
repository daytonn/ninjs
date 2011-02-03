MyApplication.add_module('TestModule');

//= require "../elements/test.elements.js"
//= require "../models/test.model.js"

MyApplication.TestModule.actions = function() {
  console.log(MyApplication.TestModule.test_id.html());
};

MyApplication.TestModule.run();
