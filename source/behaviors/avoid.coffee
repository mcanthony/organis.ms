
class Avoid

    constructor: ( options ) ->

        # Merge options & defaults
        core.extend @, core.defaults options or {},

            # Toggle
            enabled: yes

            # Obstacles
            obstacles: []

            # Ray length
            radius: 200

            # Behavior weighting
            weight: 1.0

            # Apply probability
            chance: 1.0

    apply: ( agent ) ->

        line = ( v1, v2, col, label = '', width = 1 ) ->
            ctx.save()
            ctx.beginPath()
            ctx.translate v1.x, v1.y
            ctx.moveTo 0, 0
            ctx.lineTo v2.x, v2.y
            ctx.closePath()
            ctx.strokeStyle = col
            ctx.lineWidth = width
            ctx.stroke()

            mid = v2.clone().scale 0.5
            ctx.fillStyle = '#ff00ff'
            ctx.fillText label, mid.x + 5, mid.y

            ctx.restore()

        circ = ( pos, rad, col ) ->
            ctx.beginPath()
            ctx.arc( pos.x, pos.y, rad, 0, Math.PI * 2 )
            ctx.closePath()
            ctx.strokeStyle = col
            ctx.lineWidth = 4
            ctx.stroke()

        # Determine whether or not to apply behavior
        return if not @enabled or @chance < 1 and Math.random() > @chance

        # Project a feeler out infront of the agent
        # TODO scale to velocity? (don't normalise first)
        feeler = agent.vel.clone().norm().scale @radius
        feeler.rotate 0.2

        #  BEGIN DEBUG
        line agent, feeler, 'rgba(255,0,255,0.5)', 'v', 5
        # END DEBUG

        for obstacle in @obstacles

            # Location delta
            a = Vector.sub obstacle, agent

            # Project delta onto feeler
            p = Vector.project a, feeler

            b = Vector.sub p, a

            line agent, a, '#00ff00', 'a'
            line obstacle, b, '#ff00ff', 'b'
            line agent, p, '#0000ff', 'p'

            # Feeler of infinite length will intersect obstacle
            intersect = b.mag() < obstacle.radius

            # Feeler of actual length will penetrate obstacle
            intersect = intersect and @radius + obstacle.radius > p.mag()

            if intersect

                circ obstacle, obstacle.radius, '#ff00ff'

                a.rotate -agent.vel.angle()

                line agent, a, '#00ff00', 'a'
                console.log a.norm().x
        ###

        for obstacle in @obstacles

            u = agent.vel.clone().norm()
            v = u.clone().scale @radius # ?
            a = Vector.sub obstacle, agent
            p = ( a.clone().mult u ).mult u
            b = Vector.sub p, a

            #console.log b.mag(), p.mag(), v.mag()

            if b.mag() < obstacle.radius and p.mag() < v.mag()

                line agent, a, '#00ff00', 'a'
                line obstacle, b, '#f0f00f', 'b'
                line agent, p, '#ff0000', 'p'

                # DEBUG
                circ obstacle, obstacle.radius, '#ff00ff'

                w = a.clone().rotate -Math.PI
                w.norm()

                # DEBUG
                line agent, ( w.clone().scale 100 ), '#00ffff'

                m = if a.x < 0 then 1 else -1



        ###




        ###

        for obstacle in @obstacles

            forward = agent.vel.clone().norm()
            delta = Vector.sub obstacle, agent
            dot = delta.dot forward

            if dot < 0

                ray = forward.clone().scale @radius
                pro = forward.clone().scale dot

                dist = delta.mag()

                if dist < obstacle.radius + @radius

                    force = forward.clone().scale agent.maxSpeed

                    HALF_PI = Math.PI / 2
                    theta = HALF_PI * delta.sign agent.vel
                    force.rotate theta

                    force.scale 1 - pro.mag() / ray.mag()
                    agent.acc.add force

                    force.scale 80

                    # BEGIN DEBUG
                    ctx.save()
                    ctx.translate agent.x, agent.y
                    ctx.moveTo 0, 0
                    ctx.lineTo force.x, force.y
                    ctx.strokeStyle = '#ff0000'
                    ctx.stroke()
                    ctx.restore()
                    # END DEBUG

        ###


        ###

        range = Number.MAX_VALUE

        for obstacle in @obstacles

            # Delta between agent & obstacle
            delta = Vector.sub obstacle, agent

            # Compute squared distance
            distSq = do delta.magSq

            # Combined agent, obstacle & look ahead radii
            radii = @radius + obstacle.radius + agent.radius

            # Squared radii to avoid sqrt
            radiiSq = radii * radii

            # Only check objects witin range
            if distSq < radiiSq

                # Compute the dot (scalar) product
                scalar = delta.dot agent.vel

                # Heading is the agent's velocity
                heading = agent.vel.clone()

                offset = delta.sub heading.scale scalar

                ## BEGIN DEBUG
                agent.ctx.save()
                agent.ctx.translate agent.x, agent.y
                agent.ctx.moveTo 0, 0
                agent.ctx.lineTo offset.x, offset.y
                agent.ctx.strokeStyle = '#000'
                agent.ctx.stroke()
                agent.ctx.restore()
                ## END DEBUG

                # Is obstacle in front of agent?
                infront = scalar > 0

                # Compute velocity delta
                steer = offset.scale -1

                # Limit force
                steer.limit agent.maxForce

                # Apply weighting
                steer.scale @weight

                # Apply force
                agent.acc.add steer

                # Is obstacle in front of agent?

        ###





        ###

        # Cast a ray in the direction of the vehicle's velocity
        forward = agent.vel.clone().norm()

        # Process all obstacles
        for obstacle in @obstacles

            # Compute the delta between center points
            delta = Vector.sub obstacle, agent

            # Compute the dot product for projection
            scalar = delta.dot forward

            # True if obstacle is in front
            if scalar > 0

                # Cast a ray forward
                ray = forward.clone().scale @radius

                pro = forward.clone().scale scalar

                # Squared ray length
                rMagSq = do ray.magSq

                # Squared projection ray length
                pMagSq = do pro.magSq

                # Squared distance between agent & obstacle
                distSq = do delta.magSq

                # Combined radius
                radius = obstacle.radius + agent.radius

                # Optimise by calculating squares
                radiusSq = radius * radius

                # Is avoidance response is required
                if distSq < radiusSq and pMagSq < rMagSq

                    console.log +new Date


        ###







        # minDistSq = 999999
        # closest

        # # Find closest obstacle
        # for obstacle in @obstacles

        #     distSq = agent.distSq obstacle

        #     if distSq < minDistSq

        #         closest = obstacle
        #         minDistSq = distSq

