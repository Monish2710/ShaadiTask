# ShaadiTask

# SwiftUI App with Core Data, Image Caching, and Accept/Decline Operations

This repository demonstrates a SwiftUI-based app with the following features:

- **API Integration**: Fetches data using URLSession and stores it locally in Core Data.
- **Image Caching**: Caches images in memory and on disk for faster loading and reduced network usage.
- **Accept/Decline Operations**: Users can accept or decline items, with status stored in Core Data. The UI updates smoothly with animations, and the status persists across app restarts.

## Features

- **Data Fetching**: API calls fetch data and save it to Core Data.
- **Image Caching**: Images are cached both in memory and on disk for optimized performance.
- **Accept/Decline**: Each item has "Accept" and "Decline" buttons. The user's choice is stored in Core Data and displayed even after the app is closed and reopened.
  
## Core Data Integration

The app uses **Core Data** for persistent storage, saving the user data and the accept/decline status of each item. When the app reopens, the state is fetched from Core Data and shown to the user.

## Image Caching

Images are fetched and stored in a cache to ensure they are displayed quickly, even when the app is relaunched. Images are cached both in memory and on disk to reduce network requests.

## Accept/Decline Workflow

- **Accept**: Updates the item’s status to `accepted` in Core Data.
- **Decline**: Updates the item’s status to `declined` in Core Data.
- The UI reflects these changes, hiding the opposite button after a selection.
- The status persists across app launches.

## Installation

1. Clone or download this repository.
2. Open the project in Xcode.
3. Run the app on a simulator or device with iOS 13.0+.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
