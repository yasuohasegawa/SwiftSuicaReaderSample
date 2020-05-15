# SwiftSuicaReaderSample
Japan only, Suica Reader sample<br>
You need to set up the following things before you are getting into this.<br>
<br>
<br>
## Xcode set up
Add the following capabilities:<br>
Near Field Communication Tag Reading<br>
<br>
## info.plist set up
Privacy - NFC Scan Usage Description:<br>
write any description text here<br>
<br>
ISO18092 system codes for NFC Tag Reader Session:<br>
We need to add `0003` for the Suica.<br>
<br>
It only tested on iPhone XS Max iOS13.4.
<br>
## Resources:
https://ja.osdn.net/projects/felicalib/wiki/suica<br>
https://qiita.com/m__ike_/items/7dc3e643396cf3381167
