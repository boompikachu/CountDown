//
//  CountDownCardView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI

struct CountDownCardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack() {
            HStack() {
                Text("36")
                    .frame(width: 50, height: 50)
                    .lineLimit(1)
                    .font(.system(size: 40))
                    .minimumScaleFactor(0.01)
                    .padding(10)
                    .background(
                        Rectangle()
                            .opacity(K.cardTextOpacity)
                            .cornerRadius(9)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .blur(radius: 1)
                )
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 18)
//                                                .stroke(Color.black, lineWidth: 3)
//
//                                    )
                    .padding(.trailing, 5)
                Spacer()
                Text("Boom's Birthday")
                    .minimumScaleFactor(0.75)
                    .lineLimit(2)
                    .font(.system(size: 25))
                    .padding(7)
                    .background(
                        Rectangle()
                            .opacity(K.cardTextOpacity)
                            .cornerRadius(9)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .blur(radius: 1)
                )
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
