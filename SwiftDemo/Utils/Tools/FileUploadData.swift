//
//  FileUploadData.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/4.
//

import Foundation


class FileUploadData {

    /// The data to be encoded and appended to the form data.
    let data: Data
    /// Name to associate with the `Data` in the `Content-Disposition` HTTP header.
    let name: String
    /// Filename to associate with the `Data` in the `Content-Disposition` HTTP header.
    let fileName: String
    /// The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.) For a list of valid MIME types
    /// see http://www.iana.org/assignments/media-types/. This parameter must not be `nil`.
    let mimeType: String

    /// Create HWMultipartDataModel
    /// - Parameters:
    ///   - data: The data to be encoded and appended to the form data.
    ///   - name: The name to be associated with the specified data.
    ///   - fileName: The filename to be associated with the specified data.
    ///   - mimeType: The MIME type of the specified data. eg: image/jpeg
    init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    /// Create HWMultipartDataModel
    /// - Parameters:
    ///   - data: The data to be encoded and appended to the form data.
    ///   - name: The name to be associated with the specified data.
    ///   - fileName: The filename to be associated with the specified data.
    ///   - type: The MIME type of the specified data. eg: image/jpeg
    convenience init(data: Data, name: String, fileName: String, type: HWDataMimeType) {
        self.init(data: data, name: name, fileName: fileName, mimeType: type.rawValue)
    }
    
}
