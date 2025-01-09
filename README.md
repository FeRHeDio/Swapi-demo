# Star Wars API - SwiftUI Demo
A SwiftUI application that demonstrates `Clean architecture`, `Dependency injection`, and `async/await` patterns to fetch and display character data from `The Star Wars API` [swapi.tech](swapi.tech). 

## About SWAPI - The Star Wars API

Located at [swapi.tech](swapi.tech) this API provides endpoints to get:

```
    - "films" : "https://swapi.tech/api/films"
    - "people": "https://swapi.tech/api/people"
    - "planets": "https://swapi.tech/api/planets"
    - "species": "https://swapi.tech/api/species"
    - "starships": "https://swapi.tech/api/starships"
    - "vehicles": "https://swapi.tech/api/vehicles"
```

## The Goal

The idea behind this repo is a showcase of good design principles and modern Swift development techniques.

It starts showing a simple list of characters but I'll be adding more features along the way.


## Key Features

### **Modern Async/Await Networking**
- Fully asynchronous network requests using Swift's `async/await` for cleaner and more readable code.

- Encapsulates networking logic in a reusable API class with error handling.

### **MVVM Architecture**
- The `CharactersViewModel` separates UI logic from business logic for better scalability and testability.

- The View Model introduces a `LoadingState` enum to manage view states (loading, loaded, and error) effectively.

### **Dependency Injection**
- Implements dependency injection through the `SwapiDemoApp` as the Composition Root, making the app highly testable and modular.

- The API and `CharactersViewModel` are instantiated at the root level and injected into views as needed.

### **Mock Data for Previews**
- Mock data enables seamless `SwiftUI` previews without relying on network calls.

- The People model includes a static method to generate realistic sample data for development in previews and assertions while testing.

### **SwiftUI Design**
- Leverages modern `SwiftUI` features such as `NavigationStack`, `ScrollView`, and `ProgressView` to create a responsive and intuitive user interface.

- Displays characters in a scrollable list with interactive elements, including a detail view shown via a sheet presentation (WIP)

- Add the character image in the character list

### **Error Handling**
- Gracefully handles errors during data fetching and updates the UI state accordingly.

- Provides feedback to the user with clear error messages and fallback UI components.

### **Unit Tests with Mocking** 
- Includes unit tests for the `API` class using a custom `URLSessionMock` to simulate network responses.
- Validates the behavior of API methods, such as fetching data and handling errors.

## How to Run

- Clone the repository.

- Open the project in Xcode.

- Select a simulator and run the app.

## Future Enhancements

- Unit Tests (WIP)
- Pagination
- More views
- Images
- Persistence


## Project Structure

```
SwapiDemoApp
├── Models
│   ├── People.swift
│   ├── PeopleResponse.swift
├── ViewModels
│   ├── CharactersViewModel.swift
├── Views
│   ├── CharactersView.swift
│   ├── CharacterDetailsView.swift
│   ├── CharacterView.swift
├── API
│   ├── API.swift
├── Tests
│   ├── SwapiDemoTests.swift
└── App
    ├── SwapiDemoApp.swift
```
