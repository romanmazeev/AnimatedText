//
//  GravityViewController.swift
//  GravityText
//
//  Created by Mazeev Roman on 24.01.2018.
//  Copyright © 2018 Mazeev Roman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var message = ""
    var animator: UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        gravityBehaviour(for: message)
    }
    
    func gravityBehaviour(for string: String) {
        guard animator == nil else { return }
        
        let words = string.components(separatedBy: " ")
        
        var labels = [UILabel]()
        
        for (index, word) in words.enumerated() {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            
            label.center = CGPoint(x: view.frame.midX, y: 50 + CGFloat(30 * index))
            label.text = word
            label.sizeToFit()
            view.addSubview(label)
            
            labels.append(label)
            
            let gravity = UIGravityBehavior(items: labels)
            animator = UIDynamicAnimator(referenceView: view)
            animator?.addBehavior(gravity)
            
            let collisions = UICollisionBehavior(items: labels)
            
            collisions.translatesReferenceBoundsIntoBoundary = true
            animator?.addBehavior(collisions)
        }
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        animator = nil
        gravityBehaviour(for: message)
    }
}
