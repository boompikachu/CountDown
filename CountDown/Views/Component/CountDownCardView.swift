//
//  CountDownCardView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI
import CoreData

struct CountDownCardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var selectedEvent: Event?
    var eventTitle: String = "No Title"
    var eventDate: Date = Date()
    
    func getDateFormatter(type: Int) -> DateFormatter{
        if (type == 1) {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        } else if (type == 2) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            return formatter
        }
    }
    
    var todayDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    @State var dateView: Bool = false
    
    var body: some View {
        HStack {
            
            if dateView {
                Text("18")
                    .font(.system(size: 36))
                    .fontWeight(.medium)
                    .foregroundColor(Color.red)
                    .frame(width: 55)
                    .padding(.vertical)
//                    .padding(.trailing)
                    .onTapGesture {
                        self.dateView.toggle()
                }
            } else {
                VStack() {
                    Text(getDateFormatter(type: 3).string(from: selectedEvent?.date ?? eventDate))
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray)
                    Text(getDateFormatter(type: 1).string(from: selectedEvent?.date ?? eventDate))
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .foregroundColor(Color.red)
                    Text(getDateFormatter(type: 2).string(from: selectedEvent?.date ?? eventDate))
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                }
                .frame(width: 55)
                .padding(.vertical)
//                .padding(.trailing)
                .onTapGesture {
                    self.dateView.toggle()
                }
            }
            
            Divider()
                .padding(.vertical)
                .padding(.trailing)
            Text(selectedEvent?.title ?? eventTitle)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 100)
        .clipped()
    }
}

struct CountDownCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownCardView()
    }
}
