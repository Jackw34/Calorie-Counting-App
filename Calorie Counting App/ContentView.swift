//
//  ContentView.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/5/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // calls upon the func in datacontroller to save the data the user inputted 
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            // view to the instructions
            VStack(alignment: .leading) {
                NavigationLink(destination: Instructions()) {
                    Text("Instructions For The App")
                        .font(.system(size: 25))
                }
                // where the total calories are counted and displayed
                Text("\(Int(totalCaloriesToday())) Cal")
                    .foregroundColor(.gray)
                    .padding([.horizontal])
                
                List {
                    // The display of what user inputs
                    ForEach(food) { food in
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name!)
                                    .bold()
                                Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                            }
                            Spacer()
                        }
                    }
                     .onDelete(perform: deleteFood) // allows you to delete what you added
                }
                .listStyle(.plain)
            }
            // The title
            .navigationTitle("Calorie Counter")
            // adds the image to where you add food
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                FoodView()
            }
        }
        .navigationViewStyle(.stack)// Removes sidebar on iPad
    }
    
    // The function that deletes food that has been added
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
                .forEach(managedObjContext.delete)
            
            // Saves to the database
            DataController().save(context: managedObjContext)
        }
    }
    
    // Calculates the total calories consumed today
    private func totalCaloriesToday() -> Double {
        var caloriesToday : Double = 0
        for item in food {
            caloriesToday += item.calories
        }
        print("Calories today: \(caloriesToday)")
        return caloriesToday
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
