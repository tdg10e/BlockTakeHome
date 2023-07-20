//
//  Employee.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/18/23.
//

import Foundation

enum Team: String, Codable, CaseIterable {
    case pos = "Point of Sale"
    case posp = "Point of Sale Platform"
    case marketing = "Public Web & Marketing"
    case retail = "Retail"
    case restaurants = "Restaurants"
    case cash = "Cash"
    case appointments = "Appointments"
    case invoices = "Invoices"
    case hardware = "Hardware"
    case core = "Core"
}

enum EmployeeType: String, Codable, CaseIterable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

struct Employee: Codable, Identifiable {
    var id: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoURLSmall: String
    let photoURLLarge: String
    let team: Team
    let employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}
