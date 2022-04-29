//
//  LottieView.swift
//  AirportFinder
//
//  Created by Amin on 1/20/1401 AP.
//

import SwiftUI
import Lottie
struct LottieView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    var name: String!
    var animationView = AnimationView()
    var loopMode: LottieLoopMode = .loop

    class Coordinator: NSObject {
        var parent: LottieView
        init(_ animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()

        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
