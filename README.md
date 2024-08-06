# Blog Explorer

A Flutter application that fetches and displays a list of blogs using a RESTful API. The app supports features such as searching for blogs, favoriting blog posts, and refreshing the list of blogs. It also integrates with Hive for local storage and uses environment variables for API configuration.

## Features

- **Blog Listing**: Fetch and display a list of blogs from a RESTful API.
- **Search**: Search for blogs by title.
- **Favorites**: Mark blogs as favorites and persist them locally using Hive.
- **Refresh**: Pull-to-refresh to reload the list of blogs.
- **Error Handling**: Display error messages and retry options.

## Installation

1. **Clone the Repository**:

    ```sh
    git clone https://github.com/your_username/blog_explorer.git
    ```

2. **Navigate to the Project Directory**:

    ```sh
    cd blog_explorer
    ```

3. **Install Dependencies**:

   Make sure you have Flutter and Dart SDK installed. Run the following command to get the project dependencies:

    ```sh
    flutter pub get
    ```

4. **Create Environment File**:

   Create a `.env` file in the root directory of the project and add your API credentials:

    ```plaintext
    API_URL=https://api.example.com
    API_KEY=your_api_key_here
    ```

5. **Run the Application**:

   Start the application using:

    ```sh
    flutter run
    ```

## Usage

- **Blog List Screen**: Shows a list of blogs with an option to search and filter.
- **Blog Detail Screen**: Tap on a blog to view details.
- **Favorite Blogs**: Tap the heart icon to add/remove blogs from favorites.

## Project Structure

- `lib/`
    - `blocs/`: Contains the Bloc logic for managing state.
    - `components/`: Reusable widgets like `Blogs` and `SearchBar`.
    - `screens/`: Screens such as `BlogListScreen` and `BlogDetailScreen`.
    - `services/`: API service logic.
    - `main.dart`: Entry point of the application.
- `pubspec.yaml`: Project dependencies and configuration.

## Dependencies

- `flutter_bloc`: State management with BLoC pattern.
- `hive_flutter`: Local storage with Hive.
- `http`: Making HTTP requests.
- `flutter_dotenv`: Managing environment variables.

## Troubleshooting

- **FileNotFoundError**: Ensure the `.env` file is located in the root directory and properly formatted.
- **Hive Initialization**: Verify that Hive is properly initialized before usage.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request to improve the project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Flutter community for the tools and libraries used in this project.
