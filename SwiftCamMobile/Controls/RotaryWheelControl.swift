//
//  CircularDial.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

protocol RotaryWheelDelegate: class {
    func didChange(rotaryWheel: RotaryWheelControl, selectedIndex: Int)
}

class RotaryWheelControl: UIView {
    weak var delegate: RotaryWheelDelegate?
    var components: [CameraParameterProtocol]

    var currentIndex = 0 {
        didSet {
            delegate?.didChange(rotaryWheel: self, selectedIndex: currentIndex)
        }
    }

    var transformationStart: CGAffineTransform?
    var deltaAngle: CGFloat = 0.0

    init(frame: CGRect, components: [CameraParameterProtocol]) {
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
        backgroundColor = UIColor.black

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture:)))
        panGesture.minimumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }

    private func configureComponents() {
        let angle = CGFloat.pi * 2 / CGFloat(components.count)

        for component in components.enumerated() {
            let button = UIButton()
            button.setTitle(component.element.description, for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .blue
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleEdgeInsets.left = 3.0

            button.frame = CGRect(x: 5.0, y: frame.height / 2, width: frame.width / 2, height: 20.0)
            button.layer.anchorPoint = CGPoint.init(x: 1.0, y: 0.5)
            button.layer.position = CGPoint.init(x: bounds.width / 2, y: bounds.height / 2)
            button.transform = CGAffineTransform(rotationAngle: angle * CGFloat(component.offset))
            button.tag = component.offset
            button.addTarget(self, action: #selector(componentButtonClicked(_:)), for: .touchUpInside)
            //button.isUserInteractionEnabled = false

            //button.cancelTracking(with: .)

            if component.element.description == "A" {
                button.setTitleColor(.orange, for: .normal)
            }
            addSubview(button)
        }
    }

    func rotateToComponent(withIndex index: Int) {
        let angle = CGFloat.pi * 2 / CGFloat(components.count) * CGFloat(index)
        let rotation = CGAffineTransform.identity.rotated(by: -angle)

        UIView.animate(withDuration: 0.5, animations: {
            self.transform = rotation
        })

        currentIndex = index
    }

    private func rotateToClosestComponent() {
        let singleComponentAngle = CGFloat.pi * 2 / CGFloat(components.count)
        let currentWheelRotation = atan2(transform.b, transform.a)

        guard currentWheelRotation != 0.0 else { return }
        let delta = abs(singleComponentAngle) / abs(currentWheelRotation)

        print(currentWheelRotation)
        //let closestComponentIndex = Int(delta.rounded())


        let x = singleComponentAngle / 2 + 2 * CGFloat.pi - currentWheelRotation
        let closestComponentIndex = abs(Int(x / currentWheelRotation) % components.count)


        print(closestComponentIndex)
        rotateToComponent(withIndex: closestComponentIndex)
    }

    @objc func componentButtonClicked(_ button: UIButton) {
        rotateToComponent(withIndex: button.tag)
    }

    private func getDeltaAngle(for point: CGPoint) -> CGFloat {
        let dx = point.x - center.x
        let dy = point.y - center.y
        return atan2(dy,dx)
    }

    @objc func panGestureHandler(panGesture recognizer: UIPanGestureRecognizer) {
        guard recognizer.view != nil else { return }
        let touchPoint = recognizer.location(in: self)

        switch recognizer.state {
        case .began:
            deltaAngle = getDeltaAngle(for: touchPoint)
            transformationStart = transform
        case .changed:
            let angleDifference = deltaAngle - getDeltaAngle(for: touchPoint)
            transform = transform.rotated(by: -angleDifference)
        case .ended:
            rotateToClosestComponent()
        default:
            return
        }
    }
}
