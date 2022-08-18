### Features

- Breed list caching
- Darkmode
- Accessibility support
- Favourite Dogs
- Favourite dogs between app switching

# About

Below is the process I used while developing the app.

1. Decided what patterns I wanted to use, what dependencies I might need for the project. 
2. Set up dependencies (Carthage)
3. Added Allamofire
4. Setup app navigation via the app coordinator pattern 
5. Created first breeds presenter 
6. Work through Ticket, focused on getting the foundation set up first setting up the api client as well as a particular focus on testability using injection 
7. Added unit tests to new presenter
8. At this point I did an accessibility Audit, obviously there's not much in the app to go on but I changed some of the views so they worked as you would expect and ensured text scaled correctly
9. I wasn't happy with the coordinator so I tidied it up because I wasn't happy with the implementation and I'm glad I did.
10. I did a quick memory check to check for leaks. 
11. I started working on a favourite protocol as I wanted to ensure favourites were tested correctly. I was tempted to throw another dependency in for User Defaults but decided against it because of the size of the project.
12. At this point I wanted to make some quality of life improvements
    1. Added error handling
    2. Adjusted visuals
    3. Verified dark mode implementation
    4. Verified accessibility implementation
    5. Added some tweaks

My regrets

- Naming convention - I felt I could have been clearer in a lot of places
- Structure - I felt I could have done a little better in my process, focusing on getting the foundation done a little bit more
    - I would have e done the following had I had more time 
        - Localised Strings File for all text, This would be accessed Strings file in the codebase.
	eg self.label.text = Strings.BreedList.title
        - Use a custom colour palette for light and dark mode
        - Add accessibility colours 
        - Add dynamic type scaling methods to scale text sizes appropriately. Right now the app uses the default apple text sizes.
- Breed Presenter could have been done better the first time. After the fixes I was much happier

