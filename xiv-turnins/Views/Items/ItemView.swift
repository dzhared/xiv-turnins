import SwiftUI

// MARK: - ItemView

struct ItemView: View {
    
    // MARK: Properties
    
    /// The `Item` to be displayed.
    let item: Item
    
    /// The formatted URL of the `item` icon.
    var iconURL: URL? {
        let urlString = "https://xivapi.com\(item.icon)"
        return URL(string: urlString)
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationLink(destination: ItemDetailView(item: item)) {
            HStack {
                AsyncImage(url: iconURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 10)
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding([.leading],7)
                Spacer()
            }
        }
    }
}

// MARK: - PreviewProvider

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                ItemView(item: Item.example)
            }
        }
    }
}
