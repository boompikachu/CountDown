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
                Text("30")
                    .font(.system(size: 40))
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
            .padding()
        }
    }
}

struct CountDownCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownCardView()
    }
}
