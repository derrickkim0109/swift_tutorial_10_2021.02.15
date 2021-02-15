//
//  AddViewController.swift
//  SQLite_CRUD
//
//  Created by Derrick on 2021/02/15.
//

import UIKit
import SQLite3

class AddViewController: UIViewController {
   
    ///-----
    // Fields
    //------
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMajor: UITextField!
    @IBOutlet weak var txtTelNo: UITextField!
    
    //Data Base
    var db: OpaquePointer?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. SQLite 생성하기
        // 어디있는지 가져오기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("StudentsData.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }
    
    ///-----
    // Actions
    //------
    
    // Insert Function
    @IBAction func btnInsert(_ sender: UIButton) {
        var statement: OpaquePointer?
        // Korean 때문에 필요. -> EN은 필요 없음.
        // unsafeBitCast 꼭 써야 한다.
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        // 2. 사용자가 입력한값 가져오기
        let name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dept = txtMajor.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = txtTelNo.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //----------
        
        let queryString = "INSERT INTO students (sname, sdept, sphone) VALUES (?,?,?)"
        
        // 위의 ? 3개에 statement 1,2,3을 넣어 주면 됨
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // 묶어 주는곳
        // 1
        if sqlite3_bind_text(statement, 1, name, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding name: \(errmsg)")
            return
        }
        // 2
        if sqlite3_bind_text(statement, 2, dept, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding dept: \(errmsg)")
            return
        }
        // 3
        if sqlite3_bind_text(statement, 3, phone, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding phone: \(errmsg)")
            return
        }
        
        if sqlite3_step(statement) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Failure inserting: \(errmsg)")
            return
        }
        
        // 3. 입력이 잘되었다고 Message
        let resultAlert = UIAlertController(title: "결과", message: "입력 되었습니다.", preferredStyle: UIAlertController.Style.alert)
        // 입력창에서 Table View로 다시 넘어가게 하는것을 만듬.
        let okAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: {ACTION in
            // Current Screen Close
            self.navigationController?.popViewController(animated: true)
        })
        resultAlert.addAction(okAction)
        present(resultAlert, animated: true, completion: nil)
        
        // Console에 그냥 출력
        print("Student information saved successfully")
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
