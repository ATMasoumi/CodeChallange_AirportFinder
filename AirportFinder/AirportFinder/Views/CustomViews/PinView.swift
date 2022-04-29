//
//  SwiftUIView.swift
//  AirportFinder
//
//  Created by Amin on 1/21/1401 AP.
//

import SwiftUI

struct PinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY+3))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.minY+3))
        path.closeSubpath()
        return path
    }
}

struct PinView: View {
    @Binding var isScaled: Bool
    var body:some View {
        ZStack {
            ZStack {
                Circle()
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(.gray)
                    .offset(y: 20)
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                    .animation(.easeInOut(duration: 1.5)
                                .repeatForever(), value: isScaled)
                Circle()
                    .stroke(lineWidth: 0.5)
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(.gray)
                    .scaleEffect(!isScaled ? 3 : 1)
                    .offset(y: 20)
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                    .animation(.easeInOut(duration: 1.5)
                                .repeatForever(), value: isScaled)
            }
            ZStack {
                PinShape()
                    .frame(width: 50, height: 40)
                    .foregroundColor(Color.red)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                    .offset(y: -40/6)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
            }
            .scaleEffect(isScaled ? 1.5 : 1)
            .offset(y: isScaled ? -35 : 0)
            .animation(.easeInOut(duration: 1.5)
                        .repeatForever(), value: isScaled)
        }
        .foregroundColor(.red)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PinView(isScaled: .constant(true))
    }
}
