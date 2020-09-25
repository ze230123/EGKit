
import Foundation

/// 请求的限定频率
public struct Frequency {
    public let time: TimeInterval
    public let count: Int

    public init(time: TimeInterval, count: Int) {
        self.time = time
        self.count = count
    }

    public static let zero = Frequency(time: 0, count: 0)
}

public class Record {
    private let database: Database
    // 同一接口 同一参数
    private let apFrequency: Frequency
    // 同一接口
    private let apiFrequency: Frequency
    // 所有接口
    private let allFrequency: Frequency

    public init(apiAndParameter: Frequency, api: Frequency, all: Frequency) {
        apFrequency = apiAndParameter
        apiFrequency = api
        allFrequency = all
        database = try! Database(fileName: "database")
    }

    /// 检验一个请求是否无效
    /// - Parameters:
    ///   - api: 接口path
    ///   - parameter: 接口参数
    /// - Returns: true: 无效， false: 有效
    public func invalid(api: String, parameter: String) -> Bool {
        let apiParameterCount = try! database.queryCount(api, parameter: parameter, date: Date(timeIntervalSinceNow: -apFrequency.time))
        let apiCount = try! database.queryCount(api, date: Date(timeIntervalSinceNow: -apiFrequency.time))
        let allCount = try! database.queryCount(Date(timeIntervalSinceNow: -allFrequency.time))

        removeExpired()

        if apiParameterCount > apFrequency.count {
            return true
        } else if apiCount > apiFrequency.count {
            return true
        } else if allCount > allFrequency.count {
            return true
        }
        return false
    }

    public func save(_ api: String, parameter: String) {
        try! database.saveRecord(api, parameter: parameter)
    }

    private func removeExpired() {
        database.delete(where: Date(timeIntervalSinceNow: -allFrequency.time))
    }
}
