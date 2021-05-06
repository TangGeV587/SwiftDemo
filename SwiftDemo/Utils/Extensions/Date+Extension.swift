//
//  Date+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/5.
//

import Foundation

extension Date {
    
    static func stringConvertDate(string:String, format:String="yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter.init()
        let timeZone = TimeZone.init(identifier: "UTC")
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        return date!
    }

    
    ///日期转成自定格式的时间字符串 默认 'yyyy-MM-dd' 字符串
    func toString(format: String = "yyyy-MM-dd") -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.dateFormat = format
            return formatter.string(from: self)
        }
    
   
        
        func getHumanReadableDayString() -> String {
            let weekdays = [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday"
            ]
            
            let calendar = Calendar.current.component(.weekday, from: self)
            return weekdays[calendar - 1]
        }
    
    ///日期格式化
    func time(since fromDate: Date) -> String {
           let earliest = self < fromDate ? self : fromDate
           let latest = (earliest == self) ? fromDate : self

           let allComponents: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
           let components:DateComponents = Calendar.current.dateComponents(allComponents, from: earliest, to: latest)
           let year = components.year  ?? 0
           let month = components.month  ?? 0
           let week = components.weekOfYear  ?? 0
           let day = components.day ?? 0
           let hour = components.hour ?? 0
           let minute = components.minute ?? 0
           let second = components.second ?? 0

           let descendingComponents = ["year": year, "month": month, "week": week, "day": day, "hour": hour, "minute": minute, "second": second]
           for (period, timeAgo) in descendingComponents {
               if timeAgo > 0 {
                   return "\(timeAgo.of(period)) ago"
               }
           }
           return "Just now"
       }
    
    //MARK: 日(月、年类推)
        func day() ->Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year,.month,.day], from: self)
            return com.day!
        }
    //MARK: 星期几
     func weekDay()->Int{
         let interval = Int(self.timeIntervalSince1970)
         let days = Int(interval/86400) // 24*60*60
         let weekday = ((days + 4)%7+7)%7
         return weekday == 0 ? 7 : weekday
     }

    //MARK: 当月天数
        func countOfDaysInMonth() ->Int {
            let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
            let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
            return (range?.length)!

        }
        //MARK: 当月第一天是星期几
        func firstWeekDay() ->Int {
            //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
            let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
            let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
            return firstWeekDay! - 1
        }
    
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
}

extension Int {
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
}
