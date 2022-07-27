--[[

    Variables

]]

local cids = {
    [1001] = true, -- Soze
    [1004] = true, -- Dw
    [1005] = true, -- Derby
    [1242] = true, -- Ripley
    [3503] = true, -- Dean
}

local petInfo = {
    ["coyote"] = {
      key = "coyote",
      type = "coyote",
      image = "https://i.imgur.com/DSLIlIW.png",
    },
    ["panther"] = {
      key = "panther",
      type = "panther",
      image = "https://i.imgur.com/XyEEplC.png",
    },
    ["pit"] = {
      key = "pit",
      type = "pit",
      image = "https://i.imgur.com/ID7Q0rC.png",
    },
    ["cat"] = {
      key = "cat",
      type = "cat",
      image = "https://i.imgur.com/pOrdQNC.png",
    },
    ["pug"] = {
      key = "pug",
      type = "pug",
      image = "https://i.imgur.com/POlVhoO.png",
    },
    ["poodle"] = {
      key = "poodle",
      type = "poodle",
      image = "https://i.imgur.com/fTgoZFW.png",
    },
    ["westy"] = {
      key = "westy",
      type = "westy",
      image = "https://i.imgur.com/IeClsnO.png",
    },
    ["cow"] = {
      key = "cow",
      type = "cow",
      image = "https://i.imgur.com/TdSko7H.png",
    },
    ["hen"] = {
      key = "hen",
      type = "hen",
      image = "https://i.imgur.com/igYm4Mi.png",
    },
    ["rabbit"] = {
      key = "rabbit",
      type = "rabbit",
      image = "https://i.imgur.com/PRt9vi4.png",
    },
    ["pig"] = {
      key = "pig",
      type = "pig",
      image = "https://i.imgur.com/Wf5jpe0.png",
    },
}

local smallDogSkillList = {
    ["sit"] = true,
    ["bark"] = true,
    ["playdead"] = true,
}

local dogSkillList = {
    ["sit"] = true,
    ["laydown"] = true,
    ["bark"] = true,
    ["beg"] = true,
    ["attack"] = true,
    ["taunt"] = true,
    ["paw"] = true,
    ["playdead"] = true,
}

local bigCatSkillList = {
    ["laydown"] = true,
    ["attack"] = true,
    ["taunt"] = true
}

local bigCatSkillListNoAttack = {
    ["laydown"] = true,
    ["taunt"] = true
}

local catSkillList = {
    ["stretch"] = true,
    ["laydown"] = true,
}

local animalSkillList = {
    ["a_c_chop"] = dogSkillList,
    ["a_c_husky"] = dogSkillList,
    ["a_c_husky_np"] = dogSkillList,
    ["a_c_retriever"] = dogSkillList,
    ["a_c_retriever_np"] = dogSkillList,
    ["a_c_shepherd"] = dogSkillList,
    ["a_c_shepherd_np"] = dogSkillList,
    ["a_c_pit_np"] = dogSkillList,
    ["a_c_panther"] = bigCatSkillList,
    ["a_c_coyote"] = {
        ["laydown"] = true,
        ["howl"] = true
    },
    ["a_c_cat_01"] = catSkillList,
    ["a_c_westy"] = smallDogSkillList,
    ["a_c_pug"] = smallDogSkillList,
    ["a_c_poodle"] = smallDogSkillList,
    ["a_c_cow"] = {
        ["graze"] = true,
    },
    ["a_c_hen"] = {
        ["peck"] = true,
    },
    ["a_c_rabbit_01"] = {},
    ["a_c_pig"] = {
        ["graze"] = true,
    },
}

local lastCompanionId = nil
local lastCompanionAction = nil
local attackNextTarget = false
local spawnedAnimals = {}
local spawnedAnimalsCount = 0
local spawnedK9Units = {}
local ignoreServerIds = {}
local lastActionPressTime = 0
local spawnedAnimalModels = {}

