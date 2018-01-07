# Steam Workshop Linker for Garry's Mod
A workshop linking addon for garry's mod. This module automatically retrieves the workshop package id's and broadcasts them to the users for further download, **saving hours of work digging through the fileids on the steam website.**

No need to specify what items you added to your collection. Just head over to the steamworkshop site, create your collection, grab the id of your collection and add the items to your collection. Done.


## Requirments
- HTTP Module

## Installation

Upload the `workshoplinker` folder to your `garrysmod/addons/` folder.


Edit the `workshoplinker/lua/weokshop_config.lua` file and set the correct collection id.
```lua
-- Workshop collection ID (Example link: http://steamcommunity.com/workshop/filedetails/?id=416357984) => 416357984
CollectionID = "416357984";
```
The collection id can be extracted from the url of the workshop collection:
**For the following collection:**
`http://steamcommunity.com/workshop/filedetails/?id=416357984`

**The collection id is the following:**

`416357984`

## HOW IT WORKS?
The plugin grabs the items in the specified collection from the steam workshop api and executed the following command:

```lua
resource.AddWorkshop( fileid ) 
```
## Have a question?
Please open an issue.


## License
MIT
