# Notes App

Notes is a mobile application developed with SwiftUI that allows users to add, delete, and update notes in a simple and intuitive way. The app is designed to sync with a Node.js server, ensuring that notes are always up-to-date and accessible across multiple devices.

## Key Features

- **Add Notes**: Allows users to create new notes with a clean and simple user interface.
- **Delete Notes**: Easily delete unwanted notes with a single tap.
- **Update Notes**: Modify existing notes, keeping all information current.
- **Real-Time Syncing**: With integration to a Node.js server, all notes are synced in real-time, ensuring consistency and availability across devices.

## Technologies Used

- **SwiftUI**: Used to create a modern and responsive user interface.
- **Node.js**: Backend server responsible for managing and syncing notes.
- **Express.js**: Framework used in the Node.js server to handle RESTful APIs.
- **MongoDB**: NoSQL database used to store user notes.
- **REST API**: Notes are managed through RESTful APIs, allowing CRUD operations (Create, Read, Update, Delete).

## Requirements

- **iOS 14.0+** or later.
- **Xcode 12.0+** or later.
- **Node.js 14.0+** or later.
- **MongoDB 4.0+** or later.

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/WebDevWizz/Notes-App.git
    cd Notes-App
    ```

2. **Install dependencies for the Node.js server**:
    ```bash
    cd server
    npm install
    ```

3. **Server configuration**:
   - Create a `.env` file in the `server` directory with the following variables:
     ```
     PORT=27017
     MONGODB_URI=mongodb://localhost/newDB
     ```

4. **Start the server**:
    ```bash
    npm start
    ```

5. **Open the project in Xcode**:
    - Go back to the main `Notes App` directory:
    ```bash
    cd ../
    ```
    - Open `Notes App.xcodeproj` in Xcode.

6. **Run the app**:
    - Select a simulator or a real device and click `Run`.

### Contributions

We welcome contributions! If you want to improve Notes, please follow these steps:

1. Fork the repository.
2. Create a branch for your feature (`git checkout -b feature/new-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push the branch (`git push origin feature/new-feature`).
5. Create a Pull Request.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

NoteSync makes managing your notes easier than ever, combining the power of SwiftUI and Node.js for an unparalleled user experience. Try it now and contribute to the project!
