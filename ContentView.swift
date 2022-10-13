import SwiftUI
import SpriteKit

class GameScene:SKScene {
    let texture1 = SKTexture(imageNamed: "snail_00");
    let texture2 = SKTexture(imageNamed: "snail_04");
    let texture3 = SKTexture(imageNamed: "snail_07");
    let character:SKSpriteNode = SKSpriteNode(imageNamed: "snail_00");
    
    override func sceneDidLoad() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame);
        let textures:Array<SKTexture> = [texture1, texture2, texture3];
        character.texture = texture1;
        character.position = CGPoint(x:200, y:200);
        character.size = CGSize(width:100, height:80);
        addChild(character);
        character.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2)));
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self);
        let position = CGPoint(x: location.x, y: 200);
        character.run(SKAction.move(to: position, duration: 3));
    }
}

struct ContentView: View {
    var scene:SKScene {
        let scene = GameScene();
        scene.scaleMode = .resizeFill;
        return scene;
    }
    var body: some View {
        SpriteView(scene: scene);
    }
}
