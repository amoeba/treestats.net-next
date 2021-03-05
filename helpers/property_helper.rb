# frozen_string_literal: true

module Sinatra
  module PropertyHelper
    PROPERTY = {
      199 => {type: :general, key: :housing_purchase_date, name: "Housing Purchase Date"},
      192 => {type: :general, key: :fishing_skill, name: "Fishing Skill"},
      181 => {type: :general, key: :chess_rank, name: "Chess Rank"},
      322 => {type: :general, key: :aetheria_slots, name: "Aetheria Slots"},
      390 => {type: :general, key: :times_enlightened, name: "Times Enlightened"},

      218 => {type: :aug, key: :reinforcement_of_the_lugian, name: "Reinforcement of the Lugians"},
      219 => {type: :aug, key: :bleearghs_fortitude, name: "Bleeargh's Fortitude"},
      220 => {type: :aug, key: :oswalds_enhancement, name: "Oswald's Enhancement"},
      221 => {type: :aug, key: :siraluuns_blessing, name: "Siraluun's Blessing"},
      222 => {type: :aug, key: :enduring_calm, name: "Enduring Calm"},
      223 => {type: :aug, key: :steadfast_will, name: "Steadfast Will"},
      224 => {type: :aug, key: :ciandras_essence, name: "Ciandra's Essence"},
      225 => {type: :aug, key: :yoshis_essence, name: "Yoshi's Essence"},
      226 => {type: :aug, key: :jibrils_essence, name: "Jibril's Essence"},
      227 => {type: :aug, key: :celdiseths_essence, name: "Celdiseth's Essence"},
      228 => {type: :aug, key: :kogas_essence, name: "Koga's Essence"},
      229 => {type: :aug, key: :shadow_of_the_seventh_mule, name: "Shadow of the Seventh Mule"},
      230 => {type: :aug, key: :might_of_the_seventh_mule, name: "Might of the Seventh Mule"},
      231 => {type: :aug, key: :clutch_of_the_miser, name: "Clutch of the Miser"},
      232 => {type: :aug, key: :enduring_enchantment, name: "Enduring Enchantment"},
      233 => {type: :aug, key: :critical_protection, name: "Critical Protection"},
      234 => {type: :aug, key: :quick_learner, name: "Quick Learner"},
      235 => {type: :aug, key: :ciandras_fortune, name: "Ciandra's Fortune"},
      236 => {type: :aug, key: :charmed_smith, name: "Charmed Smith"},
      237 => {type: :aug, key: :innate_renewal, name: "Innate Renewal"},
      238 => {type: :aug, key: :archmages_endurance, name: "Archmage's Endurance"},
      240 => {type: :aug, key: :enhancement_of_the_blade_turner, name: "Enhancement of the Blade Turner"},
      241 => {type: :aug, key: :enhancement_of_the_arrow_turner, name: "Enhancement of the Arrow Turner"},
      242 => {type: :aug, key: :enhancement_of_the_mace_turner, name: "Enhancement of the Mace Turner"},
      243 => {type: :aug, key: :caustic_enhancement, name: "Caustic Enhancement"},
      244 => {type: :aug, key: :fiery_enhancement, name: "Fiery Enhancement"},
      245 => {type: :aug, key: :icy_enhancement, name: "Icy Enhancement"},
      246 => {type: :aug, key: :storms_enhancement, name: "Storm's Enhancement"},
      298 => {type: :aug, key: :eye_of_the_remorseless, name: "Eye of the Remorseless"},
      299 => {type: :aug, key: :hand_of_the_remorseless, name: "Hand of the Remorseless"},
      300 => {type: :aug, key: :master_of_the_steel_circle, name: "Master of the Steel Circle"},
      301 => {type: :aug, key: :master_of_the_focused_eye, name: "Master of the Focused Eye"},
      302 => {type: :aug, key: :master_of_the_five_fold_path, name: "Master of the Five Fold Path"},
      309 => {type: :aug, key: :frenzy_of_the_slayer, name: "Frenzy of the Slayer"},
      310 => {type: :aug, key: :iron_skin_of_the_invincible, name: "Iron Skin of the Invincible"},
      326 => {type: :aug, key: :jack_of_all_trades, name: "Jack of All Trades"},
      328 => {type: :aug, key: :infused_void_magic, name: "Infused Void Magic"},
      294 => {type: :aug, key: :infused_creature_magic, name: "Infused Creature Magic"},
      295 => {type: :aug, key: :infused_item_magic, name: "Infused Item Magic"},
      296 => {type: :aug, key: :infused_life_magic, name: "Infused Life Magic"},
      297 => {type: :aug, key: :infused_war_magic, name: "Infused War Magic"},

      333 => {type: :aura, key: :valor, name: "Valor"},
      334 => {type: :aura, key: :protection, name: "Protection"},
      335 => {type: :aura, key: :glory, name: "Glory"},
      336 => {type: :aura, key: :temperance, name: "Temperance"},
      338 => {type: :aura, key: :aetheric_vision, name: "Aetheric Vision"},
      339 => {type: :aura, key: :mana_flow, name: "Mana Flow"},
      340 => {type: :aura, key: :mana_infusion, name: "Mana Infusion"},
      342 => {type: :aura, key: :purity, name: "Purity"},
      343 => {type: :aura, key: :craftsman, name: "Craftsman"},
      344 => {type: :aura, key: :specialization, name: "Specialization"},
      365 => {type: :aura, key: :world, name: "World"},

      370 => {type: :rating, key: :damage, name: "Damage"},
      371 => {type: :rating, key: :damage_resistance, name: "Damage Resistance"},
      372 => {type: :rating, key: :critical, name: "Critical"},
      373 => {type: :rating, key: :critical_resistance, name: "Critical Resistance"},
      374 => {type: :rating, key: :critical_damage, name: "Critical Damage"},
      375 => {type: :rating, key: :critical_damage_resistance, name: "Critical Damage Resistance"},
      376 => {type: :rating, key: :healing_boost, name: "Healing Boost"},
      379 => {type: :rating, key: :vitality, name: "Vitality"},

      287 => {type: :society, key: :celestial_hand, name: "Celestial Hand"},
      288 => {type: :society, key: :eldrytch_web, name: "Eldrytch Web"},
      289 => {type: :society, key: :radiant_blood, name: "Radiant Blood"},

      354 => {type: :mastery, key: :melee, name: "Melee"},
      355 => {type: :mastery, key: :ranged, name: "Ranged"},
      362 => {type: :mastery, key: :summoning, name: "Summoning"}
    }

    def property(id)
      return {type: :unknown, name: "UNK"} unless PROPERTY.key?(id)

      PROPERTY[id]
    end

    module_function :property

    def property_id(key)
      PROPERTY.select { |key, value| value[:key] == key }.keys.first
    end

    def get_properties(props)
      # Add in values
      properties = props.to_h { |p|
        prop = property(p[:property_id])

        [
          prop[:key],
          prop.merge({
            id: p[:property_id],
            value: p[:value]
          })
        ]
      }

      {
        augmentations: properties.filter { |k, p| p[:type] == :aug }.sort_by { |k, p| p[:name] }.to_h,
        auras: properties.filter { |k, p| p[:type] == :aura }.sort_by { |k, p| p[:name] }.to_h,
        ratings: properties.filter { |k, p| p[:type] == :rating }.sort_by { |k, p| p[:name] }.to_h,

        masteries: {
          melee: get_mastery(properties, :melee),
          ranged: get_mastery(properties, :ranged),
          summoning: get_mastery(properties, :summoning)
        },

        housing_purchase_date: get_property(properties, :housing_purchase_date),
        fishing_skill: get_property(properties, :fishing_skill),
        chess_rank: get_property(properties, :chess_rank),
        aetheria_slots: get_property(properties, :aetheria_slots),
        times_enlightened: get_property(properties, :times_enlightened),

        society: get_society(properties)
      }
    end

    # nil-safe property getter
    def get_property(properties, key)
      return nil unless properties.key?(key)

      properties[key][:value]
    end

    def get_property_value(properties, id)
      properties = properties.filter { |p| p[:property_id] == id }

      if properties.length != 1
        puts "#{id} is length #{properties.length}, returning nil"
        return nil
      end

      puts "id => #{properties.first}"
      properties.first[:value]
    end
  end

  helpers PropertyHelper
end
