// Generated by CoffeeScript 1.3.3
var Obstacle,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Obstacle = (function(_super) {

  __extends(Obstacle, _super);

  function Obstacle(options) {
    Obstacle.__super__.constructor.call(this, 0.0, 0.0);
    core.extend(this, core.defaults(options || {}, {
      radius: 10
    }));
  }

  return Obstacle;

})(Vector);
