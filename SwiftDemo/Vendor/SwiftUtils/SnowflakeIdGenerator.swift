//
//  SnowflakeIdGenerator.swift
//  SwiftUtils
//
//  Created by Thanh Nguyen on 8/14/16.
//  Copyright © 2016 Thanh Nguyen <btnguyen2k@gmail.com>. All rights reserved.
//----------------------------------------------------------------------
//  Swift implementation of Twitter's Snowflake.
//  * 128-bit ID:
//    <64-bits: timestamp><48-bits: node id><16-bits: sequence number>
//    (where timestamp is UNIX timestamp in milliseconds)
//  * 64-bit ID:
//    <41-bits: timestamp><21-bits: node id><2-bits: sequence number>
//    (where timestamp is UNIX timestamp in milliseconds, minus the epoch)
//  * 64-bit-nil ID:
//    <41-bits: timestamp><23-bits: node id>
//    (where timestamp is UNIX timestamp in milliseconds, minus the epoch)
//----------------------------------------------------------------------

import Foundation
import UIKit

public class SnowflakeIdGenerator {
    private static let MASK_TIMESTAMP_64     :UInt64 = (1 << 41) - 1  // 41 bits
    private static let MASK_NODE_ID_64       :UInt64 = (1 << 21) - 1  // 21 bits
    private static let MASK_SEQUENCE_64      :UInt64 = (1 <<  2) - 1  //  2 bits
    private static let MAX_SEQUENCE_64       :UInt64 = (1 <<  2) - 1  //  2 bits
    private static let SHIFT_TIMESTAMP_64    :UInt64 = 21+2
    private static let SHIFT_NODE_ID_64      :UInt64 = 2

    private static let MASK_TIMESTAMP_64NIL  :UInt64 = (1 << 41) - 1  // 41 bits
    private static let MASK_NODE_ID_64NIL    :UInt64 = (1 << 23) - 1  // 23 bits
    private static let SHIFT_TIMESTAMP_64NIL :UInt64 = 23

    private static let TIMESTAMP_EPOCH       :UInt64 = 1456790400000  // 1-Mar-2016 GMT

    private static let MASK_NODE_ID_128      :UInt64 = 0xFFFFFFFFFFFF // 48 bits
    private static let MASK_SEQUENCE_128     :UInt64 = 0xFFFF         // 16 bits
    private static let MAX_SEQUENCE_128      :UInt64 = 0xFFFF         // 16 bits
    private static let SHIFT_TIMESTAMP_128   :UInt64 = 64
    private static let SHIFT_NODE_ID_128     :UInt64 = 16

    private var nodeId                :UInt64 = 0
    private var template64            :UInt64 = 0
    private var template64Nil         :UInt64 = 0
    private var sequenceMillisec      :UInt64 = 0
    private var lastTimestampMillisec :UInt64 = 0

    init(_ nodeId: UInt64 = 0) {
        if ( nodeId != 0 ) {
            self.nodeId = nodeId
        } else {
            self.nodeId = UInt64(UIDevice.current.identifierForVendor!.hashValue)
        }
        template64 = (self.nodeId & SnowflakeIdGenerator.MASK_NODE_ID_64) << SnowflakeIdGenerator.SHIFT_NODE_ID_64
        template64Nil = (self.nodeId & SnowflakeIdGenerator.MASK_NODE_ID_64NIL)
    }

    public func getNodeId() -> UInt64 {
        return nodeId
    }

    public func getSequenceMillisec() -> UInt64 {
        return sequenceMillisec
    }

    public func getLastTimestampMillisec() -> UInt64 {
        return lastTimestampMillisec
    }

    /*----------------------------------------------------------------------*/

