//
//  EditProfileView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 03/02/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
    
  @State var name = ""
  @State var job = ""
  @State var email = ""
  @State var showingUpdatedAlert = false
  
  var body: some View {
    VStack {
      Text("Name").font(.headline)
      TextField("Enter Name", text: $name)
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
      Text("Job Position").font(.headline)
      TextField("Enter Job Position", text: $job)
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
      Text("Email").font(.headline)
      TextField("Enter Email", text: $email)
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        Button(action: {
          UserDefaults.standard.set(self.name, forKey: "name")
          UserDefaults.standard.set(self.job, forKey: "job")
          UserDefaults.standard.set(self.email, forKey: "email")
          
          self.showingUpdatedAlert.toggle()
        }) {
          Text("Save").padding(12)
        }.background(Color.pink)
        .foregroundColor(.white)
        .cornerRadius(9)
      }.navigationBarTitle(Text("Edit Profile"))
      .alert(isPresented: $showingUpdatedAlert) {
        Alert(title: Text("Data Updated"),
          message: Text("profile is successful to update."),
          dismissButton: .default(Text("OK")))
      }
  .onAppear {
    guard let getName = UserDefaults.standard.value(forKey: "name") else { return }
    guard let getJob = UserDefaults.standard.value(forKey: "job") else { return }
    guard let getEmail = UserDefaults.standard.value(forKey: "email") else { return }
    
    self.name = getName as? String ?? ""
    self.job = getJob as? String ?? ""
    self.email = getEmail as? String ?? ""
    }
  }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
