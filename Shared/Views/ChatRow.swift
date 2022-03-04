//
//  ChatRow.swift
//  sense-ios
//
//  Created by Michal Šimík on 04.03.2022.
//

import SwiftUI

struct ChatRow: View {
    var message: Message
    @AppStorage("Summer") var user = ""

    var body: some View {
        HStack(spacing: 15) {
            if message.user != user {
                Nickname(name: message.user)
            } else {
                Spacer()
            }

            VStack(alignment: message.user == user ? .trailing : .leading, spacing: 5) {
                Text(message.message)
                    .fontWeight(.semibold)
                Text(message.timestamp, style: .time)
                    .font(.caption2)
            }
        }
    }
}

struct Nickname: View {
    var name: String
    @AppStorage("Summer") var user = ""

    var body: some View {
        Text(String(name.first ?? Character("")))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background((name == user ? Color.white : Color.green).opacity(0.5))
            .clipShape(Circle())
    }
}