    /**
     * Extracts the UNIX timestamp from a 64-bit id generated by `generateId64()`.
     *
     * - Parameter id: the id generated by `generateId64()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64(_ id: UInt64) -> UInt64 {
        return SnowflakeIdGenerator.TIMESTAMP_EPOCH + (id >> SnowflakeIdGenerator.SHIFT_TIMESTAMP_64)
    }

    /**
     * Extracts the UNIX timestamp from a 64-bit id generated by `generateId64Hex()`.
     *
     * - Parameter idHex: the id generated by `generateId64Hex()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64Hex(_ idHex: String) -> UInt64 {
        let id = strtouq(idHex, nil, 16)
        return extractTimestamp64(id)
    }

    /**
     * Extracts the UNIX timestamp from a 64-bit id generated by `generateId64Bin()`.
     *
     * - Parameter idBin: the id generated by `generateId64Bin()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64Bin(_ idBin: String) -> UInt64 {
        let id = strtouq(idBin, nil, 2)
        return extractTimestamp64(id)
    }

    /**
     * Extracts the timestamp part from a 64-bit id generated by `generateId64()` as a Date.
     *
     * - Parameter id: the id generated by `generateId64()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64AsDate(_ id: UInt64) -> Date {
        let timestamp = extractTimestamp64(id)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Extracts the timestamp part from a 64-bit id generated by `generateId64Hex()` as a Date.
     *
     * - Parameter idHex: the id generated by `generateId64Hex()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64HexAsDate(_ idHex: String) -> Date {
        let timestamp = extractTimestamp64Hex(idHex)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Extracts the timestamp part from a 64-bit id generated by `generateId64Bin()` as a Date.
     *
     * - Parameter idBin: the id generated by `generateId64Bin()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64BinAsDate(_ idBin: String) -> Date {
        let timestamp = extractTimestamp64Bin(idBin)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Generates a 64-bit id.
     *
     * Format: `<41-bits: timestamp><21-bits: node id><2-bits: sequence number>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit id
     */
    @available(iOS, introduced: 1.0)
    public func generateId64() -> UInt64 {
        let result = synchronizd(lock: self) {
            let timestamp: UInt64 = DateTimeUtils.currentUnixTimestampMillisec()
            var sequence: UInt64 = 0
            if (timestamp == self.lastTimestampMillisec) {
                // increase sequence
                sequence = self.sequenceMillisec.advanced(by: 1)
                if (sequence > SnowflakeIdGenerator.MAX_SEQUENCE_64) {
                    // reset sequence
                    self.sequenceMillisec = 0
                    DateTimeUtils.waitTillNextMillisec(timestamp)
                    return self.generateId64()
                } else {
                    self.sequenceMillisec = sequence
                }
            } else {
                // reset sequence
                self.sequenceMillisec = sequence
                self.lastTimestampMillisec = timestamp
            }
            let timestampPart = (timestamp - SnowflakeIdGenerator.TIMESTAMP_EPOCH) & SnowflakeIdGenerator.MASK_TIMESTAMP_64
            let result = timestampPart << SnowflakeIdGenerator.SHIFT_TIMESTAMP_64 | self.template64
                | (sequence & SnowflakeIdGenerator.MASK_SEQUENCE_64)
            return result

        }
        return result as! UInt64
    }

    /**
     * Generates a 64-bit id as a hex string.
     *
     * Format: `<41-bits: timestamp><21-bits: node id><2-bits: sequence number>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit id as a hex string
     */
    @available(iOS, introduced: 1.0)
    public func generateId64Hex() -> String {
        let result = self.generateId64()
        return String(result, radix: 16)
    }

    /**
     * Generates a 64-bit id as a binary string.
     *
     * Format: `<41-bits: timestamp><21-bits: node id><2-bits: sequence number>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit id as a binary string
     */
    @available(iOS, introduced: 1.0)
    public func generateId64Bin() -> String {
        let result = self.generateId64()
        return String(result, radix: 2)
    }

    /*----------------------------------------------------------------------*/

