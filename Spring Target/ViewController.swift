//
//  ViewController.swift
//  Spring Target
//
//  Created by Brandon Burrus on 3/9/19.
//  Copyright © 2019 Brandon Burrus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var spring: CGFloat = 0 {
        didSet {
            springLabel.text = "\(floor(spring * 100) / 100)"
        }
    }
    var damping: CGFloat = 0 {
        didSet {
            dampingLabel.text = "\(floor(damping * 100) / 100)"
        }
    }

    @IBOutlet weak var springLabel: UILabel!
    @IBOutlet weak var dampingLabel: UILabel!
    @IBOutlet weak var ballView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballView.center = view.center
        spring = 7
        damping = 0.5
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: damping,
                initialSpringVelocity: spring,
                options: [],
                animations: {
                    self.ballView.center = sender.location(in: self.view)
                }
            )
            
        }
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let change = translation.y * -0.0033
        switch sender.view {
        case springLabel:
            spring += change
        case dampingLabel:
            damping += change
        default:
            fatalError("Unhandled panning object value not associated with a view")
        }
        sender.setTranslation(CGPoint(x: translation.x, y: 0), in: view)
    }
}
