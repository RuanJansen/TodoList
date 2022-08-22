//
//  TodoModel.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import Foundation

struct Tasks: Codable, Hashable, Identifiable{
    var id: Int
    var title: String
    var description: String
    var entryDate: Date
    var dueDate: Date
    var isDone: Bool
    var isArchived: Bool
}
