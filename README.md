# WeatherApp

**Overview**

WeatherApp is a simple SwiftUI-based weather application that allows users to manage a list of cities, view current weather conditions and forecast 7 days of weather, and favorite cities and show details. This app uses CoreData for local data storage and weather Api for fetching weather information.

**Features**

- Current Weather Information: View current weather details including description, temperature, humidity, and wind speed in Home screen.
- Forecast weather: View weather for coming 7 days.
- User can toggle in temperature units Celsius/Fahrenheit.
- Add and Remove Cities: Users can add and remove cities from Favorite list.
- Search Cities: Users can search city and add it in Favorite list.
- Favorite list: Users can show all favorite's cities in screen with summery.
- Asynchronous Data Fetching: Fetch weather data asynchronously with loading indicators.

**Technologies Used**

- SwiftUI: Framework for building the user interface.
- CoreData: Framework for local data persistence.
- URLSession: Used for the network layer to interact with the Weather API.
- Clean Architecture(MVVM Pattern): Architecture pattern used for separation of concerns(Network Layer, Data Layer, Domain Layer, Presentation Layer).
- async/await to asynchronous Data Fetching
- CoreLocation: To detect current current location of user and show weather according to this location

**Configuration**

- API Key

  The app uses the Weather API. Replace the API key in the Configuration.xcconfig file with your own key if needed:
```
API_KEY = ab71d7042b0541a8a0b205218250802
```
- Core Data Model

  The Core Data model is defined in WeatherApp.xcdatamodeld with two entities:

  CityEntity: Represents a city with a name and unique identifier.
  WeatherInfoEntity: Stores weather details such as description, temperature, humidity, wind speed, and icon.

**Usage**

- Viewing Weather Details with 7 Forecast days according to city name 

  When user add permission to access current location, get weather information and forecast days
  
- Searching Cities

  Search city when start type AutoSearch specific City when use Tapped this city navigate to Details Screen

- Removing and Adding City

  Tapped specific city from search screen and open details, tapped favorite button to add to favorite and can click again to remove it
  
- Favorite Cities

  Click tap Favorite in tabbar open list screen with all Favorite cities and can click unfavorite to remove it from list
 
- Setting

  Click tap Setting in tabbar open setting screen to help to convert from Celsius to Fahrenheit or swipe


**Architecture**

- Clean Architecture (Model-View-ViewModel): The app follows the Clean Architecture (MVVM design pattern) to separate concerns and enhance maintainability.

  NetworkLayer: Define network URLSession in separate module.
  DataLayer: Defines DataModels, implement Remote APIs and Repositories For local and remote data
  DomainLayer: Defines UseCases to handles business logic and communicates between view layer and data layer and Defines protocols of Repositories.
  PresentationLayer: View(SwiftUI views for displaying and interacting with the user interface), ViewModel (communicates between view and DomainLayer).

**Core Data Entities**

- CityEntity:

  - Attributes: name (String), id (Int)
  - Relationships: weatherInfos (to-many relationship with WeatherInfoEntity)

- WeatherInfoEntity:
  - Attributes: cityID (Int), temperatureCelsiusDegree (Double), temperatureFahrenheitDegree (Double) , humidity (Double), windSpeed (Double), icon (String), weatherCondition (String)
  - Relationships: city (to-one relationship with CityEntity)


**Naming Convention**
- Clear classes and methods names 
- All variables names are consistently named to be representable like *GetWeatherUseCase*, *SearchViewModel*. 


**Known Issues**

- Ensure the API key is correctly set in WeatherService.m to avoid authentication issues.
- Network connectivity is required to fetch weather data.


