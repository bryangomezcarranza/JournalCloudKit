//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Bryan Gomez on 8/9/21.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    var entries: [Entry] = []
    
    // TO ACCESS PRIVATE DATA.
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK: - CRUD Functions
    
    func createEntryWith(title: String, body: String, completion: @escaping (_ results: Result<Entry?, EntryError>) -> Void) {
        let newEntry = Entry(title: title, body: body)
        
        save(entry: newEntry, completion: completion)
    }
    
    func save(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        
        let entry = CKRecord(entry: entry)
        privateDB.save(entry) { record, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            guard let record = record, let savedEntryRecord = Entry(ckRecord: record) else { return completion(.failure(.couldNotUnwrap)) }
            
            self.entries.insert(savedEntryRecord, at: 0)
            completion(.success(savedEntryRecord))
            
        }
    }
    
    func fetchEntriesWith(completion: @escaping(Result<[Entry]?, EntryError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            print("Records were fetched!")
            
            let entries = records.compactMap({ Entry(ckRecord: $0) })
            completion(.success(entries))
        }
    }
}
