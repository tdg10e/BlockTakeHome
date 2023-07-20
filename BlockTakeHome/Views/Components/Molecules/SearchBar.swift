//
//  SearchBar.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import SwiftUI

class SearchBarViewModel: ObservableObject {
    @Published var searchText = ""
    var onSearch: (String) -> Void
    private var debouncer: Debouncer

    init(onSearch: @escaping (String) -> Void) {
        self.onSearch = onSearch
        self.debouncer = Debouncer(delay: 0.5)
        
        self.debouncer.callback = { [weak self] in
            self?.onSearch(self?.searchText ?? "")
        }
    }

    func searchTextChanged(to newText: String) {
        searchText = newText
        debouncer.call()
    }
}

struct SearchBar: View {
    @ObservedObject var viewModel: SearchBarViewModel
    @State private var searchText: String = ""

    var body: some View {
        HStack {
            TextField("Enter the name of an employee..", text: $searchText)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .onChange(of: searchText) { newValue in
                    viewModel.searchTextChanged(to: newValue)
                }
            IconImage(.sfSymbol(.magnifyingGlass), color: Color.charcoal)
                .padding(.trailing, 10)
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 12)
        .background(Color(.systemGray5))
        .cornerRadius(40)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(viewModel: SearchBarViewModel( onSearch: { searchResult in
            print(searchResult)
        }))
    }
}
