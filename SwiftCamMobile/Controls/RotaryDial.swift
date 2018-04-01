//
//  CircularDial.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class RotaryDial: UIView, Selectable {
    weak var delegate: SelectableControlDelegate?
    var components: [Displayable]
    var slices = [RotaryWheelSlice]()
    var deltaAngle: CGFloat = 0.0
    var currentIndex = 0 {
        didSet {
            delegate?.didSelect(index: currentIndex, in: self)
        }
    }

    init(components: [Displayable]) {
        self.components = components
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        round()
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

        buildSlices()
    }

    private func buildSlices() {
        let sliceAngle = CGFloat.pi * 2 / CGFloat(components.count)
        var middle: CGFloat = 0

        for (index, component) in components.enumerated() {
            var sliceMiddle = middle
            var sliceMinimum = middle - (sliceAngle / 2)
            let sliceMaximum = middle + (sliceAngle / 2)

            if components.count % 2 == 0 {
                if sliceMaximum - sliceAngle < -CGFloat.pi {
                    middle = CGFloat.pi
                    sliceMiddle = middle
                    sliceMinimum = CGFloat(fabsf(Float(sliceMaximum)))
                }

                middle -= sliceAngle
            } else {
                middle -= sliceAngle

                if middle < -CGFloat.pi {
                    middle = -middle
                    middle -= sliceAngle
                }
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

    private func rotateToNearestComponent() {
        let angle = atan2(transform.b, transform.a)
        var newIndex = 0

        for slice in slices {
            if slice.minimum > 0.0 && slice.maximum < 0.0 {
                if slice.maximum > angle || slice.minimum < angle {
                    newIndex = slice.index
                }
            } else if angle > slice.minimum && angle < slice.maximum {
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
        case .changed:
            let angleDifference = deltaAngle - getDeltaAngle(for: touchPoint)
            transform = transform.rotated(by: -angleDifference)
        case .ended:
            rotateToNearestComponent()
        default:
            return
        }
    }
}

