//
//  TaipeiMetroIndexViewController.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/27.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
//import TaipeiMetroMapViewController

class TaipeiMetroIndexViewController: UIViewController {
    
    var window: UIWindow?
    var taipeiMetroMapViewController: TaipeiMetroMapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.taipeiMetroMapViewController = TaipeiMetroMapViewController()
        self.addChildViewController(self.taipeiMetroMapViewController!)
        self.view.addSubview((self.taipeiMetroMapViewController?.view)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
