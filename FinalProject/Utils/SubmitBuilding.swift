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







