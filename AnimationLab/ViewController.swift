//
//  ViewController.swift
//  AnimationLab
//
//  Created by Oscar Bonilla on 10/4/17.
//  Copyright © 2017 ob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!

    var trayOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayOriginalCenter = trayView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func trayDragged(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: trayView.superview)

        if sender.state == .began {
        } else if sender.state == .changed {
            let translation = sender.translation(in: trayView.superview)
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture changed at: \(point)")
        } else if sender.state == .ended {
            trayOriginalCenter = trayView.center
            print("Gesture ended at: \(point)")
        }
    }

}

