//
//  ServerEmulator.swift
//  CoreDataTest
//
//  Created by Sergey Pohrebnuak on 26.03.2020.
//  Copyright © 2020 Sergey Pogrebnyak. All rights reserved.
//

import Cocoa

struct ServerEmulator {
    func loadDataFromCSV() {
        DispatchQueue.global().async {
            let mainQueue = CoreManager.shared.coreManagerContext
            let start = CFAbsoluteTimeGetCurrent()
            var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
            data = self.cleanRows(file: data!)
            let csvRows = self.csv(data: data!)
            print("✅work")
            mainQueue.performAndWait {
                for (index, row) in csvRows.enumerated() {
                    Company(companyName: row[0], context: mainQueue)
                    print(index)
                    usleep(200)
                }
            }
            
            do {
                NotificationCenter.default.post(name: Notification.Name("DataWasLoadedFromServer"), object: nil)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            print("✅work\(CFAbsoluteTimeGetCurrent()-start)")
        }
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func readDataFromCSV(fileName:String, fileType: String) -> String! {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
}
