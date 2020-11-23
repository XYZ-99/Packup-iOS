//
//  Deadline.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/11/23.
//

import Foundation

struct Deadline {
    var uid: Int
    var name: String?
    var description: String?
    var event_type: String?
    var course_object_id: String?
    var source_name: String?
    var reminder: UInt64?
    /* 从教学网抓下来的时间 */
    var crawl_update_time: UInt64?
    /* 和服务器同步的时间 */
    var sync_time: UInt64?
    var due_time: UInt64?
    var is_finished: Bool
    var is_deleted: Bool
    var is_starred: Bool
    var has_submission: Bool
}
