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
    init(){
        UITableView.appearance().backgroundColor = .clear
        //        UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    
    func removeEvent(at offsets: IndexSet) {
        for index in offsets {
            let event = events[index]
            managedObjectContext.delete(event)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error saving context after delete: \(error)")
        }
    }
    
    @State var opacity: Double = 1
    
    var body: some View {
        TabView() {
            NavigationView() {
                List() {
                    ForEach(events, id: \.self) { event in
                        CountDownCardView(selectedEvent: event)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Events"), displayMode: .automatic)
                .navigationBarItems(
                    leading: Text(todayDate.string(from: Date()))
                        .foregroundColor(.gray),
                    trailing: Button(action: {
                        self.opacity = 0.5
                        self.modalNewEventView = true
                        print("Launch NewEventView from ContentView")
                    }, label: {
                        Image(systemName: "plus")
                    })
                        .opacity(self.opacity)
                        .scaleEffect(1.5)
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
            .tabItem {
                VStack() {
                    Image(systemName: K.hourglassSymbol)
                    Text("Events")
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
