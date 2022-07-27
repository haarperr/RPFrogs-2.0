itemList = {};

/*

  WEAPONS START

*/

// MELEE

itemList['2343591895'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Flaslight',
  price: 1,
  weight: 11,
  nonStack: true,
  craft: [[
    { itemid: 'copper', amount: 500 },
    { itemid: 'rubber', amount: 50 },
  ]],
  model: '',
  image: 'np_flashlight.png',
  weapon: true,
};

itemList['nitrous'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nitrous Oxide',
  craft: [[{ itemid: 'electronics', amount: 10 }]],
  price: 300,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_nitrous-oxide.png',
};


itemList['-262696221'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Prison Knife',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'scrapmetal', amount: 1 }, 
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_shiv.png',
  weapon: true,
  contraband: true,
};

itemList['1923739240'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sledgehammer',
  craft: [
    [
      { itemid: 'steel', amount: 75 },
      { itemid: 'scrapmetal', amount: 75 },
    ],
    [
      { itemid: 'refinedsteel', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ],
  ],
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_sledgehammer.png',
  information: 'Big and Thicc.',
  weapon: true,
  contraband: true,
};

itemList['-102323637'] = {
  fullyDegrades: true,
  decayrate: 2.00,
  displayname: 'Broken Bottle',
  craft: [[
    { itemid: 'refinedglass', amount: 10 },
  ]],
  price: 1,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_glass-bottle.png',
  information: 'It looks like an premium Karlsberg bottle.',
};

itemList['3638508604'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Knuckle Duster',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'scrapmetal', amount: 10 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'refinedscrap', amount: 3 },
    ]
  ],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_knuckle-dusters.png',
  weapon: true,
  contraband: true,
};

itemList['knuckle_chain'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Chain Duster',
  craft: [[
    { itemid: 'refinedscrap', amount: 20 },
    { itemid: 'refinedsteel', amount: 15 },
  ]],
  price: 250,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_chain_dusters.png',
  weapon: false,
  contraband: true,
};

itemList['1141786504'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Golf Club',
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_golfclub.png',
  weapon: true,
};

itemList['1317494643'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hammer',
  price: 250,
  weight: 8,
  nonStack: true,
  model: '',
  image: 'np_hammer.png',
  weapon: true,
};

itemList['1737195953'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Nightstick',
  price: 1,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_nightstick.png',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  weapon: true,
};

itemList['2227010557'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Crowbar',
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_crowbar.png',
  weapon: true,
};

itemList['-1786099057'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Keyboard model M',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_keyboard.png',
  weapon: true,
};

itemList['-1239161099'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'While you have fun, I study the blade.',
  weapon: true,
  contraband: true,
};

