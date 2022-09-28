import SwiftUI
import SpriteKit

class GameScene:SKScene {
    override func sceneDidLoad() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame);
        let texture1 = SKTexture(imageNamed: "snail_00");
        let texture2 = SKTexture(imageNamed: "snail_04");
        let texture3 = SKTexture(imageNamed: "snail_07");
        let textures:Array<SKTexture> = [texture1, texture2, texture3];
        let character:SKSpriteNode = SKSpriteNode(imageNamed: "snail_00");
        character.texture = texture1;
        character.position = CGPoint(x:200, y:200);
        character.size = CGSize(width:100, height:80);
        addChild(character);
        character.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2)));
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
