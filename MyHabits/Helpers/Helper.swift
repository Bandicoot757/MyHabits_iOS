//
//  Helper.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 03.11.2020.
//

import UIKit

extension UIColor {
    static let customMagenta = UIColor(red: 0.631, green: 0.086, blue: 1.0, alpha: 1)
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
}

protocol RefreshProgress {
    func refreshProgress()
}
