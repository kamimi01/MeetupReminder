//
//  AdViewControllerRepresentable.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/11.
//

import UIKit
import SwiftUI

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
  let viewController = UIViewController()

  func makeUIViewController(context: Context) -> some UIViewController {
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // No implementation needed. Nothing to update.
  }
}
