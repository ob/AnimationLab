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

    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceCenter: CGPoint!
    var movingFaceCenter: CGPoint!

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

    @objc func facePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            movingFaceCenter = sender.view?.center
            sender.view?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        case .changed:
            let translation = sender.translation(in: sender.view?.superview)
            sender.view?.center = CGPoint(x: movingFaceCenter.x + translation.x, y: movingFaceCenter.y + translation.y)
        case .ended:
            sender.view?.transform = .identity
        default:
            break
        }
    }

    @objc func facePinch(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .changed:
            let scale = sender.scale
            sender.view?.transform = CGAffineTransform(scaleX: scale, y: scale)
        default:
            break
        }
    }

    @IBAction func faceDragged(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(facePan(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(facePinch(sender:)))
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)

        case .changed:
            let translation = sender.translation(in: trayView.superview)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenter.x + translation.x, y: newlyCreatedFaceCenter.y + translation.y)
        default:
            break
        }
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
                closeTray()
            }

        } else if sender.state == .ended {

        }
    }

}

