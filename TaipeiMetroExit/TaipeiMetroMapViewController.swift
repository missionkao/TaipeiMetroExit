//
//  TaipeiMetroMapViewController.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/27.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class TaipeiMetroMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var window: UIWindow?
    var mapView: MKMapView?
    var taipeiMetroLocationManager = TaipeiMetroLocationManager()
    
    private let viewModel:TaipeiMetroMapViewModel
    private var region: MKCoordinateRegion?
    private let distanceSpan: Double = 1000
    var currentLocation: CLLocation?
    
    //MARK: - Life Cycle
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(viewModel:TaipeiMetroMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.mapView = MKMapView(frame: CGRectMake(0, 20, (self.window?.frame.width)!, (self.window?.frame.height)!-20))
        self.mapView!.delegate = self
        self.view.addSubview(self.mapView!)
        
        self.taipeiMetroLocationManager.locationManager.delegate = self
        self.mapView!.showsUserLocation = true
        
        for annotation in self.viewModel.exitMapAnnotationArray() {
            self.mapView?.addAnnotation(annotation)
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if (self.currentLocation == nil) {
            self.currentLocation = manager.location
            self.region = MKCoordinateRegionMakeWithDistance((self.currentLocation!.coordinate), self.distanceSpan, self.distanceSpan)
            self.mapView!.setRegion(self.region!, animated: false)
        }
        self.currentLocation = manager.location
    }
    
}
