//
//  MapPresenter.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapPresenterOutput: class {
    func moveToLocation(_ location: CLLocation)
}

final class MapPresenter: NSObject {
    
    private let locationManager = CLLocationManager()
    unowned var delegate: MapPresenterOutput!
    
    override init() {
        super.init()
        setup()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

private extension MapPresenter {
    
    func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MapPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            NSLog("can't find user location")
            return
        }
        delegate.moveToLocation(location)
    }
}
