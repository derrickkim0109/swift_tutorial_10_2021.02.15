//
//  TableViewController.swift
//  Server Json File_02
//
//  Created by Derrick on 2021/02/15.
//

import UIKit

class TableViewController: UITableViewController, JsonModelProtocol{

    //------------
    // Properties
    //------------
    @IBOutlet var tvListView: UITableView!
    
    // Array
    var feedItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 결과값 받아서 띄우기
        // Instance
        let jsonModel = JsonModel()
        jsonModel.delegate = self
        // JsonModel.swift와 연동
        jsonModel.downLoadItems()
        
        // 크기
        tvListView.rowHeight = 130 // Cell Height
    }

    // From JsonModel.swift(locations) to here
    func itemDownLoaded(items: NSArray) {
        feedItem = items
        // 밑의 Table View 관련 소스들이 실행 되는 명령어.
        self.tvListView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count
    }

    
    // Cell 작업할때 DBModel.swift의 Data들이 들어온다는것을 인지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        // Basic Type을 TableViewCell Type으로 바꿈

        // Data 들어오는 곳
        let item: DBModel = feedItem[indexPath.row] as! DBModel
        cell.lblCode?.text = "학번 : \(item.scode!)"
        cell.lblName?.text = "성명 : \(item.sname!)"
        cell.lblDept?.text = "전공 : \(item.sdept!)"
        cell.lblPhone?.text = "전화 : \(item.sphone!)"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
