//
//  NewEventView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 3/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI
import CoreData

struct NewEventView: View {
    @Binding var onDismiss: Bool
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var description = ""
    @State var date: Date = Date()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: { self.onDismiss = false }) {
                    Text("Dismiss")
                }
            }
            
            Spacer()
            
            CountDownCardView(eventTitle: title, eventDate: date, dateView: true)
                .edgesIgnoringSafeArea(.horizontal)
            Spacer()
            
            VStack() {
                Text("Title")
                    .font(.headline)
                TextField("Enter the title", text: $title)
                    .padding(.vertical)
                Text("Description")
                    .font(.headline)
                TextField("Enter the description", text: $description)
                    .padding(.vertical)
                Text("Date")
                    .font(.headline)
                DatePicker("Please Enter your date", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    
                Text("Image")
                    .font(.headline)
            }
            
            Button(action: {
                do {
                    let event = Event(context: self.managedObjectContext)
                    event.title = self.title
                    event.date = self.date
                    try self.managedObjectContext.save()
                    self.onDismiss = false
                } catch {
                    print("Coudn't save new events with error: \(error)")
                }
            }) {
                Text("Save")
            }
        }
        .padding()
        
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
