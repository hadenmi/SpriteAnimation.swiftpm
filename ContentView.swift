import SwiftUI
import SpriteKit

class GameScene:SKScene {
    let character:SKSpriteNode = SKSpriteNode(imageNamed: "snailred");
    let character2:SKSpriteNode = SKSpriteNode(imageNamed: "snailyellow");
    let character3:SKSpriteNode = SKSpriteNode(imageNamed: "snailblue");
    let character4:SKSpriteNode = SKSpriteNode(imageNamed: "snail_00");
    let background:SKSpriteNode = SKSpriteNode(imageNamed: "natural-environment-lanscape-scene_1308-33532.jpg.webp");
    let timer:SKLabelNode = SKLabelNode(text: "0.00");
    var endDistance:Double = 0;
    var startDistance:Double = 50;
    var distance:Double = 0;
    var backgroundOffset:Double = 0;
    var snailHeight:Double = 80;
    var time:Double = 0;
    var finished:Bool = false;
    
    let char2Time = Double.random(in: 30..<40);
    let char3Time = Double.random(in: 20..<29);
    let char4Time = Double.random(in: 10..<19);
    
    override func sceneDidLoad() {
        var screenHeight:CGFloat = UIScreen.main.bounds.height;
        var screenWidth:CGFloat = UIScreen.main.bounds.width;
        time = 0;
        endDistance += screenHeight;
        background.size = CGSize(width:screenHeight * 4, height:screenHeight);
        background.position = CGPoint(x:background.size.width / 2, y:background.size.height / 2);
        backgroundOffset += background.position.x;
        addChild(background);
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame);
        
        let goalDistance:Double = 160;
        
        character2.position = CGPoint(x:startDistance, y:200);
        character2.size = CGSize(width:100, height:snailHeight);
        addChild(character2);
        let position2 = CGPoint(x: character2.position.x + goalDistance, y: character2.position.y);
        character2.run(SKAction.move(to: position2, duration: char2Time));
        
        character3.position = CGPoint(x:startDistance, y:180);
        character3.size = CGSize(width:100, height:snailHeight);
        addChild(character3);
        let position3 = CGPoint(x: character3.position.x + goalDistance, y: character3.position.y);
        character3.run(SKAction.move(to: position3, duration: char3Time));
        
        character4.position = CGPoint(x:startDistance, y:160);
        character4.size = CGSize(width:100, height:snailHeight);
        addChild(character4);
        let position4 = CGPoint(x: character4.position.x + goalDistance, y: character4.position.y);
        character4.run(SKAction.move(to: position4, duration: char4Time));
        
        character.position = CGPoint(x:startDistance, y:140);
        character.size = CGSize(width:100, height:snailHeight);
        addChild(character);
        
        timer.position = CGPoint(x:150, y:0);
        timer.fontSize = 40;
        timer.fontName = "Arial";
        addChild(timer);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(distance >= background.size.width - startDistance - endDistance) {
            finished = true;
            if (time < char4Time) {
                print("First place!")
            }
            else if (time < char3Time) {
                print("Second place!")
            }
            else if (time < char2Time) {
                print("Third place!")
            }
            else {
                print("Fourth place!")
            }
            return;
        }
        if (snailHeight == 80) {
            snailHeight = 75;
        }
        else {
            snailHeight = 80;
        }
        distance += 20;
        let position = CGPoint(x: (distance / 10) + startDistance, y: character.position.y);
        let backgroundPosition = CGPoint(x: backgroundOffset - distance, y: background.position.y);
        character.size = CGSize(width:character.size.width, height:snailHeight);
        character.run(SKAction.move(to: position, duration: 1));
        background.run(SKAction.move(to: backgroundPosition, duration: 1));
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (finished) {return}
        time += 1/60;
        timer.text = String(round(time*100)/100);
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
