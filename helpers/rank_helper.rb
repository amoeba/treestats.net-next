# frozen_string_literal: true

module Sinatra
  module RankHelper
    RANK = [
      [ # Aluvian
        [
          "",
          "Yeoman",
          "Baronet",
          "Baron",
          "Reeve",
          "Thane",
          "Ealdor",
          "Duke",
          "Aethling",
          "King",
          "High King"
        ],
        [
          "",
          "Yeoman",
          "Baronet",
          "Baroness",
          "Reeve",
          "Thane",
          "Ealdor",
          "Duchess",
          "Aethling",
          "Queen",
          "High Queen"
        ]
      ],
      [ # Gharu'ndim
        [
          "",
          "Sayyid",
          "Shayk",
          "Maulan",
          "Mu'allim",
          "Naqib",
          "Qadi",
          "Mushir",
          "Amir",
          "Malik",
          "Sultan"
        ],
        [
          "",
          "Sayyida",
          "Shayka",
          "Mualana",
          "Mu'allima",
          "Naqiba",
          "Qadiya",
          "Mushira",
          "Amira",
          "Malika",
          "Sultana"
        ]
      ],
      [ # Sho
        [
          "",
          "Jinin",
          "Jo-Chueh",
          "Nan-Chueh",
          "Shi-Chueh",
          "Ta-Chueh",
          "Kun-Chueh",
          "Kou",
          "Taikou",
          "Ou",
          "Koutei"
        ],
        [
          "",
          "Jinin",
          "Jo-Chueh",
          "Nan-Chueh",
          "Shi-Chueh",
          "Ta-Chueh",
          "Kun-Chueh",
          "Kou",
          "Taikou",
          "Jo-Ou",
          "Koutei"
        ]
      ],
      [ # Viamontian
        [
          "",
          "Squire",
          "Banner",
          "Baron",
          "Viscount",
          "Count",
          "Marquis",
          "Duke",
          "Grand Duke",
          "King",
          "High King"
        ],
        [
          "",
          "Dame",
          "Banner",
          "Baroness",
          "Vicountess",
          "Countess",
          "Marquise",
          "Duchess",
          "Grand Duchess",
          "Queen",
          "High Queen"
        ]
      ],
      [ # Shadowbound
        [
          "",
          "Tenebrous",
          "Shade",
          "Squire",
          "Knight",
          "Void Knight",
          "Void Lord",
          "Duke",
          "Archduke",
          "Highborn",
          "King"
        ],
        [
          "",
          "Tenebrous",
          "Shade",
          "Squire",
          "Knight",
          "Void Knight",
          "Void Lady",
          "Duchess",
          "Archduchess",
          "Highborn",
          "Queen"
        ]
      ],
      [ # Gearknight
        [
          "",
          "Tribunus",
          "Praefectus",
          "Optio",
          "Centurion",
          "Principes",
          "Legatus",
          "Consul",
          "Dux",
          "Secondus",
          "Primus"
        ],
        [
          "",
          "Tribunus",
          "Praefectus",
          "Optio",
          "Centurion",
          "Principes",
          "Legatus",
          "Consul",
          "Dux",
          "Secondus",
          "Primus"
        ]
      ],
      [ # Tumerok
        [
          "",
          "Xutua",
          "Tuona",
          "Ona",
          "Nuona",
          "Turea",
          "Rea",
          "Nurea",
          "Kauh",
          "Sutah",
          "Tah"
        ],
        [
          "",
          "Xutua",
          "Tuona",
          "Ona",
          "Nuona",
          "Turea",
          "Rea",
          "Nurea",
          "Kauh",
          "Sutah",
          "Tah"
        ]
      ],
      [ # Lugian
        [
          "",
          "Laigus",
          "Raigus",
          "Amploth",
          "Arintoth",
          "Obeloth",
          "Lithos",
          "Kantos",
          "Gigas",
          "Extas",
          "Tiatus"
        ],
        [
          "",
          "Laigus",
          "Raigus",
          "Amploth",
          "Arintoth",
          "Obeloth",
          "Lithos",
          "Kantos",
          "Gigas",
          "Extas",
          "Tiatus"
        ]
      ],
      [ # Empyrean
        [
          "",
          "Ensign",
          "Corporal",
          "Lieutenant",
          "Commander",
          "Commodore",
          "Admiral",
          "Commodore",
          "Warlord",
          "Ipharsin",
          "Aulin"
        ],
        [
          "",
          "Ensign",
          "Corporal",
          "Lieutenant",
          "Commander",
          "Captain",
          "Commodore",
          "Admiral",
          "Warlord",
          "Ipharsia",
          "Aulia"
        ]
      ],
      [ # Penumbrean
        [
          "",
          "Tenebrous",
          "Shade",
          "Squire",
          "Knight",
          "Void Knight",
          "Void Lord",
          "Duke",
          "Archduke",
          "Highborn",
          "King"
        ],
        [
          "",
          "Tenebrous",
          "Shade",
          "Squire",
          "Knight",
          "Void Knight",
          "Void Lady",
          "Duchess",
          "Archduchess",
          "Highborn",
          "Queen"
        ]
      ],
      [ # Undead
        [
          "",
          "Neophyte",
          "Acolyte",
          "Adept",
          "Esquire",
          "Squire",
          "Knight",
          "Count",
          "Viscount",
          "Highness",
          "Annointed"
        ],
        [
          "",
          "Neophyte",
          "Acolyte",
          "Adept",
          "Esquire",
          "Squire",
          "Knight",
          "Countess",
          "Viscountess",
          "Highness",
          "Annointed"
        ]
      ]
    ]
    def rank(heritage_id, gender_id, rank)
      RANK[heritage_id][gender_id][rank]
    end
  end

  helpers RankHelper
end
