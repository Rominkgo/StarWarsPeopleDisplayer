# StarWarsPeopleDisplayer

This app is meant to display a list of characters from the starwars franchise. 
To do so, please use the `https://swapi.dev/api/people` endpoint to fetch said list.


The app has to use Swift UI, Combine, ViewModels and repositories (MVVM with repositories).

* When the view is about to show, please fetch the list of characters (you can use the .onAppear method for a view, to call a viewmodel method to fetch).

* After the list is fetched, you need to be able to display each character's name in a `List` view.

* When the user clicks on an item, said item should be persisted to user defaults (view -> viewmodel -> repository -> UserDefaults).
 There is only going to be a single "Favorite" character, and they're Item in the List of items should have a heart. You can use the name of the character
 as the value to match between the fetched data and the persisted character, which is say, you only need to perist the character's name in user defaults.

* If the user goes out from the app and back in, if the fetched list of items contains the liked character, it should still be reflected as the "liked" character.
