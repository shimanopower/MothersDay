//
//  ConfettiView.swift
//  MothersDay
//
//  Created by shimanopower on 5/10/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let particleEmitter = CAEmitterLayer()
        let view = UIView()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        let red = self.makeEmitterCell(color: UIColor.red)
        let green = self.makeEmitterCell(color: UIColor.green)
        let blue = self.makeEmitterCell(color: UIColor.blue)

        particleEmitter.emitterCells = [red, green, blue]

        view.layer.addSublayer(particleEmitter)

        return view
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        cell.contents = UIImage(named: "polygon")?.cgImage

        return cell
    }


    func updateUIView(_ uiView: UIView, context: Context) {
    }

    typealias UIViewType = UIView
}
