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

        let red = UIViewController()
        red.view.backgroundColor = .red

        let green = UIViewController()
        green.view.backgroundColor = .green

        let blue = UIViewController()
        blue.view.backgroundColor = .blue

        green.addChildViewController(blue)
        blue.willMove(toParentViewController: green)
        green.view.addSubview(blue.view)
        blue.didMove(toParentViewController: green)

        blue.view.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.left.bottom.right.equalToSuperview()
        }

        let pulley = PulleyViewController(contentViewController: red, drawerViewController: green)

        self.addChildViewController(pulley)
        pulley.willMove(toParentViewController: self)
        view.addSubview(pulley.view)
        pulley.didMove(toParentViewController: self)

        pulley.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
