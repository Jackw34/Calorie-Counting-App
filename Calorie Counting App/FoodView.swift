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
                TextField("Food name", text: $name)
                
                VStack {
                    Picker("Seclect calorie type", selection: $calorieType) {
                        ForEach(calorieTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Enter your calories", value: $calories, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
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
