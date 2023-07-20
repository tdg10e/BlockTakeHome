//
//  FilterView.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/19/23.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var selectedTeams: [Team] = []
    @Published var selectedTypes: [EmployeeType] = []

    var returnFilters: ([Team], [EmployeeType]) -> Void

    lazy var teamsViewModel: MultipleChoiceViewModel = {
        MultipleChoiceViewModel(options: Team.allCases.map { $0.rawValue }, isMultiselect: true) { selectedOptions in
            self.selectedTeams = selectedOptions.compactMap { Team(rawValue: $0) }
        }
    }()

    lazy var typesViewModel: MultipleChoiceViewModel = {
        MultipleChoiceViewModel(options: EmployeeType.allCases.map { $0.rawValue }, isMultiselect: true) { selectedOptions in
            self.selectedTypes = selectedOptions.compactMap { EmployeeType(rawValue: $0) }
        }
    }()

    init(returnFilters: @escaping ([Team], [EmployeeType]) -> Void) {
        self.returnFilters = returnFilters
    }
}

struct FilterView: View {
    @ObservedObject var viewModel: FilterViewModel

    var headerButtons: some View {
        HStack {
            Text("Filter Options")
                .font(.title)
                .bold()
                .padding()
                .padding(.leading)
            Spacer()
            Button {
                viewModel.teamsViewModel.clearSelections()
                viewModel.typesViewModel.clearSelections()
            } label: {
                Text("Clear All")
                    .foregroundColor(.charcoal)
            }
            .padding(.trailing, 20)
        }
    }

    var body: some View {
        VStack {
            headerButtons
                .padding(.bottom, 30)

            ScrollView {
                Text("Teams")
                    .font(.subheadline)
                    .bold()
                    .padding(.top)
                    .padding(.bottom, 20)

                MultipleChoiceView(viewModel: viewModel.teamsViewModel)

                Text("Employee Type")
                    .font(.subheadline)
                    .bold()
                    .padding(.top)
                    .padding(.bottom, 20)

                MultipleChoiceView(viewModel: viewModel.typesViewModel)
            }
            
            Button(action: {
                viewModel.returnFilters(viewModel.selectedTeams, viewModel.selectedTypes)
            }) {
                Text("Apply Filters")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: FilterViewModel(returnFilters: { teams, types in
            print(teams)
            print(types)
        }))
    }
}
