//
//  ContentView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var modalNewEventView = false
    
    var todayDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }
    
    
    var body: some View {
        NavigationView() {
            
            List() {
                CountDownCardView()
                CountDownCardView()
                CountDownCardView()
                CountDownCardView()
            }
            .navigationBarTitle(Text("Events"))
            .navigationBarItems(
                leading: Text(todayDate.string(from: Date()))
                    .foregroundColor(.gray),
                trailing: Button(action: {
                    self.modalNewEventView = true
                }, label: {
                    Image(systemName: "plus")
                        .scaleEffect(1.5)
                }).sheet(isPresented: $modalNewEventView, content: {
                    NewEventView(onDismiss: {
                        self.modalNewEventView = false
                    })
                })
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
