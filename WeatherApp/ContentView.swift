
import SwiftUI
import CoreLocation
struct ContentView: View {
  @StateObject private var locationManager = LocationManager()
  @State var weatherData: [String: Any] = [:]
  var keysToExctract = Set(["timezone", "main", "weather"])
  var apiClient = APIClient.shared
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Last location: \(locationManager.lastLocation?.coordinate.latitude ?? 0), \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
      Button("Show") {
        let e = weatherData.filter { keysToExctract.contains($0.key) }
        print(e)
      }
    }
    .padding()
    .onAppear {
      Task {
        await getData()
      }
    }
  }
  
  func getData() async {
    await locationManager.requestLocation()
    let lat = locationManager.lastLocation?.coordinate.latitude
    let long = locationManager.lastLocation?.coordinate.longitude
    
    apiClient.getWeatherData(forLatitude: lat ?? 1, longitude: long ?? 1, apiKey: apiClient.apiKey) { result in
  
      switch result {
      case .success(let data):
        weatherData = data
      case .failure(let error):
        print("\(error)")
      }
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

