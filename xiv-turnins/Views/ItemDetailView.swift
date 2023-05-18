//
//  ItemDetailView.swift
//  xiv-turnins
//
//  Created by Jared on 4/7/23.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack(alignment: .center) {
                        AsyncImage(url: URL(string: "https://xivapi.com\(item.icon)"), scale: 1.5)
                            .padding(.trailing, 5)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                            Text("ilvl \(item.levelItem)")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            if let equipClass = item.classJobCategory.equipClass {
                                Text(equipClass)
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Section {
                        HStack {
                            Image(item.classJob.1)
                                .resizable()
                                .frame(width: 45, height: 45, alignment: .topLeading)
                            VStack(alignment: .leading) {
                                Text("Level \(item.itemRecipeInfo[0].level) \(item.classJob.1)")
                                    .font(.title3)
                            }
                        }
                    }
                    IngredientListView(recipeID: item.itemRecipeInfo[0].id)
                }
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item.example)
    }
}
