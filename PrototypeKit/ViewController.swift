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
