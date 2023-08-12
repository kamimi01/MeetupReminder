//
//  UITextField+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/12.
//

import Foundation
import UIKit

extension UITextField {

    static var textDidBeginEditingNotificationPublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)
    }
}
