//
//  FavoriteManager.swift
//  0610
//
//  Created by Chris on 2019/8/8.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let favoriteManager = FavoriteManager.sharedInstance

final class FavoriteManager {

    // MARK: - Singleton

    static let sharedInstance = FavoriteManager()

    // MARK: - Variables

//    var favoriteCafe: LocalCollection<Cafe>!

    func addFavoriteEvent(_ event: Event) {
        guard let currentUser = Auth.auth().currentUser else { return }



        let docRef = Firestore.firestore().collection("FavoriteEvents").document("\(event.name)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                log.debug("Document data: \(dataDescription)")

                docRef.updateData(["users": FieldValue.arrayUnion(["\(currentUser.uid)"])])
                log.debug("Add Favorite Document")
            } else {
                var event = event
                event.users.append(currentUser.uid)

                docRef.setData(event.dictionary)
                log.debug("Add Favorite Document")
            }
        }
    }

    func removeFavoriteEvent(_ event: Event) {
        guard let currentUser = Auth.auth().currentUser else { return }

        let docRef = Firestore.firestore().collection("FavoriteEvents").document("\(event.name)")

        docRef.updateData(["users":FieldValue.arrayRemove(["\(currentUser.uid)"])])
    }

    func isEventCollected(_ event: Event, completion: @escaping (_ collected: Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false)
            return
        }

        let docRef = Firestore.firestore().collection("FavoriteEvents").document("\(event.name)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                log.debug("Document data: \(dataDescription)")f

                var isCollected = false
                if let event = Event(dictionary: document.data()!) {
                    for (_, user) in event.users.enumerated() {
                        if user == "\(currentUser.uid)" {
                            isCollected = true
                            log.debug("Event \(event.name) isCollected")
                        }
                    }
                }
                completion(isCollected)

            } else {
                log.debug("Event \(event.name) is not collected")
                completion(false)
            }
        }
    }

    func getEvents(_ completion: @escaping (_ events: [Event]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion([])
            return
        }

        let collection = Firestore.firestore().collection("FavoriteEvents")

        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                log.error("Getting Documents Error: \(error.localizedDescription)")
            } else {
                let events = querySnapshot?.documents.map { (document) -> Event in
                    if let event = Event(dictionary: document.data()) {
                        return event
                    } else {
                        // Don't use fatalError here in a real app.
                        fatalError("Unable to initialize type \(Event.self) with dictionary \(document.data())")
                    }
                }

                if let events = events {
                    var collectedEvents: [Event] = []

                    for (_, event) in events.enumerated() {
                        for (_, user) in event.users.enumerated() {
                            if user == "\(currentUser.uid)" {
                                collectedEvents.append(event)
                            }
                        }
                    }

                    completion(collectedEvents)
                } else {
                    completion([])
                }
            }
        }
    }

}
