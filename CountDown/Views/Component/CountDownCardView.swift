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
    
    
    func secondsToDays(seconds: TimeInterval) -> String {
        print("/////")
        print(now)
        print(eventDate)
        print(seconds.description)
        if let intSeconds = Double(seconds.description) {
            let temp = Int(intSeconds/60/60/24)
            return String(temp)
        }
        return "x"
    }
    
    @State var dateView: Bool = false
    
    
    
    let now = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) ?? Date()
    let tomorrow = Date().addingTimeInterval(86400)
    
    
    var body: some View {
        HStack {
            if !dateView {
                Text(secondsToDays(seconds: now.distance(to: selectedEvent?.date ?? eventDate)))
                    .font(.system(size: 36))
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(Color.red)
                    .frame(width: 55)
                    .padding(.vertical)
                    .padding(.leading)
//                                        .padding(.trailing, 0)
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
                        .foregroundColor(Color.primary)
                }
                .frame(width: 55)
                .padding(.vertical)
                .padding(.leading)
//                                    .padding(.trailing, 0)
                    .onTapGesture {
                        self.dateView.toggle()
                }
            }
            
            Divider()
                .foregroundColor(Color.secondary)
                .padding(.vertical)
                .padding(.trailing)
            Text(selectedEvent?.title ?? eventTitle)
                .font(.system(size: 21))
                .fontWeight(.medium)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 100)
        .background(
            ZStack {
                Image("background-demo")
                    .resizable()
//                    .clipped()
                    .scaledToFill()
//                    .frame(height: 100)
                    .clipped()
                Rectangle()
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .opacity(colorScheme == .dark ? 0.6 : 0.7)
            }
        )
    }
}

struct CountDownCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownCardView()
    }
}
