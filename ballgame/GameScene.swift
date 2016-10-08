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
    
    var ball = SKSpriteNode(imageNamed: "Ball")
    
    override func didMove(to view: SKView) {
        var ropeSegments = [SKSpriteNode]()
        
        let ropeHolder = SKSpriteNode(imageNamed: "RopeHolder")
        ropeHolder.position = CGPoint(x: frame.midX, y: frame.midY)
        ropeSegments.append(ropeHolder)
        addChild(ropeHolder)
        
        ropeHolder.physicsBody = SKPhysicsBody(circleOfRadius: ropeHolder.size.width / 2)
        ropeHolder.physicsBody?.isDynamic = false
        
        for i in 0..<30 {
            let ropeSegment = SKSpriteNode(imageNamed: "RopeTexture")
            let offset = ropeSegment.size.height * CGFloat(i + 1)
            ropeSegment.position = CGPoint(x: ropeHolder.position.x, y: ropeHolder.position.y - offset)
            ropeSegments.append(ropeSegment)
            addChild(ropeSegment)
            
            ropeSegment.physicsBody = SKPhysicsBody(rectangleOf: ropeSegment.size)
        }
        
        for i in 1..<31 {
            let nodeA = ropeSegments[i - 1]
            let nodeB = ropeSegments[i]
            let joint = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: nodeB.physicsBody!, anchor: CGPoint(x: nodeA.frame.midX, y: nodeA.frame.midY))
            
            physicsWorld.add(joint)
        }
        
        ball.position = CGPoint(x: frame.midX, y: ropeSegments.last!.position.y - ball.size.height / 2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        addChild(ball)
        
        let joint = SKPhysicsJointPin.joint(withBodyA: ropeSegments.last!.physicsBody!, bodyB: ball.physicsBody!, anchor: CGPoint(x: ropeSegments.last!.frame.midX, y: ropeSegments.last!.frame.midY))
        physicsWorld.add(joint)
        
        let moveAction = SKAction.move(to: CGPoint(x: frame.midX - 100, y: frame.midY), duration: 0.5)
        ball.run(moveAction)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            ball.position = point
        }
    }
}
