//
//  UIImage+Ext.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import UIKit

extension UIImageView {
    static func getImageFrom(url: URL, callback: @escaping (_ imageData: Data) -> ()) {
        NetworkManager.shared.getData(from: url) { (data) in
            callback(data)
        }
    }
}
