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
    @State var sheetRKCalendarView = false
    @State private var sheetImagePickerView = false
    @State private var selectedPhoto: UIImage?
    
    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365*10), mode: 0)
    
    func loadSelectedPhoto() {
        
    }
    
    
    var body: some View {
        NavigationView() {
            VStack(alignment: .leading) {
                
                Spacer()
                
                CountDownCardView(eventTitle: title, eventDate: date, eventImage: selectedPhoto, dateView: true)
                    // The image inside this view blocks button
                    .cornerRadius(CGFloat(K.cardRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                            .stroke(Color.primary, lineWidth: 1)
                )
                
                
                Spacer()
                
                
                Group() {
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
                    //                    DatePicker("Please Enter your date", selection: $date, displayedComponents: .date)
                    //                        .labelsHidden()
                    Button(action: { self.sheetRKCalendarView = true }) {
                        Text("Select Date")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.secondary)
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                                    .stroke(Color.secondary, lineWidth: 5)
                        )
                            .cornerRadius(CGFloat(K.cardRadius))
                            .padding(.vertical)
                    }.sheet(isPresented: self.$sheetRKCalendarView, content: {
                        RKViewController(isPresented: self.$sheetRKCalendarView, rkManager: self.rkManager1)
                            .onDisappear() {
                                if let safeSelectedDate = self.rkManager1.selectedDate {
                                    self.date = safeSelectedDate
                                }
                                
                        }
                    })
                    
                    Text("Image")
                        .font(.headline)
                    HStack {
                        Button(action: {
                        
                       }) {
                            Text("Unsplash")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.secondary)
                                .padding(.vertical)
                                .padding(.horizontal, 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                                        .stroke(Color.secondary, lineWidth: 5)
                            )
                                .cornerRadius(CGFloat(K.cardRadius))
                                .padding(.vertical)
                        }
                        Button(action: {
                         
                        }) {
                             Text("Pallettes")
                                 .fontWeight(.semibold)
                                 .foregroundColor(Color.secondary)
                                 .padding(.vertical)
                                 .padding(.horizontal, 20)
                                 .overlay(
                                     RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                                         .stroke(Color.secondary, lineWidth: 5)
                             )
                                 .cornerRadius(CGFloat(K.cardRadius))
                                 .padding(.vertical)
                         }
                        Button(action: {
                            self.sheetImagePickerView = true
                        }) {
                             Text("Photo")
                                 .fontWeight(.semibold)
                                 .foregroundColor(Color.secondary)
                                 .padding(.vertical)
                                 .padding(.horizontal, 20)
                                 .overlay(
                                     RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                                         .stroke(Color.secondary, lineWidth: 5)
                             )
                                 .cornerRadius(CGFloat(K.cardRadius))
                                 .padding(.vertical)
                         }
                    }
                }
                
                HStack() {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { // Delete and make new views
                            
                            Button(action: {
                                //
                            }) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.red)
                            }
                            Button(action: {
                                //
                            }) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.blue)
                            }
                            Button(action: {
                                //
                            }) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.green)
                            }
                            Button(action: {
                                //
                            }) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.yellow)
                            }
                            Button(action: {
                                //
                            }) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.purple)
                            }
                            
                        }
                        
                    }
                    Spacer()
                    Button(action: {
                        do {
                            let event = Event(context: self.managedObjectContext)
                            event.title = self.title
                            event.date = self.date
                            
                            event.image = self.selectedPhoto?.pngData()
                            
                            try self.managedObjectContext.save()
                            self.onDismiss = false
                        } catch {
                            print("Coudn't save new events with error: \(error)")
                        }
                    }) {
                        Text("Save")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.primary)
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: CGFloat(K.cardRadius))
                                    .stroke(Color.primary, lineWidth: 5)
                        )
                            .cornerRadius(CGFloat(K.cardRadius))
                            .padding()
                    }
                }
                .frame(height: 75)
                
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.onDismiss = false
                }) {
                    Text("Dismiss")
            })
        }
        .sheet(isPresented: self.$sheetImagePickerView, onDismiss: loadSelectedPhoto) {
            ImagePicker(image: self.$selectedPhoto)
        }
        
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return NewEventView(onDismiss: Binding.constant(true)).environment(\.managedObjectContext, context)
    }
}