local k9types = {
    [1] = {
      key = "chop",
      type = "rott",
      image = "https://i.imgur.com/rwKGt2b.png",
    },
    [2] = {
      key = "husky",
      type = "shep",
      image = "https://i.imgur.com/Kc51atn.png",
    },
    [3] = {
      key = "retriever",
      type = "retriever",
      image = "https://i.imgur.com/U2EjWoU.png",
    },
    [4] = {
      key = "shepherd",
      type = "shepherd",
      image = "https://i.imgur.com/ZK58r7W.png",
    },
    [5] = {
      key = "pit",
      type = "pit",
      image = "https://i.imgur.com/ID7Q0rC.png",
    },
}

local k9Depts = {
    [1] = {
      key = "lspd",
    },
    [2] = {
      key = "bcso",
    },
    [3] = {
      key = "troopers",
    },
    [4] = {
      key = "rangers",
    },
    [5] = {
      key = "doc",
    },
    [6] = {
      key = "therapy",
    },
}

--[[

    Functions

]]

local function supportedAnimals()
    return {
        ["chop_lspd"] = {
            id = "chop_lspd",
            name = "lspd Chop",
            appearance = {
                model = "a_c_chop",
                components = {
                    {
                        componentId = 3,
                        drawableId = 1,
                        textureId = 0,
                        paletteId = 0,
                    },
                },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
        ["chop_bcso"] = {
            id = "chop_bcso",
            name = "BCSO Chop",
            appearance = {
            model = "a_c_chop",
            components = {
                {
                    componentId = 3,
                    drawableId = 1,
                    textureId = 2,
                    paletteId = 0,
                },
            },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
      ["chop_troopers"] = {
        id = "chop_troopers",
        name = "Troopers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_doc"] = {
        id = "chop_doc",
        name = "DOC Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_rangers"] = {
        id = "chop_rangers",
        name = "Rangers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_therapy"] = {
        id = "chop_therapy",
        name = "Therapy Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_lspd"] = {
        id = "husky_lspd",
        name = "lspd Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_bcso"] = {
        id = "husky_bcso",
        name = "BCSO Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_troopers"] = {
        id = "husky_troopers",
        name = "Troopers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_doc"] = {
        id = "husky_doc",
        name = "DOC Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_rangers"] = {
        id = "husky_rangers",
        name = "Rangers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_therapy"] = {
        id = "husky_therapy",
        name = "Therapy Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_lspd"] = {
        id = "retriever_lspd",
        name = "lspd Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_bcso"] = {
        id = "retriever_bcso",
        name = "BCSO Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_troopers"] = {
        id = "retriever_troopers",
        name = "Troopers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_doc"] = {
        id = "retriever_doc",
        name = "DOC Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_rangers"] = {
        id = "retriever_rangers",
        name = "Rangers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_therapy"] = {
        id = "retriever_therapy",
        name = "Therapy Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_lspd"] = {
        id = "shepherd_lspd",
        name = "lspd Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_bcso"] = {
        id = "shepherd_bcso",
        name = "BCSO Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_troopers"] = {
        id = "shepherd_troopers",
        name = "Troopers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_doc"] = {
        id = "shepherd_doc",
        name = "DOC Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_rangers"] = {
        id = "shepherd_rangers",
        name = "Rangers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_therapy"] = {
        id = "shepherd_therapy",
        name = "Therapy Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_lspd"] = {
        id = "pit_lspd",
        name = "lspd Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_bcso"] = {
        id = "pit_bcso",
        name = "BCSO Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_troopers"] = {
        id = "pit_troopers",
        name = "Troopers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_doc"] = {
        id = "pit_doc",
        name = "DOC Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_rangers"] = {
        id = "pit_rangers",
        name = "Rangers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_therapy"] = {
        id = "pit_therapy",
        name = "Therapy Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["panther"] = {
        id = "panther",
        name = "Panther",
        appearance = {
          model = "a_c_panther",
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["coyote"] = {
        id = "coyote",
        name = "Coyote",
        appearance = {
          model = "a_c_coyote",
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["pit"] = {
        id = "pit",
        name = "pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["cat"] = {
        id = "cat",
        name = "cat",
        appearance = {
          model = "a_c_cat_01"
        },
        speedModifier = 2,
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pug"] = {
        id = "pug",
        name = "pug",
        appearance = {
          model = "a_c_pug"
        },
        maxHealth = 1000,
      },
      ["poodle"] = {
        id = "poodle",
        name = "poodle",
        appearance = {
          model = "a_c_poodle"
        },
        maxHealth = 1000,
      },
      ["westy"] = {
        id = "westy",
        name = "westy",
        appearance = {
          model = "a_c_westy"
        },
        maxHealth = 1000,
      },
      ["cow"] = {
        id = "cow",
        name = "cow",
        appearance = {
          model = "a_c_cow"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["hen"] = {
        id = "hen",
        name = "hen",
        appearance = {
          model = "a_c_hen"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["rabbit"] = {
        id = "rabbit",
        name = "rabbit",
        appearance = {
          model = "a_c_rabbit_01"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pig"] = {
        id = "pig",
        name = "pig",
        appearance = {
          model = "a_c_pig"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
    }
end

local function hasSpawnedK9Unit()
    local k9UnitSpawned = false
    for k, v in pairs(spawnedK9Units) do
        k9UnitSpawned = k9UnitSpawned or spawnedK9Units[k]
    end
    return k9UnitSpawned
end

local function modelHasSkill(id, skill)
    return animalSkillList[spawnedAnimalModels[id]][skill]
end

local function showCompanionOptions(companionId)
    local items = {}

    items[#items + 1] = {
        title = "Move",
        description = "Move To Next Target.",
        action = "np-pets:companionAction",
        params = { companionId = companionId, action = "move" },
    }

    items[#items + 1] = {
        title = "Follow",
        description = "Make Pet Follow You.",
        action = "np-pets:companionAction",
        params = { companionId = companionId, action = "follow" },
    }

    if modelHasSkill(companionId, "sit") then
        items[#items + 1] = {
            title = "Sit",
            description = "Make Pet Sit.",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "sit" },
        }
    end

    if modelHasSkill(companionId, "laydown") then
        items[#items + 1] = {
            title = "Lay",
            description = "Make Pet Lay Down.",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "laydown" },
        }
    end

    if modelHasSkill(companionId, "bark") then
        items[#items + 1] = {
            title = "Bark",
            description = "Woof Woof",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "bark" },
        }
    end

    items[#items + 1] = {
        title = "Wander Around",
        description = "Keep Your Pet Busy",
        action = "np-pets:companionAction",
        params = { companionId = companionId, action = "wander" },
    }

    if spawnedK9Units[companionId] then
        items[#items + 1] = {
            title = "Track",
            description = "Start Tracking Someone",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "track" },
        }
    end

    if modelHasSkill(companionId, "taunt") then
        items[#items + 1] = {
            title = "Taunt",
            description = "Make Pet Taunt",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "taunt" },
        }
    end

    if modelHasSkill(companionId, "stretch") then
        items[#items + 1] = {
            title = "Stretch",
            description = "Make Pet Stretch",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "stretch" },
        }
    end

    if modelHasSkill(companionId, "beg") then
        items[#items + 1] = {
            title = "Beg",
            description = "Make Pet Beg",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "beg" },
        }
    end

    if modelHasSkill(companionId, "paw") then
        items[#items + 1] = {
            title = "Paw",
            description = "Make Pet give Paw",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "paw" },
        }
    end

    if modelHasSkill(companionId, "peck") then
        items[#items + 1] = {
            title = "Chew",
            description = "Look for things to Chew",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "peck" },
        }
    end

    if modelHasSkill(companionId, "graze") then
        items[#items + 1] = {
            title = "Graze",
            description = "Dinner Time",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "graze" },
        }
    end

    if modelHasSkill(companionId, "howl") then
        items[#items + 1] = {
            title = "Howl",
            description = "Make Pet Howl",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "howl" },
        }
    end

    if modelHasSkill(companionId, "playdead") then
        items[#items + 1] = {
            title = "Play Dead",
            description = "Make Pet Play Dead",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "playdead" },
        }
    end

    if modelHasSkill(companionId, "attack") then
        items[#items + 1] = {
            title = "Attack",
            description = "Have Pet Attack",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "attack" },
        }
    end

    exports["np-context"]:showContext(items)
end

local function hasAnimalWithSkill(skill)
    for k, v in pairs(spawnedAnimals) do
        if v and modelHasSkill(k, skill) then
            return true
        end
    end
    return false
end

local function showPlayerOptions(companionId, pedId)
    local items = {
        {
            title = "Move",
            description = "move to that person",
            action = "np-pets:companionPlayerAction",
            params = { companionId = companionId, action = "move", pedId = pedId },
        },
        {
            title = "Watch",
            description = "keep your eyes open'",
            action = "np-pets:companionAction",
            params = { companionId = companionId, action = "watch", pedId = pedId },
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Sniff",
            description = "Any Contraband?",
            action = "np-pets:companionPlayerAction",
            params = { companionId = companionId, action = "sniff", pedId = pedId },
        }
    end

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Ignore",
            description = "Ignore This Person",
            action = "np-pets:companionPlayerAction",
            params = { companionId = companionId, action = "untrack", pedId = pedId },
        }
    end

    if hasAnimalWithSkill("attack") then
        items[#items + 1] = {
            title = "Attack",
            description = "Attack!",
            action = "np-pets:companionPlayerAction",
            params = { companionId = companionId, action = "attack", pedId = pedId },
        }
    end

    exports["np-context"]:showContext(items)
end

local function showVehicleOptions(vehicleId)
    local items = {
        {
            title = "Move",
            description = "Move To Vehicle",
            action = "np-pets:companionVehicleAction",
            params = { vehicleId = vehicleId, action = "move" },
        },
        {
            title = "Enter",
            description = "Get In Vehicle",
            action = "np-pets:companionVehicleAction",
            params = { vehicleId = vehicleId, action = "vehicle" },
        },
        {
            title = "Watch",
            description = "Keep Your Eyes Open",
            action = "np-pets:companionVehicleAction",
            params = { vehicleId = vehicleId, action = "watch" },
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Sniff",
            description = "Look For Contraband",
            action = "np-pets:companionVehicleAction",
            params = { vehicleId = vehicleId, action = "sniff" },
        }
    end

    exports["np-context"]:showContext(items)
end

function trackPlayers(companionId)
    ignoreServerIds[GetPlayerServerId(PlayerId())] = true

    local closestCoords = RPC.execute("np-pets:getClosestPlayer", GetEntityCoords(PlayerPedId()), ignoreServerIds)
    if not closestCoords then
        exports["np-companions"]:perform("sit", companionId or "")
        TriggerEvent("DoLongHudText", "He doesn't seem interested")
        exports["np-companions"]:deselect()
        return
    end

    local coords = { x = closestCoords.coords.x, y = closestCoords.coords.y, z = closestCoords.coords.z, speed = 0.8 }
    exports["np-companions"]:perform("move", companionId or "", coords)
    exports["np-companions"]:deselect()
end

local function doSniffAction(pType, pCompanionId)
    exports["np-companions"]:perform("move", pCompanionId)

    Wait(1000)

    local target = exports["np-companions"]:getSelection()
    local hasContraband = false

    if pType == "ped" then
        hasContraband = RPC.execute("np-pets:sniffTarget", pType, GetPlayerServerId(NetworkGetPlayerIndexFromPed(target.entityId)))
    elseif pType == "vehicle" then
        local vid = exports["np-vehicles"]:GetVehicleIdentifier(target.entityId)
        local plate = exports["np-vehicles"]:GetVehiclePlate(target.entityId)

        hasContraband = RPC.execute("np-pets:sniffTarget", pType, (true and vid or plate))
    end

    exports["np-companions"]:deselect()

    if hasContraband then
        TriggerEvent("DoLongHudText", "Did your pet find something?!")
        exports["np-companions"]:perform("bark", pCompanionId)
        Wait(1000)
        exports["np-companions"]:perform("sit", pCompanionId)
    else
        TriggerEvent("DoLongHudText", "Your pet didn't find anything.")
    end
end

--[[

    Events

]]

RegisterNetEvent("np-pets:k9create")
AddEventHandler("np-pets:k9create", function(pCid, pType, pDept, pName, pVariation)
    -- local characterId = exports["np-base"]:getChar("id")
    -- if not cids[characterId] then return end

    local typeConfig = k9types[tonumber(pType)] or k9types[1]
    local deptConfig = k9Depts[tonumber(pDept)] or k9Depts[1]

    TriggerEvent("player:receiveItem", "summonablepet", 1, false, {
        Owner = pCid,
        Name = pName or "No Name",
        type = typeConfig.type,
        key = typeConfig.key .. "_" .. deptConfig.key,
        k9 = true,
        id = tostring(math.random(1000000, 9999999)),
        cVariation = pVariation and tonumber(pVariation) or -1,
        _image_url = typeConfig.image,
        _hideKeys = { "_image_url", "type", "key", "id", "k9", "cVariation" },
    })
end)

RegisterNetEvent("np-pets:petCreate")
AddEventHandler("np-pets:petCreate", function(pCid, pType, pName, pVariation)
    -- local characterId = exports["np-base"]:getChar("id")
    -- if not cids[characterId] then return end

    local info = petInfo[pType]
    if not info then return end

    TriggerEvent("player:receiveItem", "summonablepet", 1, false, {
        Owner = pCid,
        Name = pName or "No Name",
        type = info.type,
        key = info.key,
        k9 = false,
        id = tostring(math.random(1000000, 9999999)),
        cVariation = pVariation and tonumber(pVariation) or -1,
        _image_url = info.image,
        _hideKeys = { "_image_url", "type", "key", "id", "k9", "cVariation" },
    })
end)

AddEventHandler("np-inventory:itemUsed", function(item, info)
    if item ~= "summonablepet" then return end

    local info = json.decode(info)
    local characterId = exports["np-base"]:getChar("id")

    if tonumber(info.Owner) ~= tonumber(characterId) then
        TriggerEvent("DoLongHudText", "they don't recognize you.", 2)
        return
    end

    local id = info.id

    if spawnedAnimals[id] then
        spawnedAnimals[id] = false
        spawnedK9Units[id] = false
        spawnedAnimalsCount = spawnedAnimalsCount - 1
        exports["np-companions"]:dismiss(id)
        exports["np-companions"]:deselect()
        return
    end

    spawnedAnimals[id] = true
    spawnedAnimalsCount = spawnedAnimalsCount + 1
    spawnedK9Units[id] = info.k9

    local animal = supportedAnimals()[info.key]

    if  info.cVariation ~= -1 and animal.appearance and animal.appearance.components and animal.appearance.components[2] then
        animal.appearance.components[2].textureId = info.cVariation
    end

    animal.id = id
    spawnedAnimalModels[id] = animal.appearance.model

    exports["np-companions"]:summon({ animal }, function()
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if not veh or veh == 0 then
            exports["np-companions"]:perform("follow", animal.id)
        end
    end)
end)

AddEventHandler("np-pets:companionAction", function(params)
    if params.action == "move" or params.action == "attack" then
        lastCompanionId = params.companionId
        lastCompanionAction = params.action
        return
    end

    if params.action == "track" then
        trackPlayers(params.companionId)
        return
    end

    exports["np-companions"]:perform(params.action, params.companionId)
    exports["np-companions"]:deselect()
end)

AddEventHandler("np-pets:companionPlayerAction", function(params)
    if params.action == "sniff" then
        doSniffAction("ped", params.companionId)
        return
    end

    if params.action == "untrack" then
        local sid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(params.pedId))
        ignoreServerIds[sid] = not ignoreServerIds[sid]
        exports["np-companions"]:deselect()
        return
    end

    if params.companionId == nil or params.companionId == "" then
        for k, v in pairs(spawnedAnimals) do
            if spawnedAnimals[k] and modelHasSkill(k, params.action) then
                exports["np-companions"]:perform(params.action, k)
            end
        end
    else
        exports["np-companions"]:perform(params.action, params.companionId)
    end

    exports["np-companions"]:deselect()
end)

AddEventHandler("np-pets:companionVehicleAction", function(params)
    if params.action == "sniff" then
        doSniffAction("vehicle", params.companionId)
        return
    end

    exports["np-companions"]:perform(params.action)
    exports["np-companions"]:deselect()
end)

AddEventHandler("np-companions:pedSelected", function(pedId, companionId)
    if lastActionPressTime + 250 > GetGameTimer() then
        exports["np-companions"]:deselect()
        return
    end

    if companionId then
        showCompanionOptions(companionId)
        return
    end

    if lastCompanionId then
        exports["np-companions"]:perform(lastCompanionAction, lastCompanionId)
        exports["np-companions"]:deselect()
        lastCompanionId = nil
        return
    end

    if attackNextTarget then
        exports["np-companions"]:perform("attack")
        exports["np-companions"]:deselect()
        attackNextTarget = false
        return
    end

    if IsPedAPlayer(pedId) then
        showPlayerOptions(companionId, pedId)
    end
end)

AddEventHandler("np-companions:vehicleSelected", function(vehicleId)
    if lastActionPressTime + 400 > GetGameTimer() then
        exports["np-companions"]:deselect()
        return
    end

    showVehicleOptions(vehicleId)
end)

AddEventHandler("np-companions:groundSelected", function()
    if lastActionPressTime + 400 > GetGameTimer() then
      exports["np-companions"]:deselect()
      return
    end
    exports["np-companions"]:perform("move", lastCompanionId)
    lastCompanionId = nil
end)

AddEventHandler("np-companions:tooBigForVehicle", function()
    TriggerEvent("DoLongHudText", "Too big for this vehicle!")
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local pointActionEnabled = true

    RegisterCommand("+petAction", function()
        if not pointActionEnabled then return end
        if spawnedAnimalsCount <= 0 then return end
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if not veh or veh == 0 then
            lastActionPressTime = GetGameTimer()
            exports["np-companions"]:startSelecting()
        end
    end, false)

    RegisterCommand("-petAction", function()
        exports["np-companions"]:stopSelecting()
        if lastActionPressTime + 400 > GetGameTimer() then
            exports["np-companions"]:deselect()
            return
        end
    end, false)

    RegisterCommand("+petActionToggle", function()
        pointActionEnabled = not pointActionEnabled
    end, false)
    RegisterCommand("-petActionToggle", function() end, false)

    RegisterCommand("+petActionFollow", function()
        exports["np-companions"]:perform("follow")
    end, false)
    RegisterCommand("-petActionFollow", function() end, false)

    RegisterCommand("+petActionVehicle", function()
        exports["np-companions"]:perform("vehicle")
    end, false)
    RegisterCommand("-petActionVehicle", function() end, false)

    RegisterCommand("+petActionAttack", function()
        attackNextTarget = true
        lastCompanionId = nil
    end, false)
    RegisterCommand("-petActionAttack", function() end, false)

    RegisterCommand("+petActionTrack", function()
        trackPlayers()
    end, false)
    RegisterCommand("-petActionTrack", function() end, false)

    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Action Pet", "+petAction", "-petAction", "")
    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Action Enable / Disable", "+petActionToggle", "-petActionToggle", "")
    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Follow Self", "+petActionFollow", "-petActionFollow", "")
    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Get in Vehicle", "+petActionVehicle", "-petActionVehicle", "")
    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Attack Next Target", "+petActionAttack", "-petActionAttack", "")
    exports["np-keybinds"]:registerKeyMapping("", "Pets", "Track Target", "+petActionTrack", "-petActionTrack", "")
end)