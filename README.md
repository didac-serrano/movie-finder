# movie-finder

### Features
Movie finder is a simple application that lets the user find movies based on an text entry. It consists in 2 screens: the first one is a list where movies are displayed. The title, the year of release and a picture are displayed. The user can click in a movie to see the detail or swipe left to remove that movie from the list.

### Architecture
The application uses VIPER architecture being the modules
- *Presenter*: recieves view actions and connects all modules
- *Interactor*: stores the data (in our case the list of movies)
- *DataManager*: does the API calls and hadles data to the Interactor
- *Entity*: class that encapsulates the data and performs minor adjustments
- *View*: recieves actions from the user and Entities to populate itself
- *Wireframe*: is responsible for creating modules and navigation
