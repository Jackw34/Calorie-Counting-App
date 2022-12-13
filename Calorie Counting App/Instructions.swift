//
//  Instructions.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/7/22.
//

import SwiftUI

struct Instructions: View {
    // display for the instructions
    var body: some View {
        ZStack{
            Text("In order to use this app click on the plus icon on the right hand side of the screen, which will bring you to the input screen. From here put the name of the food you ate and the appoximate amount of calories it was and then hit the submit button to add what you just added. If you want to edit what you just added click on the edit button on the left hand side of the screen, which will allow you to remove anything you added.")
                .padding(40)
                .font(.system(size: 25))
                .minimumScaleFactor(0.01)
        }
    }
}
struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}

