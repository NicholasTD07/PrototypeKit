//
//  ViewController.swift
//  PrototypeKit
//
//  Created by nicholas.tian on 6/2/18.
//  Copyright © 2018 nickTD. All rights reserved.
//

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        setUpLayers()
    }

    private func setUpLayers() {
        func circleView(diameter: CGFloat) -> UIView {
            let circle = UIView(frame:
                CGRect(
                    origin: .zero,
                    size: CGSize(
                        width: diameter,
                        height: diameter
                    )
                )
            )

            circle.backgroundColor = .white
            circle.layer.cornerRadius = diameter / 2
            circle.layer.masksToBounds = true

            return circle
        }
        func shadowLayer() -> CALayer {
            let shadow = CALayer()

            shadow.shadowColor = UIColor.white.cgColor
            shadow.shadowRadius = 10
            shadow.shadowOffset = CGSize(width: 0, height: 5)
            shadow.shadowOpacity = 1

            return shadow
        }

        let diameter: CGFloat = 100
        let circle = circleView(diameter: diameter)

        let shadow = shadowLayer()

        circle.center = view.center
//        view.addSubview(circle)

        shadow.addSublayer(circle.layer)

        view.layer.addSublayer(shadow)

    }
}

private extension ViewController {
    private func verifySnapKitInstallation() {
        let subview = UIView()

        view.addSubview(subview)
        subview.snp.makeConstraints { make in
        }
    }
}
