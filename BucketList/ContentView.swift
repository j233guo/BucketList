//
//  ContentView.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import SwiftUI

struct ContentView: View {
    @State private var authState = AuthState.fail
    
    var body: some View {
        VStack {
            if authState == .success || authState == .unavailable {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .padding()
        .onAppear(perform: {
            let status = authenticate()
            print(status)
            authState = status
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
