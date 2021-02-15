//
//  ViewController.swift
//  Server Image Download
//
//  Created by Derrick on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {

    //-------------
    // Fields
    //-------------
    
    @IBOutlet weak var imgDisplay: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //-------------
    // Actions
    //-------------
    
    @IBAction func btnLoadImage(_ sender: UIButton) {
        downLoadItems()
    }
    
    // DownLoad
    func downLoadItems(){
        let url: URL = URL(string: "http://127.0.0.1:8080/jpg/dog2.jpg")!
        // 연결용
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        // AsyncTask
        let task = defaultSession.dataTask(with: url){(data, respondse, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                //---------------------
                // JSon, JSP 들어갈 부분.
                //---------------------
                print("Data is downloading")
                DispatchQueue.main.async {
                    //maintask
                    self.imgDisplay.image = UIImage(data: data!)
                    // download png
//                    if let image = UIImage(data: data!){
//                        if let data = image.pngData() {
//                            // File Name 만들기 (서버에서 받아서 쓸 File)
//                            let fileName = self.getDocumentDirectory().appendingPathComponent("copy.png")
//                            try? data.write(to: fileName)
//                        }
//                    }
                    // download jpg
                    if let image = UIImage(data: data!){
                        if let data = image.jpegData(compressionQuality: 0.8){
                            // File Name 만들기 (서버에서 받아서 쓸 File)
                            let fileName = self.getDocumentDirectory().appendingPathComponent("copy.png")
                            try? data.write(to: fileName)
                            
                            print("Data is writed")
                            // File save 어디에 됬는지 확인하기 위해.
                            print(self.getDocumentDirectory())
                        }
                    }
                }
            } // else END
            
        } // task END
        // 실행 시켜주는 statement
        task.resume()
        
    }
    
    // PATH
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
    
    
}////-----END

