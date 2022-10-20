import SwiftUI
import SpriteKit

class GameScene:SKScene {
    let texture1 = SKTexture(imageNamed: "snail_00");
    let texture2 = SKTexture(imageNamed: "snail_04");
    let texture3 = SKTexture(imageNamed: "snail_07");
    let character:SKSpriteNode = SKSpriteNode(imageNamed: "snail_00");
    let background:SKSpriteNode = SKSpriteNode(imageNamed: "natural-environment-lanscape-scene_1308-33532.jpg.webp");
    var endDistance:Double = 0;
    var startDistance:Double = 50;
    var distance:Double = 0;
    var backgroundOffset:Double = 0;
    
    override func sceneDidLoad() {
        var screenHeight:CGFloat = UIScreen.main.bounds.height;
        endDistance += screenHeight;
        background.size = CGSize(width:screenHeight * 4, height:screenHeight);
        background.position = CGPoint(x:background.size.width / 2, y:background.size.height / 2);
        backgroundOffset += background.position.x;
        addChild(background);
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame);
        let textures:Array<SKTexture> = [texture1, texture2, texture3];
        character.texture = texture1;
        character.position = CGPoint(x:startDistance, y:200);
        character.size = CGSize(width:100, height:80);
        addChild(character);
        character.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2)));
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(distance >= background.size.width - startDistance - endDistance) {
            return;
        }
        distance += 20;
        let position = CGPoint(x: (distance / 10) + startDistance, y: 200);
        let backgroundPosition = CGPoint(x: backgroundOffset - distance, y: background.position.y);
        character.run(SKAction.move(to: position, duration: 1));
        background.run(SKAction.move(to: backgroundPosition, duration: 1));
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
