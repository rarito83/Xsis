//
//  ProfileView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("rarito")
                    .resizable()
                    .frame(width: 180, height: 180, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
                Text("Rahmat Susanto")
                    .font(Font.title)
                    .foregroundColor(.indigo)
                Text("iOS Developer")
                    .bold()
            }.navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
