//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Bryan Gomez on 8/9/21.
//

import Foundation
import CloudKit

struct EntryStrings {
    static let recordTypeKey = "Entry"
    
    fileprivate static let titleKey = "title"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestampKey = "timestamp"
}

class Entry {
    
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecord: CKRecord.ID =  CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecord
    }
}
// Innits the Entry Model with the CKRecord string keys. 
extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
              let body = ckRecord[EntryStrings.bodyKey] as? String,
              let timestamp = ckRecord[EntryStrings.timestampKey] as? Date  else {return nil}
        self.init(title: title, body: body, timestamp: timestamp, ckRecord: ckRecord.recordID)
    }
}
// Create our CKRecords with Entry and saves it to the iCloud
extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey, recordID: entry.ckRecordID)
        self.setValuesForKeys([
            EntryStrings.titleKey : entry.title,
            EntryStrings.bodyKey : entry.body,
            EntryStrings.timestampKey : entry.timestamp
        ])
    }
}
