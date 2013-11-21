// Generated by CoffeeScript 1.6.3
(function() {
  var generateLi, linda, reloadList, ts,
    _this = this;

  linda = new Linda();

  ts = new linda.TupleSpace("stock");

  linda.io.on("connect", function() {
    ts.list([], function(tuples) {
      return reloadList(tuples);
    });
    return ts.watch([], function(tuple) {
      return ts.list([], reloadList);
    });
  });

  reloadList = function(tuples) {
    var li, tuple, ul, _i, _len;
    console.log(tuples);
    ul = $("#list");
    ul.empty();
    for (_i = 0, _len = tuples.length; _i < _len; _i++) {
      tuple = tuples[_i];
      console.log(tuple);
      li = generateLi(tuple[0]);
      ul.append(li);
    }
    return ul.listView("refresh");
  };

  generateLi = function(n) {
    var a, li, name;
    li = $("<li>");
    a = $("<a>");
    name = $("<span>").html("" + n + "　がない！");
    li.append($("<a>").append(name));
    li.bind("click", function() {
      var _this = this;
      return ts.take([n], function(t) {
        $("#list").empty(i);
        return ts.list([], reloadList);
      });
    });
    return li;
  };

}).call(this);
