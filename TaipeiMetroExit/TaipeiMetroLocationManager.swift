//
//  TaipeiMetroLocationManager.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/27.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import MapKit

class TaipeiMetroLocationManager: NSObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        let authstate = CLLocationManager.authorizationStatus()
        if (authstate == CLAuthorizationStatus.NotDetermined) {
            self.locationManager.requestAlwaysAuthorization()
        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.startUpdatingLocation()

    }
    
}
