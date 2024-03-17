# LiveNationTest - Search App 🔭
This is an iOS App that shows a list of events from Ticketmaster API. The app is built entirely with Swift and don't use any third party library.

- [x] Swift
- [x] MVVM
- [x] Dependency Injection
- [x] Storage: use dictonary to cache downloaded images
- [x] A simple plain text search
- [x] Unit testing
- [x] README file explaining your app.

## Requirements
- iOS 16.4

Clone this repo and openn into XCode
```
git clone https://github.com/OmarGReyes/LiveNationTest.git
```
## Screenshots
|Launch screen|Empty search|
|---|---|
|![Screenshot 2024-03-17 at 4 29 41 PM](https://github.com/OmarGReyes/LiveNationTest/assets/64993876/feafa148-a8d5-4bca-9881-e7cc0619ad57)|![Screenshot 2024-03-17 at 4 30 33 PM](https://github.com/OmarGReyes/LiveNationTest/assets/64993876/0ad08f04-bd8c-4a05-a13b-ad27441d6f82)|
|Search|Error|
|![Screenshot 2024-03-17 at 4 32 42 PM](https://github.com/OmarGReyes/LiveNationTest/assets/64993876/eee4f3f2-e7dd-47df-bca4-bf5777ed1194)|![Screenshot 2024-03-17 at 4 33 25 PM](https://github.com/OmarGReyes/LiveNationTest/assets/64993876/b89fc591-55fa-41c6-b4aa-267196d1896c)|

## Files organizartion
```
:LiveNationTest/
LiveNationApp
:Common/
├── :LargeProgressView/
├── :CacheAsyncImage/
├── :AppConstants/
├── :ViewState
:Entities/
├── :EventEntity
: Networking/
├── :RequestError
├── :RequestMethod
├── :Endpoint
├── :HTTPClient
├── :LiveNationEndpoint
: Screens/
├──: LaunchScreen/
├────:LaunchScreen (Sotryboard)
├──: :EventsScreen/
├────:RemoteDataManager
├────:Repository
├────:Presentation
├────:DTOs
```

- **LiveNationTest**: Contains all the app's files
- **LiveNationApp**: Entry point of the app
- **Common**: Contains views and constants that could be shated across the app like: LargeProgressView, CacheAsyncImage etc...
- **Entities**: Entities that will be displayed on the screen or used for presentation purposes
- **Networking**: Contains all the protocols and classes related to Networking
- **LiveNationTest**: Contains all the screens and their related files
