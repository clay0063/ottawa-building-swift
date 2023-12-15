//
//  SubmitBuilding.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-14.
//

import Foundation
import Firebase


class SubmissionModel: ObservableObject {
    @Published var submissions: [Submission] = []
    private let submissionRef = Firestore.firestore().collection("Buildings")
    
    init() {
        fetchAllSubmissions()
    }
    
    func fetchAllSubmissions() {
        self.submissions.removeAll()
        submissionRef.getDocuments {
            snapshot,
            error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    
                    let submission = Submission(
                        id: id,
                        name: name,
                        category: category,
                        description: description
                    )
                    self.submissions.append(submission)
                }
            }
        }
    }
    
    func submitBuilding(building: Submission){
        let ref = submissionRef.document(building.id)
        
        ref.setData(
            [
                "id": building.id,
                "name": building.name,
                "category": building.category,
                "description": building.description
            ]
        ) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if !self.submissions.contains(where: { $0.id == building.id }) {
                    self.submissions.append(building)
                }
            }
        }
    }
}







