//
//  AddLocationBtn.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import SwiftUI

struct AddLocationBtn: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .padding(.horizontal)
        }
        .padding()
        .background(.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
    }
}

struct AddLocationBtn_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationBtn(action: {})
    }
}
