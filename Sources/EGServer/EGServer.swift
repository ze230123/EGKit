
import Foundation
import Moya
import RxMoya
import RxSwift
import Record

public class EGServer {
    public static let shared = EGServer()

    private static var timeoutRequestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider.RequestResultClosure) in
        do {
            var urlRequest = try endpoint.urlRequest()
            urlRequest.timeoutInterval = EGServer.timeout
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }

    static var timeout: TimeInterval = 30
    static var plugins: [PluginType] = []

    private lazy var provider = MoyaProvider<MultiTarget>(requestClosure: EGServer.timeoutRequestClosure, callbackQueue: .main, plugins: EGServer.plugins)

    private let handler: Record

    private let rxCache: RxCache
    private let scheduler: SchedulerType

    public init() {
        handler = Record(
            apiAndParameter: Frequency(time: 1000, count: 8),
            api: Frequency(time: 1000 * 10, count: 100),
            all: Frequency(time: 1000 * 60, count: 1000)
        )
        scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.default)
        rxCache = RxCache(scheduler: scheduler)
    }

    /// 发送请求
    /// - Parameters:
    ///   - api: 请求API
    ///   - map: 数据转换工具
    /// - Returns: 返回数据可观察对象
    private func sendRequest<Map, Element>(api: TargetType, map: Map) -> Observable<CacheResult<Element>> where Map: MapHandler, Element == Map.Element {
        return self.provider
            .rx
            .request(MultiTarget(api))
            .asObservable()
            .observeOn(scheduler)
            .filterSuccessfulStatusCodes()
            .mapString()
            .map(map.mapHttpObject())
    }

    /// 请求api接口
    ///
    /// - Parameters:
    ///   - api: 请求api
    ///   - map: 数据转换工具
    /// - Returns: 返回数据可观察对象
    public func request<Map, Element>(api: TargetType & MoyaAddable, map: Map) -> Observable<Element> where Map: MapHandler, Element == Map.Element {
        return toObservable(sendRequest(api: api, map: map), strategy: api.policy.strategy, map: map)
    }

    /// 处理请求的重复判断、缓存
    ///
    /// - Parameters:
    ///   - observable: 真实请求
    ///   - strategy: 缓存策略
    ///   - map: 数据转换工具
    /// - Returns: 返回数据可观察对象
    func toObservable<Map, Element>(_ observable: Observable<CacheResult<Element>>, strategy: BaseStrategy, map: Map) -> Observable<Element> where Map: MapHandler, Element == Map.Element {
        return strategy.execute(rxCache, handler: handler, map: map, observable: observable)
    }

}
