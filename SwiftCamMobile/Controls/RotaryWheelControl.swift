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
    var slices = [RotaryWheelSlice]()
    var transformationStart: CGAffineTransform?
    var deltaAngle: CGFloat = 0.0
    var currentIndex = 0 {
        didSet {
            delegate?.didChange(rotaryWheel: self, selectedIndex: currentIndex)
        }
    }

    init(components: [CameraParameterProtocol]) {
        self.components = components
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircle()
    }

    func configureView() {
        backgroundColor = UIColor.black

        configureComponents()
        configurePanGesture()
    }

    private func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture:)))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }

    private func configureComponents() {
        let angle = CGFloat.pi * 2 / CGFloat(components.count)

        for component in components.enumerated() {
            let button = UIButton()
            button.setTitle(component.element.description, for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .black
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleEdgeInsets.left = 3.0


            if component.element.description == "A" {
                button.setTitleColor(.orange, for: .normal)
            }
            addSubview(button)

            button.translatesAutoresizingMaskIntoConstraints = false

            button.layer.anchorPoint = CGPoint.init(x: 1.0, y: 0.5)
            button.transform = CGAffineTransform(rotationAngle: angle * CGFloat(component.offset))

            button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
            button.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

            button.tag = component.offset
            button.addTarget(self, action: #selector(componentButtonClicked(_:)), for: .touchUpInside)
        }

        if components.count % 2 == 0 {
            buildSlicesWithEvenCount()
        } else {
            buildSlicesWithOddCount()
        }
    }

    private func buildSlicesWithEvenCount() {
        let sliceAngle = CGFloat.pi * 2 / CGFloat(components.count)
        var middle: CGFloat = 0

        for (index, component) in components.enumerated() {
            var sliceMiddle = middle
            var sliceMinimum = middle - (sliceAngle / 2)
            let sliceMaximum = middle + (sliceAngle / 2)

            if sliceMaximum - sliceAngle < -CGFloat.pi {
                middle = CGFloat.pi
                sliceMiddle = middle
                sliceMinimum = CGFloat(fabsf(Float(sliceMaximum)))
            }

            middle -= sliceAngle
            let slice = RotaryWheelSlice(minimum: sliceMinimum,
                                         maximum: sliceMaximum,
                                         middle: sliceMiddle,
                                         component: component, index: index)

            slices.append(slice)
        }

    }

    private func buildSlicesWithOddCount() {
        let sliceAngle = CGFloat.pi * 2 / CGFloat(components.count)
        var middle: CGFloat = 0

        for (index, component) in components.enumerated() {
            let sliceMiddle = middle
            let sliceMinimum = middle - (sliceAngle / 2)
            let sliceMaximum = middle + (sliceAngle / 2)

            middle -= sliceAngle

            if middle < -CGFloat.pi {
                middle = -middle
                middle -= sliceAngle
            }

            let slice = RotaryWheelSlice(minimum: sliceMinimum,
                                         maximum: sliceMaximum,
                                         middle: sliceMiddle,
                                         component: component, index: index)

            slices.append(slice)
        }
    }


    func rotateToComponent(withIndex index: Int) {
        let angle = CGFloat.pi * 2 / CGFloat(components.count) * CGFloat(index)
        let rotation = CGAffineTransform.identity.rotated(by: -angle)

        UIView.animate(withDuration: 0.2, animations: {
            self.transform = rotation
        })

        currentIndex = index
    }

    private func toClosest() {
        let angle = atan2(transform.b, transform.a)
        var newValue: CGFloat = 0.0
        var newIndex = 0

        for slice in slices {
            if slice.minimum > 0.0 && slice.maximum < 0.0 {
                if slice.maximum > angle || slice.minimum < angle {
                    if angle > 0 {
                        newValue = angle - CGFloat.pi
                    } else {
                        newValue = CGFloat.pi + angle
                    }
                    newIndex = slice.index
                }
            } else if angle > slice.minimum && angle < slice.maximum {
                newValue = angle - slice.middle
                newIndex = slice.index
            }

        }
        rotateToComponent(withIndex: newIndex)

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
            toClosest()
        default:
            return
        }
    }
}

