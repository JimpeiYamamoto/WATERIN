//
//  FirebaseClass.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/04.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class FirebaseClass
{
    var ID = String()
    var contents = [Contents]()
    var filter_contents = [Contents]()
    
    func upload_one_image(name:String, t_info:take_info, image:UIImage, time_info_: TimeClass)
    {
        let c1 = v.DATABASE_C1
        let c2 = t_info.subject!
        var c3 = time_info_.year + time_info_.month + time_info_.day
                + time_info_.hour + time_info_.minute + time_info_.second + "_"
        c3 += ID
        let storageRef = Storage.storage().reference().child(c1).child(c2).child(c3).child(name)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = image.jpegData(compressionQuality: 0.9)
        {
            storageRef.putData(uploadData, metadata: metaData)
            { (metadata , error) in
                if error != nil
                {
                    print("error: \(String(describing: error?.localizedDescription))")
                }
                storageRef.downloadURL(completion:{ (url, error) in
                if error != nil
                {
                    print("error: \(String(describing: error?.localizedDescription))")
                }
                    print("url: \(String(describing: url?.absoluteString))")
                })
            }
        }
    }
    
    func upload_images_storage(t_info:take_info, time_info:TimeClass)
    {
        let name_ref1 = v.REF_1_IMAGE_NAME
        let name_ref2 = v.REF_2_IMAGE_NAME
        let name_target = v.TARGET_IMAGE_NAME
        
        upload_one_image(name: name_ref1, t_info: t_info, image: t_info.ref1_image!, time_info_: time_info)
        if (t_info.subject == v.PH)
        {
            upload_one_image(name: name_ref2, t_info: t_info, image: t_info.ref2_image!, time_info_: time_info)
        }
        upload_one_image(name: name_target, t_info: t_info, image: t_info.target_image!, time_info_: time_info)
    }
    
    func upload_t_info_database(t_info:take_info, l_info:location_info, time_info:TimeClass)
    {
        var values = [String:String]()
        
        values[t_info.subject!] = String(t_info.outcome!)
        values[v.PAPER] = t_info.paper!
        values[v.CATEGORY] = t_info.category!
        
        values[v.YEAR] = time_info.year
        values[v.MONTH] = time_info.month
        values[v.DAY] = time_info.day
        values[v.HOUR] = time_info.hour
        values[v.MINUTE] = time_info.minute
        values[v.SECOND] = time_info.second
        let ope_con = operate_contents()
        values[v.TIME] = ope_con.get_time_string(year: values[v.YEAR]!, month: values[v.MONTH]!, day: values[v.DAY]!, hour: values[v.HOUR]!, minute: values[v.MINUTE]!, second: values[v.SECOND]!)
        
        values[v.ADDRESS] = l_info.address!
        values[v.LAT] = l_info.lat!
        values[v.LOT] = l_info.lot!
        /** stil not send RGB data */
        
        let c1 = v.STORAGE_C1
        let c2 = t_info.subject!
        var c3 = time_info.year + time_info.month + time_info.day + time_info.hour + time_info.minute + time_info.second + "_"
        c3 += ID
        let database = Database.database().reference().child(c1).child(c2).child(c3)
        database.setValue(values)
    }
    
    func generatorID(_ length: Int)
    {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 0 ..< length {
            randomString += String(letters.randomElement()!)
        }
        ID = randomString
    }
    
    func fetch_firebase(subject:String)
    {
        contents.removeAll()
        _ = Database.database().reference().child(v.STORAGE_C1).child(subject).queryOrderedByKey().observe(.value)
        { [self] snapshot in
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snapShot
                {
                    if let postData = snap.value as? [String:String]
                    {
                        let outcome = postData[subject]
                        let category = postData[v.CATEGORY]
                        let paper = postData[v.PAPER]
                        let address = postData[v.ADDRESS]
                        let lat = postData[v.LAT]
                        let lot = postData[v.LOT]
                        let year = postData[v.YEAR]
                        let month = postData[v.MONTH]
                        let day = postData[v.DAY]
                        let hour = postData[v.HOUR]
                        let minute = postData[v.MINUTE]
                        let second = postData[v.SECOND]
                        let timestr = postData[v.TIME]
                        print(postData)
                        contents.append(Contents(atai: Double(outcome!)!, address: address!, lat: lat!, lot: lot!, time: timestr!,
                                                 year: year!, month: month!, day: day!, hour: hour!,
                                                 minute: minute!, second: second!, category: category!, sikensi: paper!))
                    }
                }
            }
        }
        print("fetch_firebase_contents")
        print("content.count=\(contents.count)")
        print(contents)
        print("________________________")
    }
    
    func filter_content(start:String, stop:String)
    {
        filter_contents = operate_contents().filter_content_by_time(contents: contents, start: start, stop: stop)
    }
}
