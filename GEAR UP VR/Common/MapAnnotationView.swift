//
//  MapAnnotationView.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 11/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import MapKit
import UIKit

class MapAnnotationView: MKAnnotationView, MKMapViewDelegate {
    init(annotation: MKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage.mapViewmarkerImage
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
