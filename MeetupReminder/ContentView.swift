//
//  ContentView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/24.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var viewModel = PersonListViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(viewModel.personList) { person in
                   PersonCardView(person: person)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
