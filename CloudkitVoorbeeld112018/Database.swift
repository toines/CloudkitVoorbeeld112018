//
//  Database.swift
//  CloudkitVoorbeeld112018
//
//  Created by Toine Schnabel on 12/11/2018.
//  Copyright © 2018 Toine Schnabel. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

struct NaamRecord:Hashable {// nodig voor cloudKit
    let keyVoorNaam = "voorNaam"
    let keyAchterNaam = "achterNaam"
    let recordNaam = "naamRecord"
    var record :CKRecord
    
    static func == (lhs:NaamRecord, rhs:NaamRecord) -> Bool
    {return (lhs.achterNaam == rhs.achterNaam && lhs.voorNaam == rhs.voorNaam)}
    init(record: CKRecord) { self.record = record}
    init(voorNaam:String,achterNaam:String) {
        self.record = CKRecord(recordType: recordNaam)
        self.record.setObject(voorNaam as CKRecordValue?, forKey: keyVoorNaam)
        self.record.setObject(achterNaam as CKRecordValue?, forKey: keyAchterNaam)
     }
    var voorNaam : String{
        get {return self.record.value(forKey: keyVoorNaam) as! String}
        set {self.record.setObject(newValue as CKRecordValue?, forKey: keyVoorNaam)}
    }
    var achterNaam : String{
        get {return self.record.value(forKey: keyAchterNaam) as! String}
        set {self.record.setObject(newValue as CKRecordValue?, forKey: keyAchterNaam)}
    }
}

let zonenaam = "Namen"

class Model
{
    let container = CKContainer.default()     // aanpasing voor Cloudkit
    var privateDatabase: CKDatabase?   // aanpasing voor Cloudkit
    var currentRecord: CKRecord? {   // aanpasing voor Cloudkit
        didSet {
            
        }
    }
    var recordZone: CKRecordZone?   // aanpasing voor Cloudkit
    
    func performSetupCloudKit(){    // functie voor Cloudkit
        privateDatabase = container.privateCloudDatabase
//        recordZone = CKRecordZone(zoneName: zonenaam)
//        if let zone = recordZone {
//            privateDatabase?.save(zone,
//                                  completionHandler: {(recordzone, error) in
//                                    if (error != nil) {
//                                        print ("Record Zone Error Failed to create custom record zone.")
//                                    } else {
//                                        print("Saved record zone")
//                                    }
//            })
//        }
    }
    func saveRecord(record:CKRecord){// functie voor Cloudkit
//        if (recordZone?.zoneID) != nil{
//        let recordsToInsert = copyDB.filter({$0.record.recordID})
            let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
            let configuration = CKOperation.Configuration()
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            modifyRecordsOperation.configuration = configuration
            modifyRecordsOperation.modifyRecordsCompletionBlock =
                { records, recordIDs, error in
                    if let err = error {
                        print ("Save Error \(err.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {print ("Success Record saved successfully")}
                        self.currentRecord = record
                        
                    }
            }
            privateDatabase?.add(modifyRecordsOperation)
//        }
    }




    var copyDB = Set<NaamRecord>()
    var copyDBSortedData = [NaamRecord]()
    var copyDBSorted : [NaamRecord] {get {
        if copyDBSortedData.count != copyDB.count {
            copyDBSortedData = Array(copyDB).sorted{$0.achterNaam < $1.achterNaam} }
        return copyDBSortedData}
        }
    var count : Int {get {return copyDB.count}}
    
    init() {
        performSetupCloudKit()
            }
    func addNaamRecord(voorNaam:String, achterNaam:String){
        let naamRecord = NaamRecord(voorNaam: voorNaam, achterNaam: achterNaam)
        copyDB.insert(naamRecord)
        saveRecord(record: naamRecord.record)
        copyDBSortedData = [NaamRecord]()
    }
    var teDeletenRecords = Set<NaamRecord>()
    func deleteNaamRecord(forRow:Int){
        teDeletenRecords.insert(copyDBSorted[forRow])
        copyDB = copyDB.subtracting(teDeletenRecords)
        copyDBSortedData.remove(at: forRow)
    }
    
    
    
}
