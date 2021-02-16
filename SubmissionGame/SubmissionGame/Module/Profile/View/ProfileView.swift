//
//  ProfileView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 03/02/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @State var name = "Muhamad Muhyidin Amin"
  @State var job = "Mid Web Developer"
  @State var email = "muhyidinxiitkj3@gmail.com"
    
  var body: some View {
    ScrollView(.vertical) {
        VStack {
            Rectangle()
              .frame(width: 500)
              .foregroundColor(.gray)
              .edgesIgnoringSafeArea(.top)
              .frame(height: 200.0)
            Image("photo")
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 4))
              .shadow(radius: 10)
              .offset(y: -250)
              .padding(.bottom, -300)
              Text(name)
                  .bold()
                  .font(.title)
              Text(job)
                  .font(.subheadline)
                  .foregroundColor(.gray)
              Text(email)
                  .font(.subheadline)
                  .foregroundColor(.gray)
          }.padding()
          NavigationLink(destination: EditProfileView()) {
              Text("Edit").padding(12)
          }
          .background(Color.pink)
          .foregroundColor(.white)
          .cornerRadius(9)
          .navigationBarTitle(Text("Profile"))
    }.onAppear {
        guard let getName = UserDefaults.standard.value(forKey: "name") else { return }
        guard let getJob = UserDefaults.standard.value(forKey: "job") else { return }
        guard let getEmail = UserDefaults.standard.value(forKey: "email") else { return }
        
        self.name = getName as? String ?? ""
        self.job = getJob as? String ?? ""
        self.email = getEmail as? String ?? ""
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
