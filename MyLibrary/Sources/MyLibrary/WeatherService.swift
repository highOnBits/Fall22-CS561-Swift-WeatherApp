import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}



public class WeatherServiceImpl: WeatherService {
    private let baseUrl: String
    private let city: String
    private let relativeUrl = "/data/2.5/weather?q=<add_city_here>&units=imperial&appid=key1234"
    
    public init(baseUrl: String = "https://api.openweathermap.org", city: String = "Corvallis") {
        self.baseUrl = baseUrl
        self.city = city
    }

    public func getTemperature() async throws -> Int {
        // Generate the url of the request according to the call
        let urlToUse = (baseUrl + relativeUrl).replacingOccurrences(of: "<add_city_here>", with: city)
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlToUse, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

public struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
