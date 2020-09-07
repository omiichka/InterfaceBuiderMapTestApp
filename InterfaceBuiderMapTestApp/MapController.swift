//
//  MapController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 07.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit
import MapKit

final class MapController: UIViewController {

    @IBOutlet weak var mapArrowView: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonSelectionView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var mapViewInitialPos: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGestures()
    }
}

private extension MapController {
    
    func setup() {
        mapView.overrideUserInterfaceStyle = .dark
        view.sendSubviewToBack(mapView)
        view.bringSubviewToFront(bottomView)
        mapView.addSubview(mapArrowView)
        mapViewInitialPos = mapView.frame.origin.y
    }
    
    @IBAction func didHandleScooterButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSelectionView.frame.origin.x = sender.frame.origin.x - 10
        })
    }
    
    @IBAction func didHandleBikeButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSelectionView.frame.origin.x = sender.frame.origin.x
        })
    }
    
    @IBAction func didHandleSeatScooterButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSelectionView.frame.origin.x = sender.frame.origin.x - 5
        })
        
    }
    
    func setupGestures() {
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
           mapArrowView.addGestureRecognizer(panGesture)
       }
    
    @objc func panned(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: mapView)
        switch sender.state {
        case .changed:
            mapView.frame.origin.y += translation.y
            sender.setTranslation(.zero, in: view)
        case .ended:
            UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                self.mapView.frame.origin.y = self.mapViewInitialPos
                }, completion: nil)
        default:
            break
        }
    }
}
