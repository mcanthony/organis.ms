// Generated by CoffeeScript 1.3.3
var utils;

utils = {
  random: function(min, max) {
    if (!(max != null)) {
      max = min;
      min = 0;
    }
    return min + Math.random() * (max - min);
  },
  map: function(num, minA, maxA, minB, maxB) {
    var dA, dB, f;
    dA = maxA - minA;
    dB = maxB - minB;
    f = (num - minA) / dA;
    return minB + f * dB;
  },
  closest: function(target, others) {
    var closest, d, distSq, other, _i, _len;
    distSq = Number.MAX_VALUE;
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      if ((d = target.distSq(other)) < distSq) {
        closest = other;
        distSq = d;
      }
    }
    return closest;
  }
};
