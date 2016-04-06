//
//  TaipeiMetroTableViewModel.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/3/24.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
import RxCocoa
import RxSwift

class TaipeiMetroTableViewModel: NSObject {
    
//    var lineArray = Variable(Array<Line>())
    var lineArray = Array<Line>?()
    
    //MARK: - Life Cycle
    override init() {
        super.init()
        self.retrievingData()
    }
    
    deinit {
        
    }
    
    func retrievingData() {
        let realm = try! Realm()
        self.lineArray = Array(realm.objects(Line))
//        self.lineArray = Variable(Array(realm.objects(Line)))
    }
    
//    func lineObservableArray() -> Observable<[Line]> {
//        return self.lineArray.asObservable()
//    }
    
}
