Very Good Coffee ☕️
===================

**Very Good Coffee** is a Flutter application made with Bloc State Management that allows users to explore and enjoy random coffee images from the web. Users can swipe through images to interact with them --- swipe left or right to skip the image if they don't like it, and swipe up or down to save the image for offline access. The saved images can be viewed later, even without an internet connection, offering a delightful coffee-themed experience.

Features
--------

-   🖼️ **Random Coffee Images**: Browse through random coffee images fetched from the web.
-   👈 **Swipe Interaction**: Swipe left or right to skip images you don't like.
-   👍 **Save Your Favorites**: Swipe up or down to save your favorite coffee images for offline access.
-   📂 **Offline Access**: View your saved images anytime, even when you're offline.
-   🚀 **Smooth UI**: User-friendly and intuitive interface with animations and visual feedback.
-   🚀 **Unit Tests**: Tests to make sure everything runs smoothly.

Screenshots
-----------

<img src="https://github.com/user-attachments/assets/e241c57c-7485-4e6d-9e38-6c92842f4864" width="100" alt="Simulator Screenshot - test - 2024-09-28 at 05 26 04">
<img src="https://github.com/user-attachments/assets/1a02e086-0400-4796-9ad1-107f56f980cf" width="100" alt="Simulator Screenshot - test - 2024-09-28 at 05 26 06">
<img src="https://github.com/user-attachments/assets/f7cfa5ec-ea2f-4d95-9e7b-caee85ab37cb" width="100" alt="Simulator Screenshot - test - 2024-09-28 at 05 26 08">
<img src="https://github.com/user-attachments/assets/8c482072-296e-4676-9b7b-bc3e789378bc" width="100" alt="Simulator Screenshot - test - 2024-09-28 at 05 27 49">



Installation
------------

To run **Very Good Coffee** on your local machine, follow the steps below:

### Prerequisites

-   **Flutter SDK**: Make sure you have Flutter installed. If not, follow the Flutter installation guide.
-   **Dart SDK**: Dart is included with the Flutter SDK, so no additional installation is required.
-   **Xcode/Android Studio**: Depending on whether you are targeting iOS or Android, have either Xcode or Android Studio installed.

### Step-by-Step Guide

1.  **Clone the Repository**

    Open your terminal and run:

    bash

    Copy code

    `git clone https://github.com/taaha161/very-good-coffee.git
    cd very-good-coffee`

2.  **Install Dependencies**

    Navigate to the project directory and install the required dependencies:

    bash

    Copy code

    `flutter pub get`

3.  **Run the App**

    Connect your device or start an emulator, then run:

    bash

    Copy code

    `flutter run`

    This will build and launch the app on your connected device or emulator.

### Troubleshooting

-   **No Connected Devices**: Ensure your device is connected, USB debugging is enabled (for Android), and you have the correct drivers installed.
-   **Build Errors**: Make sure all dependencies are resolved correctly by running `flutter pub get` and checking for any version conflicts.
-   **Network Issues**: If images fail to load, ensure that you have a stable internet connection and check that the API endpoint is accessible.

How to Use the App
------------------

1.  **Explore**: Open the app to start viewing random coffee images.
2.  **Swipe to Skip**: Swipe left or right to skip images you don't like.
3.  **Swipe to Save**: Swipe up or down to save your favorite images for offline access.
4.  **Offline Mode**: Access saved images from the saved section of the app even when offline.

Dependencies
------------

-   [Flutter](https://flutter.dev)
-   Bloc/Flutter_Bloc: For State management
-   Dio: For network requests and image downloads.
-   Shared Preferences: To store the paths of saved images for offline access.
-   Shimmer: For loading animations while images are being fetched.
  

Contributing
------------

Contributions are welcome! Please fork the repository and create a pull request with your changes. If you find a bug, kindly open an issue.

License
-------

This project is licensed under the MIT License. See the LICENSE file for more details.

* * * * *

Enjoy your coffee experience with **Very Good Coffee**! ☕✨

For any queries or support, feel free to reach out or create an issue on GitHub.

* * * * *
