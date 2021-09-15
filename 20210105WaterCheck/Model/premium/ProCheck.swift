//
//  ProCheck.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/30.
//

import Foundation
import Firebase

class Procheck
{
    var Store = StoreClass()
    
    func check_mesure()->Int
    {
        if (Auth.auth().currentUser?.metadata.creationDate != nil)
        {
            let first_date = Auth.auth().currentUser?.metadata.creationDate
            let now_data = Auth.auth().currentUser?.metadata.lastSignInDate
            print(now_data!)
            let last_month_date = Calendar.current.date(byAdding: .month, value: 1, to: first_date!)
            if (last_month_date?.compare(now_data!) == ComparisonResult.orderedAscending)
            {
                if (check_subsc() == 1)
                {
                    //ログインから１ヶ月経っているけど、サブスクに登録している
                    return (1)
                }
                else
                {
                    //ログインから１ヶ月経っていて、サブスクに登録してない
                    return (-1)
                }
            }
            else
            {
                //ログインから１ヶ月経っていない
                return (1)
            }
        }
        else
        {
            //そもそもログインしてない
            return (-2)
        }
    }
    
    func check_subsc() -> Int
    {
        Store.get_receipt()
        Store.check_receipt()
        if (UserDefaults.standard.value(forKey: "purchace") != nil)
        {
            if (UserDefaults.standard.value(forKey: "purchace") as! Int == 2)
            {
                return (1)
            }
        }
        return (-1)
    }
    
}
