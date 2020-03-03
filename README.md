#  FlickrAPIExample

## 前菜

1. 注册Flickr
2. 申请应用获取API_KEY

```sh
APP_name: onelcat
KEY: 475486054f5b1afa16fefe55415fa546
密钥: 3d818f197a6fa194
```

## flickr.interestingness.getList

### 请求

> 参数说明
- api_key （必需的）
您的API应用程序密钥。有关更多详细信息，请参见此处。
- date （可选的）
特定日期，格式为YYYY-MM-DD，用于返回感兴趣的照片。
- extras （可选的）
以逗号分隔的额外信息列表，可用于获取每个返回的记录。目前支持的领域有：description，license，date_upload，date_taken，owner_name，icon_server，original_format，last_update，geo，tags，machine_tags，o_dims，views，media，path_alias，url_sq，url_t，url_s，url_q，url_m，url_n，url_z，url_c，url_l，url_o
- per_page （可选的）
每页返回的照片数。如果省略此参数，则默认为100。最大允许值为500。
- page （可选的）
要返回的结果页面。如果省略此参数，则默认为1。

```sh
wget https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=475486054f5b1afa16fefe55415fa546&format=json&nojsoncallback=1
```

### 返回结果

```json
{ "photos": { "page": 1, "pages": 5, "perpage": 100, "total": "500", 
"photo": [
  { "id": "49608977642", "owner": "64882836@N02", "secret": "16423619c9", "server": "65535", "farm": 66, "title": "Lean to the left.", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608194436", "owner": "128941223@N02", "secret": "4772a214ae", "server": "65535", "farm": 66, "title": "Red Squirrel", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608836723", "owner": "35609298@N06", "secret": "70ac058b86", "server": "65535", "farm": 66, "title": "White Lighting", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607581188", "owner": "16193266@N04", "secret": "8840be875b", "server": "65535", "farm": 66, "title": "Brush-Macro Mondays", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607104341", "owner": "131004886@N02", "secret": "d1741e95dc", "server": "65535", "farm": 66, "title": "Syd's choice", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606472218", "owner": "86352240@N00", "secret": "1129cecc68", "server": "65535", "farm": 66, "title": "Fork", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609479713", "owner": "38181284@N06", "secret": "79f75e8cc0", "server": "65535", "farm": 66, "title": "Tate", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606862541", "owner": "122138117@N08", "secret": "b762b11662", "server": "65535", "farm": 66, "title": "Strawberry Red [Macro Mondays][Brush]", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608810372", "owner": "95100042@N02", "secret": "e842ff3b9e", "server": "65535", "farm": 66, "title": "kleine Kapelle", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608612422", "owner": "91820810@N05", "secret": "e0a5d7beaa", "server": "65535", "farm": 66, "title": "Sparrow Hawk", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607102107", "owner": "91591453@N04", "secret": "c9a6b64f68", "server": "65535", "farm": 66, "title": "Brosse", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608634251", "owner": "50101900@N02", "secret": "ac319765be", "server": "65535", "farm": 66, "title": "male Gadwall...", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608075243", "owner": "75309441@N02", "secret": "d943f9d1fc", "server": "65535", "farm": 66, "title": "highway", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607825133", "owner": "115514608@N03", "secret": "7547b45d7b", "server": "65535", "farm": 66, "title": "Duo de printemps", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609153351", "owner": "97236284@N04", "secret": "b703f90fff", "server": "65535", "farm": 66, "title": "View from the Lesser Town Bridge Tower", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607997356", "owner": "133699006@N06", "secret": "6fd0e4d727", "server": "65535", "farm": 66, "title": "QUIÉN ES QUIÉN", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607935278", "owner": "146494084@N06", "secret": "87bf0947a6", "server": "65535", "farm": 66, "title": "I love spring. Don’t you?", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607504901", "owner": "68358198@N00", "secret": "48a22448e8", "server": "65535", "farm": 66, "title": "Testing Canon 1DX3", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607364157", "owner": "77052415@N06", "secret": "949d36d677", "server": "65535", "farm": 66, "title": "Coyote (Explored 3-2-20)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607116458", "owner": "92655181@N07", "secret": "ae2ca08445", "server": "65535", "farm": 66, "title": "Amur Tiger (panthera tigris altaica)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607583718", "owner": "58827557@N06", "secret": "d842dff518", "server": "65535", "farm": 66, "title": "Wire Brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607202383", "owner": "125487675@N08", "secret": "a4f1dc1e3d", "server": "65535", "farm": 66, "title": "European crested tit (Lophophanes cristatus)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606364683", "owner": "69522958@N04", "secret": "47686d7852", "server": "65535", "farm": 66, "title": "Doud Creek, Big Sur", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608557493", "owner": "71792101@N03", "secret": "d12e5fca98", "server": "65535", "farm": 66, "title": "The Road to Gilded Peaks", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607947642", "owner": "126343077@N07", "secret": "cb1f8b83b8", "server": "65535", "farm": 66, "title": "Buse variable \/ Common Buzzard", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607159666", "owner": "83802319@N00", "secret": "3359c9c559", "server": "65535", "farm": 66, "title": "Japanese Crane awakening", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608319752", "owner": "163830427@N08", "secret": "26d2d6a4cd", "server": "65535", "farm": 66, "title": "Sanderling", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607394433", "owner": "64842157@N06", "secret": "acc1aa2cd6", "server": "65535", "farm": 66, "title": "...not Christmas yet...", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608681232", "owner": "56446000@N04", "secret": "6c78b1526b", "server": "65535", "farm": 66, "title": "Orange Tip Heaven", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608518808", "owner": "24662369@N07", "secret": "61b0621bdf", "server": "65535", "farm": 66, "title": "Hubble Spots a Spiral With a Past", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608192812", "owner": "72999943@N05", "secret": "bb1be3b96d", "server": "65535", "farm": 66, "title": "little wren", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607880793", "owner": "129544038@N04", "secret": "ac2655e2d2", "server": "65535", "farm": 66, "title": "National Monument", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607614388", "owner": "157425505@N04", "secret": "6c6a55b612", "server": "65535", "farm": 66, "title": "Barn Owl Explored", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49610262707", "owner": "125914022@N05", "secret": "961a5299e7", "server": "65535", "farm": 66, "title": "Magic glitter", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608547923", "owner": "66311931@N05", "secret": "7832c21e07", "server": "65535", "farm": 66, "title": "Spring Colours", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607738973", "owner": "96844815@N03", "secret": "a061d60bcc", "server": "65535", "farm": 66, "title": "Happy [Explore 3\/3\/20]", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607626192", "owner": "132517350@N07", "secret": "457ca38ece", "server": "65535", "farm": 66, "title": "watercolor brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606631403", "owner": "186686878@N06", "secret": "06c5883504", "server": "65535", "farm": 66, "title": "Paint it on...", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609683461", "owner": "131792239@N06", "secret": "80f2982dce", "server": "65535", "farm": 66, "title": "Paint Me A Rainbow ... - MM - Theme-Brush - (Explored)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607220882", "owner": "121471031@N02", "secret": "bd963db3ea", "server": "65535", "farm": 66, "title": "maybe you can show me how to love", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606867048", "owner": "137379197@N08", "secret": "ea40f105a5", "server": "65535", "farm": 66, "title": "Making it last", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49610023192", "owner": "27475953@N03", "secret": "12462f255a", "server": "65535", "farm": 66, "title": "Morning in the Alabama Hills", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608694298", "owner": "128700403@N04", "secret": "9a4758b948", "server": "65535", "farm": 66, "title": "Springtime!", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607411207", "owner": "90024104@N08", "secret": "368b2bab34", "server": "65535", "farm": 66, "title": "Change of Time", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607314256", "owner": "153617615@N08", "secret": "a7b34776a4", "server": "65535", "farm": 66, "title": "Glitter brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609380232", "owner": "24689012@N07", "secret": "13988b3a23", "server": "65535", "farm": 66, "title": "Lying In Wait !!!!!!!!!!!!!", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608936043", "owner": "64148082@N02", "secret": "2a0f0aa80d", "server": "65535", "farm": 66, "title": "I FERRI DEL MESTIERE. THE IRONS OF THE CRAFT", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608905152", "owner": "53581245@N08", "secret": "8412d849c2", "server": "65535", "farm": 66, "title": "Calligraphy Anyone?", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608702371", "owner": "34428167@N05", "secret": "4a18dd301d", "server": "65535", "farm": 66, "title": "The Colourful Lovebird!", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608312353", "owner": "73697167@N03", "secret": "590dab3a5c", "server": "65535", "farm": 66, "title": "Elephant Family", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606637633", "owner": "143569290@N08", "secret": "d6099d5c79", "server": "65535", "farm": 66, "title": "Colorful Bristles", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608354598", "owner": "13980928@N03", "secret": "11cce13fd1", "server": "65535", "farm": 66, "title": "The House of the Stars", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608087396", "owner": "159099954@N08", "secret": "281a64cce1", "server": "65535", "farm": 66, "title": "HMM: Brush (detail)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607107797", "owner": "142153013@N04", "secret": "06aa7d3e04", "server": "65535", "farm": 66, "title": "Brushes HMM", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609222151", "owner": "23329645@N00", "secret": "1068cc92fb", "server": "65535", "farm": 66, "title": "Orange stripe (on Explore)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608900806", "owner": "125645386@N04", "secret": "2baaccc173", "server": "65535", "farm": 66, "title": "Sword-billed hummingbird - Colibri porte-épée - Ensifera ensifera", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607645513", "owner": "88954196@N00", "secret": "d1db24463e", "server": "65535", "farm": 66, "title": "Please see the video in Youtube. You will love it!", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607543893", "owner": "159013774@N04", "secret": "bd3e54bcbf", "server": "65535", "farm": 66, "title": "MM_#Brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607830671", "owner": "144726176@N03", "secret": "93ddd72b4a", "server": "65535", "farm": 66, "title": "Arches panorama at twilight", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49606637448", "owner": "147026769@N04", "secret": "9643339ff6", "server": "65535", "farm": 66, "title": "", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609826257", "owner": "64534310@N07", "secret": "606a1e533c", "server": "65535", "farm": 66, "title": "DSC9310  Snow Bunting..", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608806813", "owner": "8845484@N02", "secret": "23a10d740a", "server": "65535", "farm": 66, "title": "Back to school.", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608727218", "owner": "127723660@N02", "secret": "2efef5976c", "server": "65535", "farm": 66, "title": "Eurasisches Eichhörnchen (Sciurus vulgaris) im Winterfell (Explored)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608545248", "owner": "165783724@N07", "secret": "292e83d276", "server": "65535", "farm": 66, "title": "3_1", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608542687", "owner": "83822200@N02", "secret": "c42d1ef693", "server": "65535", "farm": 66, "title": "Paintbrush. HMM!  (In Explore)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608490922", "owner": "145920189@N08", "secret": "fff74b0b1e", "server": "65535", "farm": 66, "title": "Before sunrise", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608956807", "owner": "113852409@N08", "secret": "97ae5a9db0", "server": "65535", "farm": 66, "title": "ibis on the fly", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608123687", "owner": "50080622@N08", "secret": "4cb5f266be", "server": "65535", "farm": 66, "title": "Silicone pastry brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607991696", "owner": "137414659@N08", "secret": "01bb67f6eb", "server": "65535", "farm": 66, "title": "Brush - MM", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607688103", "owner": "75958878@N04", "secret": "a8460f12d4", "server": "65535", "farm": 66, "title": "Golden eagle", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607414106", "owner": "128842391@N07", "secret": "5050b4af42", "server": "65535", "farm": 66, "title": "Macro Mondays - Brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607102187", "owner": "35156936@N00", "secret": "8d644717b1", "server": "65535", "farm": 66, "title": "Man On Fire", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607973917", "owner": "54455610@N05", "secret": "7ec5666d87", "server": "65535", "farm": 66, "title": "Stunning colors of a grasshopper", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608968673", "owner": "21028294@N06", "secret": "644b43829b", "server": "65535", "farm": 66, "title": "oranges", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608766238", "owner": "25138781@N05", "secret": "7465a12fc1", "server": "65535", "farm": 66, "title": "Cherry Blossoms & Taipei 101 Building", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607330986", "owner": "43355778@N03", "secret": "3781d6186b", "server": "65535", "farm": 66, "title": "Sauna Massage Brush Bristles", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609020197", "owner": "131301995@N02", "secret": "86559ecefd", "server": "65535", "farm": 66, "title": "Agateador común (Certhia brachydactyla)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607354523", "owner": "15110778@N05", "secret": "88beee830d", "server": "65535", "farm": 66, "title": "Quadriga \/ Brandenburger Tor Berlin", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608392626", "owner": "69131641@N04", "secret": "9ef9ee3cfb", "server": "65535", "farm": 66, "title": "Silver-spotted Skipper", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608310303", "owner": "130488194@N03", "secret": "1309a5ec09", "server": "65535", "farm": 66, "title": "2I1A6705", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607505998", "owner": "129593667@N03", "secret": "b7b1df0be5", "server": "65535", "farm": 66, "title": "Leopard with prey", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607105572", "owner": "56757728@N03", "secret": "f922a38215", "server": "65535", "farm": 66, "title": "Brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608631302", "owner": "44635421@N06", "secret": "3863031aa8", "server": "65535", "farm": 66, "title": "Golden pheasant (Chrysolophus pictus)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608383632", "owner": "8118124@N07", "secret": "e5bf40dc95", "server": "65535", "farm": 66, "title": "Bristles", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608273352", "owner": "47308200@N02", "secret": "91c7f01efe", "server": "65535", "farm": 66, "title": "En Bas (Explored)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608400212", "owner": "158339474@N08", "secret": "7586f4d676", "server": "65535", "farm": 66, "title": "No sounds", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608292172", "owner": "134213050@N02", "secret": "94c1c876a8", "server": "65535", "farm": 66, "title": "Ginger up!", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608014101", "owner": "61176154@N00", "secret": "f31d135027", "server": "65535", "farm": 66, "title": "When the sun goes down...", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607199887", "owner": "141930662@N07", "secret": "56804e8dc2", "server": "65535", "farm": 66, "title": "Sud-Ouest, 2020", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609512847", "owner": "78683307@N04", "secret": "91600e8794", "server": "65535", "farm": 66, "title": "龍磐大草原～！", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608773461", "owner": "126232476@N06", "secret": "89c9dc4493", "server": "65535", "farm": 66, "title": "Passing Through", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608170641", "owner": "17516529@N00", "secret": "81eb4f991a", "server": "65535", "farm": 66, "title": "Snowscape", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607034661", "owner": "23939795@N04", "secret": "a9393066e7", "server": "65535", "farm": 66, "title": "Badlands Nightscape 3922", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49608805437", "owner": "52469261@N03", "secret": "379ffbc203", "server": "65535", "farm": 66, "title": "1st Of March", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607635853", "owner": "152580420@N03", "secret": "8cdc8ee5c5", "server": "65535", "farm": 66, "title": "forest series #503", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609989341", "owner": "28726735@N08", "secret": "8053bc6084", "server": "65535", "farm": 66, "title": "rainbow macro brush", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609243777", "owner": "74269181@N00", "secret": "51d462305c", "server": "65535", "farm": 66, "title": "'At the close of autumn ... '", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607272386", "owner": "97574100@N05", "secret": "765557fd84", "server": "65535", "farm": 66, "title": "Steampunk gothic TARDIS console", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49607191116", "owner": "103847494@N02", "secret": "a2cc104a26", "server": "65535", "farm": 66, "title": "Febrovery Day...30?", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
  { "id": "49609785457", "owner": "94080938@N08", "secret": "1037017d13", "server": "65535", "farm": 66, "title": "Great Horned Owl", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
] }, "stat": "ok" }
```

## 拼接URL

若要將 <photo> 元素對映至 URL，請閱讀  [URL說明文件](https://www.flickr.com/services/api/misc.urls.html)。

> URL 會採用以下格式：
- https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
- https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
- https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)

样例:

```json
{ "id": "49608977642", "owner": "64882836@N02", "secret": "16423619c9", "server": "65535", "farm": 66, "title": "Lean to the left.", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
```

```sh
# https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

wegt https://farm66.staticflickr.com/65535/49608977642_16423619c9.jpg
```
