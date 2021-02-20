//
//  Logger.swift
//  DreamtHome
//
//  Created by Ahmed Osman on 2/24/20.
//  Copyright © 2020 RC Structure. All rights reserved.
//

import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
enum LogEvent: String {
    case e = "‼️" // error
    case i = "ℹ️" // info
    case d = "💬" // debug
    case v = "🔬" // verbose
    case w = "⚠️" // warning
    case s = "🔥" // severe
}

/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities](https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/)
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any, _ eventType: LogEvent, _ filename: String = #file, _ line: Int = #line, _ column: Int = #column, _ funcName: String = #function) {
    let dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print("[\(eventType.rawValue)\n\(dateFormatter.string(from: Date()))\nclass:\(sourceFileName(filePath: filename))\nmethod:\(funcName) line:\(line):\n\(object)];")
    #elseif RELEASE
    #warning("Log in crashlytics")
    #endif
}

/// Extract the file name from the file path
///
/// - Parameter filePath: Full file path in bundle
/// - Returns: File Name with extension
func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last ?? ""
}
