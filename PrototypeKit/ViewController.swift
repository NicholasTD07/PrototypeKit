//
//  ViewController.swift
//  PrototypeKit
//
//  Created by nicholas.tian on 6/2/18.
//  Copyright © 2018 nickTD. All rights reserved.
//

private class ShadowView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        func makeShadow() {
            let context = UIGraphicsGetCurrentContext()!
            let rectanglePath = UIBezierPath.init(
                roundedRect: rect,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: 16, height: 16)
            )
            rectanglePath.close()
            context.saveGState()
            context.setShadow(
                offset: CGSize(width: 0, height: 5),
                blur: 10,
                color: UIColor.white.cgColor
            )
            UIColor.white.setFill()
            rectanglePath.fill()
            context.restoreGState()
        }

        makeShadow()
    }
}

class ViewController: UIViewController {
    private let contentView = ShadowView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .gray

//        setUpLayers()

        contentView.backgroundColor = .white

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }

//        addShadow(to: contentView)
    }

    private func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowOpacity = 1
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let rect = self.contentView.bounds
        let maskPath = UIBezierPath.init(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 16, height: 16)
        )

        let maskLayer = CAShapeLayer()

        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath

        self.contentView.layer.mask = maskLayer
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
