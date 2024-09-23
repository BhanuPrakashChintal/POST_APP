
# Posts App

This Flutter application fetches data from an API and displays the posts in a list of cards with pagination. The app uses state management (`setState`) and includes a basic user interface to showcase fetched data in a neatly styled way.

## Features

- **Fetch Data from API**: The app uses the `http` package to fetch data from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts).
- **Display Posts**: Each post is displayed in a `Card` widget with a bold title and body text.
- **Pagination**: The app supports loading additional posts when the user scrolls to the bottom.
- **State Management**: The app uses `setState` to manage its state for simplicity.
  
## Technologies Used

- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **http**: A package for making HTTP requests to fetch data from APIs.
  
## Installation

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/posts-app.git
```

### 2. Navigate to the project directory
```bash
cd posts_app
```

### 3. Install dependencies
```bash
flutter pub get
```

### 4. Run the app
```bash
flutter run
```

Make sure you have an emulator or a connected device before running the app.

## API

The data is fetched from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts), a free and open REST API used for testing and prototyping.

### Example of API Data:

```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit..."
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore vitae..."
  },
  ...
]
```

## Structure

```text
lib/
├── main.dart      // Main entry point of the app
```

### Key Components:
- **`Card` widget**: Displays the post title (in bold) and body.
- **`ListView.builder`**: Used to create a scrollable list of posts.
- **`setState()`**: Manages state to update the UI when new data is fetched.
- **Pagination**: The app loads more posts when the user scrolls to the end of the list.



## Screenshots

![App Screenshot](screenshot.png)  
_Screenshot showing the app with fetched posts._

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### Additional Notes:

- Ensure that the necessary packages are listed in your `pubspec.yaml` file, such as `http`.
- You can add screenshots or GIFs of the app for better visualization in your `README.md`.
- Customize the repository URL (`yourusername/posts-app.git`) to reflect your actual GitHub repository.

