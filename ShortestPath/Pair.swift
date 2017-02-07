//
//  Pair.swift
//  ShortestPath
//
//  Created by Md Asif Huda on 2/6/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

struct Pair {
    var len = Int()
    var  path = String()
    
    init (len : Int, s: String) {
        self.len = len
        self.path = s
    }
}

