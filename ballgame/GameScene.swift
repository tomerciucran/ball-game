//
//  GameScene.swift
//  ballgame
//
//  Created by Tomer Ciucran on 9/18/16.
//  Copyright © 2016 tomerciucran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKShapeNode(circleOfRadius: 20.0)
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
//        var ropeSegments = [SKSpriteNode]()
//        
        let ropeHolder = SKSpriteNode(imageNamed: "RopeHolder")
        ropeHolder.position = CGPoint(x: frame.midX, y: frame.midY)
//        ropeSegments.append(ropeHolder)
        addChild(ropeHolder)
        
        ropeHolder.physicsBody = SKPhysicsBody(circleOfRadius: ropeHolder.size.width / 2)
        ropeHolder.physicsBody?.isDynamic = false
//
//        for i in 0..<30 {
//            let ropeSegment = SKSpriteNode(imageNamed: "RopeTexture")
//            let offset = ropeSegment.size.height * CGFloat(i + 1)
//            ropeSegment.position = CGPoint(x: ropeHolder.position.x, y: ropeHolder.position.y - offset)
//            ropeSegments.append(ropeSegment)
//            addChild(ropeSegment)
//            
//            ropeSegment.physicsBody = SKPhysicsBody(rectangleOf: ropeSegment.size)
//        }
//        
//        for i in 1..<31 {
//            let nodeA = ropeSegments[i - 1]
//            let nodeB = ropeSegments[i]
//            let joint = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: nodeB.physicsBody!, anchor: CGPoint(x: nodeA.frame.midX, y: nodeA.frame.midY))
//            
//            physicsWorld.add(joint)
//        }
        
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20.0)
        ball.fillColor = UIColor.red
        addChild(ball)
        
//        let joint = SKPhysicsJointPin.joint(withBodyA: ropeSegments.last!.physicsBody!, bodyB: ball.physicsBody!, anchor: CGPoint(x: ropeSegments.last!.frame.midX, y: ropeSegments.last!.frame.midY))
//        physicsWorld.add(joint)
        
        let joint = SKPhysicsJointSpring.joint(withBodyA: ropeHolder.physicsBody!, bodyB: ball.physicsBody!, anchorA: CGPoint(x: ropeHolder.frame.midX, y: ropeHolder.frame.midY), anchorB: CGPoint(x: ball.frame.midX, y: ball.frame.midY))
        joint.damping = 0.2
        joint.frequency = 0.5
        physicsWorld.add(joint)
        
//        let moveAction = SKAction.move(to: CGPoint(x: frame.midX - 100, y: frame.midY), duration: 0.5)
//        ball.run(moveAction)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            ball.position = point
        }
    }
}
