# Image Gallery App

A dynamic image gallery application built using Flutter, integrated with the [Pixabay API](https://pixabay.com/api/docs/) to display images. The app is designed to work on both mobile and web platforms with responsive layouts and performance optimizations.

## Features

- Dynamic image gallery displayed in a grid format
- Images loaded from the Pixabay API
- Search bar with debounce functionality for fetching specific image results
- Infinite scrolling to load more images as the user scrolls down
- Number of likes and views displayed under each image
- Full-screen image view with fade-in/out animation
- Caching of images to optimize performance
- Adaptable layout for mobile and web with responsive columns
- Platform-aware image optimization (using smaller images for mobile, larger ones for the web)
- Clean and modern UI with a stylish search bar and app bar

## Technologies Used

- **Flutter**: Cross-platform framework for building responsive and beautiful applications.
- **Pixabay API**: For fetching free-to-use images.
- **Provider**: State management.
- **Cached Network Image**: Caching network images to improve performance.
- **Responsive Layout**: Automatically adapts the number of columns in the grid based on screen size.

## Prerequisites

- Flutter SDK installed ([Download Flutter](https://flutter.dev/docs/get-started/install))
- A valid API key from [Pixabay](https://pixabay.com/api/docs/)

## Web App Deployment

- Web app is deployed on Github pages [View](https://atuljava74.github.io/image_gallery_web_demo/)

