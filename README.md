# character-chat
iOS TableView App that plays out a scripted conversation

## Summary
When you first launch the app the 'character' starts talking to you immediately. 
When he is done speaking (ie. the audio clip completes) the user text cell appears. If you tap on that the next audio clip starts playing. 
If you press a 'character' line, it will repeat the audio for that line. 

## Implementation Decisions
### Data / View Models
There are a couple models in the implementation. In general, I tried creating enough models to support the application had I added a few more
features or subtle views. Both the `ChatCell` and the `ChatBubbleView` have view models and are `ViewModelConfigurable` (a useful protocol, although probably more-so on bigger apps). 

Also, I figured it would be useful to have a reference model for a 'Chat Line', `ChatLine`. This is meant to represent the data model for a line of a conversation
app-wide. There could probably be an analogous 'Chat' model, but there was no need for it. 
Assuming these 'reference' or 'base' models would come from a request, or a configuration file, I made sure that all the table view models
were created as a 'tranformation' of those models. Although they have an almost 1-1 mapping there are some things that belong in the table view cell models
that don't belong anywhere else and vice versa. If I had other views in the app that displayed similar information I would write a similar
'base model' -> 'view model' mapping. 

### Dependency Injection
Although there are no tests, it should be possible to test the logic pretty easily. `ChatTableViewController`'s dependencies are completely injectable and easily mockable. 
This is particularly important for testing the `AudioPlayer` logic, as you don't want to be playing audio in tests. Most of the other business logic involves
transforming and reading/writing to/from models, so mocking that is not a problem. 

### Architecture
Overall it's a pretty standard tableview. The two decisions that might stick out are:
- I used a separate class to handle/override the UITableViewDataSource methods.
- I only have 1 cell (view) type. 

For the first, I just know that TableViewControllers have a tendency to be massive so moving some of the responsibilities out early is a good idea. 

For the second, my chat cells for users vs. characters are identical except for being pushed to the left or right, so I figured one cell was enough to capture this behavior. 
I could have used inheritance but I try not to when possible. 
Also, since the cell has multiple reuseidentifiers, I can safely recyle them without installing constraints again (to move the bubble chat view from right to left for example), which is a performance win. 

### Tools used
No external dependencies. I used VFL for all layout. Ultimately used `AVAudioPlayer` to play sound. 
