//
//  Funeral.swift
//  Hw05
//
//  Created by YuKai Lee on 2020/6/3.
//  Copyright © 2020 leeyk. All rights reserved.
//

import Foundation

class Funeral {
    var category: String
    var name: String
    var publicPrivate: String
    var country: String
    var region: String
    var address: String
    var longitude: Double = 0
    var latitude: Double = 0
    var tel: String
    var jurisdiction: String
    var distance: Double = 0
    
    init?(category: String,
          name: String,
          publicPrivate: String,
          country: String,
          region: String,
          address: String,
          longitude: Double,
          latitude: Double,
          tel: String,
          jurisdiction: String,
          distance: Double) {
        
        //名稱和經緯度不得為空
        if(name=="" || longitude<0.0 || latitude<0.0) {
            return nil
        }
        
        self.category = category
        self.name = name
        self.publicPrivate = publicPrivate
        self.country = country
        self.region = region
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
        self.tel = tel
        self.jurisdiction = jurisdiction
        self.distance = distance
    }
}
