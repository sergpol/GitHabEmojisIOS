//
//  Emoji.swift
//  GitHub API emojis
//
//  Created by Сергей Полицинский on 07.09.2018.
//  Copyright © 2018 GitHub. All rights reserved.
//

import Foundation
import EVReflection

class Emoji: EVNetworkingObject {
    var name: String = ""
    var url: String = ""
}

class EmojiResponse: EVNetworkingObject {
    var name: String?
    var url: String?
}

////////////////////////////////////////////////
class Actor: EVNetworkingObject {
    var id: String?
    var login: String?
}

class Repo: EVNetworkingObject {
    var id: String?
    var name: String?
}

class Event: EVNetworkingObject {
    var actor: Actor?
    var repo: Repo?
    var created_at: String?
    var pub: Bool = false
    var type: String?
    
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "pub", keyInResource: "public")]
    }
}

class EventsResponse: EVNetworkingObject {
    var events: [Event] = []
}
