//
//  Event.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/26.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import Foundation

struct Event {

    var id: String
    var name: String
    var localDate: String
    var localTime: String
    var waitlistCount: Int
    var yesRsvpCount: Int
    var venueName: String
    var groupName: String
    var link: String
    var description: String
    var visibility: String
    var memberPayFee: Bool

    var users: [String] = []

    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "localDate": localDate,
            "localTime": localTime,
            "waitlistCount": waitlistCount,
            "yesRsvpCount": yesRsvpCount,
            "venueName": venueName,
            "groupName": groupName,
            "link": link,
            "description": description,
            "visibility": visibility,
            "memberPayFee": memberPayFee,

            "users": users
        ]
    }

    init(id: String,
         name: String,
         localDate: String,
         localTime: String,
         waitlistCount: Int,
         yesRsvpCount: Int,
         venueName: String,
         groupName: String,
         link: String,
         description: String,
         visibility: String,
         memberPayFee: Bool,
         users: [String]) {

        self.id = id
        self.name = name
        self.localDate = localDate
        self.localTime = localTime
        self.waitlistCount = waitlistCount
        self.yesRsvpCount = yesRsvpCount
        self.venueName = venueName
        self.groupName = groupName
        self.link = link
        self.description = description
        self.visibility = visibility
        self.memberPayFee = memberPayFee
        self.users = users
    }

}

extension Event: DocumentSerializable {
    
    init?(dictionary: [String : Any]) {
        guard
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let localDate = dictionary["localDate"] as? String,
            let localTime = dictionary["localTime"] as? String,
            let waitlistCount = dictionary["waitlistCount"] as? Int,
            let yesRsvpCount = dictionary["yesRsvpCount"] as? Int,
            let venueName = dictionary["venueName"] as? String,
            let groupName = dictionary["groupName"] as? String,
            let link = dictionary["link"] as? String,
            let description = dictionary["description"] as? String,
            let visibility = dictionary["visibility"] as? String,
            let memberPayFee = dictionary["memberPayFee"] as? Bool,

            let users = dictionary["users"] as? [String]
            else {
                return nil
        }

        self.init(id: id,
                  name: name,
                  localDate: localDate,
                  localTime: localTime,
                  waitlistCount: waitlistCount,
                  yesRsvpCount: yesRsvpCount,
                  venueName: venueName,
                  groupName: groupName,
                  link: link,
                  description: description,
                  visibility: visibility,
                  memberPayFee: memberPayFee,
                  users: users)
    }

}
