//
//  CLLocationCoordinate2DExtension.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 12/02/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {}

public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
