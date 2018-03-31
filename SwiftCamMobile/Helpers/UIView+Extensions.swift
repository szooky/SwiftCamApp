//
//  UIView+Extensions.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit


extension UIView {
    func round() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

    func constraintsEqualToSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
