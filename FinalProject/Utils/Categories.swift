//
//  Categories.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-10.
//

import Foundation
import SwiftUI

class CategoryManager {
    struct CategoryWithIcon {
        var category: String
        var icon: Image
    }
    
    var categoriesWithIcons = [CategoryWithIcon]()
    
    let categoriesEng = [
        "All Categories",
        "Academic Institutions",
        "Business and/or Foundations",
        "Community and/or Care centres",
        "Embassies",
        "Functional Buildings",
        "Galleries and Theatres",
        "Government buildings",
        "Museums, Archives, and Historic Sites",
        "Other",
        "Religious buildings",
        "Sports and Leisure buildings"
    ]
    
    let categoryIcons = [
        Image("search"),
        Image("academicsFilter"),
        Image("businessFilter"),
        Image("communityFilter"),
        Image("embassyFilter"),
        Image("functionalFilter"),
        Image("galleriresFilter"),
        Image("governmentBuildingsFilter"),
        Image("museumsFilter"),
        Image("otherFilter"),
        Image("newReligionHandsFilter"),
        Image("sportsFilter")
    ]
    
    init() {
        for index in 0..<min(categoriesEng.count, categoryIcons.count) {
            let categoryWithIcon = CategoryWithIcon(category: categoriesEng[index], icon: categoryIcons[index])
            categoriesWithIcons.append(categoryWithIcon)
        }
    }
    
    func getAllCategories() -> [(String, Image)] {
        return categoriesWithIcons.map { ($0.category, $0.icon) }
    }
    
    
}
