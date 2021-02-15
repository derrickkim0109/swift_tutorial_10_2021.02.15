//
//  JsonModel.swift
//  Server Json File_02
//
//  Created by Derrick on 2021/02/15.
//

import Foundation

// Java interface와 똑같은것 Protocol
protocol JsonModelProtocol: class{
    func itemDownLoaded(items : NSArray)
}

class JsonModel: NSObject {
    //-----------
    // Properties
    //-----------
    var delegate: JsonModelProtocol!
    let urlPath = "http://127.0.0.1:8080/iOS/student.json"
    
    func downLoadItems(){
        let url = URL(string : urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                // student.json 파일안에 있는 data를 이곳에 넘겨주는 것이다.
                self.parseJSON(data!)
            }
        }
        // 실행시키는 것
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            // object 바로 불러온다. Android 때처럼 userInfo 처럼 따로 이름이 없다
            // Data 하나씩 들어가 있다.
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        }catch let error as NSError{
            print(error)
        }
        
        // 가져온 Data를 분리해서 보기
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        // {} 스코프 되있는 Data가 2개 있었다.
        for i in 0..<jsonResult.count {
            // NSDictionary Type 으로 바꿔주는부분.
            jsonElement = jsonResult[i] as! NSDictionary
            // DBModel 은 Bean이다. <- 한꺼번에 DATA 여기에 넣는다;.
           // let query = DBModel() - First Version
            
            
            if let scode = jsonElement["code"] as? String,
               let sname = jsonElement["name"] as? String,
               let sdept = jsonElement["dept"] as? String,
               let sphone = jsonElement["phone"] as? String
            {
                //- Second Version
               let query = DBModel(scode: scode, sname: sname, sdept: sdept, sphone: sphone)
//                query.scode = scode
//                query.sname = sname
//                query.sdept = sname
//                query.sphone = sphone
                // NSMutableArray()  - Second Version
                locations.add(query)
            }
            // - First Version
            //locations.add(query)
            
        }// For Statement 'END'
        
        // delegate <- one of the properties
        DispatchQueue.main.async(execute: {() -> Void in
            // Array만든것을 넣어 줄거다.
            self.delegate.itemDownLoaded(items: locations)
        })
    }
}
