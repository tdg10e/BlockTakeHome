//
//  MultipleChoiceView.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import SwiftUI

class MultipleChoiceViewModel: ObservableObject {
    @Published var options: [String]
    @Published var selectedOptions: [String] = [] {
        didSet {
            onSelectOption(selectedOptions)
        }
    }
    @Published var isMultiselect: Bool
    var onSelectOption: ([String]) -> Void

    init(options: [String], isMultiselect: Bool = false, onSelectOption: @escaping ([String]) -> Void) {
        self.options = options
        self.isMultiselect = isMultiselect
        self.onSelectOption = onSelectOption
    }

    func selectOption(_ option: String) {
        if isMultiselect {
            if let index = selectedOptions.firstIndex(of: option) {
                selectedOptions.remove(at: index)
            } else {
                selectedOptions.append(option)
            }
        } else {
            selectedOptions = [option]
        }
    }
    
    func clearSelections() {
        selectedOptions = []
    }
}

struct MultipleChoiceView: View {
    @ObservedObject var viewModel: MultipleChoiceViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack {
                ForEach(viewModel.options, id: \.self) { option in
                    Button(action: {
                        viewModel.selectOption(option)
                    }) {
                        HStack {
                            Text(option)
                                .foregroundColor(.black)
                                .font(.title3)
                                .bold()
                                .padding(.horizontal, 12)
                            Spacer()
                            if viewModel.selectedOptions.contains(option) {
                                IconImage(.sfSymbol(.checkmark), color: Color.gray)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(viewModel.selectedOptions.contains(option) ? Color.lightGray.opacity(0.5) : Color.clear)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 26)
        }
        .ignoresSafeArea(.all)
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    @State static var answer: [String] = []
    static var previews: some View {
        MultipleChoiceView(viewModel: MultipleChoiceViewModel(options: Team.allCases.map{$0.rawValue}, isMultiselect: true, onSelectOption: { options in
            print(options)
        }))
    }
}

