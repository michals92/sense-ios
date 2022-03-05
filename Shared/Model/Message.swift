//
//  Message.swift
//  sense-ios
//
//  Created by Michal Šimík on 05.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var message: String
    var user: String
    var timestamp: Date
}
