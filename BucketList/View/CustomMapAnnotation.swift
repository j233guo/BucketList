//
//  CustomMapAnnotation.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-13.
//

import SwiftUI

struct CustomMapAnnotation: View {
    var name: String
    var body: some View {
        VStack {
            Image(systemName: "star.circle")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 44, height: 44)
                .background(.white)
                .clipShape(Circle())
            Text(name)
                .fixedSize()
        }
    }
}

struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapAnnotation(name: "Buckingham Palace")
    }
}
