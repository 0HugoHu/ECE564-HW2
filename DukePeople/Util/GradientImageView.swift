//
//  GradientImageView.swift
//
//
//  Created by Hugo Hu on 9/12/23.
//

import Foundation
import SwiftUI

/*
 This protocol is used to pass back action to the DukePersonVC
 */
protocol GradientImageViewDelegate: AnyObject {
    func didTapBackButton()
}


public struct GradientImageView : View {
    var image: Image
    var height: CGFloat
    var width: CGFloat
    var lName: String
    var description: String
    var blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialLight
    weak var delegate: GradientImageViewDelegate?
    
    public init(image: Image, lName: String, desc: String) {
        self.image = image
        self.height = 693
        self.width = 393
        self.lName = lName
        self.description = desc
    }
    
    public var body: some View {
        VStack() {
            ZStack(alignment: .top){
                GreenBackgroundView()
                    .offset(x: 0, y: -12)
                
                Text(lName)
                    .font(Font.custom("Futura", size: 75)
                        .weight(.bold))
                    .foregroundColor(textColor)
                    .offset(x: 0, y: -15)
                    .background(blurColor)
                
                let offsetY = 50.0
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width , height: width)
                    .clipped()
                    .offset(x: 0, y: offsetY)
                
                
                let gradient = Gradient(stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .clear, location: 0.3134),
                    .init(color: blurColor.opacity(0), location: 0.35),
                    .init(color: blurColor.opacity(0.8), location: 0.55),
                    .init(color: blurColor.opacity(1), location: 1),
                ])
                
                VStack{}
                    .frame(width: width , height: height - offsetY)
                    .background(
                        VisualEffectView(effect: UIBlurEffect(style: blurStyle))
                            .preferredColorScheme(.dark).offset(x: 0, y: offsetY + width * 0.4)
                    )
                    .mask(
                        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                    )
                
                
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width , height: width)
                    .mask(LinearGradient(stops: [.init(color: blurColor, location: 0),
                                                 .init(color: blurColor, location: 0.6),
                                                 .init(color: .clear, location: 0.8),], startPoint: .top, endPoint: .bottom))
                    .offset(x: 0, y: offsetY)
                
                ZStack {
                    Text(description)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .offset(x: 0, y: 365)
                
                ZStack {
                    Button (action:{
                        self.delegate?.didTapBackButton()
                    }, label: {
                        Text("Back")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                            .environment(\.colorScheme, .dark)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                        
                    })
                }
                .offset(x: 0, y: 550)
            }
        }
        .background(blurColor)
    }
}


/*
 Update image with blur effect
 */
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}


/*
 Add a blur effect to the background
 */
struct GreenBackgroundView: View {
    var body: some View {
        blurColor
            .frame(width: 393, height: 100)
    }
}
