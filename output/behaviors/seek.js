// Generated by CoffeeScript 1.3.3
var Seek;

Seek = (function() {

  function Seek(options) {
    core.extend(this, core.defaults(options || {}, {
      enabled: true,
      target: new Vector(),
      braking: 100,
      radius: 999999,
      weight: 1.0,
      chance: 1.0
    }));
  }

  Seek.prototype.apply = function(agent) {
    var brakingSq, desired, distanceSq, radiusSq, steer;
    if (!this.enabled || this.chance < 1 && Math.random() > this.chance) {
      return;
    }
    desired = Vector.sub(this.target, agent);
    distanceSq = desired.magSq();
    radiusSq = this.radius * this.radius;
    if (distanceSq > 0.000001 && distanceSq < radiusSq) {
      desired.norm();
      brakingSq = this.braking * this.braking;
      if (distanceSq < brakingSq) {
        desired.scale(utils.map(distanceSq, 0, brakingSq, 0, agent.maxSpeed));
      } else {
        desired.scale(agent.maxSpeed);
      }
      steer = Vector.sub(desired, agent.vel);
      steer.scale(this.weight);
      return agent.acc.add(steer);
    }
  };

  return Seek;

})();
