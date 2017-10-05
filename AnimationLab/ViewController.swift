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

    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let midx = trayView.superview?.frame.midX
        var midy = (trayView.superview?.frame.maxY)! - trayView.frame.height / 2.0
        trayCenterWhenOpen = CGPoint(x: midx!, y: midy)
        midy = (trayView.superview?.frame.maxY)! + (trayView.frame.height / 2.0) - 30
        trayCenterWhenClosed = CGPoint(x: midx!, y: midy)
        trayView.center = trayCenterWhenClosed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func animateTrayTo(_ position: CGPoint) {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.trayView.center = position
        }, completion: nil)

    }

    fileprivate func openTray() {
        animateTrayTo(self.trayCenterWhenOpen)
    }

    fileprivate func closeTray() {
            animateTrayTo(self.trayCenterWhenClosed)
    }

    @IBAction func trayTapped(_ sender: Any) {
        if trayView.center == trayCenterWhenClosed {
            openTray()
        } else {
            closeTray()
        }
    }

    @IBAction func trayDragged(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
        } else if sender.state == .changed {
            let veolocity = sender.velocity(in: trayView.superview)
            if veolocity.y < 0 {
                openTray()
            } else {
            }

        } else if sender.state == .ended {

        }
    }

}

