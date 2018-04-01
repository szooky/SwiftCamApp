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

    func edges(equalTo view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func addGradient(direction: GradientDirection, colors: GradientColor) {
        let gradient = CAGradientLayer()
        gradient.frame.size = frame.size
        gradient.colors = colors.values
        gradient.startPoint = direction.startPoint
        gradient.endPoint = direction.endPoint
        layer.addSublayer(gradient)
    }
}
