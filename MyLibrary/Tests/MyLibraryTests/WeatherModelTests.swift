import XCTest
import MyLibrary

final class WeatherServiceTests: XCTestCase {
    
    private func getTestJson() throws -> String {
        let file = try XCTUnwrap(Bundle.module.path(forResource: "sampleJSON", ofType: "json"))
        let jsonString = try String(contentsOfFile: file)
        
        return jsonString
    }
    
    func testWeatherServiceModel_canCreate() throws {
        // Given
        let jsonString = try getTestJson()
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        
        // When
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
        
        
        // Then
        XCTAssertNotNil(weather)
    }
}