    /**
     * Extracts the UNIX timestamp from a 64-bit-nil id generated by `generateId64Nil()`.
     *
     * - Parameter id: the id generated by `generateId64Nil()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64Nil(_ id: UInt64) -> UInt64 {
        return SnowflakeIdGenerator.TIMESTAMP_EPOCH + (id >> SnowflakeIdGenerator.SHIFT_TIMESTAMP_64NIL)
    }

    /**
     * Extracts the UNIX timestamp from a 64-bit-nil id generated by `generateId64NilHex()`.
     *
     * - Parameter idHex: the id generated by `generateId64NilHex()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64NilHex(_ idHex: String) -> UInt64 {
        let id = strtouq(idHex, nil, 16)
        return extractTimestamp64Nil(id)
    }

    /**
     * Extracts the UNIX timestamp from a 64-bit-nil id generated by `generateId64NilBin()`.
     *
     * - Parameter idBin: the id generated by `generateId64NilBin()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64NilBin(_ idBin: String) -> UInt64 {
        let id = strtouq(idBin, nil, 2)
        return extractTimestamp64Nil(id)
    }

    /**
     * Extracts the timestamp part from a 64-bit-nil id generated by `generateId64Nil()` as a Date.
     *
     * - Parameter id: the id generated by `generateId64Nil()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64NilAsDate(_ id: UInt64) -> Date {
        let timestamp = extractTimestamp64Nil(id)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Extracts the timestamp part from a 64-bit-nil id generated by `generateId64NilHex()` as a Date.
     *
     * - Parameter idHex: the id generated by `generateId64Nil()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64NilHexAsDate(_ idHex: String) -> Date {
        let timestamp = extractTimestamp64NilHex(idHex)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Extracts the timestamp part from a 64-bit-nil id generated by `generateId64NilBin()` as a Date.
     *
     * - Parameter idBin: the id generated by `generateId64NilBin()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp64NilBinAsDate(_ idBin: String) -> Date {
        let timestamp = extractTimestamp64NilBin(idBin)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Generates a 64-bit-nil id.
     *
     * Format: `<41-bits: timestamp><23-bits: node id>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit-nil id
     */
    @available(iOS, introduced: 1.0)
    public func generateId64Nil() -> UInt64 {
        let result = synchronizd(lock: self) {
            let timestamp: UInt64 = DateTimeUtils.currentUnixTimestampMillisec()
            if (timestamp == self.lastTimestampMillisec) {
                DateTimeUtils.waitTillNextMillisec(timestamp)
                return self.generateId64Nil()
            } else {
                self.lastTimestampMillisec = timestamp
            }
            let timestampPart = (timestamp - SnowflakeIdGenerator.TIMESTAMP_EPOCH) & SnowflakeIdGenerator.MASK_TIMESTAMP_64NIL
            let result = timestampPart << SnowflakeIdGenerator.SHIFT_TIMESTAMP_64NIL | self.template64Nil
            return result
        }
        return result as! UInt64
    }

    /**
     * Generates a 64-bit-nil id as a hex string
     *
     * Format: `<41-bits: timestamp><23-bits: node id>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit-nil id as a hex string
     */
    @available(iOS, introduced: 1.0)
    public func generateId64NilHex() -> String {
        let result = self.generateId64Nil()
        return String(result, radix: 16)
    }

    /**
     * Generates a 64-bit-nil id as a binary string
     *
     * Format: `<41-bits: timestamp><23-bits: node id>`
     * Where timestamp is in milliseconds, minus the epoch.
     *
     * - Returns: 64-bit-nil id as a binary string
     */
    @available(iOS, introduced: 1.0)
    public func generateId64NilBin() -> String {
        let result = self.generateId64Nil()
        return String(result, radix: 2)
    }

    /*----------------------------------------------------------------------*/

