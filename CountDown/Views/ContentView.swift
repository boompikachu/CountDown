//
//  ContentView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(entity: Event.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Event.date, ascending: true)]) var events: FetchedResults<Event>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var modalNewEventView = false
    
    var todayDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }
    
    @State var opacity: Double = 1
    
    var body: some View {
        NavigationView() {
            
            List(events, id: \.self) { event in
                CountDownCardView(selectedEvent: event)
            }
            .navigationBarTitle(Text("Events"), displayMode: .automatic)
            .navigationBarItems(
                leading: Text(todayDate.string(from: Date()))
                    .foregroundColor(.gray),
                trailing: Image(systemName: "plus")
                    .opacity(self.opacity)
                    .scaleEffect(1.5)
                    .onTapGesture {
                        self.opacity = 0.5
                        self.modalNewEventView = true
                        print("Launch NewEventView from ContentView")
                }
                .sheet(isPresented: $modalNewEventView,
                       onDismiss: {
                        self.opacity = 1
                        print("dismiess")
                },
                       content: {
                    NewEventView(onDismiss: self.$modalNewEventView)
                        .environment(\.managedObjectContext, self.managedObjectContext)
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
