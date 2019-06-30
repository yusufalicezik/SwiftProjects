//
//  BottomMenu.swift
//  AnyThng
//
//  Created by Yusuf ali cezik on 29.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class BottomMenu: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteButtonClicked(_ sender: Any) {
        print("delete tiklandi")
    }
    @IBAction func moreButtonClicked(_ sender: Any) {
        print("more tiklandi")
    }
}
