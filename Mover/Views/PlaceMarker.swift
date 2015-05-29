//
//  PlaceMarker.swift
//  Mover
//
//  Created by IHSOFT on 2015. 5. 21..
//  Copyright (c) 2015년 IHSOFT. All rights reserved.
//

import UIKit

class PlaceMarker: GMSMarker {
    let place: GooglePlace
    
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
