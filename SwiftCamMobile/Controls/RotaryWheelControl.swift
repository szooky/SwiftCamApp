//
//  CircularDial.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

protocol RotaryWheelDelegate: class {
    func didChangedValue()
}

class RotaryWheelControl: UIControl {
    var components: [String]


    init(frame: CGRect, components: [String]) {
        self.components = components

        super.init(frame: frame)

        configureView()
        configureComponents()


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        makeCircle()
        backgroundColor = .gray
    }

    private func configureComponents() {
        let angle = CGFloat.pi * 2 / CGFloat(components.count)

        for component in components.enumerated() {
            let button = UIButton()
            button.setTitle(component.element, for: .normal)
            button.titleLabel?.textAlignment = .left
            button.backgroundColor = .blue

            button.frame = CGRect(x: 5.0, y: frame.height / 2, width: frame.width / 2, height: 10.0)
            button.layer.anchorPoint = CGPoint.init(x: 1.0, y: 0.5)
            button.layer.position = CGPoint.init(x: bounds.width / 2, y: bounds.height / 2)
            button.transform = CGAffineTransform(rotationAngle: angle * CGFloat(component.offset))

            addSubview(button)

        }
    }



}
