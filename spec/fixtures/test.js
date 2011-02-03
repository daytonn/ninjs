MyApplication.add_module('TestModule');

$(document).ready(function() {
	MyApplication.TestModule.test_id = $('#test-element-with-id');
	console.log(MyApplication.TestModule.test_id);
});
MyApplication.test_model = {
	some_data_member: 'some data value'
};

MyApplication.TestModule.actions = function() {
  console.log(MyApplication.TestModule.test_id.html());
};

MyApplication.TestModule.run();