itemList['1692590063'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
    { itemid: 'refinedaluminium', amount: 250 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'While you have fun, I study the blade.',
  weapon: true,
  contraband: true,
};

itemList['-538741184'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Switchblade',
  craft: [[
    { itemid: 'methlabproduct', amount: 25 },
    { itemid: 'ciggy', amount: 100 },
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_switchblade.png',
  weapon: true,
};

itemList['2460120199'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Antique Cavalry Dagger',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'scrapmetal', amount: 10 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'scrapmetal', amount: 10 },
    ]
  ],
  price: 250,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_dagger.png',
  weapon: true,
  contraband: true,
};

itemList['600439132'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Lime',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_lime.png',
  weapon: true,
  contraband: true,
};

itemList['-1024456158'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Baseball Bat',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_baseball-bat.png',
  weapon: true,
  contraband: true,
};

itemList['-2000187721'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Security Case',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_securitycase.png',
  weapon: true,
  contraband: true,
};

itemList['28811031'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Suitcase',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_suitcase.png',
  weapon: true,
  contraband: true,
};

itemList['2578778090'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Knife',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_knife.png',
  weapon: true,
};

itemList['2484171525'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Pool Cue',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_pool-cue.png',
  weapon: true,
};

itemList['3713923289'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Machete',
  craft: [
    [
      { itemid: 'aluminium', amount: 140 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_machete.png',
  weapon: true,
  contraband: true,
};

itemList['4191993645'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hatchet',
  price: 250,
  weight: 17,
  nonStack: true,
  model: '',
  image: 'np_hatchet.png',
  weapon: true,
};

// THROW

itemList['1064738331'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Brick',
  craft: [[
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 250,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brick.png',
  weapon: true,
};

itemList['-691061592'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Book',
  craft: [[
    { itemid: 'rollingpaper', amount: 10 },
  ]],
  price: 250,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_book_w.png',
  weapon: true,
};

itemList['571920712'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cash',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cash.png',
  weapon: true,
};

itemList['-828058162'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stolen Shoes',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stolenshoes.png',
  information: 'It does not fit on your feet bro.',
};

itemList['-1813897027'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Stun Grenade (SWAT)',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'This way, police coul raid a building withou filling a ______! If you dont make part of SWAT, dont buy it.',
  weapon: true,
  contraband: true,
};

itemList['1233104067'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Flare',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_flare.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-1600701090'] = {
  fullyDegrades: false,
  decayrate: 0.2,
  displayname: 'Grenade M67',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 110 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 100 },
  ], [
    { itemid: 'refinedaluminium', amount: 35 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'refinedrubber', amount: 35 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_grenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-37975472'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Stun Grenade',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-1169823560'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Pipe Bomb',
  price: 250,
  weight: 7,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_pipe-bomb.png',
  weapon: true,
  contraband: true,
};

itemList['615608432'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Molotov',
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'whiskey', amount: 3 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 12 },
      { itemid: 'whiskey', amount: 3 },
    ]
  ],
  price: 250,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_molotov.png',
  weapon: true,
  contraband: true,
};

itemList['741814745'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sticky Bomb',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1250 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'rubber', amount: 1250 },
  ], [
    { itemid: 'refinedaluminium', amount: 415 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'refinedrubber', amount: 415 },
  ]],
  weight: 22,
  nonStack: true,
  model: '',
  image: 'np_sticky-bomb.png',
  weapon: true,
  contraband: true,
};

itemList['1748076076'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nail Gun',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_nailgun.png',
  weapon: true,
  insertFrom: ['nails'],
};

itemList['-72657034'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 30,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};

itemList['101631238'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Fire Extinguisher',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'scrapmetal', amount: 40 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_fire-extinguisher.png',
  weapon: true,
};

itemList['883325847'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Petrol Can',
  price: 250,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_petrol-can.png',
  weapon: true,
};

// WEAPONS

itemList['218362403'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Rubber Shotgun',
  price: 10,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 70 },
    { itemid: 'steel', amount: 70 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_lessthanlethal.png',
  weapon: true,
  information: 'Non lettal weapon used by PD and DOC',
  insertFrom: ['rubberslugs'],
};

itemList['148457251'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Browning 9mm',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_browning.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['-2012211169'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Diamondback DB9',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_DB9.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['-1746263880'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Colt Python',
  price: 250,
  weight: 11,
  craft: [
    [
      { itemid: 'aluminium', amount: 150 },
      { itemid: 'plastic', amount: 150 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 45 },
      { itemid: 'refinedplastic', amount: 45 },
    ],
  ],
  nonStack: true,
  model: '',
  image: 'np_colt.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['453432689'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Colt 1911',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 6,
  nonStack: true,
  model: '',
  image: 'np_pistol.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['-1075685676'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Beretta M9',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_pistol2.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['1593441988'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'FN FNX-45',
  price: 250,
  craft: [[
    { itemid: 'steel', amount: 65 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_combat-pistol.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['-820634585'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'PD Taser',
  price: 1,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stun-gun.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  insertFrom: ['taserammo'],
};

itemList['-120179019'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Glock 18',
  price: 1,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 9,
  nonStack: true,
  model: '',
  image: 'np_glock.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  insertFrom: ['pistolammo', 'pistolammoPD'],
};

itemList['-1716589765'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Desert Eagle',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 130 },
      { itemid: 'plastic', amount: 130 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 43 },
      { itemid: 'refinedplastic', amount: 43 },
    ],
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_pistol-50.png',
  weapon: true,
  insertFrom: ['pistolammo'],
};

itemList['-134995899'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Mac-10',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg.png',
  weapon: true,
  insertFrom: ['subammo', 'subammoPD'],
};

itemList['584646201'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Glock 18C',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 80 },
      { itemid: 'plastic', amount: 70 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 25 },
      { itemid: 'refinedplastic', amount: 25 },
    ],
  ],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_glock18c.png',
  weapon: true,
  insertFrom: ['pistolammo', 'pistolammoPD'],
};

itemList['-942620673'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Uzi',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg2.png',
  weapon: true,
  insertFrom: ['subammo', 'subammoPD'],
};

itemList['736523883'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'MP5',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_mp5.png',
  weapon: true,
  insertFrom: ['subammo', 'subammoPD'],
};

itemList['1192676223'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'M4',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m4.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  insertFrom: ['rifleammo', 'rifleammoPD'],
};

itemList['-1768145561'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'FN SCAR-L',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_scar.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC) - Subject to change',
  insertFrom: ['rifleammo', 'rifleammoPD'],
};

itemList['-1719357158'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mk14',
  price: 550,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_mk14.png',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  weapon: true,
  insertFrom: ['sniperammo'],
};

itemList['100416529'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'M24',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m24.png',
  weapon: true,
  insertFrom: ['sniperammo'],
};

itemList['-1536150836'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'AWM',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_awm.png',
  weapon: true,
  insertFrom: ['sniperammo'],
};

itemList['-90637530'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Dragunov',
  price: 500,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_dragunov.png',
  weapon: true,
  insertFrom: ['sniperammo'],
};

itemList['-1074790547'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'AK-47',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_assault-rifle.png',
  weapon: true,
  insertFrom: ['rifleammo', 'rifleammoPD'],
};

itemList['497969164'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'M70',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_m70.png',
  weapon: true,
  insertFrom: ['rifleammo', 'rifleammoPD'],
};

itemList['-275439685'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'Double Barrel Shotgun',
  price: 250,
  craft: [[
    { itemid: 'refinedsteel', amount: 50 },
    { itemid: 'refinedcopper', amount: 25 },
    { itemid: 'refinedscrap', amount: 25 },
  ]],
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_db-shotgun.png',
  weapon: true,
  insertFrom: ['shotgunammo', 'shotgunammoPD'],
};

itemList['487013001'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'IZh-81',
  price: 250,
  craft: [
    [
      { itemid: 'steel', amount: 225 },
      { itemid: 'copper', amount: 150 },
      { itemid: 'scrapmetal', amount: 150 },
    ],
    [
      { itemid: 'refinedsteel', amount: 75 },
      { itemid: 'refinedcopper', amount: 50 },
      { itemid: 'refinedscrap', amount: 50 },
    ]
  ],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_izh81.png',
  weapon: true,
  insertFrom: ['shotgunammo', 'shotgunammoPD'],
};

itemList['1432025498'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Remington 870',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_remington.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  insertFrom: ['shotgunammo', 'shotgunammoPD'],
};

itemList['171789620'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'SIG MPX',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_mpx.png',
  weapon: true,
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  insertFrom: ['subammo', 'subammoPD'],
};

itemList['1649403952'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Draco NAK9',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 300 },
      { itemid: 'steel', amount: 300 },
      { itemid: 'rubber', amount: 300 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 70 },
      { itemid: 'refinedsteel', amount: 70 },
      { itemid: 'refinedrubber', amount: 70 },
    ]
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_draco.png',
  weapon: true,
  insertFrom: ['rifleammo', 'rifleammoPD'],
};

itemList['-1472189665'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Skorpion',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 100 },
      { itemid: 'steel', amount: 100 },
      { itemid: 'rubber', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
      { itemid: 'refinedrubber', amount: 20 },
    ]
  ],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_skorpion.png',
  weapon: true,
  insertFrom: ['subammo', 'subammoPD'],
};

itemList['-1312131151'] = {
  fullyDegrades: false,
  decayrate: 4.0,
  displayname: 'Rocket Launcher',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 2300 },
    { itemid: 'rubber', amount: 2000 },
    { itemid: 'copper', amount: 2500 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_rocketlauncher.png',
  information: 'Accuracy may vary',
  weapon: true,
  insertFrom: ['rpgammo'],
};

/*

  WEAPONS END

*/

/*

  AMMOS START

*/

itemList['subammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Sub Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_sub-ammo.png',
};

itemList['heavyammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Heavy Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
};

itemList['sniperammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Sniper Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_sniper-ammo.png',
};

itemList['shotgunammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Shotgun Ammo',
  craft: [[
    { itemid: 'refinedsteel', amount: 1 },
    { itemid: 'plastic', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_shotgun-ammo.png',
};

itemList['pistolammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Pistol Ammo',
  craft: [
    [
      { itemid: 'aluminium', amount: 1 },
      { itemid: 'plastic', amount: 1 },
      { itemid: 'rubber', amount: 1 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 1 },
    ]
  ],
  price: 10,
  weight: 2,
  blockScrap: true,
  nonStack: false,
  model: '',
  image: 'np_pistol-ammo.png',
};

itemList['rifleammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Rifle Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 10 },
  ]],
  price: 1,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
  contraband: true,
};

itemList['pistolammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'PD Pistol Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 1,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  image: 'np_pistol-ammo.png',
};

itemList['subammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'PD Sub Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  image: 'np_sub-ammo.png',
};

itemList['rifleammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'PD Rifle Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  contraband: true,
};

itemList['shotgunammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'PD Shotgun Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  image: 'np_shotgun-ammo.png',
};

itemList['taserammo'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Taser Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  image: 'np_taserammo.png',
};

itemList['empammo'] = {
  fullyDegrades: true,
  decayrate: 0.08,
  displayname: 'EMP Ammo',
  price: 150,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_emp_ammo.png',
};

itemList['nails'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Nails',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_nails.png',
};

itemList['paintballs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Paintballs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_paintball_ammo.png',
};

itemList['rubberslugs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: '12 Gauge Rubber Slugs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  information: 'Equipment issued by the government (PD / EMS / DOC)',
  image: 'np_rubberslugs.png',
};

itemList['rpgammo'] = {
  fullyDegrades: true,
  decayrate: 4.0,
  displayname: 'RPG',
  craft: [[
    { itemid: 'aluminium', amount: 1500 },
    { itemid: 'plastic', amount: 200 },
    { itemid: 'rubber', amount: 400 },
  ]],
  price: 10,
  weight: 30,
  nonStack: false,
  model: '',
  image: 'np_rpgammo.png',
};

/*

  AMMOS END

*/

/*

  ATTACHMENTS START

*/

itemList['weapon_silencer_pistol'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Pistol Silencer',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'copper', amount: 50 },
    { itemid: 'rubber', amount: 50 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_ssilencer.png',
  information: 'Silencer made for some Pistols.',
};

itemList['weapon_oil_silencer'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  displayname: 'Oil Filter',
  price: 500,
  weight: 15,
  craft: [
    [
      { itemid: 'aluminium', amount: 20 },
      { itemid: 'steel', amount: 20 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 4 },
      { itemid: 'refinedsteel', amount: 4 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_oil_can_supp.png',
  information: 'Old and used Oil Filter. Does not seem to last long.',
};

itemList['weapon_silencer_assault'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Rifle Silencer',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'copper', amount: 110 },
    { itemid: 'rubber', amount: 110 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_silencerbig.png',
  information: 'Silencer made for some Rifles.',
};

itemList['weapon_scope'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Scope',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 200 },
    { itemid: 'rubber', amount: 200 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_lscope.png',
  information: 'Scope made for some weapons.',
};

itemList['weapon_uzi_extended'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Extended UZI Comb',
  price: 1500,
  weight: 15,
  craft: [
    [
      { itemid: 'aluminium', amount: 80 },
      { itemid: 'steel', amount: 80 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_extended.png',
  information: 'Only fits on a UZI.',
};

itemList['weapon_uzi_foldstock'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'UZI Fold Stock',
  price: 1500,
  weight: 5,
  craft: [
    [
      { itemid: 'aluminium', amount: 40 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_fold_stock.png',
  information: 'Only fits on a UZI.',
};

itemList['weapon_uzi_woodstock'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'UZI Wood Stock',
  price: 1500,
  weight: 5,
  craft: [
    [
      { itemid: 'aluminium', amount: 40 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_wooden_stock.png',
  information: 'Only fits on a UZI.',
};

/*

  ATTACHMENTS END

*/

/*

  FOODS START

*/

itemList['hamburger'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Hamburger',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hamburger.png',
  information: 'Hmmmm',
};

itemList['sandwich'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  displayname: 'Sandwich',
  price: 8,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_sandwich.png',
  information: 'Hmmmm',
};

itemList['donut'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Donut',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_donut.png',
  information: 'To sweeten',
};

itemList['eggsbacon'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Bacon with eggs',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_eggs-and-bacon.png',
  information: 'The perfect morning meal',
};

itemList['cookie'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cookie',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 2,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cookie.png',
  information: 'Cooked with love <3',
};

itemList['muffin'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Muffin',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_muffin.png',
  information: 'Hmmm buttery',
};

itemList['taco'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Taco',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_taco.png',
  information: 'Original from Mexico.',
};

itemList['burrito'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Burrito',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_burrito.png',
  information: 'Orale',
};

itemList['fishtaco'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Fish Taco',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishtaco.png',
  information: 'Peculiar.',
};

itemList['fries'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'French Fries',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fries.png',
  information: 'Kills hunger and thickens the blood',
};

itemList['jailfood'] = {
  fullyDegrades: true,
  decayrate: 0.001,
  displayname: 'Jail Food',
  price: 0,
  weight: 25,
  nonStack: false,
  model: '',
  image: 'np_jailfood.png',
  information: "It looks as bad as the sheriff's aim.",
};

itemList['bleederburger'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Bleeder Burger',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_the-bleeder.png',
  information: 'Looks raw, but i think its good.',
};

itemList['heartstopper'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Heart Stopper',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_the-heart-stopper.png',
  information: 'How many people does this feed?',
};

itemList['torpedo'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Torpedo',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_torpedo.png',
  information: 'Hmmm.',
};

itemList['meatfree'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Vegan Meat',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_meat-free.png',
  information: 'Thats soy meat?',
};

itemList['moneyshot'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Money Shot',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_money-shot.png',
  information: 'Snack of the real millionares.',
};

itemList['churro'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Churro',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_churro.png',
  information: 'Basically a long donut. Raises glucose.',
};

itemList['hotdog'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Hot Dog',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hotdog.png',
  information: 'Whats inside?',
};

itemList['chocobar'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Chocolate Bar',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 6,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_chocolate-bar.png',
  information: 'Hmm...',
};

itemList['icecream'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Icecream',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_icecream.png',
  information: 'Chilling.',
};

itemList['pizza'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pizza Slice',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pizza-slice.png',
  information: 'Check for pineapple',
};

itemList['pizzabox'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Pizza Box',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_pizza_box.png',
  information: 'Oven Fresh!',
};

itemList['spaghetti'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Spaghetti',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spaghetti.png',
  information: 'Knees weak...',
};

/*

  FOODS END

*/

/*

  DRINKS START

*/

itemList['water'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Water',
  price: 4,
  weight: 1,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: 'Kills the thirst.',
};

itemList['cola'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cola',
  price: 7,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coke.png',
  information: 'Kills the thirst.',
};

itemList['greencow'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Green Cow',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_green-cow.png',
  information: 'Does not give you wings.',
};

itemList['slushy'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Slushy',
  price: 0,
  weight: 15,
  nonStack: false,
  model: '',
  image: 'np_slushy.png',
  information: 'The only thing on jail that tastes good.',
};

itemList['coffee'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Coffe',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coffee.png',
  information: 'Careful, its hot.',
};

itemList['frappuccino'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Frappuccino',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_frappuccino.png',
  information: 'Hmm',
};

itemList['latte'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Latte',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_latte.png',
  information: 'Rich thing',
};

itemList['softdrink'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Soft Drink',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'softdrink2.png',
  information: 'Kills the thirst and the wish for a candy.',
};

itemList['mshake'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Milkshake',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_milkshake.png',
  information: 'Hmm',
};

itemList['bscoffee'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cheap Coffe',
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_bscoffee.png',
  information: 'It taste like dirt, but it has some caffeine.',
};

itemList['jaildrink'] = {
  fullyDegrades: true,
  decayrate: 0.001,
  displayname: 'Jail Drink',
  price: 0,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_jaildrink.png',
  information: "It looks as bad as the sheriff's aim.",
};

itemList['sprunk'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Sprunk',
  price: 9,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sprunk.png',
  information: 'The essence of life.',
};

itemList['fruitslushy'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Fruit Slushy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fruit_slushy.png',
  information: 'The most fruity of all.',
};

/*

  DRINKS END

*/

/*

  ALCOHOLS START

*/

itemList['vodka'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vodka',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_vodka.png',
  information: 'Replaces any meal',
};

itemList['beer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Beer',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_beer.png',
  information: 'Just another one...',
};

itemList['whiskey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Whiskey',
  price: 5,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_whiskey.png',
  information: 'For some, soft.',
};

itemList['absinthe'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Absinthe',
  craft: [[
    { itemid: 'glass', amount: 1 },
    { itemid: 'moonshine', amount: 1 },
  ]],
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_absinthe.png',
  information: 'The stongest drink, 95%.',
};

itemList['drink1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Citrus vodka',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'lemon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink1.png',
  information: 'The perfect option for happy hour.',
};

itemList['drink2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Strawberry Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink2.png',
  information: 'Liquid Happiness.',
};

itemList['drink3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Banana and Peach Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'banana', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink3.png',
  information: 'It tastes like fruit gum.',
};

itemList['drink4'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Banana and Orange Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'banana', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink4.png',
  information: 'Some sweetness for your day.',
};

itemList['drink5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry and Kiwi Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'kiwi', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink5.png',
  information: 'Fruity and refreshing.',
};

itemList['drink6'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Strawberry and Watermelon Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink6.png',
  information: 'Cool, Sweet and colorful.',
};

itemList['drink7'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lime and Apple Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lime', amount: 1 },
    { itemid: 'apple', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_polarbear.png',
  information: 'Inhibits the desire for sweets.',
};

itemList['drink8'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Peach and Cherry Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_rumcoke.png',
  information: 'Perfect for cooling off on hot days.',
};

itemList['drink9'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Coconut and Lime Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'coconut', amount: 1 },
    { itemid: 'lime', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_straightvodka.png',
  information: 'NGL Good combination.',
};

itemList['drink10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Paw',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'grapes', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_whitepaw.png',
  information: 'Enjoy on your balcony admiring the stars.',
};

itemList['shot1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange and Lemon Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'lemon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot1.png',
  information: 'Acid.',
};

itemList['shot2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry and Strawberry Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot2.png',
  information: 'To sweet.',
};

itemList['shot3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Banana and Peach Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'banana', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot3.png',
  information: 'Kills the thirst.',
};

itemList['shot4'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange and Banana Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'banana', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot4.png',
  information: 'Sweet and acid.',
};

itemList['shot5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry and Kiwi Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'kiwi', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot5.png',
  information: 'Good thing.',
};

itemList['shot6'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Watermelon and Strawberry Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot6.png',
  information: 'Sweet redness.',
};

itemList['shot7'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Apple and Lime Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lime', amount: 1 },
    { itemid: 'apple', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot7.png',
  information: 'Kills the thirst.',
};

itemList['shot8'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry and Peach Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot8.png',
  information: 'Kill the will of a sweet drink.',
};

itemList['shot9'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Coconut and Lime Mixture',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'coconut', amount: 1 },
    { itemid: 'lime', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot9.png',
  information: 'Almost perfect mixing.',
};

itemList['shot10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Grapes and Watermelon Drink',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'grapes', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot10.png',
  information: 'My favourite one!',
};

itemList['wineglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glass of Wine',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glass-wine.png',
  information: 'Best wine from Portugal',
};

/*

  ALCOHOLS END

*/

/*

  FRUITS START

*/

itemList['apple'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Apple',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_apple.png',
  information: '',
};

itemList['banana'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Banana',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_banana.png',
  information: '',
};

itemList['cherry'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Cherry',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cherry.png',
  information: '',
};

itemList['coconut'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Coconut',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coconut.png',
  information: '',
};

itemList['grapes'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Grapes',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_grapes.png',
  information: '',
};

itemList['kiwi'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Kiwi',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_kiwi.png',
  information: '',
};

itemList['lemon'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Lemon',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lemon.png',
  information: '',
};

itemList['lime'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Lime',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lime.png',
  information: '',
};

itemList['orange'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Orange',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_orange.png',
  information: '',
};

itemList['peach'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Peach',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_peach.png',
  information: '',
};

itemList['potato'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Potato',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_potato.png',
  information: '',
};

itemList['strawberry'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Strawberry',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_strawberry.png',
  information: '',
};

itemList['watermelon'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Watermelon',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_watermelon.png',
  information: '',
};

/*

  FRUITS END

*/

/*

  InGREDIENTS START

*/

itemList['foodingredient'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Ingredients',
  price: 10,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_ingredients.png',
  information: 'Used in various recipes - Beware of validity!',
};

itemList['cheese'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Cheese',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_cheese.png',
  information: 'Used in various recipes - Beware of validity!',
};

itemList['lettuce'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Lettuce',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_lettuce.png',
  information: 'Used in various recipes - Beware of validity!',
};

itemList['freshmeat'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Fresh Meat',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rawmeat.png',
  information: 'Direct from the butcher shop.',
};

itemList['hfcs'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Fructose charope',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_hfcs.png',
  information: 'Used in various recipes - Beware of validity!',
};

itemList['milk'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Milk',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_milk.png',
  information: 'Used in various recipes - Beware of validity!',
};

itemList['icecreamingred'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Icecream Ingredients',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_icecream.png',
  information: 'Used in various recipes - Careful because it melts!',
};

itemList['tomato'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Tomato',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_tomato.png',
  information: 'Used in various recipes - Beware of validity!',
};

/*

  InGREDIENTS END

*/

/*

  DRUGS START

*/

itemList['weedq'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Weed Q',
  craft: [[{ itemid: 'weedoz', amount: 0.25 }]],
  price: 65,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_weed-oz.png',
  information: 'Relaxing...',
  contraband: true,
};

itemList['rollingpaper'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rolling Paper',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rolling-paper.png',
  information: 'For rolling that thing.',
};

itemList['joint'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.2,
  displayname: 'Joint',
  craft: [[
    { itemid: 'weedq', amount: 0.5 },
    { itemid: 'rollingpaper', amount: 1 },
  ]],
  price: 25,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_joint.png',
  information: 'Try to get high with this. ',
  contraband: true,
};

itemList['codein'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'codein',
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_codein.png',
  information: 'Be careful not to exaggerate.',
  contraband: true,
};

itemList['anfetamina'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Anfetamina',
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'ogs-anfetamina.png',
  information: 'This seems toxic.',
  contraband: true,
};

itemList['lean'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Lean',
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lean.png',
  information: 'It is not addictive, is it?',
  contraband: true,
  craft: [[
    { itemid: 'codein', amount: 1 },
    { itemid: 'sprunk', amount: 1 },
  ]],
};

itemList['1gcocaine'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Cocaine 1g',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cocaine-baggy.png',
  information: 'Looks good. ',
  contraband: true,
};

itemList['1gmeta'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Crack 1g',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_crack.png',
  information: 'Its bad to try?',
  contraband: true,
  craft: [[
    { itemid: 'anfetamina', amount: 1 },
    { itemid: 'coffee', amount: 1 },
  ]],
};

itemList['maleseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Male Weed Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weed-seed.png',
  information: 'Whats the difference between this seed and another?',
  contraband: true,
};

itemList['femaleseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Female Weed Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weed-seed.png',
  information: 'Whats the difference between this seed and another?',
  contraband: true,
};

/*

  DRUGS END

*/

/*

  POLICE START

*/

itemList['spikes'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'PD Spike Kit',
  price: 69,
  weight: 40,
  nonStack: false,
  model: '',
  image: 'np_spikes.png',
  information: 'Police equipment (lasts a short time).',
};

itemList['pdarmor'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Politie Vest',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 50,
  weight: 37,
  nonStack: false,
  model: '',
  image: 'np_chest-armor.png',
  information: 'Equipment issued by the government (PD / EMS / DOC).',
};

itemList['IFAK'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  displayname: 'IFAK',
  price: 8,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'ifak.png',
  information: 'Equipment issued by the government (PD / EMS / DOC).',
};

itemList['pdbadge'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'PD Badge',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pd_badge.png',
};

itemList['gatheringkit'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Gathering Kit',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_cleaning-goods.png',
  information: 'Used to collect Evidences.',
};

itemList['np_evidence_marker_yellow'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yellow Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_yellow.png',
};

itemList['np_evidence_marker_red'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_red.png',
};

itemList['np_evidence_marker_white'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_white.png',
};

itemList['np_evidence_marker_orange'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_orange.png',
};

itemList['np_evidence_marker_light_blue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_light_blue.png',
};

itemList['np_evidence_marker_purple'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Purple Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_purple.png',
};

itemList['pdevidencebag'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Evidence Bag',
  price: 10,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_evidence_bag.png',
};

itemList['dnaswab'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'DNA Swab',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_cotonete.png',
};

/*

  POLICE END

*/

/*

  PAWNSHOP END

*/

itemList['stolenrolexwatch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  isStolen: true,
  displayname: 'Rolex Watch',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rolex-watch.png',
};

itemList['stolen10ctchain'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Gold Chain',
  price: 2230,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_10ct-gold-chain.png',
};

itemList['stolenring'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Wedding Ring',
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_wedding-ring.png',
};

itemList['stolenlaptop'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Notebook',
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_pixellaptop.png',
};

/*

  PAWNSHOP END

*/

/*

  MISC START

*/

itemList['ciggy'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Cigarette',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cigarette.png',
};

itemList['cigar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cigar',
  price: 30,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cigar.png',
};

itemList['summonablepet'] = {
  _name: 'summonablepet',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Animal Pet',
  price: 100,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_p_rott.png',
  information: "Call your Pet.",
};

itemList['repairkit'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Basic Repair Kit',
  craft: [[{ itemid: 'electronics', amount: 25 }]],
  price: 100,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_basic_repair-kit.png',
};

itemList['repairkitbennys'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Basic Repair Kit (Bennys)',
  craft: [[{ itemid: 'electronics', amount: 25 }]],
  price: 150,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_basic_repair-kit-bennys.png',
};

itemList['wheelchair'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Wheel Chair',
  price: 250,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_wheelchair.png',
  information: 'Careful driving it.',
};

itemList['armor'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Vest',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 5 },
    { itemid: 'rubber', amount: 5 },
  ]],
  price: 1,
  weight: 37,
  nonStack: false,
  model: '',
  image: 'np_chest-armor.png',
  information: 'Protects you from bullet injuries.',
};

itemList['cashroll'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cash Roll',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-roll.png',
  information: 'How much does this have..',
};

itemList['cashstack'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cash Stack',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-stack.png',
  information: 'Brand new bills.',
};



itemList['markedbills'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Marked Bills',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_inked-money-bag.png',
  information: 'Brand new marked bills.',
};

itemList['band'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Band',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-stack.png',
  information: 'Just some band, who walks around with this?',
};

itemList['rollcash'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Samll Cash Roll',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-roll.png',
  information: 'Just some band, who walks around with this?',
};

itemList['binoculars'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Binoculars',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 1,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_binoculars.png',
};

itemList['blindfold'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blindfold',
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_blindfold.png',
};

itemList['camera'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Camera NP1000',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_camera.png',
  information: 'Looks like it has good quality.',
};

itemList['hairtie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hair Tie',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hairtie.png',
  information: 'Útil.',
};

itemList['idcard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'ID Card',
  price: 500,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_citizen-card.png',
};

itemList['phonebox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Phone Box',
  price: 200,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'phone_box.png',
  information: 'Open it to grab your phone',
};

itemList['phoneboxempty'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Empty Phone Box',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'phone_box_empty.png',
  information: 'This isnt worth anything',
};

itemList['lighter'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lighter',
  price: 5,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lighter.png',
  information: 'Careful using It. ',
};

itemList['mobilephone'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mobile Phone',
  price: 200,
  craft: [
    [
      { itemid: 'electronics', amount: 10 },
    ]
  ],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_mobile-phone.png',
};

itemList['lockpick'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Lockpick',
  craft: [
    [
      { itemid: 'aluminium', amount: 5 },
      { itemid: 'plastic', amount: 3 },
      { itemid: 'rubber', amount: 3 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 2 },
    ]
  ],
  price: 80,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'LockPicks things.',
  image: 'np_lockpick-set.png',
};

itemList['okaylockpick'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shit Lockpick',
  price: 0,
  craft: [[{ itemid: 'shitlockpick', amount: 100 }]],
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shitlockpick.png',
  information: 'It sucks, maybe is best to trow it away.',
};

itemList['shitlockpick'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Heavy Lockpick',
  price: 0,
  craft: [[{ itemid: 'jailfood', amount: 1 }]],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_shitlockpick.png',
  information:
    'Almost doesnt fit on the pocket.',
};

itemList['radio'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'PD Radio',
  craft: [[
    { itemid: 'electronics', amount: 30 },
    { itemid: 'plastic', amount: 5 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 1,
  weight: 5,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_radio.png',
  information: 'Used for comunication betwen members of the PD.',
};

itemList['delivery_taco'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Food Delivery',
  price: 10,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_food_bag.png',
};

itemList['delivery_supply'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Supply Delivery',
  price: 20,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_box.png',
};

itemList['megaphone'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Megaphone',
  price: 25,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_megaphone.png',
  information: '',
  deg: true
}

itemList['fertilizer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fertilizer',
  price: 20,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_fertilizer.png',
  information: 'It does not come with instructions.',
};

itemList['spray'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Spray',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'ogs_spray.png',
};

itemList['sprayremover'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Spray Remover',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'ogs_sprayremover.png',
};

itemList['custommiscitem'] = {
  _name: 'custommiscitem',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Item',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_placeholder.png',
  information: '',
  deg: false,
};

itemList['musicwalkman'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Walkman',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_walkman.png',
  information: '',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 1 },
  ]],
}

itemList['musictape'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cassette',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cassette.png',
};

/*

  MISC END

*/

/*

  CLOTHES START

*/

itemList['mask'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Masker',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_mask.png',
  information: '',
};

itemList['googles'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glasses',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_oakley-sunglasses.png',
  information: '',
};

itemList['hat'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hat',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_hat.png',
  information: '',
};

itemList['chain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ketting',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_5ct-gold-chain.png',
  information: '',
};

itemList['vest'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vest',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_vest.png',
  information: '',
};

itemList['jacket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Jas',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_jacket.png',
  information: '',
};

itemList['shirt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shirt',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_shirt.png',
  information: '',
};

itemList['backpack'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'BackPack',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_backpack.png',
  information: '',
};

itemList['pants'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Broek',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_pants.png',
  information: '',
};

itemList['shoes'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Schoenen',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_stolenshoes.png',
  information: '',
};

itemList['watch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Watch',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_casio-watch.png',
  information: '',
};

itemList['braclets'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Braclets',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_braclets.png',
  information: '',
};

itemList['earrings'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Earrings',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'ogs_earrings.png',
  information: '',
};

/*

  CLOTHES END

*/

/*

  TCG START

*/

itemList['tcgcard'] = {
  _name: 'tcgcard',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'TCG Card',
  price: 1,
  weight: 0.0,
  nonStack: true,
  model: '',
  image: 'np_tcgcard.png',
  information: 'A collectible card.',
  deg: false,
};

itemList['tcgpack_ogs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'TCG Cards Pack',
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_tcgpromobooster.png',
  information: 'Pack containing 5 collectible cards.',
  deg: false,
};

itemList['tcgbinder'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Binder',
  price: 1,
  weight: 10.0,
  nonStack: true,
  model: '',
  image: 'np_tcgbinder.png',
  information: 'A Binder to store all of your collectible cards.',
  deg: false,
};

/*

  TCG END

*/

/*

  VEHICLES START

*/

//X CLASS REPAIR PARTS
itemList['xfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_x.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['xfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_x.png',
  information: 'New shaft components.',
};

itemList['xfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_x.png',
  information: 'New radiator and cooling parts.',
};

itemList['xfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_x.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['xfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_x.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['xfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_x.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['xfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_x.png',
  information: 'New fuel injectors.',
};

itemList['xfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_x.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['xfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_x.png',
  information: 'New body panels',
};

itemList['xfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_x.png',
  information: 'New engine parts.',
};

//S CLASS REPAIR PARTS
itemList['sfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (S)',
  craft: [
    [
      { itemid: 'sgenericmechanicpart', amount: 3 },
    ]
  ],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_s.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['sfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (S)',
  craft: [
    [
      { itemid: 'sgenericmechanicpart', amount: 3 },
    ]
  ],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_s.png',
  information: 'New shaft components.',
};

itemList['sfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_s.png',
  information: 'New radiator and cooling parts.',
};

itemList['sfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_s.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['sfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_s.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['sfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_s.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['sfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_s.png',
  information: 'New fuel injectors.',
};

itemList['sfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_s.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['sfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_s.png',
  information: 'New body panels.',
};

itemList['sfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_s.png',
  information: 'New engine parts.',
};

//A CLASS REPAIR PARTS
itemList['afixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_a.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['afixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_a.png',
  information: 'New shaft components.',
};

itemList['afixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_a.png',
  information: 'New radiator and cooling parts.',
};

itemList['afixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_a.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['afixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_a.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['afixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_a.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['afixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_a.png',
  information: 'New fuel injectors.',
};

itemList['afixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_a.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['afixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_a.png',
  information: 'New body panels.',
};

itemList['afixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_a.png',
  information: 'New engine parts.',
};

//B CLASS REPAIR PARTS
itemList['bfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_b.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['bfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_b.png',
  information: 'New shaft components.',
};

itemList['bfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_b.png',
  information: 'New radiator and cooling parts.',
};

itemList['bfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_b.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['bfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_b.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['bfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_b.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['bfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_b.png',
  information: 'New fuel injectors.',
};

itemList['bfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_b.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['bfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_b.png',
  information: 'New body panels.',
};

itemList['bfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_b.png',
  information: 'New engine parts.',
};

//C CLASS REPAIR PARTS
itemList['cfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_c.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['cfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_c.png',
  information: 'New shaft components.',
};

itemList['cfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_c.png',
  information: 'New radiator and cooling parts.',
};

itemList['cfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_c.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['cfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_c.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['cfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_c.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['cfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_c.png',
  information: 'New fuel injectors.',
};

itemList['cfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_c.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['cfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_c.png',
  information: 'New body panels.',
};

itemList['cfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_c.png',
  information: 'New engine parts.',
};

//D CLASS REPAIR PARTS
itemList['dfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_d.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['dfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_d.png',
  information: 'New shaft components.',
};

itemList['dfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_d.png',
  information: 'New radiator and cooling parts.',
};

itemList['dfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_d.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['dfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_d.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['dfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_d.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['dfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_d.png',
  information: 'New fuel injectors.',
};

itemList['dfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_d.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['dfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_d.png',
  information: 'New body panels.',
};

itemList['dfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_d.png',
  information: 'New engine parts.',
};

//M CLASS REPAIR PARTS
itemList['mfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_m.png',
  information: 'New brake discs, pads, tweezers, hubs and accessories.',
};

itemList['mfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Shaft Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_m.png',
  information: 'New shaft components.',
};

itemList['mfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_m.png',
  information: 'New radiator and cooling parts.',
};

itemList['mfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_m.png',
  information: 'New clutch disc and pressure plate.',
};

itemList['mfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_m.png',
  information: 'New gear sets, shafts, converters and clutch assemblies.',
};

itemList['mfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Electronics Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_m.png',
  information: 'Various electrical components of the vehicle.',
};

itemList['mfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel injectors (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_m.png',
  information: 'New fuel injectors.',
};

itemList['mfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire repair kit (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_m.png',
  information: 'To change and repair worn or damaged tires.',
};

itemList['mfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body panels (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_body_panels_m.png',
  information: 'New body panels.',
};

itemList['mfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_m.png',
  information: 'New engine parts.',
};


// HEISTS
// practice
itemList['heistlaptopprac'] = {
  fullyDegrades: true,
  decayrate: 0.107,
  displayname: 'Laptop',
  price: 200,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop_prac.png',
  information: 'Practice makes perfect. Marked for police seizure.',
};

// fleeca
itemList['heistlaptop3'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  craft: [[{ itemid: 'electronics', amount: 1500 }]],
  image: 'np_laptop03.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// paleto
itemList['heistlaptop2'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop02.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// vault upper
itemList['heistlaptop4'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop04.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// vault lower
itemList['heistlaptop1'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop01.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// fleeca
itemList['heistusb4'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_green.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusb5'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Laptop Dongle',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_green.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusb6'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Laptop Dongle',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusbsr'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Master Key (25%)',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Combine multiple USBs to create a master encryption key.',
};

itemList['heistusbsrmk'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Master Key (100%)',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Master Key to access encrypted data.',
};

itemList['powercodes'] = {
  fullyDegrades: true,
  decayrate: 0.000124,
  displayname: 'Authorization Codes',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_receipt.png',
  information: 'Temporary access to city systems',
};

itemList['relayprobe'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Relay Reader',
  price: 500,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_electronic-kit.png',
  information: 'Reads relay power state',
};

// paleto
itemList['heistusb1'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_blue.png',
  information: 'Marked for Police Seizure',
};

// vault upper
itemList['heistusb2'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_red.png',
  information: 'Marked for Police Seizure',
};

// vault lower
itemList['heistusb3'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_gold.png',
  information: 'Marked for Police Seizure',
};

// lower vault keyboard
itemList['vcomputerusb'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Lower Vault Computer USB',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_black.png',
  information: 'Marked for Police Seizure',
};

itemList['thermitecharge'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Thermite Charge',
  price: 250,
  weight: 6,
  nonStack: false,
  model: '',
  image: 'np_thermite_charge.png',
  information: 'This thing burns!',
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'copper', amount: 75 },
      { itemid: 'rubber', amount: 50 },
      { itemid: 'plastic', amount: 75 },
      { itemid: 'electronics', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 18 },
      { itemid: 'refinedcopper', amount: 18 },
      { itemid: 'refinedrubber', amount: 12 },
      { itemid: 'refinedplastic', amount: 18 },
      { itemid: 'electronics', amount: 100 },
    ]
  ]
}

itemList['bobcatsecuritycard'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [],
  decayrate: 0.0,
  displayname: 'Bobcat Security Keycard',
  price: 3500,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'gruppe62.png',
  information: 'For Gruppe6 contractors.',
};

itemList['casinoblueprintscase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Secure Case',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_securitycase.png',
  information: 'Etched on the side it reads "Blueprints to the Casino"',
};

itemList['casinoblueprints'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diamond Casino & Resort',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
  information: 'Blueprints and information for Mr Dean Watson, or future owners.',
};

// YACHT
itemList['heistmicroenvelope'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.005,
  displayname: 'Microchipped Envelope',
  price: 350,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_microchipped_envelope.png',
  information: 'Wirelessly connected to the Yacht Security System',
};

// yacht ipad
itemList['heistpadyacht'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.075,
  displayname: 'PixelPad',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_pad_blue.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};
// HEISTS END

// METH
// lab key optimus prime
itemList['methlabkey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key to a Door',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_key.png',
  information: '',
  contraband: true,
};

itemList['methlabbatch'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Batch of Raw Meth',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_meth_batch.png',
  information: 'Crystal-like. Needs to be stored somewhere cool and dry to cure.',
  contraband: true,
};

itemList['methlabcured'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Batch of Cured Meth',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_cured.png',
  information: 'Ready for bagging!',
  contraband: true,
};

itemList['methlabbaggy'] = {
  fullyDegrades: false,
  decayrate: 0.02,
  displayname: 'Small Packaging Bag',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_empty_baggy.png',
  information: '',
};

itemList['methlabproduct'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Meth (1g)',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_meth-baggy.png',
  information: '',
  contraband: true,
  insertTo: ['methpipe']
};

//Vehicle Boosting Items
itemList['trackerdisabler'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Tracker Disabling Tool',
  craft: [[
    { itemid: 'copper', amount: 150 },
    { itemid: 'glass', amount: 150 },
    { itemid: 'electronics', amount: 150 },
    { itemid: 'aluminium', amount: 150 },
  ]],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_disabler.png',
  information: 'Plug this in and keep moving.',
};

itemList['pixellaptop'] = {
  fullyDegrades: true,
  decayrate: 0.46,
  displayname: 'Pixel Laptop',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 92 },
  ]],
  price: 7000,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_pixellaptop.png',
  information: 'Pixel 3 (os) 3.0.69',
};

itemList['advlockpick'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Adv Lock Pick',
  price: 2500,
  craft: [
    [
      { itemid: 'aluminium', amount: 50 },
      { itemid: 'plastic', amount: 50 },
      { itemid: 'rubber', amount: 50 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 15 },
      { itemid: 'refinedplastic', amount: 12 },
      { itemid: 'refinedrubber', amount: 15 },
    ]
  ],
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_advanced-lockpick.png',
};
/*

  VEHICLES END

*/