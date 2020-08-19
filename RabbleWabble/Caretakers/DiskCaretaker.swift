//
//  DiskCaretaker.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import Foundation

public final class DiskCaretaker {
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    // to save codable object
    
    public static func save<T: Codable> (_ object: T, to fileName: String) throws {
        do {//generic method that takes any object
            
            let url = createDocumentURL(withFileName: fileName)
            
            let data = try encoder.encode(object)// to fix error from data (try)
            
            try data.write(to: url, options: .atomic)// to call data.write, atomic: to create a temporary file and then move it
            
        } catch (let error) {
            print("Save failed: Object: `\(object)`, " + "Error: `\(error)`")
            throw error
        }
    }
    // To creat a file URL and call retrive
    public static func retrive <T:Codable>(_ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumentURL(withFileName: fileName)
        return try retrive(T.self, from: url)
    }
    
    public static func retrive<T:Codable> (_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)// "Try" because it may fail
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            print("Retrieve failed: URL: `\(url)`, Error: `\(error)`")
        throw error
        }
    }
    //create a document url
    //this method finds the documents directory and appends the given name
    public static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
}
