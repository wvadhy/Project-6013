import Foundation
import UIKit

struct TasksBrain {
    
    let tasks: [Activity] = [
        Activity(name: "Deep dive", difficulty: "Medium", image: UIImage(named: "water")!),
        Activity(name: "Code rush", difficulty: "Easy", image: UIImage(named: "fire")!),
        Activity(name: "Deep dive", difficulty: "Hard", image: UIImage(named: "water")!),
    ]
    
    let colours = [
        "Hard": UIColor.red,
        "Medium": UIColor.orange,
        "Easy": UIColor.green
    ]
    
    
    
}
