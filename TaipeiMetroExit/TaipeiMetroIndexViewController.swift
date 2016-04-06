//
//  TaipeiMetroIndexViewController.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/27.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import RealmSwift
import RxCocoa
import RxSwift

class TaipeiMetroIndexViewController: UIViewController {
    
    var window: UIWindow?
    var taipeiMetroMapViewController: TaipeiMetroMapViewController?
    var taipeiMetroTableViewController: TaipeiMetroTableViewController?
    
    private var taipeiMetroMapViewModel: TaipeiMetroMapViewModel?
    private var taipeiMetroTableViewModel: TaipeiMetroTableViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Taipei Metro Map"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back1.png"), style: .Plain, target: self, action: #selector(TaipeiMetroIndexViewController.backButtonClicked(_:)))
        
        let centerLocationBarButtonItem = UIBarButtonItem(image: UIImage(named: "location1.png"), style: .Plain, target: self, action: #selector(TaipeiMetroIndexViewController.locationButtonClicked(_:)))
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(TaipeiMetroIndexViewController.searchButtonClicked(_:)))
        let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        self.toolbarItems = [centerLocationBarButtonItem, flexibleBarButtonItem ,searchBarButtonItem]
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setToolbarItems(self.toolbarItems, animated: false)
        
        self.saveMetroStationToRealm()
        self.saveMetroDataToRealm()
        
        let realm = try! Realm()
        let line = realm.objects(Line).filter("id == 0").first
        let station = line?.stations.filter("id == 19").first
        print(station?.id,station?.name,station?.latitude,station?.longitude)
        let exits = station?.exit
        for exit in exits! {
            print(exit.name, exit.latitude, exit.longitude)
        }
        self.taipeiMetroMapViewModel = TaipeiMetroMapViewModel()
        self.taipeiMetroMapViewController = TaipeiMetroMapViewController.init(viewModel: self.taipeiMetroMapViewModel!)
        self.addChildViewController(self.taipeiMetroMapViewController!)
        self.view.addSubview((self.taipeiMetroMapViewController?.view)!)
        
        self.taipeiMetroTableViewModel = TaipeiMetroTableViewModel()
        self.taipeiMetroTableViewController = TaipeiMetroTableViewController.init(viewModel: self.taipeiMetroTableViewModel!)
        self.addChildViewController(self.taipeiMetroTableViewController!)
        
        self.taipeiMetroTableViewController?.tableView.rx_itemSelected
            .subscribeNext { indexPath in
                print("The IndexPath row is ")
                print(indexPath.row)
                let latitude = self.taipeiMetroTableViewModel!.lineArray![indexPath.section].stations[indexPath.row].latitude
                let longitude = self.taipeiMetroTableViewModel!.lineArray![indexPath.section].stations[indexPath.row].longitude
                let coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
                self.taipeiMetroMapViewController!.mapView!.setRegion(region, animated: false)
            }
            .addDisposableTo(disposeBag)
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
    
    func saveMetroStationToRealm() {
        let fileName = NSBundle.mainBundle().pathForResource("metroStation", ofType: "json");
        do {
            let realm = try! Realm()
            let data: NSData = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let json = JSON(data: data)
            for (_,subJson):(String, JSON) in json {
                let lineName = subJson["name"].string!
                let lineId = subJson["id"].string!
                let station = subJson["stop"]
                
                let lineClass = Line()
                lineClass.name = lineName
                lineClass.id = Int(lineId)!
                //                print(lineName)
                for (_,stationJson):(String, JSON) in station {
                    let id = stationJson["id"].string!
                    let stationName = stationJson["stopname"].string!
                    let stationClass = Station()
                    stationClass.name = stationName
                    stationClass.id = Int(id)!
                    //                    print(Int(id), stationName)
                    lineClass.stations.append(stationClass)
                }
                
                try! realm.write {
                    realm.add(lineClass, update: true)
                }
            }
        }catch let unknownError{
            print("\(unknownError) is an unknown error.")
        }
        
    }
    
    func saveMetroDataToRealm() {
        let fileName = NSBundle.mainBundle().pathForResource("metro", ofType: "json");
        do {
            let realm = try! Realm()
            let data: NSData = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let json = JSON(data: data)
            for (_,subJson):(String, JSON) in json {
                let id = Int(subJson["id"].string!)!
                let name = subJson["name"].string!
                let stationLatitude = subJson["latitude"].string!
                let stationLongitude = subJson["longitude"].string!
                let exit = subJson["exit"]
                let stationClass = Station()
                
                stationClass.name = name
                stationClass.id = id
                stationClass.latitude = Double(stationLatitude)!
                stationClass.longitude = Double(stationLongitude)!
                
                for (_,exitJson):(String, JSON) in exit {
                    let exitName = exitJson["name"].string!
                    let latitude = exitJson["latitude"].string!
                    let longitude = exitJson["longitude"].string!
                    
                    let exitClass = Exit()
                    exitClass.name = exitName
                    exitClass.latitude = Double(latitude)!
                    exitClass.longitude = Double(longitude)!
                    stationClass.exit.append(exitClass)
//                    let annotation = MetroAnnotation(title: name, subtitle: exitNumber, coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!))
//                    self.mapView?.addAnnotation(annotation)
                }
                try! realm.write {
                    realm.add(stationClass, update: true)
                }
            }
        }catch let unknownError{
            print("\(unknownError) is an unknown error.")
        }
    }
    
}
