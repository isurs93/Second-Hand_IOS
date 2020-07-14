//
//  MySQLForAddPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/21.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

class BoardInsert: NSObject{

    func insertBoard(title: String, content: String, price:String , location:String,latitude:String,longitude:String) -> Bool{
        print("board content insert start")
        var result: Bool = true
        var urlPath = "\(coreIP)board_Insert.jsp?title=\(title)&content=\(content)&user_Seqno=\(String(describing: user_Seqno!))&price=\(price)&sido=\(location)&latitude=\(latitude)&longitude=\(longitude)"
        
        print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
                
            }else{
               print("board content Data is inserted!")
                result = true
            }
        }
        task.resume()
        
        return result
      
    }
    
    
    func insertImage(imgURL: String,bSeqno:Int) {
         // var result: Bool = true
          var urlPath = "\(coreIP)image_Insert.jsp?imgString=\(imgURL)&bSeqno=\(bSeqno)"
          print("insert image path start")
          print(urlPath)
          // 한글 url encoding 2byte문자를 1byte문자로 변환
          urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
          
          let url = URL(string: urlPath)!
          let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
          
          let task = defaultSession.dataTask(with: url){(data, response, error) in
              if error != nil{
                  print("Failed to insert img")
                  //result = false
                  
              }else{
                 print("Img is inserted!")
                  //result = true
              }
          }
          task.resume()
          //return result
      }
    
    func updateBoardHit(bSeqno:Int){
        var urlPath = "\(coreIP)board_UpdateHit.jsp?bSeqno=\(bSeqno)"
        
        print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert board Hit")
               
            }else{
               print("board Hit is inserted!")
                
            }
        }
        task.resume()
    }
    
    func insertDeleteDate(bSeqno:Int){
        var urlPath = "\(coreIP)boardDeleteDate.jsp?bSeqno=\(bSeqno)"
        
        print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert board Hit")
               
            }else{
               print("board Hit is inserted!")
                
            }
        }
        task.resume()
    }
    
    func insertIsDone(bSeqno:Int){
        var urlPath = "\(coreIP)boardIsDone.jsp?bSeqno=\(bSeqno)"
        
        print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert board Hit")
               
            }else{
               print("board Hit is inserted!")
                
            }
        }
        task.resume()
    }
    
    
    
    
    
}
