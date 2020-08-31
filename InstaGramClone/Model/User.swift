//
//  User.swift
//  InstaGramClone
//
//  Created by MANINDER SINGH on 13/08/20.
//  Copyright © 2020 MANINDER SINGH. All rights reserved.
//

import Foundation
class User {
    var username:String!
    var name : String!
    var profileImageUrl:String!
    var uid:String!
    init(uid:String,dictionary: Dictionary<String,AnyObject>) {
        self.uid = uid
        if let username = dictionary["username"] as? String{
            self.username = username
        }
        if let name = dictionary["name"] as? String{
            self.name = name
        }
        if let profileImageUrl = dictionary["profileImageUrl"] as? String{
            self.profileImageUrl = profileImageUrl
        }
    }
}
