//
//  CircularDial.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

protocol RotaryWheelDelegate: class {
    func didChange(selectedIndex: Int)
}

class RotaryWheelControl: UIControl {
    weak var delegate: RotaryWheelDelegate?
    var components: [String]
    var currentIndex = 0 {
        didSet {
            delegate?.didChange(selectedIndex: currentIndex)
        }
    }

    var transformationStart: CGAffineTransform?
    var deltaAngle: CGFloat = 0.0

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
        backgroundColor = UIColor.black
    }

    private func configureComponents() {
        let angle = CGFloat.pi * 2 / CGFloat(components.count)

        for component in components.enumerated() {
            let button = UIButton()
            button.setTitle(component.element, for: .normal)
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
//            button.isUserInteractionEnabled = false

            if component.element == "A" {
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
        let currentWheelRotation = atan2(transform.b, transform.a)
        let partialAngle = CGFloat.pi * 2 / CGFloat(components.count)

        guard currentWheelRotation != 0.0 else { return }
        let delta = abs(partialAngle) / abs(currentWheelRotation)

        print(currentWheelRotation)
        let closestComponentIndex = Int(delta.rounded())

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

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        deltaAngle = getDeltaAngle(for: touchPoint)
        transformationStart = transform

        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let angleDifference = deltaAngle - getDeltaAngle(for: touch.location(in: self))
        transform = transform.rotated(by: -angleDifference)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        rotateToClosestComponent()
    }

}
