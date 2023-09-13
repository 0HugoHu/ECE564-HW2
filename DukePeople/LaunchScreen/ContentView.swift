//
//  ContentView.swift
//  RealityKitLaunchScreen
//
//  Created by A. Zheng (github.com/aheze) on 5/10/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = LaunchViewModel()
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Duke People")
                    .font(.system(size: 42, weight: .bold, design: .rounded))

                Text("Where you find Duke Alumni")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
            .offset(x: 0, y: 50)

            Spacer()

            Group {
                Text("ECE564 HW2: Persistent Storage\n")
                +
                Text("@0HugoHu, 9/13/2023")
            }
            .font(.system(size: 22, weight: .semibold))
            .accentColor(.white.opacity(0.75))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .foregroundColor(.white)
        .background(
            ZStack {
                Color(LaunchConstants.backgroundColor)

                LaunchViewControllerRepresentable(model: model)
            }
            .edgesIgnoringSafeArea(.all)
        )
    }
}
