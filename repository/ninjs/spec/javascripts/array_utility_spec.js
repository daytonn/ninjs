describe("Array Extensions", function() {

  it("should test for emptiness with is_empty and not_empty", function() {
    expect([].is_empty()).toBeTruthy();
    expect(['one', 'two', 'three'].is_empty()).toBeFalsy();
    expect(['one', 'two', 'three'].not_empty()).toBeTruthy();
    expect([].not_empty()).toBeFalsy();
  });

  it("should iterate over each element with each", function() {
    var iteration_count = 0,
        test_array_values = [],
        test_array_indices = [];
  
    ['one', 'two', 'three'].each(function(value, index) {
      iteration_count++;
      test_array_values.push(value);
      test_array_indices.push(index);
    });

    expect(test_array_values[0]).toEqual('one');
    expect(test_array_values[1]).toEqual('two');
    expect(test_array_values[2]).toEqual('three');

    expect(test_array_indices[0]).toEqual(0);
    expect(test_array_indices[1]).toEqual(1);
    expect(test_array_indices[2]).toEqual(2);

    expect(iteration_count).toEqual(3);
  });

  it("should test if an array contains an element", function() {
    var array = ['one', 'two', 'three'],
        string = 'hello',
        object = {
          name: 'some object'
        },
        number = 45,
        date = new Date(),
        test_array = [array, string, object, number, date];

    expect(test_array.contains(array)).toBeTruthy();
    expect(test_array.contains(string)).toBeTruthy();
    expect(test_array.contains(object)).toBeTruthy();
    expect(test_array.contains(number)).toBeTruthy();
    expect(test_array.contains(date)).toBeTruthy();
    expect(test_array.contains('not in there')).toBeFalsy();
  });
});