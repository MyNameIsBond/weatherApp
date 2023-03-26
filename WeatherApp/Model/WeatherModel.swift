
import Foundation


struct WeatherMainModel {
  let feels_like: Int
  let humidity: Int
  let pressure: Int
  let temp: String
  let temp_max: String
  let temp_min: String
}

struct WeatherMain {
  let description: String
  let icon: Int
  let id: Int
  let main: Any
}
