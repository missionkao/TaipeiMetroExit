//
//  TaipeiMetroIndexViewController.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/27.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import MapKit
//import TaipeiMetroMapViewController

class TaipeiMetroIndexViewController: UIViewController {
    
    var window: UIWindow?
    var taipeiMetroMapViewController: TaipeiMetroMapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.redColor()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Taipei Metro Map"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back1.png"), style: .Plain, target: self, action: nil)
        
        let centerLocationBarButtonItem = UIBarButtonItem(image: UIImage(named: "location1.png"), style: .Plain, target: self, action: "locationButtonClicked:")
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: nil)
        let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        self.toolbarItems = [centerLocationBarButtonItem, flexibleBarButtonItem ,searchBarButtonItem]
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setToolbarItems(self.toolbarItems, animated: false)
        
        self.taipeiMetroMapViewController = TaipeiMetroMapViewController()
        self.addChildViewController(self.taipeiMetroMapViewController!)
        self.view.addSubview((self.taipeiMetroMapViewController?.view)!)
        
    }

    func locationButtonClicked(sender: UIButton) {
        if let currentLocation = self.taipeiMetroMapViewController?.currentLocation {
            let region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000, 1000)
            self.taipeiMetroMapViewController?.mapView?.setRegion(region, animated: true)
        }
    }

}
