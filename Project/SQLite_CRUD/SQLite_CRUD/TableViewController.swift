//
//  TableViewController.swift
//  SQLite_CRUD
//
//  Created by Derrick on 2021/02/15.
//

import UIKit
import SQLite3

class TableViewController: UITableViewController {

    ///-----
    // Fields
    //------
    @IBOutlet var tvListView: UITableView!
    
    //Data Base
    var db: OpaquePointer?
    //var studentsList: [Students] = []
    // Empty Type NSArray
    // This is Students Type
    var studentsList = [Students]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // SQLite 생성하기
        // 어디있는지 가져오기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("StudentsData.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
        // 기존의 테이블이 있으면 안만들어지고 없으면 만들어지도록
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS students (sid INTEGER PRIMARY KEY AUTOINCREMENT, sname TEXT, sdept TEXT,sphone TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating ttable: \(errmsg)")
        }
        
        // Temporary Insert
       // tempInsert()
        
        
        
        // Table 내용 불러오기
        readValues()
        
    }
    
    ///-----
    // Actions
    //------
    
    // 제일 처음에 만들때만 쓰고 그다음에는 안쓸것이다.
    func tempInsert(){
        var statement: OpaquePointer?
        // Korean 때문에 필요. -> EN은 필요 없음.
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO students (sname, sdept, sphone) VALUES (?,?,?)"
        
        // 위의 ? 3개에 statement 1,2,3을 넣어 주면 됨
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // 묶어 주는곳
        // 1
        if sqlite3_bind_text(statement, 1, "유비", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding name: \(errmsg)")
            return
        }
        // 2
        if sqlite3_bind_text(statement, 2, "컴퓨터공학과", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding dept: \(errmsg)")
            return
        }
        // 3
        if sqlite3_bind_text(statement, 3, "1234", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding phone: \(errmsg)")
            return
        }
        
        if sqlite3_step(statement) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Failure inserting: \(errmsg)")
            return
        }
        
        // Console에 그냥 출력
        print("Student information saved successfully ")
    }
    
    // Informatiton  --> studentsList Array에 넣은것을 보여주기위해
    func readValues(){
        // 초기화
        studentsList.removeAll()
        
        let queryString = "SELECT * FROM students"
        var statement :OpaquePointer?
        
        // print 잘적어줘야 위에서 Error 인지 아닌지 판단할수 있다.
        // 위의 ? 3개에 statement 1,2,3을 넣어 주면 됨
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        
        // 읽어올 데이터 있는지 여부 판단.(select에 대해)
        while sqlite3_step(statement) == SQLITE_ROW {
            // 제일 처음에 들어온 값. --> 0 번째것.
            let id = sqlite3_column_int(statement, 0)
            // Array [1]
            let name = String(cString: sqlite3_column_text(statement, 1))
            // Array [2]
            let dept = String(cString: sqlite3_column_text(statement, 2))
            // Array [3]
            let phone = String(cString: sqlite3_column_text(statement, 3))
            
            // 확인용
            print(id,name,dept,phone)
            // Array에 추가
            // 한글 포함되어서 describing으로 쓴것이다.
            studentsList.append(Students(id: Int(id), name: String(describing: name), dept: String(describing: dept), phone: String(describing: phone)))
            // database에 담은것.
        }
        // 실행 시키면 Table 밑에 있는것들(Table view data source) 실행시키는 것이다.
        self.tvListView.reloadData()
    }
    
    // 넘어왔을때 다시 읽어줄 부분
    // 넘어오게 되면 viewDidLoad는 아무것도 안함
    override func viewWillAppear(_ animated: Bool) {
        // 다시 table view로 돌아왔을때 list up 함.
        readValues()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // Students 는 Class이다.
        // studentsList 배열에 Students Class Type으로 각각 들어가는 것이다.
        let students: Students
        
        // Table View
        students = studentsList[indexPath.row]
        
        // SubTitle 로 설정해둔 부분 -> 변수이름이 정해져 있다.
        cell.textLabel?.text = "학번 : \(students.id)"
        // id는 반드시 존재하는(Primary Key) 지만 성명은 없을수있으므로
        // optional
        cell.detailTextLabel?.text = "성명 : \(students.name!)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // Detail View 부분이다.
    // Table View의 정보를 넘겨주기 위한부분.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            // cell 값
            // Table View Cell을 정의해서 써야 디자인을 마음대로 바꿔서 쓸수 있다.
            let cell = sender as! UITableViewCell
            
            // Table View를 Click 했을경우 몇번째인지 알려주기
            let indexPath = self.tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! DetailViewController
            
            // Data 넣기
            // Array 에 Students Class Type 을 넣는거다 [0],[1].. 마다.
            // 방식 - 1 (선생님 선호)
            let item: Students = studentsList[(indexPath! as NSIndexPath).row]
            // 같은 것. 다른 방식 -2
            //let item: Students = studentsList[indexPath!.row]
            
            // Id는 Primary Key
            let sid = item.id
            
            let sname = item.name!
            let sdept = item.dept!
            let sphone = item.phone!
            
            // Data 넣을 함수 (DetailView에서 만들 함수)
            detailView.receiveItems(sid, sname, sdept, sphone)
        }
    }
    

}
