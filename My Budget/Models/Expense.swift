//
//  Expense.swift
//  My Budget

//- used to take all records for expense in db


import UIKit

class Expense: NSObject {
    var expenseId:       Int
    var date:            CLongLong
    var value:           Double
    var categoryId :     Int
    var subCategoryId:   Int
    var weekOfYear:      Int
    var subcategoryName: String
    
    
    init(fmresultSet: FMResultSet) {
        self.expenseId       = Int(fmresultSet.int(forColumn: fieldId))
        self.date            = CLongLong(fmresultSet.long(forColumn: fieldDate))
        self.value           = Double(fmresultSet.double(forColumn: fieldValue))
        self.categoryId      = Int(fmresultSet.int(forColumn: fieldCategoryId))
        self.subCategoryId   = Int(fmresultSet.int(forColumn: fieldSubcategoryId))
        self.weekOfYear      = Int(fmresultSet.int(forColumn: fieldWeekOfYear))
        self.subcategoryName = fmresultSet.string(forColumn: fieldSubcategory)!
    }
    
}
