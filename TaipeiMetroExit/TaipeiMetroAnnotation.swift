//
//  TaipeiMetroAnnotation.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/3/22.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import MapKit

class TaipeiMetroAnnotation: NSObject, MKAnnotation {
    
    let title:String?
    let subtitle:String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle:String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
