# frozen_string_literal: true

module Sinatra
  module TitleHelper
    TITLE = {
      0 => "Unknown",
      1 => "Adventurer",
      2 => "Archer",
      3 => "Blademaster",
      4 => "Enchanter",
      5 => "Life Mage",
      6 => "Sorcerer",
      7 => "Vagabond",
      8 => "Warrior",
      9 => "Bow Hunter",
      10 => "Life Caster",
      11 => "Soldier",
      12 => "Swashbuckler",
      13 => "War Mage",
      14 => "Wayfarer",
      15 => "Abhorrent Warrior",
      16 => "Alchemist",
      17 => "Annihilator",
      18 => "Apothecary",
      19 => "Arctic Adventurer",
      20 => "Arctic Mattekar Annihilator",
      21 => "Artifex",
      22 => "Axe Warrior",
      23 => "Ballisteer",
      24 => "Bane of the Remoran",
      25 => "Blood Shreth Butcher",
      26 => "Bloodletter",
      27 => "Broodu Killer",
      28 => "Browerk Killer",
      29 => "Bug Butcher",
      30 => "Bugstomper",
      31 => "Bunny Master",
      32 => "Carenzi Slayer",
      33 => "Chain Breaker",
      34 => "Champion of Dereth",
      35 => "Champion of Sanamar",
      36 => "Champion of Silyun",
      37 => "Chef",
      38 => "Creature Adept",
      39 => "Dagger Fighter",
      40 => "Deadeye",
      41 => "Deathcap Defeater",
      42 => "Defender of Dereth",
      43 => "Deliverer",
      44 => "Diplomat",
      45 => "Dire Mattekar Dispatcher",
      46 => "Duelist",
      47 => "Ebon Gromnie Eradicator",
      48 => "Engorged Scourge",
      49 => "Evoker",
      50 => "Explorer",
      51 => "Exterminator",
      52 => "Fisherman",
      53 => "Fletcher",
      54 => "Floeshark Flogger",
      55 => "Friend of Sanamar",
      56 => "Friend of Silyun",
      57 => "Gaerlan Slayer",
      58 => "Gardener Weeder",
      59 => "Glenden Wood Knight",
      60 => "Glenden Wood Militia",
      61 => "Golden God",
      62 => "Grave Robber",
      63 => "Guardian of Dereth",
      64 => "Gumshoe",
      65 => "Guppy Master",
      66 => "Heart Ripper",
      67 => "Hero of Dereth",
      68 => "Hero of Sanamar",
      69 => "Hero of Silyun",
      70 => "Honorary Snowman",
      71 => "Honorary Windreave",
      72 => "Hunter",
      73 => "Impaler",
      74 => "Insatiable Slayer",
      75 => "Invader's Bane",
      76 => "Iron Chef",
      77 => "Iron-Spined Chittick Immolator",
      78 => "Item Adept",
      79 => "Keeper of Dereth",
      80 => "Keerik Killer",
      81 => "Kingslayer",
      82 => "Kiree Killer",
      83 => "K'nath An'dras Assassinator",
      84 => "Lakeman",
      85 => "Life Adept",
      86 => "Lightbringer",
      87 => "Mace Warrior",
      88 => "Man-At-Arms Thrasher",
      89 => "Master Fletcher",
      90 => "Master of Slaughter",
      91 => "Master of Staves",
      92 => "Miner",
      93 => "Moarsman Defiler",
      94 => "Morale Smasher",
      95 => "Mosswart Worshipper Whipper",
      96 => "Mottled Carenzi Mauler",
      97 => "Mud Slinger",
      98 => "Naughty Skeleton Snuffer",
      99 => "Olthoi Ripper Reducer",
      100 => "Paragon of Death",
      101 => "Philanthropist",
      102 => "Plate Armoredillo Punisher",
      103 => "Platinum Prowler",
      104 => "Polar Ursuin Pounder",
      105 => "Polardillo Pummeler",
      106 => "Pond Scum",
      107 => "Pro Fisherman",
      108 => "Projectilist",
      109 => "Pugilist",
      110 => "Queenslayer",
      111 => "Ravenous Killer",
      112 => "Red Fury",
      113 => "Reeshan Killer",
      114 => "Rehir Killer",
      115 => "Repugnant Eater Ripper",
      116 => "Resistance Fighter",
      117 => "Resistance Recruit",
      118 => "Servant of The Deep",
      119 => "Sezzherei Slayer",
      120 => "Shadow Stalker",
      121 => "Shallows Shark Nemesis",
      122 => "Sharpshooter",
      123 => "Shellfish Hater",
      124 => "Shield of Glenden",
      125 => "Shredder",
      126 => "Silver Serf",
      127 => "Siraluun Slasher",
      128 => "Skipper",
      129 => "Skullcrusher",
      130 => "Skullsplitter",
      131 => "Slicer",
      132 => "Sniper",
      133 => "Soldier Slaughterer",
      134 => "Spear Warrior",
      135 => "Spring Cleaner",
      136 => "Staff Warrior",
      137 => "Stonebreaker",
      138 => "Sureshot",
      139 => "Swordfighter",
      140 => "Theurgist",
      141 => "Thrungus Reaper",
      142 => "Timberman",
      143 => "Tracker",
      144 => "Trapper",
      145 => "Tukora Lieutenant Trouncer",
      146 => "Unarmed Brawler",
      147 => "Violator Grievver Vetoer",
      148 => "Voracious Flayer",
      149 => "Voracious Hunter",
      150 => "War Adept",
      151 => "Warden of Dereth",
      152 => "Warlock",
      153 => "Warlord of Dereth",
      154 => "Warrior Vanquisher",
      155 => "Wicked Skeleton Walloper",
      156 => "Windreave Stalker",
      157 => "Worker Obliterator",
      158 => "Dryreach Militia",
      159 => "Honorary Shadow Hunter",
      160 => "Perforated Knight",
      162 => "Pest Control",
      163 => "Rat Reaper",
      164 => "Nymph Maniac",
      165 => "\$imiu\$",
      166 => "2nd Place Lore- Quiz Night",
      167 => "AC Veteran",
      168 => "Ain't afraid of no ghost!",
      169 => "Ain't afraid of no ghost",
      170 => "Ain't afraid of no ghost..mwahaha!",
      171 => "Ankle Biter",
      172 => "Annoying Furry Talking Animal",
      173 => "Archer Assassin",
      174 => "Archmage",
      175 => "Asheron's Call God",
      176 => "Avatar of Kain",
      177 => "Azure Assailant",
      178 => "Baby Bunny Master",
      179 => "Baron Oddity",
      180 => "Beginning of the End",
      181 => "Best Melee in DT",
      182 => "Big Block",
      183 => "Big Rocx",
      184 => "Blood",
      185 => "Bounty Hunter",
      186 => "British Tootsie",
      187 => "Bug Bait",
      188 => "Bunny Killer",
      189 => "Carebear Stare",
      190 => "Certified Ganksta",
      191 => "Chicken Nugget",
      192 => "Chicken Select",
      193 => "Chimaera's Champion",
      194 => "Co-Monarch of TheChosen",
      195 => "Containment Unit",
      196 => "Coolest Title Ever!",
      197 => "Corrosive Soul",
      198 => "Cow Killer",
      199 => "Cowboy",
      200 => "Crystal Lord King",
      201 => "Cuddly Kitten >\^..\^<",
      202 => "Curmudgeon's Friend",
      203 => "Cursed Adventurer",
      204 => "Dagger Master",
      205 => "Dark Sword Lady",
      206 => "Darktides Finest",
      207 => "Darktides Most Wanted",
      208 => "Dead Meat",
      209 => "Deadly Eggburt",
      210 => "Death by Default",
      211 => "Death by Pumpkin",
      212 => "Death by Sappho",
      213 => "Death Specialist",
      214 => "Defender of Mr. P",
      215 => "Dereth's Gladiator",
      216 => "Dereth's Master Dodger",
      217 => "Dev Evader",
      218 => "Dev Killer",
      219 => "Dev Slayer",
      220 => "Double Fashion King",
      221 => "Double Golem Killer",
      222 => "Double Survival Champion",
      223 => "Dude of DOOM!",
      224 => "Ecto Cooler",
      225 => "Ecto-Cooler",
      226 => "Envoy Slayer",
      227 => "Escapee Killer",
      228 => "Evil Toothfairy",
      229 => "Fancy Title",
      230 => "Fashion King",
      231 => "Fashion Penguin King",
      232 => "Fashion Queen",
      233 => "Fashion Victim",
      234 => "Fearless Fighter",
      235 => "Flag Boy",
      236 => "Frelorn Slayer",
      237 => "Friend to Mr. P",
      238 => "Gangsta Style",
      239 => "Gangster",
      240 => "Ghostbuster",
      241 => "Gimp",
      242 => "Gimp Goddess",
      243 => "Gimpy Mage of Might",
      244 => "Gladiator Champion",
      245 => "Glowing Archer",
      246 => "God of the Swordsman",
      247 => "Golem Killer",
      248 => "Golem Slayer",
      249 => "Great Pookie Slayer",
      250 => "Guardian Angel",
      251 => "Guardian of Arwic",
      252 => "Hamster Herder",
      253 => "Hamster Vitae",
      254 => "Have Bunnie's Will Travel",
      255 => "Have Trike Will Babble",
      256 => "Hide and Seek Specialist",
      257 => "Hollywood Bud",
      258 => "Holtburg Survival Champion",
      259 => "Holtburg's Survivor Champion",
      260 => "Honorary Pink Eep",
      261 => "Hungry Hungry Hippo",
      262 => "Husband of Lynnie",
      263 => "Husbands Healer",
      264 => "I am Big \[\]D \[\] \[\]\\/\[\] \[\]D \[\] \[\]\\\[\]",
      265 => "I liked dying!",
      266 => "Jessica <3",
      267 => "King of all that is Pumpkin",
      268 => "King of Caul",
      269 => "King of Darktide",
      270 => "King of Pierce Diggys",
      271 => "Knight Rider",
      272 => "Lady of the Four Towers",
      273 => "Lange Gang",
      274 => "Level Master",
      275 => "Leviathan",
      276 => "Leviathan Slayer",
      277 => "Libe Events Manager",
      278 => "Life Preserver",
      279 => "Live Event Coordinator",
      280 => "Live Events Manager",
      281 => "Live Op Coordinator",
      282 => "Lore- 2nd Place",
      283 => "Lore 2nd Place Quiz Night",
      284 => "Lore Champion - Quiz Night",
      285 => "Lore Champion Quiz Night",
      286 => "Lore Master",
      287 => "{{keepspaces}}Lore Master  Quiz Night",
      288 => "Lore Master - Quiz Night",
      289 => "Lore Master 2nd Place",
      290 => "Lore Master of Staves",
      291 => "Lots of Vitae",
      292 => "Lucky Lady",
      293 => "Mad Cow Slayer",
      294 => "Mages Assitant",
      295 => "Master Tinkerer",
      296 => "Mayor of Ayan Baqur",
      297 => "Minty Fresh",
      298 => "Misunderstood Pengy",
      299 => "Mom",
      300 => "Mommy Pengy",
      301 => "Mosswart Ally",
      302 => "Mr. Nice Guy",
      303 => "Murderer",
      304 => "Murderer !",
      305 => "Newby Title",
      306 => "Nice Blue Lady",
      307 => "Number one draft pick",
      308 => "Old School",
      309 => "Paradox Slayer",
      310 => "Patron Saint of the Lifestone",
      311 => "Peacebear",
      312 => "Penguin Killer",
      313 => "Pig Farmer",
      314 => "Pink Bunny Killer",
      315 => "Pink Bunny Master",
      316 => "Pink Goddess",
      317 => "Pink Lady",
      318 => "PK Queen",
      319 => "Playa Killa King",
      320 => "Pokemon Slayer",
      321 => "Pretty Pumpkin",
      322 => "Prisoner",
      323 => "Protector of the Cheese",
      324 => "Proton Pack",
      325 => "Pumpkin Slayer",
      326 => "Pumpkin Stalker",
      327 => "Purple Pengy",
      328 => "Pwner of Newbs",
      329 => "Queen of Brats",
      330 => "Queens Crafter",
      331 => "Queen's Crafter",
      332 => "Queen's Pack Rat",
      333 => "Queen's Packrat",
      334 => "Queen's Tinker",
      335 => "Rawr!",
      336 => "Rayne's Mage Pet",
      337 => "Reggae Renegade",
      338 => "Ring Bearer",
      339 => "Ring ring ring.....Bananaphone",
      340 => "Road Kill",
      341 => "Rolling Death Destroyer",
      342 => "Royal Chef",
      343 => "Royal Cook",
      344 => "Rugged",
      345 => "Sanitation Engineer",
      346 => "Scarecrow Slayer",
      347 => "Scary Pumkpkin Dominator",
      348 => "Scary Pumpkin Slayer",
      349 => "Sentinal",
      350 => "Sentry",
      351 => "Shadow Child",
      352 => "Shadow Hunter",
      353 => "Shadow Slayer",
      354 => "Slayer of the Great Pookie",
      355 => "Slimer",
      356 => "Snazzy Dresser",
      357 => "Soul Man",
      358 => "Spooky Title",
      359 => "Staff Masta",
      360 => "Staypuffed Mallow Girl",
      361 => "Super Gimped Adventurer",
      362 => "Supercalifragilisticexpialidocious",
      363 => "Superman",
      364 => "Survivor Champion",
      365 => "Sword Scholar",
      366 => "Teh Newb",
      367 => "Teh Saint",
      368 => "Testing Guy",
      369 => "The Bait",
      370 => "The Chosen King",
      371 => "The Come Back Kid",
      372 => "The Forgotten",
      373 => "The Gimped",
      374 => "The Great and Powerful",
      375 => "The Half-Fox",
      376 => "The Noob",
      377 => "The Purple Fez",
      378 => "The Pwnerer",
      379 => "The Unknown Pk",
      380 => "Thunder Chicken Slayer",
      381 => "TM Killer",
      382 => "Tough Guy",
      383 => "Tradesman of Auberean",
      384 => "Treasure Hunter",
      385 => "Tremendous Monouga Master",
      386 => "Triple Golem Killer",
      387 => "Turbine Slayer",
      388 => "Twins of Terror",
      389 => "Uberest Noob on Frostfell",
      390 => "Underworld-Thugg",
      391 => "Viamontian Slayer",
      392 => "Vitae King",
      393 => "Vitae Vixen",
      394 => "Vixen of Vitae",
      395 => "Wabbit Bait",
      396 => "Wabbit Killer",
      397 => "Wandering Fool",
      398 => "Warden's Assistant",
      399 => "Wardens Thug",
      400 => "Wimp",
      401 => "Wolfpack Crafter",
      402 => "Wonder Woman",
      403 => "Ya got served",
      404 => "GIMP",
      405 => "Wardens Assistant",
      406 => "Supreme Bunny Master",
      407 => "Guardian of the Dark",
      408 => "April's Fool",
      409 => "Ulgrim's Eep",
      410 => "Mukkir Masher",
      411 => "Harbinger's Bane",
      412 => "Master of the Elements",
      413 => "Killcrane's Ally",
      414 => "Apprentice Shadow Hunter",
      415 => "Squire of the Golden Flame",
      416 => "Knight of the Golden Flame",
      417 => "Knight of the Whispering Blade",
      418 => "The Black Spear",
      420 => "Carraida's Avenger",
      421 => "Paragon of the Whispering Blade",
      422 => "Paragon of the Rossu Morta",
      423 => "Chosen of Varicci",
      424 => "Chosen of Elysa",
      425 => "Small Mukkir Squasher",
      426 => "Blood Warrior",
      427 => "Strategist",
      428 => "War Beast",
      429 => "Champion of Daemal",
      430 => "Hero of the Golden Flame",
      431 => "Slayer of the Black Spear",
      433 => "Obviously Bored",
      434 => "Zefir Zapper",
      435 => "Tusker Blight",
      436 => "Elemental Eradicator",
      437 => "Expert Banished Hunter",
      438 => "Expert Fallen Hunter",
      439 => "Elite Head Hunter",
      440 => "Friend of the Frostglaive",
      441 => "Squire of New Viamont",
      442 => "Reanimator",
      443 => "Zombie Incursion Survivor",
      444 => "Ulgrim's Drinking Buddy",
      445 => "Master of the Porcelain Altar",
      446 => "Master of the Mystical Mug",
      447 => "Colosseum Champion",
      448 => "Titan",
      449 => "Colossus",
      450 => "Master Gladiator",
      451 => "Fearless",
      452 => "Lord of the Arena",
      453 => "Ring Master",
      454 => "Pit Fighter",
      455 => "Myrmidon",
      456 => "Hostile Combatant",
      457 => "Survivalist",
      458 => "Warrior of the Seventh Circle",
      459 => "Gladiator",
      460 => "Contender",
      461 => "Drudge Dread",
      462 => "Arena Custodian",
      463 => "Arena Rat",
      464 => "Scrapper",
      465 => "Champion of Stone",
      466 => "Champion of Sickles",
      467 => "Champion of the Wild",
      468 => "Champion of the Hive",
      469 => "Champion of Assassins",
      470 => "Immortal Champion",
      471 => "Ruuk Ally",
      472 => "Seeker of Asheron",
      473 => "Seeker of Torgluuk",
      474 => "Portal Ritualist",
      475 => "Ranger Ruuk",
      476 => "Basher Slasher",
      477 => "Guruk Hunter",
      478 => "Dead Eye for the Colossi",
      479 => "Fiendish Huntsman",
      480 => "Monster Killer",
      481 => "Bosh Bosh Kibosh",
      482 => "Mushroom Collector",
      483 => "Fungal Farmer",
      484 => "Mushroom Man",
      485 => "Fungi",
      486 => "Mushroom King",
      487 => "Thrungamandius",
      488 => "Initiate of the Blade",
      489 => "Torgluuk's Liberator",
      490 => "Burun Liberator",
      491 => "Asheron's Savior",
      492 => "Asheron's Defender",
      494 => "Fuzzy Bunny Slayer",
      495 => "Moar Hunter",
      496 => "Spiketooth Slayer",
      497 => "Tower Guardian Architect",
      498 => "Artisan of the Flame and Light",
      499 => "Guardian of the Tower",
      500 => "Cragstone Militia",
      501 => "Cragstone Knight",
      502 => "Guardian of Cragstone",
      503 => "Knight of the Windmill",
      504 => "Hero of House Mhoire",
      505 => "Lady Tairla's Champion",
      506 => "Royal Investigator",
      507 => "Wanga Fighter",
      508 => "Hoogan's Hero",
      509 => "Cragstone Firefighter",
      511 => "Stalker Stalker",
      512 => "Ravenous",
      513 => "Altered Hunter",
      514 => "Augmented Hunter",
      515 => "Drudge Doom",
      516 => "Defender of Kryst",
      517 => "Paradox-touched Queenslayer",
      518 => "Amelia's Caretaker",
      519 => "Prodigal Tusker Slayer",
      520 => "Mudmouth's Bane",
      521 => "Oolutanga's Bane",
      522 => "Prodigal Shadow Slayer",
      523 => "Prodigal Harbinger Slayer",
      524 => "Blood Seeker",
      525 => "Storm Rider",
      526 => "Meddler",
      527 => "Vile Betrayer",
      528 => "Spy",
      529 => "Slithis Slayer",
      530 => "Chosen of the Rift",
      531 => "Rift Shifter",
      532 => "Rift Walker",
      533 => "Reef Builder",
      534 => "Reef Breaker",
      535 => "Crypt Rat",
      536 => "Grave Stalker",
      537 => "Bone Breaker",
      538 => "Crypt Creeper",
      539 => "Tomb Raider",
      540 => "Follower of the Vine",
      541 => "Harvester",
      542 => "Harvester Harvester",
      543 => "Harvester Harvester Harvester",
      544 => "Pumpkin Throne Usurper",
      545 => "Death Knight",
      547 => "Tracker Guardian",
      548 => "Dojiro Sangi's Savior",
      549 => "Master of the Hunt",
      550 => "Initiate of the Hunt",
      551 => "Apprentice of the Hunt",
      552 => "Disciple of the Hunt",
      553 => "Seeker of the Hunt",
      554 => "Champion of the Hunt",
      555 => "Guardian of Linvak Tukal",
      556 => "Unwitting Participant",
      557 => "Friend of Rheaga",
      558 => "Slayer of Rheaga",
      559 => "Protector of the Past",
      560 => "Warrior of the Past",
      561 => "Anthropologist",
      562 => "Gold Farmer",
      563 => "Third Eye Blinder",
      564 => "Dire Drudge Decapitator",
      565 => "Renegade Hunter",
      566 => "Banderling Bully",
      567 => "Xenophobic",
      568 => "Shadow Sunderer",
      569 => "Dire Huntsman",
      570 => "Game Warden",
      571 => "Honorary Rea of the Aun",
      572 => "Hope of the Past",
      573 => "Beacon of Hope",
      574 => "Aerbax's Bane",
      575 => "Aerbax Slayer",
      576 => "Jester's Emancipator",
      577 => "Jester's Fool",
      578 => "Jester's Accomplice",
      579 => "Honorary Burun Scout",
      580 => "Marble Wrangler",
      581 => "Secret Keeper",
      582 => "Jester's Little Helper",
      583 => "Hard to Kill",
      584 => "Expendable",
      585 => "Novice of the Sea",
      586 => "Acolyte of the Sea",
      587 => "Minister of the Sea",
      588 => "Defender of the Sea",
      589 => "Champion of the Sea",
      590 => "Master of the Sea",
      591 => "Defeater of the Blight",
      592 => "Champion of the Aerlinthe Node",
      593 => "Champion of the A'mun Node",
      594 => "Champion of the Esper Node",
      595 => "Champion of the Halaetan Node",
      596 => "Champion of the Linvak Node",
      597 => "Champion of the Obsidian Node",
      599 => "Ulgrim's Happy Hundredth",
      600 => "Plucker of Eyes",
      601 => "Warden of the Burning Wood",
      602 => "Tough Tough",
      603 => "Archaeologist",
      604 => "Hero of Woe",
      605 => "Defender of Silyun",
      606 => "Memorial Champion",
      607 => "Thane of Colier",
      608 => "Guardian of the Keep",
      609 => "Warrior of the Crater Lake",
      611 => "Arwician",
      612 => "Desert Warrior",
      613 => "Mayoi Protector",
      614 => "Stone Collector",
      615 => "Rock Star",
      616 => "Rock Hound",
      617 => "Warrior of Woe",
      618 => "Has way too much time",
      619 => "Champion Immemorial",
      620 => "Colier Miner",
      621 => "Legionnaire",
      622 => "Volcanologist",
      623 => "Hilltop Defender",
      624 => "Arwic Noble",
      625 => "Zharalim",
      626 => "Samurai",
      627 => "Guardian in the Patriarch Raids",
      628 => "Warden in the Patriarch Raids",
      629 => "Hero of the Patriarch Raids",
      630 => "Marked by the Patriarchs",
      637 => "Cathedrals Champion",
      638 => "Asheron's Militia",
      639 => "Minik Ra's Bane",
      640 => "Kazyk Ri's Bane",
      641 => "Nivinizk's Bane",
      642 => "Minik Ra's Nemesis",
      643 => "Kazyk Ri's Nemesis",
      644 => "Nivinizk's Nemesis",
      645 => "Auberean's Sentinel",
      646 => "Dereth's Elite",
      647 => "Defender of the Deru",
      648 => "Bane of the Blessed",
      649 => "Negotiator",
      650 => "Bane of the Blight",
      651 => "Gifted",
      652 => "Seasonal Seeker",
      653 => "Amateur Explorer",
      654 => "Experienced Explorer",
      655 => "Adept Explorer",
      656 => "Master Explorer",
      657 => "Elite Explorer",
      658 => "Mountain Climber",
      659 => "Daredevil",
      660 => "Sky Diver",
      661 => "Spelunker",
      662 => "Party-Goer",
      663 => "Crater Crasher",
      664 => "Tactical Aid",
      665 => "True Tactician",
      666 => "Tactical Fantastical",
      667 => "Fire of the Tanada",
      668 => "Crystalline Adventurer",
      669 => "Wisp Whipper",
      670 => "Burning Soul",
      671 => "Frozen Fighter",
      672 => "Dedicated",
      673 => "Assassin",
      674 => "Death Dealer",
      675 => "Bridge Jumper",
      676 => "Sure Step",
      677 => "Player Slayer",
      678 => "Bathed in Blood",
      679 => "I Am Darktide",
      680 => "Darkness in the Light",
      681 => "Beginning's End",
      682 => "Nexus Crawler",
      683 => "Selfless Soul",
      684 => "Timeless Adventurer",
      685 => "Virindi Informer",
      686 => "No Cage Can Hold Me",
      687 => "All for One",
      688 => "One for All",
      689 => "Jack-O'-All Trades",
      690 => "Knight of the Northeast Tower",
      691 => "Knight of the Northwest Tower",
      692 => "Knight of the Southeast Tower",
      693 => "Knight of the Southwest Tower",
      694 => "Knight of the Mhoire Throne",
      695 => "Historian of the Mhoire Throne",
      696 => "Champion of House Mhoire",
      697 => "Swordbearer of House Mhoire",
      698 => "Archmage of House Mhoire",
      699 => "Seeker of Castle Mhoire",
      700 => "Steward of Castle Mhoire",
      701 => "Golden Gear Crafter",
      702 => "Ally of the Gold Primus",
      703 => "Gear Knight Assassin",
      704 => "Gear Knight Recruiter",
      705 => "Gear Knight Emissary",
      706 => "Menhir Seeker",
      707 => "Mana Field Finder",
      708 => "Assistant's Assistant",
      709 => "Arcanum Adventurer",
      710 => "Gear Knight Defender",
      711 => "Soldier of the Queen",
      712 => "Spitter of the Queen",
      713 => "Bloodstone Hunter",
      714 => "Guiding Light",
      715 => "Clouded Soul",
      716 => "Undercover of Darkness",
      717 => "Brought to Light",
      719 => "Illuminating the Shadows",
      720 => "Exploring Archaeologist",
      721 => "Contract Killer",
      722 => "Shadow Puppet",
      723 => "Hopebringer",
      724 => "In the Dark",
      726 => "Searching the Shadows",
      727 => "Shadow Soldier",
      728 => "Bright Knight",
      729 => "Merciful Killer",
      730 => "Soul Siphon",
      731 => "The Tou-Tou Terror",
      732 => "Double Agent",
      733 => "Duleing with the Dark",
      734 => "Creature of Chaos",
      735 => "Conspirator",
      736 => "Hero of the Night",
      737 => "Master of the Twisted Word",
      738 => "The Nightmare Lord",
      739 => "The Nightmare Mage",
      740 => "The Twisted Weaver",
      741 => "Lord of Dark Dreams",
      743 => "The Dark Dreamwalker",
      745 => "The Dreamslayer",
      746 => "The Nightmare Stalker",
      748 => "The Thought Spiral",
      751 => "Master of the Oubliette",
      753 => "The Restless",
      754 => "Fiery Spirit",
      755 => "Icy Veins",
      756 => "Shocking Disposition",
      757 => "Acidic Soul",
      758 => "Grounded Morals",
      759 => "Darkened Heart",
      760 => "The True Emperor",
      761 => "Bearer of Darkness",
      763 => "Healer Ritualist",
      764 => "Vanquisher of the Titan",
      765 => "Derethian Newbie",
      766 => "Novice Wanderer",
      767 => "Notable Citizen",
      768 => "Adept Adventurer",
      769 => "Intrepid Explorer",
      770 => "Supreme Soldier",
      771 => "Epic Warrior",
      772 => "Paragon of New Aluvia",
      773 => "An Auberean Legend",
      774 => "Heretic",
      775 => "Captain",
      776 => "Pet Savior",
      777 => "Avalanche Avoider",
      778 => "Liberator of Uziz",
      779 => "Out of Tune",
      780 => "Hive Queenslayer",
      781 => "Eviscerator Decimator",
      782 => "Ultimate Warrior",
      783 => "Stone Cold Killer",
      784 => "Queller of Rage",
      785 => "Ender of Torment",
      786 => "Controller of Emotions",
      787 => "Rynthid Ravager",
      788 => "Lothus Servitor",
      789 => "Ally of the Lothus",
      790 => "Ally of the Council",
      791 => "Emotional Wreck",
      792 => "Minion Marauder",
      793 => "Rynthid Wrecker",
      794 => "Mender of the Rift",
      795 => "Rage Quitter",
      796 => "Sorcerer Slayer",
      797 => "Night Owl",
      798 => "Purifier",
      799 => "Fan of Asheron",
      800 => "Asheron's #1 Fan",
      801 => "Shutterbug",
      802 => "The Focused",
      803 => "Dereth Recruiter",
      804 => "Fowl Follower",
      805 => "Follower of Asheron",
      806 => "Follows Directions",
      807 => "Can't Follow Directions",
      808 => "Likes Asheron",
      809 => "Likes Getting Titles",
      810 => "Likes Where This Is Going",
      811 => "Likes Ulgrim",
      812 => "Likable",
      813 => "Captivating",
      814 => "Master of Ceremony",
      815 => "Road Warrior",
      816 => "Thriller",
      817 => "Haunts Your Dreams",
      818 => "Asheron's Collect Caller",
      819 => "The Inquisitive",
      820 => "Portal Stormer",
      821 => "Bringer of Pain",
      822 => "Harbinger of Madness",
      823 => "Marked by Luck",
      824 => "Marked by Fate",
      825 => "Marked by Fame",
      826 => "Marked by Glamour",
      827 => "Marked by Bacon",
      828 => "Puzzlemaster",
      829 => "Riddle Ravager",
      830 => "The Cool Kids Club",
      831 => "Epic Win",
      832 => "Epic Fail",
      833 => "Always Picked First",
      834 => "Always Picked Last",
      835 => "Forever Alone",
      836 => "99 Problems, Olthoi Ate 1",
      837 => "Hungry for Moar",
      838 => "I Can Haz Title Nao",
      839 => "Snowbunny",
      840 => "Cold as Ice",
      841 => "Penguin Plunge",
      842 => "Flower Sniffer",
      843 => "Springs Into Action",
      844 => "Heats Things Up",
      845 => "Cruel Summer",
      846 => "Hot in the City",
      847 => "Runs Through Sprinklers",
      848 => "The Knowledgeable",
      849 => "Well Trained",
      850 => "Pumpkin Lord",
      851 => "Haunted",
      852 => "Possessed",
      853 => "Doomsayer",
      854 => "Accursed",
      855 => "Cold Turkey",
      856 => "Jive Turkey",
      857 => "Present Protector",
      858 => "Holly Jolly Helper",
      859 => "Loss Prevention",
      860 => "Gift Gopher",
      861 => "Holiday Hero",
      862 => "Crown Of the Deru",
      863 => "Viridian Dreamer",
      864 => "Viridian Lord",
      865 => "Viridian Knight",
      866 => "Viridian Stalker",
      867 => "Viridian Slayer",
      868 => "Viridian Purifier",
      869 => "Knight Of Thorns",
      870 => "Hunter Of Thorns",
      871 => "Mage Of Thorns",
      872 => "Thornstalker",
      873 => "Champion Of The Viridian Tree",
      874 => "Corruptor Of The Root",
      875 => "Killer Among Shadows",
      876 => "Servant Of The Vile",
      877 => "Knight Of Corrupted Amber",
      878 => "Gauntlet Champion",
      879 => "Bloodthirsty",
      880 => "Gauntlet Gladiator",
      881 => "Wily Warrior",
      882 => "Soldier of Fortune",
      883 => "Society Savage",
      884 => "Coin Collector",
      885 => "Brutal Barbarian",
      886 => "Idolized",
      887 => "Master of Puppets",
      888 => "Titan Slayer",
      889 => "Awakened",
      890 => "Enlightened",
      891 => "Illuminated",
      892 => "Transcended",
      893 => "Cosmic Conscious",
      894 => "Last Man Standing",
    }

    def title(id)
      TITLE[id]
    end

    def titles
      TITLE
    end
  end

  helpers TitleHelper
end
