//
//  UIView+Extensions.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit


extension UIView {
    func makeCircle() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
