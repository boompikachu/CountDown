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
    var eventImage: UIImage?
    @Binding var textColor: UIColor
    
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
    
//    func getColour(data: Data) -> Color {
//        do {
//            return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)!)
//        } catch {
//            print(error)
//        }
//
//        return Color.clear
//    }
    
    func secondsToDays(seconds: TimeInterval) -> String {
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
                    .foregroundColor(((selectedEvent?.color as? UIColor) != nil) ? Color(self.selectedEvent?.color as! UIColor) : Color(textColor))
                    .frame(width: 60)
                    
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
                        .foregroundColor(((selectedEvent?.color as? UIColor) != nil) ? Color(self.selectedEvent?.color as! UIColor) : Color(textColor))
                    Text(getDateFormatter(type: 2).string(from: selectedEvent?.date ?? eventDate))
                        .fontWeight(.medium)
                        .foregroundColor(Color.primary)
                }
                .frame(width: 60)
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
                if selectedEvent?.image != nil{
                    Image(uiImage: UIImage(data: (selectedEvent?.image)!)!)
                        .resizable()
                        .scaledToFill()
                } else if eventImage != nil {
                    Image(uiImage: eventImage!)
                        .resizable()
                        .scaledToFill()
                }
                    
                Rectangle()
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .opacity(colorScheme == .dark ? 0.6 : 0.5)
            }
            .frame(height: 100)
        )
        .clipped()
    }
}

struct CountDownCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownCardView(textColor: Binding.constant(.red))
    }
}
