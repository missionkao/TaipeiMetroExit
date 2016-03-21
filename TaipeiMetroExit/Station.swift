//
//  Station.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/29.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import Foundation
import RealmSwift

class Station: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    let exit = List<Exit>()
    let ownerLine = List<Line>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