    /**
     * Extracts the UNIX timestamp from a 128-bit id generated by `generateId128Hex()`.
     *
     * - Parameter idHex: the id generated by `generateId128Hex()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp128Hex(_ idHex: String) -> UInt64 {
        let index = idHex.index(idHex.endIndex, offsetBy: -16)
        let timestamp = strtouq(idHex.substring(to: index), nil, 16)
        return timestamp
    }

    /**
     * Extracts the UNIX timestamp from a 128-bit id generated by `generateId128Bin()`.
     *
     * - Parameter idBin: the id generated by `generateId128Bin()`
     *
     * - Returns: the extracted UNIX timestamp in milliseconds
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp128Bin(_ idBin: String) -> UInt64 {
        let index = idBin.index(idBin.endIndex, offsetBy: -64)
        let timestamp = strtouq(idBin.substring(to: index), nil, 2)
        return timestamp
    }

    /**
     * Extracts the timestamp part from a 128-bit id generated by `generateId128Hex()` as a Date.
     *
     * - Parameter idHex: the id generated by `generateId128Hex()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp128HexAsDate(_ idHex: String) -> Date {
        let timestamp = extractTimestamp128Hex(idHex)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Extracts the timestamp part from a 128-bit id generated by `generateId128Bin()` as a Date.
     *
     * - Parameter idBin: the id generated by `generateId128Bin()`
     *
     * - Returns: the extracted timestamp part as a Date
     */
    @available(iOS, introduced: 1.0)
    public static func extractTimestamp128BinAsDate(_ idBin: String) -> Date {
        let timestamp = extractTimestamp128Bin(idBin)
        return Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }

    /**
     * Generates a 128-bit id.
     *
     * Format: `<64-bits: timestamp><48-bits: node id><16-bits: sequence number>`
     * Where timestamp is in milliseconds.
     *
     * - Returns: 128-bit id as an array of two UInt64s
     */
    @available(iOS, introduced: 1.0)
    public func generateId128() -> [UInt64] {
        let result = synchronizd(lock: self) {
            let timestamp: UInt64 = DateTimeUtils.currentUnixTimestampMillisec()
            var sequence: UInt64 = 0
            if (timestamp == self.lastTimestampMillisec) {
                // increase sequence
                sequence = self.sequenceMillisec.advanced(by: 1)
                if (sequence > SnowflakeIdGenerator.MAX_SEQUENCE_128) {
                    // reset sequence
                    self.sequenceMillisec = 0
                    DateTimeUtils.waitTillNextMillisec(timestamp)
                    return self.generateId128()
                } else {
                    self.sequenceMillisec = sequence
                }
            } else {
                // reset sequence
                self.sequenceMillisec = sequence
                self.lastTimestampMillisec = timestamp
            }
            let first = timestamp
            let second = (self.nodeId << SnowflakeIdGenerator.SHIFT_NODE_ID_128) | (sequence & SnowflakeIdGenerator.MASK_SEQUENCE_128)
            return [first, second]
        }
        return result as! [UInt64]
    }

    /**
     * Generates a 128-bit id as a hex string.
     *
     * Format: `<64-bits: timestamp><48-bits: node id><16-bits: sequence number>`
     * Where timestamp is in milliseconds.
     *
     * - Returns: 128-bit id as a hex string
     */
    @available(iOS, introduced: 1.0)
    public func generateId128Hex() -> String {
        let result = self.generateId128()
        var tail = String(result[1], radix: 16)
        while ( tail.count < 16 ) {
            tail.insert("0", at: tail.startIndex)
        }
        return String(result[0], radix: 16) + tail
    }

    /**
     * Generates a 128-bit id as a binary string.
     *
     * Format: `<64-bits: timestamp><48-bits: node id><16-bits: sequence number>`
     * Where timestamp is in milliseconds.
     *
     * - Returns: 128-bit id as a binary string
     */
    @available(iOS, introduced: 1.0)
    public func generateId128Bin() -> String {
        let result = self.generateId128()
        var tail = String(result[1], radix: 2)
        while ( tail.count < 64 ) {
            tail.insert("0", at: tail.startIndex)
        }
        return String(result[0], radix: 2) + tail
    }
}
