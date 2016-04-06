//
//  TaipeiMetroTableViewController.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/29.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import RealmSwift
import RxCocoa
import RxSwift

class TaipeiMetroTableViewController: UITableViewController {
    
    let TaipeiMetroTableCellIdentifier: String = "TaipeiMetroTableCell"
    var window: UIWindow?
//    var metroStationArray = ["文湖線", "淡水信義線", "松山新店線", "中和新蘆線", "板南線"]
//    var lineArray = Results<Line>?()
    
    private let viewModel:TaipeiMetroTableViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Life Cycle
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(viewModel:TaipeiMetroTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView
//            .rx_setDelegate(self)
//            .addDisposableTo(disposeBag)
        self.tableView.frame = CGRectMake(0, 0, (self.window?.frame.width)!, (self.window?.frame.height)!-20-300)
//        self.retrievingData()
        
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel.lineArray!.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.lineArray![section].name
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.lineArray![section].stations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: self.TaipeiMetroTableCellIdentifier)
        cell.textLabel?.text = self.viewModel.lineArray![indexPath.section].stations[indexPath.row].name
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    }
    
//    func retrievingData() {
//        let realm = try! Realm()
//        self.lineArray = realm.objects(Line)
//        print(self.lineArray!.count)
//    }
    
    func getApi(indexPath: NSIndexPath) -> Observable<CLLocationCoordinate2D> {
        return Observable.create { observer in
            let latitude = self.viewModel.lineArray![indexPath.section].stations[indexPath.row].latitude
            let longitude = self.viewModel.lineArray![indexPath.section].stations[indexPath.row].longitude
            let coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            observer.on(.Next(coordinate))
            observer.on(.Completed)
            
            return NopDisposable.instance
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
