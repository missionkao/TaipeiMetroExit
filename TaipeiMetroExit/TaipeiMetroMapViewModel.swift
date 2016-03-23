//
//  TaipeiMetroMapViewModel.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/3/23.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class TaipeiMetroMapViewModel: NSObject {

    //MARK: - Life Cycle
    override init() {
        super.init()
    }
    
    deinit {
        
    }
    
    func exitMapAnnotationArray() -> Array<TaipeiMetroAnnotation> {
        var annotationArray = Array<TaipeiMetroAnnotation>()
        let realm = try! Realm()
        let lines = realm.objects(Line)
        for line in lines {
            for station in line.stations {
                for exit in station.exit {
                    let annotation = TaipeiMetroAnnotation(title: station.name, subtitle: exit.name, coordinate: CLLocationCoordinate2D(latitude: exit.latitude, longitude: exit.longitude))
                    annotationArray.append(annotation)
                }
            }
        }
        
        return annotationArray
    }
}
