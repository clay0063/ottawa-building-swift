//
//  TestPage.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-07.
//

import SwiftUI

struct TestPage: View {
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let category1: Bool
        let category2: Bool
        let category3: Bool
        // Add more categories...
    }

    let jsonData: [Item] = [
        Item(name: "Item 1", category1: true, category2: false, category3: false),
        Item(name: "Item 2", category1: false, category2: true, category3: false),
        Item(name: "Item 3", category1: true, category2: true, category3: false),
        // Add more items...
    ]

    @State private var selectedCategories: Set<String> = []

    let categories: [(name: String, keyPath: KeyPath<Item, Bool>)] = [
        ("Category 1", \.category1),
        ("Category 2", \.category2),
        ("Category 3", \.category3),
        // Add more categories...
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(jsonData.filter { item in
                    let result = selectedCategories.isEmpty || categories.allSatisfy { category in
                        let categoryValue = item[keyPath: category.keyPath]
                        print("\(category.name): \(categoryValue)")
                        return (!selectedCategories.contains(category.name) || categoryValue)
                    }
                    return result
                }) { item in
                    Text(item.name)
                }
            }
            .navigationTitle("Filtered List")
            .navigationBarItems(trailing:
                HStack {
                    Text("Filter:")
                    ForEach(categories, id: \.name) { category in
                        Button(action: {
                            toggleCategory(category.name)
                        }) {
                            Text(category.name)
                                .fontWeight(selectedCategories.contains(category.name) ? .bold : .regular)
                        }
                    }
                }
            )
        }
    }

    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}


#Preview {
    TestPage()
}
