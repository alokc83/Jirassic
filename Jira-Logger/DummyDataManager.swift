//
//  DummyDataManager.swift
//  Jira-Logger
//
//  Created by Baluta Cristian on 29/03/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Cocoa

class DummyDataManager: NSObject {

	class func data() -> [JiraData] {
		
		let d1 = JiraData()
		d1.date_task_finished = NSDate()
		d1.issue_nr = "AN-3422"
		d1.notes = "Finished the task by deleting the whole project..."
		
		let d1_1 = JiraData()
		d1_1.date_task_finished = NSDate().dateByAddingTimeInterval(-500100)
		d1_1.issue_nr = "AN-3425"
		d1_1.notes = "Finished the task by deleting the whole project..."
		
		let d2 = JiraData()
		d2.date_task_finished = NSDate().dateByAddingTimeInterval(-500000)
		d2.issue_nr = "AN-3423"
		d2.notes = "Finished the task by deleting the whole project..."
		
		let d3 = JiraData()
		d3.date_task_finished = NSDate().dateByAddingTimeInterval(-369000)
		d3.issue_nr = "AN-3423"
		d3.notes = "Finished the task by deleting the whole project. Finished the task by deleting the whole project..."
		
		let d4 = JiraData()
		d4.date_task_finished = NSDate().dateByAddingTimeInterval(-106500)
		d4.issue_nr = "AN-3423"
		d4.notes = "Finished the task by deleting the whole project..."
		
		let d5 = JiraData()
		d5.date_task_finished = NSDate().dateByAddingTimeInterval(-90600)
		d5.issue_nr = "AN-3323"
		d5.notes = "Finished the task by deleting the whole project..."
		
		return [d1, d1_1, d2, d3, d4, d5]
	}
	
	class func dates() -> [JiraData] {
		
		var objects = data()
		var currrentDate = NSDate.distantFuture() as! NSDate
		objects = objects.filter { (object: JiraData) -> Bool in
			RCLogO("> \(object.date_task_finished) isTheSameDayAs \(currrentDate) \(object.date_task_finished!.isTheSameDayAs(currrentDate))")
			if object.date_task_finished!.isTheSameDayAs(currrentDate) == false {
				currrentDate = object.date_task_finished!
				return true
			}
			return false
		}
		
		return objects
	}
	
	class func tasksForDate(date: NSDate) -> [JiraData] {
		
		var objects = data()
		objects = objects.filter { (object: JiraData) -> Bool in
			RCLogO("tasks for date: \(date)")
			RCLogO(object)
			RCLogO(object.date_task_finished!.isTheSameDayAs( date ))
			return object.date_task_finished!.isTheSameDayAs( date )
		}
		
		return objects
	}
}
