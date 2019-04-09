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
            let circle = UIView(frame: .zero)
            circle.backgroundColor = .white
            circle.layer.cornerRadius = diameter / 2
            circle.layer.masksToBounds = true

            return circle
        }
        func shadowView() -> UIView {
            let view = UIView()

            view.layer.shadowColor = UIColor.white.cgColor
            view.layer.shadowRadius = 10
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowOpacity = 1

            return view
        }

        let diameter: CGFloat = 100
        let circle = circleView(diameter: diameter)

        let shadow = shadowView()

        shadow.addSubview(circle)

        circle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(shadow)

        shadow.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(diameter)
        }
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
