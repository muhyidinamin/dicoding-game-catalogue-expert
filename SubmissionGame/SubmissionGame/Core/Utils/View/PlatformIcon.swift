//
//  PlatformIcon.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 03/02/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI

struct PlatformIcon: View {
    var platform: String

    var body: some View {
      Group {
        if platform == "pc" {
            Image("pc").resizable().frame(width: 20.0, height: 20.0)
        } else if platform == "playstation" {
            Image("ps").resizable().frame(width: 25.0, height: 25.0)
        } else if platform == "xbox" {
            Image("xbox").resizable().frame(width: 20.0, height: 20.0)
        } else if platform == "ios" {
            Image("ios").resizable().frame(width: 20.0, height: 20.0)
        } else if platform == "mac" {
            Image("apple").resizable().frame(width: 20.0, height: 20.0)
        } else if platform == "linux" {
            Image("linux").resizable().frame(width: 20.0, height: 20.0)
        } else if platform == "nintendo" {
            Image("nintendo").resizable().frame(width: 18.0, height: 18.0)
        } else if platform == "android" {
            Image("android").resizable().frame(width: 20.0, height: 20.0)
        } else {
            Text(platform)
        }
      }
    }
}
