//
//  UITextField+Extension.swift
//  Navigation
//
//  Created by Ирина Савостьянова on 17.05.2023.
//

import UIKit

extension UITextField {
    func setPlaceholder(_ string: String, isError: Bool) {
        let attributedString = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: isError ? UIColor.red : UIColor.lightGray]
        )
        attributedPlaceholder = attributedString
    }
}
