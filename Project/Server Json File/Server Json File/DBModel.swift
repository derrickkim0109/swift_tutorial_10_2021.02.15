//
//  DBModel.swift
//  Server Json File
//
//  Created by Derrick on 2021/02/15.
//

import Foundation

class DBModel: NSObject{
    
    // Properties == Fields
    var scode: String?
    var sname: String?
    var sdept: String?
    var sphone: String?
    
    // Empty constroctor
    override init() {
        
    }
    
    init(scode: String, sname: String, sdept: String, sphone: String){
        self.scode = scode
        self.sname = sname
        self.sdept = sdept
        self.sphone = sphone
    }
}
