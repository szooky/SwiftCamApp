//
//  CircularDial.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CircularDial: UIView {
    var values: [String]

    init(frame: CGRect, values: [String]) {
        self.values = values

        super.init(frame: frame)

        configureView()
        configureValues()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        makeCircle()
        backgroundColor = .gray
    }

    private func configureValues() {
        for value in values {
            let button = UIButton()
            button.setTitle(value, for: .normal)
            button.backgroundColor = .blue
            button.frame = CGRect(x: 5.0, y: frame.height / 2, width: frame.width / 2, height: 10.0)
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

            addSubview(button)

        }
    }

}
