//
//  EventView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//

import SwiftUI


struct EventView: View {
    @StateObject var viewModel = ListEventViewModel()
    let userId = UserDefaults.standard.string(forKey: "userId")

    var body: some View {
        NavigationView {
            List(viewModel.contacts, id: \.self) { event in
                Text(event.EventName)
            }
            .navigationBarTitle("Events")
            .onAppear {
                print("userId: \(userId ?? "nil")")

                viewModel.fetchEvents(userId: userId ?? "") { result in
                    switch result {
                    case .success:
                        break // success
                    case .failure(let error):
                        print("Error fetching events: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

struct JoindreEventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
