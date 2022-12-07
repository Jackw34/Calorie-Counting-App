//
//  FoodView.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/7/22.
//

import SwiftUI
// nothing else to add
struct FoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    @State private var calorieType = "Calories"
    
    let calorieTypes = ["Calories", "kilocalories"]
    
    var body: some View {
            
  
        Form {
            Section() {
                // where you put the name of your food
                TextField("Food name", text: $name)
                
                VStack {
                    // allows you to selct the correct calorie type
                    Picker("Seclect calorie type", selection: $calorieType) {
                        ForEach(calorieTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    // where you enter the amount of calories your food was
                    TextField("Enter your calories", value: $calories, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        // where you submit whatever you have inputed into view so far
                        DataController().addFood(
                            name: name,
                            calories: calories,
                            context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}
