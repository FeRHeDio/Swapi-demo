# Swapi-demo
A SwiftUI application that demonstrates `Clean architecture`, `Dependency injection`, and `async/await` patterns to fetch and display character data from the Star Wars API (swapi.tech). 
This project is designed as a showcase of good design principles and modern Swift development techniques.

## Key Features

### **Modern Async/Await Networking**
- Fully asynchronous network requests using Swift's async/await for cleaner and more readable code.

- Encapsulates networking logic in a reusable API class with error handling.

### **MVVM Architecture**
- The CharactersViewModel separates UI logic from business logic for better scalability and testability.

- Introduces a LoadingState enum to manage view states (loading, loaded, and error) effectively.

### **Dependency Injection**
- Implements dependency injection through the `SwapiDemoApp` Composition Root, making the app highly testable and modular.

- The API and CharactersViewModel are instantiated at the root level and injected into views as needed.

### **Mock Data for Previews**
- Mock data enables seamless `SwiftUI` previews without relying on network calls.

- The People model includes a static method to generate realistic sample data for development and testing.

### **SwiftUI Design**
- Leverages modern SwiftUI features such as `NavigationStack`, `ScrollView`, and `ProgressView` to create a responsive and intuitive user interface.

- Displays characters in a scrollable list with interactive elements, including a detail view shown via a sheet presentation.

### **Error Handling**
- Gracefully handles errors during data fetching and updates the UI state accordingly.

- Provides feedback to the user with clear error messages and fallback UI components.

### **Unit Tests with Mocking** (WIP)
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
