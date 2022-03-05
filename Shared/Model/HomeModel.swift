//
//  HomeModel.swift
//  sense-ios
//
//  Created by Michal Šimík on 04.03.2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class HomeModel: ObservableObject {
    @Published var messages: [Message] = []
    @AppStorage("Summer") var username: String?

    func onAppear() {
        readAllMessages()
    }

    func readAllMessages() {
        Firestore.firestore().collection("messages").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            }

            guard let data = snapshot else {
                return
            }

            do {
                try data.documentChanges.forEach { document in
                    if document.type == .added {
                        if let message = try document.document.data(as: Message.self) {
                            DispatchQueue.main.async {
                                self.messages.append(message)
                            }

                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    func sendMessage(message: String) {
        do {
            let messageModel = Message(message: message, user: username ?? "", timestamp: Date())
            try Firestore.firestore().collection("messages").addDocument(from: messageModel, completion: { error in
                print(error)
            })
        } catch {
            print(error)
        }
    }
}
