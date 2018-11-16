//
//  viewControllerExtensions.swift
//  CloudkitVoorbeeld112018
//
//  Created by Toine Schnabel on 15/11/2018.
//  Copyright © 2018 Toine Schnabel. All rights reserved.
//

import Foundation
import UIKit
protocol NotifyUserProtocol {
    func notifyUser(_ title: String, message: String)
}
//extension TableVC:NotifyUserConsumer{
//    func notifyUser(_ title: String, message: String)
//    {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "OK",
//                                         style: .cancel, handler: nil)
//
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true,
//                     completion: nil)
//    }
//}
