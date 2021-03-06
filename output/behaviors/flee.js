// Generated by CoffeeScript 1.3.3
var Flee;

Flee = (function() {

  function Flee(options) {
    core.extend(this, core.defaults(options || {}, {
      enabled: true,
      target: new Vector(),
      radius: 100,
      weight: 1.0,
      chance: 1.0
    }));
  }

  Flee.prototype.apply = function(agent) {
    var desired, distanceSq, radiusSq, steer;
    if (!this.enabled || this.chance < 1 && Math.random() > this.chance) {
      return;
    }
    desired = Vector.sub(agent, this.target);
    distanceSq = desired.magSq();
    radiusSq = this.radius * this.radius;
    if (distanceSq < radiusSq) {
      desired.norm();
      desired.scale(utils.map(distanceSq, radiusSq, 0, 0, agent.maxSpeed));
      steer = Vector.sub(desired, agent.vel);
      steer.scale(this.weight);
      return agent.acc.add(steer);
    }
  };

  return Flee;

})();
