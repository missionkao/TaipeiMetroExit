//
//  Line.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/29.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import Foundation
import RealmSwift

class Line: Object {
    dynamic var id = 0
    dynamic var name = ""
    let stations = List<Station>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
