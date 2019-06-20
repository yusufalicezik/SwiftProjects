//
//  DataDelegate.swift
//  ExercsPrj
//
//  Created by Yusuf ali cezik on 20.06.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func getFirstVCDataList(list:[Photo])
    
}

protocol DataDelegateSecondVc {
    func getSecondVCDataList(comment:Comment)
}
