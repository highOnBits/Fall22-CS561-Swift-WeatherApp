import XCTest
import MyLibrary

final class WeatherServiceImplTests: XCTestCase {
    
    func testweatherSeriveTest_canGetTemperature() async throws {
        // Given
        let temperatureToBeReturned = 38.9
        let weatherServiceMockBaseUrl = "http://127.0.0.1:5000"
        let weatherSerivce = WeatherServiceImpl(baseUrl: weatherServiceMockBaseUrl)
        
        // When
        let temperature = try await weatherSerivce.getTemperature()
        
        // Then
        XCTAssertNotNil(temperature)
        XCTAssertEqual(temperature, Int(temperatureToBeReturned))
    }
    
    func testweatherSeriveTest_failedGetTemperature() async throws {
        // Given
        let weatherServiceMockBaseUrl = "http://127.0.0.1:5000"
        let weatherSerivce = WeatherServiceImpl(baseUrl: weatherServiceMockBaseUrl, city: "")
        var isErrorReturned: Bool
        
        // When
        do {
            let temperature = try await weatherSerivce.getTemperature()
            isErrorReturned = false
        } catch {
            isErrorReturned = true
        }
        
        // Then
        XCTAssertTrue(isErrorReturned)
    }
}
