//
//  CountDownCardView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI

struct CountDownCardView: View {
    var body: some View {
        VStack() {
            HStack() {
                Text("36")
                    .frame(width: 50, height: 50)
                    .lineLimit(1)
                    .font(.system(size: 40))
                    .minimumScaleFactor(0.01)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.black, lineWidth: 3)
                )
                    .padding(.trailing, 5)
                Spacer()
                Text("Boom's Birthday")
                    .lineLimit(2)
                    .font(.system(size: 25))
                Spacer()
            }
            .frame(height: 100)
            .padding()
            .background(
                Image("background-demo")
                    .resizable()
                    .scaledToFill()
            )
                .clipped()
            .cornerRadius(9)
        }
    }
}

struct CountDownCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownCardView()
    }
}
