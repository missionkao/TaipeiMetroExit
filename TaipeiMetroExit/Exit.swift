//
//  Exit.swift
//  TaipeiMetroExit
//
//  Created by Ｍission on 2016/2/29.
//  Copyright © 2016年 missionkao. All rights reserved.
//

import Foundation
import RealmSwift

class Exit: Object {
    dynamic var name = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
}
