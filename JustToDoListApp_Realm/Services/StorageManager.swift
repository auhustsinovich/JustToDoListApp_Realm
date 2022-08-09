//
//  StorageManager.swift
//  JustToDoListApp_Realm
//
//  Created by Daniil Auhustsinovich on 8.08.22.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    // точка входа в базу данных
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task Lists
    
    func saveLists(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func saveList(_ taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func deleteList(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func editList(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func doneList(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    // MARK: - Tasks
    
    func saveTask(_ task: Task, to taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    func deleteTask(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func editTask(_ task: Task, newName name: String, withnote note: String) {
        write {
            task.name = name
            task.note = note
        }
    }
    
    func doneTask(_ task: Task) {
        write {
            task.isComplete.toggle()
        }
    }
    
    // MARK: - Realm save data
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
