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
    var taipeiMetroTableViewController: TaipeiMetroTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Taipei Metro Map"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back1.png"), style: .Plain, target: self, action: "backButtonClicked:")
        
        let centerLocationBarButtonItem = UIBarButtonItem(image: UIImage(named: "location1.png"), style: .Plain, target: self, action: "locationButtonClicked:")
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "searchButtonClicked:")
        let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        self.toolbarItems = [centerLocationBarButtonItem, flexibleBarButtonItem ,searchBarButtonItem]
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setToolbarItems(self.toolbarItems, animated: false)
        
        self.taipeiMetroMapViewController = TaipeiMetroMapViewController()
        self.addChildViewController(self.taipeiMetroMapViewController!)
        self.view.addSubview((self.taipeiMetroMapViewController?.view)!)
        
        self.taipeiMetroTableViewController = TaipeiMetroTableViewController()
        self.addChildViewController(self.taipeiMetroTableViewController!)

    }

    func locationButtonClicked(sender: UIButton) {
        if let currentLocation = self.taipeiMetroMapViewController?.currentLocation {
            let region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000, 1000)
            self.taipeiMetroMapViewController?.mapView?.setRegion(region, animated: true)
        }
    }
    
    func searchButtonClicked(sender: UIButton) {
        self.taipeiMetroTableViewController?.view.frame = CGRectMake(0,(self.window?.frame.height)!, (self.window?.frame.width)!, (self.window?.frame.height)!-20-300)
        self.view.addSubview((self.taipeiMetroTableViewController?.view)!)
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.taipeiMetroMapViewController?.mapView?.frame = CGRectMake(0, 20, (self.window?.frame.width)!, 300)
            if let currentLocation = self.taipeiMetroMapViewController?.currentLocation {
                let region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 500, 500)
                self.taipeiMetroMapViewController?.mapView?.setRegion(region, animated: true)
            }
            
            self.taipeiMetroTableViewController?.view.frame = CGRectMake(0, 300+20, (self.window?.frame.width)!, (self.window?.frame.height)!-20-300)
            }, completion: { finished in
                self.navigationItem.leftBarButtonItem?.enabled = true
        })
    }
    
    func backButtonClicked(sender: UIButton){
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.taipeiMetroMapViewController?.mapView?.frame = CGRectMake(0, 20, (self.window?.frame.width)!, (self.window?.frame.height)!-20)
            self.taipeiMetroTableViewController?.view.frame = CGRectMake(0,(self.window?.frame.height)!,(self.window?.frame.width)!, (self.window?.frame.height)!-20-300)
            }, completion: { finished in
                self.taipeiMetroTableViewController?.view.removeFromSuperview()
                self.navigationItem.leftBarButtonItem?.enabled = false
        })
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
}
