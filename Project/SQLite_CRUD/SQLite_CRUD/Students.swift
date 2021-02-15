//
//  Students.swift
//  SQLite_CRUD
//
//  Created by Derrick on 2021/02/15.
//

import Foundation

class Students{
    // per value ->
    // stuctor -> class (Static/ Final 쓸려고 할때)
    // ID
    var id: Int
    // ? 들어올수도 있고 안들어올수도 있다. --> Optional
    var name : String?
    var dept : String?
    var phone : String?
    
    // 빈 생성자는 무조건 만들어두어야 한다.
    init(id: Int, name : String?, dept : String?, phone : String?) {
        // this(JAVA) == self
        self.id = id
        self.name = name
        self.dept = dept
        self.phone = phone
    }
    
    
}
