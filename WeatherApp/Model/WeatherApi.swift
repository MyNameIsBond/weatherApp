
import Foundation

struct WeatherData: Codable {
  let temp: Double
  let icon: String
  let humidity: Int
  let desciption: String
  let country: String
  let name: String
}

class APIClient {
  static let shared = APIClient()
  
  let apiKey = "81cfeabb4b9ed6029335733752871236"
  let importantData = (["main", ])
  func fetchData(forLatitude latitude: Double, longitude: Double, exclude: String?, apiKey: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    
    var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")!
    urlComponents.queryItems = [
      URLQueryItem(name: "lat", value: String(latitude)),
      URLQueryItem(name: "lon", value: String(longitude)),
      URLQueryItem(name: "exclude", value: exclude),
      URLQueryItem(name: "appid", value: apiKey)
    ].filter { $0.value != nil }
    
    guard let url = urlComponents.url else {
      let error = NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
      completion(.failure(error))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        let error = NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
        completion(.failure(error))
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
        completion(.success(json))
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
  
  func getWeatherData(forLatitude latitude: Double, longitude: Double, apiKey: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    fetchData(forLatitude: latitude, longitude: longitude, exclude: nil, apiKey: apiKey, completion: completion)
  }
}
