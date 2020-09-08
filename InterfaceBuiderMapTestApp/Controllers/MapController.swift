//
//  MapController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 07.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapController: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonSelectionView: UIView!
    @IBOutlet weak var mapArrowView: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    private var mapViewInitialPos: CGFloat!
    
    private let presenter = MapPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGestures()
        setupMapStyle()
    }
}

private extension MapController {
    
    func setup() {
        presenter.delegate = self
        mapView.overrideUserInterfaceStyle = .dark
        view.sendSubviewToBack(mapView)
        view.bringSubviewToFront(bottomView)
        [mapArrowView, locationButton, unlockButton, settingsButton].forEach {
            mapView.addSubview($0)
        }
        mapView.bringSubviewToFront(mapArrowView)
        mapViewInitialPos = mapView.frame.origin.y
        mapView.isMyLocationEnabled = true
    }
    
    func setupGestures() {
        mapView.settings.consumesGesturesInView = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        mapArrowView.addGestureRecognizer(panGesture)
    }
    
    func setupMapStyle() {
        do {
            if let style = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: style)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    @IBAction func didHandleLocationButton(_ sender: UIButton) {
        presenter.startUpdatingLocation()
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
    
    @objc func panned(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: mapView)
        switch sender.state {
        case .began:
            mapView.settings.scrollGestures = false
        case .changed:
            if mapView.frame.origin.y + translation.y >= mapViewInitialPos {
                mapView.frame.origin.y += translation.y
            }
            sender.setTranslation(.zero, in: view)
        case .ended:
            mapView.settings.scrollGestures = true
            UIView.animate(withDuration: 0.5, animations: {
                self.mapView.frame.origin.y = self.mapViewInitialPos
                }, completion: nil)
        default:
            break
        }
    }
}

extension MapController: MapPresenterOutput {
    
    func moveToLocation(_ location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.0)
        mapView.animate(to: camera)
        presenter.stopUpdatingLocation()
    }
}
