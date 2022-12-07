//
//  ContentView.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/5/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                NavigationLink(destination: Instructions()) {
                    Text("Instructions For The App")
                        .font(.system(size: 25))
                }
                
                Text("\(Int(totalCaloriesToday())) Cal")
                    .foregroundColor(.gray)
                    .padding([.horizontal])
                
                List {
                    
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
        
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                }
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
           
            .navigationTitle("Calorie Counter")
          
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
        .navigationViewStyle(.stack)
    }
    
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
            .forEach(managedObjContext.delete)
            
            
            DataController().save(context: managedObjContext)
        }
    }
    
   
    private func totalCaloriesToday() -> Double {
        var caloriesToday : Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
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
