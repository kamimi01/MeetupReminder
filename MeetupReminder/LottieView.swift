//
//  LottieView.swift
//  JapanTravelRoulette
//
//  Created by mikaurakawa on 2023/01/16.
//

import SwiftUI
import Lottie

enum AnimationType: String {
    case friendships = "friendships"
}

struct LottieView: UIViewRepresentable {
    let animationType: AnimationType

    func makeUIView(context: Context) -> UIView {
        let view = LottieAnimationView(name: animationType.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false

        let parentView = UIView()
        parentView.addSubview(view)
        parentView.addConstraints([
            view.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ])

        view.play()
        view.loopMode = .loop

        return parentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
