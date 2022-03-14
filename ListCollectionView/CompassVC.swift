//
//  CompassVC.swift
//  ListCollectionView
//
//  Created by AzizOfficial on 3/14/22.
//

import UIKit
import CoreLocation

class CompassVC: UIViewController {
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.startUpdatingHeading()
      return $0
    }(CLLocationManager())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "Compass"
    }
}

extension CompassVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(newHeading)
    }
}
