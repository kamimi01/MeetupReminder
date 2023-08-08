//
//  UIApplication+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/08.
//

import Foundation
import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController
    }
}
