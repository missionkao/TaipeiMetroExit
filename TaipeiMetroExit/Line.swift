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
    dynamic var name = ""
    let stations = List<Station>()
}
