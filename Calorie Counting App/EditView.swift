//
//  EditView.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/7/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section() {
                // Allows to edit the name of the food and the amount of calories it was
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    TextField("Enter your calories", value: $calories, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
