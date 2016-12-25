//
//  ScriptableApplication.swift
//  Jirassic
//
//  Created by Baluta Cristian on 28/11/15.
//  Copyright © 2015 Cristian Baluta. All rights reserved.
//

import Cocoa

extension NSApplication {
	
	func tasks() -> String {
		return "Tasks returned from Jirassic"
	}
	
	func setTasks (_ json: String) {
        
        RCLog(json)
        let validJson = json.replacingOccurrences(of: "'", with: "\"")
        
        if let data = validJson.data(using: String.Encoding.utf8) {
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
                    return
                }
                RCLog(dict)
                let notes = dict["notes"] ?? ""
                let branchName = dict["branchName"] ?? ""
                let taskNumber = dict["taskNumber"] != "null" ? dict["taskNumber"]! : branchName
                let taskType = dict["taskType"] != nil ? TaskType(rawValue: Int(dict["taskType"]!)!)! : TaskType.gitCommit
                let informativeText = "\(taskNumber): \(notes)"
                
                let saveInteractor = TaskInteractor(repository: localRepository)
                let reader = ReadTasksInteractor(repository: localRepository)
                let currentTasks = reader.tasksInDay(Date())
                if currentTasks.count == 0 {
                    let startDayMark = Task(dateEnd: Date(hour: 9, minute: 0), type: TaskType.startDay)
                    saveInteractor.saveTask(startDayMark)
                }
                
                let task = Task(
                    startDate: nil,
                    endDate: Date(),
                    notes: notes,
                    taskNumber: taskNumber,
                    taskType: taskType,
                    objectId: String.random()
                )
                saveInteractor.saveTask(task)
                
                UserNotifications().showNotification("Git commit logged", informativeText: informativeText)
                InternalNotifications.notifyAboutNewlyAddedTask(task)
            }
            catch let error as NSError {
                RCLogErrorO(error)
            }
        }
	}
	
	func logCommit (_ commit: String, ofBranch: String) {
		RCLog(commit)
		RCLog(ofBranch)
	}
}