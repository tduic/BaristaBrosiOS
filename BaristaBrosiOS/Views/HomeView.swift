//
//  HomeView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/29/21.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var page: Pages
    
    var body: some View {
        
        VStack{
            Text("Hello, World!")
            Text("what up")
            Button(action: {page = Pages.Login}) {
                LoginButtonContent()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(page: .constant(Pages.Home))
    }
}
