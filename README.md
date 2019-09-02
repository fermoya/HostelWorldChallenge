# HostelWorldChallenge
For a better experience, the App should run on an iPhone X. As I believe it was't the purpose of the challenge to design it for any kind of device. 
 
### Architecture
For the architecture, I chose MVVM, DI and Navigator Pattern. The app is modularized in layers, following Clean Architecture guidelines, and therefore divided, from higher to lower, into:

- UserInterface
- Repository
- Domain

By DI containers, I manage to inject the dependencies each component needs and anstract the code from initialization. The App module sets the root view controller as the User Interface module initial view controller. It needs to know no more about the UI. User Interface Container is responsible for dealing with the initiazation of the components of each scene.

Navigations are extracted to components called Navigators to remove boilerplate code from View Controller. This would prove useful for complex navigations such as custom transitions.

### Unit and UI Testing
The architecture allows to Unit Test the different components of the App. Although not required, I coded several test for the Repository Module in no attempt to get 100% coverage but as an example of what should be done.

About the UI, I simply tested that the name of the property showed up in the list and then in the detail scene and they were the same. The API could fail and it makes no sense to depend on it for a test of your code. That's why when launching, I append some arguments to the app that are then processed by the AppContainer. I've allowed the repository container to have options and this way mock the responses from the Mock Server.

### GitFlow
The repository follows GitFlow Guidlines: branches come from master, are merged in develop and finally develop is merged into master.