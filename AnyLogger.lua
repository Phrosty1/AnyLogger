---@diagnostic disable: undefined-global
AnyLogger = {}
local ADDON_NAME = "AnyLogger"
AnyLoggerSavedVariablesV2 = AnyLoggerSavedVariablesV2 or {}
local select, type, tostring, pairs = select, type, tostring, pairs
local GetGameTimeMilliseconds = GetGameTimeMilliseconds
local StrLen = string.len
local TblIns = table.insert
local msBaseTime = (1000*GetTimeStamp())-GetGameTimeMilliseconds()
local playerName = ZO_CachedStrFormat("<<C:1>>",GetRawUnitName("player"))
local sep = "`"
local txtSepNameSep = sep .. playerName .. sep
local function Dump(o)
   local typ_obj = type(o)
   if typ_obj == "string" then return o
   elseif typ_obj == "number" then return tostring(o)
   elseif typ_obj == "table" then
      local s = "{"
      for k,v in pairs(o) do
         if type(k) ~= "number" then k = "'"..tostring(k).."'" end
         s = s .. "["..k.."]=" .. Dump(v) .. ","
      end
      return s .. "}"
   elseif typ_obj == 'userdata' then
      local s = "{"
      for k,v in pairs(getmetatable(o).__index) do
         if type(k) ~= "number" then k = "'"..tostring(k).."'" end
         s = s .. "["..k.."]=" .. Dump(v) .. ","
      end
      return s .. "}"
   else return tostring(o) end
end AnyLogger.Dump = Dump
local function Ternary(cond, ifTrue, ifFalse) if cond==true then return ifTrue elseif cond==false then return ifFalse else return cond end end
AnyLogger.Ternary = Ternary
local function LogBase(title, ...)
   local strArgs = (msBaseTime+GetGameTimeMilliseconds()) .. txtSepNameSep .. title
   for i = 1,select("#", ...) do strArgs = strArgs..sep..Dump(select(i, ...)) end
   if StrLen(strArgs) >= 2000 then
      for i=1, StrLen(strArgs), 1999 do
         TblIns(AnyLoggerSavedVariablesV2, string.sub(strArgs, i, i-1+1999))
      end
   else TblIns(AnyLoggerSavedVariablesV2, strArgs) end
end AnyLogger.LogBase = LogBase
local function LogAnyTxt(title, ...) LogBase(title, ...)end
function AnyLogger:LogAnyTxt(title, ...) LogBase(title, ...) end
function AnyLogger:Log(title, ...) LogBase(title, ...) end
local function GetGlobalNamesByID(...)
   local lstNamesByID, lstBadNames = {}, {}
   for i = 1, select("#", ...) do
      local txtName = select(i, ...)
      if txtName and _G[txtName]~=nil then lstNamesByID[_G[txtName]] = txtName else table.insert(lstBadNames, txtName) end
   end
   return lstNamesByID, lstBadNames
end AnyLogger.GetGlobalNamesByID = GetGlobalNamesByID
local lstEventNamesByID = GetGlobalNamesByID("EVENT_ABILITY_LIST_CHANGED","EVENT_ABILITY_PROGRESSION_RANK_UPDATE","EVENT_ABILITY_PROGRESSION_RESULT","EVENT_ABILITY_PROGRESSION_XP_UPDATE","EVENT_ABILITY_REQUIREMENTS_FAIL","EVENT_ACCEPT_SHARED_QUEST_RESPONSE","EVENT_ACHIEVEMENT_AWARDED","EVENT_ACHIEVEMENT_UPDATED","EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY","EVENT_ACHIEVEMENTS_UPDATED","EVENT_ACTION_BAR_IS_RESPECCABLE_BAR_STATE_CHANGED","EVENT_ACTION_BAR_LOCKED_REASON_CHANGED","EVENT_ACTION_LAYER_POPPED","EVENT_ACTION_LAYER_PUSHED","EVENT_ACTION_SLOT_ABILITY_USED_WRONG_WEAPON","EVENT_ACTION_SLOT_ABILITY_USED","EVENT_ACTION_SLOT_EFFECT_UPDATE","EVENT_ACTION_SLOT_EFFECTS_CLEARED","EVENT_ACTION_SLOT_STATE_UPDATED","EVENT_ACTION_SLOT_UPDATED","EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED","EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED","EVENT_ACTION_UPDATE_COOLDOWNS","EVENT_ACTIVE_COMPANION_STATE_CHANGED","EVENT_ACTIVE_DAEDRIC_ARTIFACT_CHANGED","EVENT_ACTIVE_MOUNT_CHANGED","EVENT_ACTIVE_QUEST_TOOL_CHANGED","EVENT_ACTIVE_QUEST_TOOL_CLEARED","EVENT_ACTIVE_QUICKSLOT_CHANGED","EVENT_ACTIVE_WEAPON_PAIR_CHANGED","EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE","EVENT_ACTIVITY_FINDER_COOLDOWNS_UPDATE","EVENT_ACTIVITY_FINDER_STATUS_UPDATE","EVENT_ACTIVITY_QUEUE_RESULT","EVENT_ADD_ON_LOADED","EVENT_AGENT_CHAT_ACCEPTED","EVENT_AGENT_CHAT_DECLINED","EVENT_AGENT_CHAT_FORCED","EVENT_AGENT_CHAT_REQUESTED","EVENT_AGENT_CHAT_TERMINATED","EVENT_ALL_GUI_SCREENS_RESIZE_STARTED","EVENT_ALL_GUI_SCREENS_RESIZED","EVENT_ALLIANCE_POINT_UPDATE","EVENT_ANIMATION_NOTE","EVENT_ANTIQUITIES_UPDATED","EVENT_ANTIQUITY_DIG_SITES_UPDATED","EVENT_ANTIQUITY_DIG_SPOT_DIG_POWER_CHANGED","EVENT_ANTIQUITY_DIG_SPOT_DURABILITY_CHANGED","EVENT_ANTIQUITY_DIG_SPOT_STABILITY_CHANGED","EVENT_ANTIQUITY_DIGGING_ACTIVE_SKILL_USE_RESULT","EVENT_ANTIQUITY_DIGGING_ANTIQUITY_UNEARTHED","EVENT_ANTIQUITY_DIGGING_BONUS_LOOT_UNEARTHED","EVENT_ANTIQUITY_DIGGING_DIG_POWER_REFUND","EVENT_ANTIQUITY_DIGGING_EXIT_RESPONSE","EVENT_ANTIQUITY_DIGGING_GAME_OVER","EVENT_ANTIQUITY_DIGGING_MOUSE_OVER_ACTIVE_SKILL_CHANGED","EVENT_ANTIQUITY_DIGGING_NUM_RADARS_REMAINING_CHANGED","EVENT_ANTIQUITY_DIGGING_READY_TO_PLAY","EVENT_ANTIQUITY_JOURNAL_SHOW_SCRYABLE","EVENT_ANTIQUITY_LEAD_ACQUIRED","EVENT_ANTIQUITY_SCRYING_RESULT","EVENT_ANTIQUITY_SEARCH_RESULTS_READY","EVENT_ANTIQUITY_SHOW_CODEX_ENTRY","EVENT_ANTIQUITY_TRACKING_INITIALIZED","EVENT_ANTIQUITY_TRACKING_UPDATE","EVENT_ANTIQUITY_UPDATED","EVENT_ARTIFACT_CONTROL_STATE","EVENT_ARTIFACT_SCROLL_STATE_CHANGED","EVENT_ARTIFICIAL_EFFECT_ADDED","EVENT_ARTIFICIAL_EFFECT_REMOVED","EVENT_ASSIGNED_CAMPAIGN_CHANGED","EVENT_ATTRIBUTE_UPGRADE_UPDATED","EVENT_AUTO_MAP_NAVIGATION_TARGET_SET","EVENT_AVAILABLE_DISPLAY_DEVICES_CHANGED","EVENT_AVENGE_KILL","EVENT_BACKGROUND_LIST_FILTER_COMPLETE","EVENT_BANK_DEPOSIT_NOT_ALLOWED","EVENT_BANK_IS_FULL","EVENT_BANKED_CURRENCY_UPDATE","EVENT_BANKED_MONEY_UPDATE","EVENT_BATTLE_STANDARDS_UPDATED","EVENT_BATTLEGROUND_INACTIVITY_WARNING","EVENT_BATTLEGROUND_KILL","EVENT_BATTLEGROUND_LEADERBOARD_DATA_CHANGED","EVENT_BATTLEGROUND_RULESET_CHANGED","EVENT_BATTLEGROUND_SCOREBOARD_UPDATED","EVENT_BATTLEGROUND_SHUTDOWN_TIMER","EVENT_BATTLEGROUND_STATE_CHANGED","EVENT_BEGIN_CUTSCENE","EVENT_BEGIN_LOCKPICK","EVENT_BEGIN_SIEGE_CONTROL","EVENT_BEGIN_SIEGE_UPGRADE","EVENT_BOSSES_CHANGED","EVENT_BROADCAST","EVENT_BUY_RECEIPT","EVENT_BUYBACK_RECEIPT","EVENT_CADWELL_PROGRESSION_LEVEL_CHANGED","EVENT_CAMPAIGN_ALLIANCE_LOCK_ACTIVATED","EVENT_CAMPAIGN_ALLIANCE_LOCK_PENDING","EVENT_CAMPAIGN_ASSIGNMENT_RESULT","EVENT_CAMPAIGN_EMPEROR_CHANGED","EVENT_CAMPAIGN_HISTORY_WINDOW_CHANGED","EVENT_CAMPAIGN_LEADERBOARD_DATA_CHANGED","EVENT_CAMPAIGN_QUEUE_JOINED","EVENT_CAMPAIGN_QUEUE_LEFT","EVENT_CAMPAIGN_QUEUE_POSITION_CHANGED","EVENT_CAMPAIGN_QUEUE_STATE_CHANGED","EVENT_CAMPAIGN_SCORE_DATA_CHANGED","EVENT_CAMPAIGN_SELECTION_DATA_CHANGED","EVENT_CAMPAIGN_STATE_INITIALIZED","EVENT_CAMPAIGN_UNASSIGNMENT_RESULT","EVENT_CAMPAIGN_UNDERPOP_BONUS_CHANGE_NOTIFICATION","EVENT_CANCEL_GROUND_TARGET_MODE","EVENT_CANCEL_MOUSE_REQUEST_DESTROY_ITEM","EVENT_CANCEL_REQUEST_CONFIRM_USE_ITEM","EVENT_CANNOT_CROUCH_WHILE_CARRYING_ARTIFACT","EVENT_CANNOT_DO_THAT_WHILE_DEAD","EVENT_CANNOT_DO_THAT_WHILE_HIDDEN","EVENT_CAPS_LOCK_STATE_CHANGED","EVENT_CAPTURE_AREA_SPAWNED","EVENT_CAPTURE_AREA_STATE_CHANGED","EVENT_CAPTURE_AREA_STATUS","EVENT_CAPTURE_FLAG_STATE_CHANGED","EVENT_CARRIED_CURRENCY_UPDATE","EVENT_CHAMPION_LEVEL_ACHIEVED","EVENT_CHAMPION_POINT_GAINED","EVENT_CHAMPION_POINT_UPDATE","EVENT_CHAMPION_PURCHASE_RESULT","EVENT_CHAMPION_SYSTEM_UNLOCKED","EVENT_CHAT_CATEGORY_COLOR_CHANGED","EVENT_CHAT_LOG_TOGGLED","EVENT_CHAT_MESSAGE_CHANNEL","EVENT_CHATTER_BEGIN","EVENT_CHATTER_END","EVENT_CLAIM_REWARD_RESULT","EVENT_CLIENT_INTERACT_RESULT","EVENT_CLOSE_BANK","EVENT_CLOSE_GUILD_BANK","EVENT_CLOSE_STORE","EVENT_CLOSE_TRADING_HOUSE","EVENT_COLLECTIBLE_BLACKLIST_UPDATED","EVENT_COLLECTIBLE_CATEGORY_NEW_STATUS_CLEARED","EVENT_COLLECTIBLE_DYE_DATA_UPDATED","EVENT_COLLECTIBLE_NEW_STATUS_CLEARED","EVENT_COLLECTIBLE_NOTIFICATION_NEW","EVENT_COLLECTIBLE_NOTIFICATION_REMOVED","EVENT_COLLECTIBLE_RENAME_ERROR","EVENT_COLLECTIBLE_REQUEST_BROWSE_TO","EVENT_COLLECTIBLE_SET_IN_WATER_ALERT","EVENT_COLLECTIBLE_UPDATED","EVENT_COLLECTIBLE_USE_RESULT","EVENT_COLLECTIBLES_SEARCH_RESULTS_READY","EVENT_COLLECTIBLES_UNLOCK_STATE_CHANGED","EVENT_COLLECTION_UPDATED","EVENT_COMBAT_EVENT","EVENT_COMPANION_ACTIVATED","EVENT_COMPANION_DEACTIVATED","EVENT_COMPANION_EXPERIENCE_GAIN","EVENT_COMPANION_RAPPORT_UPDATE","EVENT_COMPANION_SKILL_LINE_ADDED","EVENT_COMPANION_SKILL_RANK_UPDATE","EVENT_COMPANION_SKILL_XP_UPDATE","EVENT_COMPANION_SKILLS_FULL_UPDATE","EVENT_COMPANION_SUMMON_RESULT","EVENT_COMPANION_ULTIMATE_FAILURE","EVENT_CONFIRM_INTERACT","EVENT_CONVERSATION_FAILED_INVENTORY_FULL","EVENT_CONVERSATION_FAILED_UNIQUE_ITEM","EVENT_CONVERSATION_UPDATED","EVENT_CORONATE_EMPEROR_NOTIFICATION","EVENT_CRAFT_BAG_AUTO_TRANSFER_NOTIFICATION_CLEARED","EVENT_CRAFT_COMPLETED","EVENT_CRAFT_FAILED","EVENT_CRAFT_STARTED","EVENT_CRAFTING_STATION_INTERACT","EVENT_CROWN_CRATE_INVENTORY_UPDATED","EVENT_CROWN_CRATE_OPEN_RESPONSE","EVENT_CROWN_CRATE_QUANTITY_UPDATE","EVENT_CROWN_CRATES_SYSTEM_STATE_CHANGED","EVENT_CROWN_GEM_UPDATE","EVENT_CROWN_UPDATE","EVENT_CURRENCY_CAPS_CHANGED","EVENT_CURRENCY_UPDATE","EVENT_CURRENT_CAMPAIGN_CHANGED","EVENT_CURRENT_SUBZONE_LIST_CHANGED","EVENT_CURSOR_DROPPED","EVENT_CURSOR_PICKUP","EVENT_CUSTOMER_SERVICE_FEEDBACK_SUBMITTED","EVENT_CUSTOMER_SERVICE_TICKET_SUBMITTED","EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED","EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED","EVENT_DAILY_LOGIN_MONTH_CHANGED","EVENT_DAILY_LOGIN_REWARDS_CLAIMED","EVENT_DAILY_LOGIN_REWARDS_UPDATED","EVENT_DEFERRED_SETTING_REQUEST_COMPLETED","EVENT_DEPOSE_EMPEROR_NOTIFICATION","EVENT_DISABLE_SIEGE_AIM_ABILITY","EVENT_DISABLE_SIEGE_FIRE_ABILITY","EVENT_DISABLE_SIEGE_PACKUP_ABILITY","EVENT_DISCOVERY_EXPERIENCE","EVENT_DISGUISE_STATE_CHANGED","EVENT_DISPLAY_ACTIVE_COMBAT_TIP","EVENT_DISPLAY_ALERT","EVENT_DISPLAY_ANNOUNCEMENT","EVENT_DISPLAY_TUTORIAL","EVENT_DISPOSITION_UPDATE","EVENT_DUEL_COUNTDOWN","EVENT_DUEL_FINISHED","EVENT_DUEL_INVITE_ACCEPTED","EVENT_DUEL_INVITE_CANCELED","EVENT_DUEL_INVITE_DECLINED","EVENT_DUEL_INVITE_FAILED","EVENT_DUEL_INVITE_RECEIVED","EVENT_DUEL_INVITE_REMOVED","EVENT_DUEL_INVITE_SENT","EVENT_DUEL_NEAR_BOUNDARY","EVENT_DUEL_STARTED","EVENT_DYE_STAMP_USE_FAIL","EVENT_DYEING_STATION_INTERACT_END","EVENT_DYEING_STATION_INTERACT_START","EVENT_DYES_SEARCH_RESULTS_READY","EVENT_EFFECT_CHANGED","EVENT_EFFECTS_FULL_UPDATE","EVENT_ENABLE_SIEGE_AIM_ABILITY","EVENT_ENABLE_SIEGE_FIRE_ABILITY","EVENT_ENABLE_SIEGE_PACKUP_ABILITY","EVENT_END_CRAFTING_STATION_INTERACT","EVENT_END_CUTSCENE","EVENT_END_FAST_TRAVEL_INTERACTION","EVENT_END_FAST_TRAVEL_KEEP_INTERACTION","EVENT_END_KEEP_GUILD_CLAIM_INTERACTION","EVENT_END_KEEP_GUILD_RELEASE_INTERACTION","EVENT_END_SIEGE_CONTROL","EVENT_END_SOUL_GEM_RESURRECTION","EVENT_ENLIGHTENED_STATE_GAINED","EVENT_ENLIGHTENED_STATE_LOST","EVENT_ENTER_GROUND_TARGET_MODE","EVENT_ESO_PLUS_FREE_TRIAL_NOTIFICATION_CLEARED","EVENT_ESO_PLUS_FREE_TRIAL_STATUS_CHANGED","EVENT_EXPERIENCE_GAIN","EVENT_EXPERIENCE_UPDATE","EVENT_FAST_TRAVEL_KEEP_NETWORK_LINK_CHANGED","EVENT_FAST_TRAVEL_KEEP_NETWORK_UPDATED","EVENT_FAST_TRAVEL_NETWORK_UPDATED","EVENT_FEEDBACK_REQUESTED","EVENT_FEEDBACK_TOO_FREQUENT_SCREENSHOT","EVENT_FINESSE_RANK_CHANGED","EVENT_FISHING_LURE_CLEARED","EVENT_FISHING_LURE_SET","EVENT_FOLLOWER_SCENE_FINISHED_FRAGMENT_TRANSITION","EVENT_FORCE_RESPEC","EVENT_FORWARD_CAMP_RESPAWN_TIMER_BEGINS","EVENT_FORWARD_CAMPS_UPDATED","EVENT_FRIEND_ADDED","EVENT_FRIEND_CHARACTER_CHAMPION_POINTS_CHANGED","EVENT_FRIEND_CHARACTER_LEVEL_CHANGED","EVENT_FRIEND_CHARACTER_UPDATED","EVENT_FRIEND_CHARACTER_ZONE_CHANGED","EVENT_FRIEND_DISPLAY_NAME_CHANGED","EVENT_FRIEND_HERON_INFO_BATCH_UPDATED","EVENT_FRIEND_NOTE_UPDATED","EVENT_FRIEND_PLAYER_STATUS_CHANGED","EVENT_FRIEND_REMOVED","EVENT_FULLSCREEN_MODE_CHANGED","EVENT_GAME_CAMERA_ACTIVATED","EVENT_GAME_CAMERA_CHARACTER_FRAMING_STARTED","EVENT_GAME_CAMERA_DEACTIVATED","EVENT_GAME_CAMERA_UI_MODE_CHANGED","EVENT_GAME_CREDITS_READY","EVENT_GAME_FOCUS_CHANGED","EVENT_GAMEPAD_PREFERRED_MODE_CHANGED","EVENT_GAMEPAD_TYPE_CHANGED","EVENT_GIFT_ACTION_RESULT","EVENT_GIFTING_GRACE_PERIOD_STARTED_NOTIFICATION_CLEARED","EVENT_GIFTING_GRACE_PERIOD_STARTED","EVENT_GIFTING_UNLOCKED_NOTIFICATION_CLEARED","EVENT_GIFTING_UNLOCKED_STATUS_CHANGED","EVENT_GIFTS_UPDATED","EVENT_GLOBAL_MOUSE_DOWN","EVENT_GLOBAL_MOUSE_UP","EVENT_GRAVEYARD_USAGE_FAILURE","EVENT_GROUP_CAMPAIGN_ASSIGNMENTS_CHANGED","EVENT_GROUP_ELECTION_FAILED","EVENT_GROUP_ELECTION_NOTIFICATION_ADDED","EVENT_GROUP_ELECTION_NOTIFICATION_REMOVED","EVENT_GROUP_ELECTION_REQUESTED","EVENT_GROUP_ELECTION_RESULT","EVENT_GROUP_INVITE_ACCEPT_RESPONSE_TIMEOUT","EVENT_GROUP_INVITE_RECEIVED","EVENT_GROUP_INVITE_REMOVED","EVENT_GROUP_INVITE_RESPONSE","EVENT_GROUP_MEMBER_CONNECTED_STATUS","EVENT_GROUP_MEMBER_IN_REMOTE_REGION","EVENT_GROUP_MEMBER_JOINED","EVENT_GROUP_MEMBER_LEFT","EVENT_GROUP_MEMBER_ROLE_CHANGED","EVENT_GROUP_MEMBER_SUBZONE_CHANGED","EVENT_GROUP_NOTIFICATION_MESSAGE","EVENT_GROUP_OPERATION_RESULT","EVENT_GROUP_SUPPORT_RANGE_UPDATE","EVENT_GROUP_TYPE_CHANGED","EVENT_GROUP_UPDATE","EVENT_GROUP_VETERAN_DIFFICULTY_CHANGED","EVENT_GROUPING_TOOLS_FIND_REPLACEMENT_NOTIFICATION_NEW","EVENT_GROUPING_TOOLS_FIND_REPLACEMENT_NOTIFICATION_REMOVED","EVENT_GROUPING_TOOLS_LFG_JOINED","EVENT_GROUPING_TOOLS_NO_LONGER_LFG","EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED","EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED","EVENT_GUI_HIDDEN","EVENT_GUI_WORLD_PARTICLE_EFFECT_READY","EVENT_GUILD_BANK_DESELECTED","EVENT_GUILD_BANK_ITEM_ADDED","EVENT_GUILD_BANK_ITEM_REMOVED","EVENT_GUILD_BANK_ITEMS_READY","EVENT_GUILD_BANK_OPEN_ERROR","EVENT_GUILD_BANK_SELECTED","EVENT_GUILD_BANK_TRANSFER_ERROR","EVENT_GUILD_BANK_UPDATED_QUANTITY","EVENT_GUILD_BANKED_MONEY_UPDATE","EVENT_GUILD_CLAIM_KEEP_CAMPAIGN_NOTIFICATION","EVENT_GUILD_CLAIM_KEEP_RESPONSE","EVENT_GUILD_DATA_LOADED","EVENT_GUILD_DESCRIPTION_CHANGED","EVENT_GUILD_FINDER_APPLICATION_RESPONSE","EVENT_GUILD_FINDER_APPLICATION_RESULTS_GUILD","EVENT_GUILD_FINDER_APPLICATION_RESULTS_PLAYER","EVENT_GUILD_FINDER_BLACKLIST_RESPONSE","EVENT_GUILD_FINDER_BLACKLIST_RESULTS","EVENT_GUILD_FINDER_GUILD_APPLICATIONS_VIEWED","EVENT_GUILD_FINDER_GUILD_NEW_APPLICATIONS","EVENT_GUILD_FINDER_LONG_SEARCH_WARNING","EVENT_GUILD_FINDER_PLAYER_APPLICATIONS_CHANGED","EVENT_GUILD_FINDER_PROCESS_APPLICATION_RESPONSE","EVENT_GUILD_FINDER_SEARCH_COMPLETE","EVENT_GUILD_FINDER_SEARCH_COOLDOWN_UPDATE","EVENT_GUILD_HISTORY_CATEGORY_UPDATED","EVENT_GUILD_HISTORY_REFRESHED","EVENT_GUILD_HISTORY_RESPONSE_RECEIVED","EVENT_GUILD_ID_CHANGED","EVENT_GUILD_INFO_REQUEST_COMPLETE","EVENT_GUILD_INVITE_ADDED","EVENT_GUILD_INVITE_PLAYER_SUCCESSFUL","EVENT_GUILD_INVITE_REMOVED","EVENT_GUILD_INVITE_TO_BLACKLISTED_PLAYER","EVENT_GUILD_INVITES_INITIALIZED","EVENT_GUILD_KEEP_CLAIM_UPDATED","EVENT_GUILD_KIOSK_ACTIVE_BIDS_RESPONSE","EVENT_GUILD_KIOSK_CONSIDER_BID_START","EVENT_GUILD_KIOSK_CONSIDER_BID_STOP","EVENT_GUILD_KIOSK_CONSIDER_PURCHASE_START","EVENT_GUILD_KIOSK_CONSIDER_PURCHASE_STOP","EVENT_GUILD_KIOSK_ERROR","EVENT_GUILD_KIOSK_RESULT","EVENT_GUILD_LEVEL_CHANGED","EVENT_GUILD_LOST_KEEP_CAMPAIGN_NOTIFICATION","EVENT_GUILD_MEMBER_ADDED","EVENT_GUILD_MEMBER_CHARACTER_CHAMPION_POINTS_CHANGED","EVENT_GUILD_MEMBER_CHARACTER_LEVEL_CHANGED","EVENT_GUILD_MEMBER_CHARACTER_UPDATED","EVENT_GUILD_MEMBER_CHARACTER_ZONE_CHANGED","EVENT_GUILD_MEMBER_DEMOTE_SUCCESSFUL","EVENT_GUILD_MEMBER_NOTE_CHANGED","EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED","EVENT_GUILD_MEMBER_PROMOTE_SUCCESSFUL","EVENT_GUILD_MEMBER_RANK_CHANGED","EVENT_GUILD_MEMBER_REMOVED","EVENT_GUILD_MOTD_CHANGED","EVENT_GUILD_NAME_AVAILABLE","EVENT_GUILD_PLAYER_RANK_CHANGED","EVENT_GUILD_RANK_CHANGED","EVENT_GUILD_RANKS_CHANGED","EVENT_GUILD_RECRUITMENT_INFO_UPDATED","EVENT_GUILD_RELEASE_KEEP_CAMPAIGN_NOTIFICATION","EVENT_GUILD_RELEASE_KEEP_RESPONSE","EVENT_GUILD_SELF_JOINED_GUILD","EVENT_GUILD_SELF_LEFT_GUILD","EVENT_GUILD_TRADER_HIRED_UPDATED","EVENT_HELP_INITIALIZED","EVENT_HELP_SEARCH_RESULTS_READY","EVENT_HERALDRY_CUSTOMIZATION_END","EVENT_HERALDRY_CUSTOMIZATION_START","EVENT_HERALDRY_FUNDS_UPDATED","EVENT_HERALDRY_SAVED","EVENT_HERON_URL_REQUESTED","EVENT_HIDE_BOOK","EVENT_HIDE_OBJECTIVE_STATUS","EVENT_HIGH_FALL_DAMAGE","EVENT_HOME_SHOW_LEADERBOARD_DATA_CHANGED","EVENT_HOT_BAR_RESULT","EVENT_HOTBAR_SLOT_CHANGE_REQUESTED","EVENT_HOTBAR_SLOT_STATE_UPDATED","EVENT_HOTBAR_SLOT_UPDATED","EVENT_HOUSING_ADD_PERMISSIONS_CANT_ADD_SELF","EVENT_HOUSING_ADD_PERMISSIONS_FAILED","EVENT_HOUSING_EDITOR_COMMAND_RESULT","EVENT_HOUSING_EDITOR_LINK_TARGET_CHANGED","EVENT_HOUSING_EDITOR_MODE_CHANGED","EVENT_HOUSING_EDITOR_REQUEST_RESULT","EVENT_HOUSING_FURNITURE_MOVED","EVENT_HOUSING_FURNITURE_PATH_DATA_CHANGED","EVENT_HOUSING_FURNITURE_PATH_NODE_ADDED","EVENT_HOUSING_FURNITURE_PATH_NODE_MOVED","EVENT_HOUSING_FURNITURE_PATH_NODE_REMOVED","EVENT_HOUSING_FURNITURE_PATH_NODES_RESTORED","EVENT_HOUSING_FURNITURE_PATH_STARTING_NODE_INDEX_CHANGED","EVENT_HOUSING_FURNITURE_PLACED","EVENT_HOUSING_FURNITURE_REMOVED","EVENT_HOUSING_LOAD_PERMISSIONS_RESULT","EVENT_HOUSING_PATH_NODE_SELECTION_CHANGED","EVENT_HOUSING_PERMISSIONS_CHANGED","EVENT_HOUSING_PLAYER_INFO_CHANGED","EVENT_HOUSING_POPULATION_CHANGED","EVENT_HOUSING_PRIMARY_RESIDENCE_SET","EVENT_HOUSING_TARGET_FURNITURE_CHANGED","EVENT_IGNORE_ADDED","EVENT_IGNORE_NOTE_UPDATED","EVENT_IGNORE_ONLINE_CHARACTER_CHANGED","EVENT_IGNORE_REMOVED","EVENT_IMPACTFUL_HIT","EVENT_INCOMING_FRIEND_INVITE_ADDED","EVENT_INCOMING_FRIEND_INVITE_NOTE_UPDATED","EVENT_INCOMING_FRIEND_INVITE_REMOVED","EVENT_INPUT_LANGUAGE_CHANGED","EVENT_INSTANCE_KICK_TIME_UPDATE","EVENT_INTERACT_BUSY","EVENT_INTERACTION_ENDED","EVENT_INTERFACE_SETTING_CHANGED","EVENT_INVENTORY_BAG_CAPACITY_CHANGED","EVENT_INVENTORY_BANK_CAPACITY_CHANGED","EVENT_INVENTORY_BOUGHT_BAG_SPACE","EVENT_INVENTORY_BOUGHT_BANK_SPACE","EVENT_INVENTORY_BUY_BAG_SPACE","EVENT_INVENTORY_BUY_BANK_SPACE","EVENT_INVENTORY_CLOSE_BUY_SPACE","EVENT_INVENTORY_EQUIP_MYTHIC_FAILED","EVENT_INVENTORY_FULL_UPDATE","EVENT_INVENTORY_IS_FULL","EVENT_INVENTORY_ITEM_DESTROYED","EVENT_INVENTORY_ITEM_USED","EVENT_INVENTORY_ITEMS_AUTO_TRANSFERRED_TO_CRAFT_BAG","EVENT_INVENTORY_SINGLE_SLOT_UPDATE","EVENT_INVENTORY_SLOT_LOCKED","EVENT_INVENTORY_SLOT_UNLOCKED","EVENT_ITEM_COMBINATION_RESULT","EVENT_ITEM_LAUNDER_RESULT","EVENT_ITEM_ON_COOLDOWN","EVENT_ITEM_PREVIEW_READY","EVENT_ITEM_REPAIR_FAILURE","EVENT_ITEM_SET_COLLECTION_SLOT_NEW_STATUS_CLEARED","EVENT_ITEM_SET_COLLECTION_UPDATED","EVENT_ITEM_SET_COLLECTIONS_SEARCH_RESULTS_READY","EVENT_ITEM_SET_COLLECTIONS_UPDATED","EVENT_ITEM_SLOT_CHANGED","EVENT_JUMP_FAILED","EVENT_JUSTICE_BEING_ARRESTED","EVENT_JUSTICE_BOUNTY_PAYOFF_AMOUNT_UPDATED","EVENT_JUSTICE_FENCE_UPDATE","EVENT_JUSTICE_GOLD_PICKPOCKETED","EVENT_JUSTICE_GOLD_REMOVED","EVENT_JUSTICE_INFAMY_UPDATED","EVENT_JUSTICE_NO_LONGER_KOS","EVENT_JUSTICE_NOW_KOS","EVENT_JUSTICE_PICKPOCKET_FAILED","EVENT_JUSTICE_STOLEN_ITEMS_REMOVED","EVENT_KEEP_ALLIANCE_OWNER_CHANGED","EVENT_KEEP_END_INTERACTION","EVENT_KEEP_GATE_STATE_CHANGED","EVENT_KEEP_GUILD_CLAIM_UPDATE","EVENT_KEEP_INITIALIZED","EVENT_KEEP_IS_PASSABLE_CHANGED","EVENT_KEEP_PIECE_DIRECTIONAL_ACCESS_CHANGED","EVENT_KEEP_RESOURCE_UPDATE","EVENT_KEEP_START_INTERACTION","EVENT_KEEP_UNDER_ATTACK_CHANGED","EVENT_KEEPS_INITIALIZED","EVENT_KEYBINDING_CLEARED","EVENT_KEYBINDING_SET","EVENT_KEYBINDINGS_LOADED","EVENT_KILL_LOCATIONS_UPDATED","EVENT_LEADER_TO_FOLLOWER_SYNC","EVENT_LEADER_UPDATE","EVENT_LEAVE_CAMPAIGN_QUEUE_RESPONSE","EVENT_LEAVE_RAM_ESCORT","EVENT_LEVEL_UP_REWARD_CHOICE_UPDATED","EVENT_LEVEL_UP_REWARD_UPDATED","EVENT_LEVEL_UPDATE","EVENT_LINKED_WORLD_POSITION_CHANGED","EVENT_LOCAL_PLAYER_MODEL_REBUILT","EVENT_LOCKPICK_BROKE","EVENT_LOCKPICK_FAILED","EVENT_LOCKPICK_SUCCESS","EVENT_LOGOUT_DEFERRED","EVENT_LOGOUT_DISALLOWED","EVENT_LOOT_CLOSED","EVENT_LOOT_ITEM_FAILED","EVENT_LOOT_RECEIVED","EVENT_LOOT_UPDATED","EVENT_LORE_BOOK_ALREADY_KNOWN","EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE","EVENT_LORE_BOOK_LEARNED","EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE","EVENT_LORE_COLLECTION_COMPLETED","EVENT_LORE_LIBRARY_INITIALIZED","EVENT_LOW_FALL_DAMAGE","EVENT_LUA_ERROR","EVENT_MAIL_ATTACHED_MONEY_CHANGED","EVENT_MAIL_ATTACHMENT_ADDED","EVENT_MAIL_ATTACHMENT_REMOVED","EVENT_MAIL_CLOSE_MAILBOX","EVENT_MAIL_COD_CHANGED","EVENT_MAIL_INBOX_UPDATE","EVENT_MAIL_NUM_UNREAD_CHANGED","EVENT_MAIL_OPEN_MAILBOX","EVENT_MAIL_READABLE","EVENT_MAIL_REMOVED","EVENT_MAIL_SEND_FAILED","EVENT_MAIL_SEND_SUCCESS","EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS","EVENT_MAIL_TAKE_ATTACHED_MONEY_SUCCESS","EVENT_MAP_PING","EVENT_MARKET_ANNOUNCEMENT_UPDATED","EVENT_MARKET_PRODUCT_AVAILABILITY_UPDATED","EVENT_MARKET_PRODUCTS_UNLOCKED_NOTIFICATIONS_CLEARED","EVENT_MARKET_PRODUCTS_UNLOCKED","EVENT_MARKET_PURCHASE_RESULT","EVENT_MARKET_STATE_UPDATED","EVENT_MATCH_TRADING_HOUSE_ITEM_NAMES_COMPLETE","EVENT_MEDAL_AWARDED","EVENT_MONEY_UPDATE","EVENT_MOST_RECENT_GAMEPAD_TYPE_CHANGED","EVENT_MOUNT_FAILURE","EVENT_MOUNT_INFO_UPDATED","EVENT_MOUNTED_STATE_CHANGED","EVENT_MOUSE_REQUEST_ABANDON_QUEST","EVENT_MOUSE_REQUEST_DESTROY_ITEM_FAILED","EVENT_MOUSE_REQUEST_DESTROY_ITEM","EVENT_MULTIPLE_RECIPES_LEARNED","EVENT_MURDERBALL_STATE_CHANGED","EVENT_NEW_DAILY_LOGIN_REWARD_AVAILABLE","EVENT_NEW_MOVEMENT_IN_UI_MODE","EVENT_NO_DAEDRIC_PICKUP_AS_EMPEROR","EVENT_NO_DAEDRIC_PICKUP_WHEN_STEALTHED","EVENT_NO_INTERACT_TARGET","EVENT_NON_COMBAT_BONUS_CHANGED","EVENT_NOT_ENOUGH_MONEY","EVENT_OBJECTIVE_COMPLETED","EVENT_OBJECTIVE_CONTROL_STATE","EVENT_OBJECTIVES_UPDATED","EVENT_OPEN_BANK","EVENT_OPEN_COMPANION_MENU","EVENT_OPEN_FENCE","EVENT_OPEN_GUILD_BANK","EVENT_OPEN_HOUSE_STORE","EVENT_OPEN_STORE","EVENT_OPEN_TIMED_ACTIVITIES","EVENT_OPEN_TRADING_HOUSE","EVENT_OPEN_UI_SYSTEM","EVENT_OUTFIT_CHANGE_RESPONSE","EVENT_OUTFIT_EQUIP_RESPONSE","EVENT_OUTFIT_RENAME_RESPONSE","EVENT_OUTFITS_INITIALIZED","EVENT_OUTGOING_FRIEND_INVITE_ADDED","EVENT_OUTGOING_FRIEND_INVITE_REMOVED","EVENT_PATH_FINDING_NETWORK_LINK_CHANGED","EVENT_PENDING_INTERACTION_CANCELLED","EVENT_PERSONALITY_CHANGED","EVENT_PICKPOCKET_STATE_UPDATED","EVENT_PLAYER_ACTIVATED","EVENT_PLAYER_ACTIVELY_ENGAGED_STATE","EVENT_PLAYER_ALIVE","EVENT_PLAYER_COMBAT_STATE","EVENT_PLAYER_DEACTIVATED","EVENT_PLAYER_DEAD","EVENT_PLAYER_DEATH_INFO_UPDATE","EVENT_PLAYER_DEATH_REQUEST_FAILURE","EVENT_PLAYER_EMOTE_FAILED_PLAY","EVENT_PLAYER_IN_PIN_AREA_CHANGED","EVENT_PLAYER_NOT_SWIMMING","EVENT_PLAYER_QUEUED_FOR_CYCLIC_RESPAWN","EVENT_PLAYER_REINCARNATED","EVENT_PLAYER_STATUS_CHANGED","EVENT_PLAYER_STUNNED_STATE_CHANGED","EVENT_PLAYER_SWIMMING","EVENT_PLAYER_TITLES_UPDATE","EVENT_PLEDGE_OF_MARA_OFFER_REMOVED","EVENT_PLEDGE_OF_MARA_OFFER","EVENT_PLEDGE_OF_MARA_RESULT","EVENT_POI_DISCOVERED","EVENT_POI_UPDATED","EVENT_POIS_INITIALIZED","EVENT_POWER_UPDATE","EVENT_PREPARE_FOR_JUMP","EVENT_QUEST_ADDED","EVENT_QUEST_ADVANCED","EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL","EVENT_QUEST_COMPLETE_DIALOG","EVENT_QUEST_COMPLETE","EVENT_QUEST_CONDITION_COUNTER_CHANGED","EVENT_QUEST_CONDITION_OVERRIDE_TEXT_CHANGED","EVENT_QUEST_LIST_UPDATED","EVENT_QUEST_LOG_IS_FULL","EVENT_QUEST_OFFERED","EVENT_QUEST_OPTIONAL_STEP_ADVANCED","EVENT_QUEST_POSITION_REQUEST_COMPLETE","EVENT_QUEST_REMOVED","EVENT_QUEST_SHARE_REMOVED","EVENT_QUEST_SHARE_RESULT","EVENT_QUEST_SHARED","EVENT_QUEST_SHOW_JOURNAL_ENTRY","EVENT_QUEST_TIMER_PAUSED","EVENT_QUEST_TIMER_UPDATED","EVENT_QUEST_TOOL_UPDATED","EVENT_QUEUE_FOR_CAMPAIGN_RESPONSE","EVENT_RAID_LEADERBOARD_DATA_CHANGED","EVENT_RAID_LEADERBOARD_PLAYER_DATA_CHANGED","EVENT_RAID_PARTICIPATION_UPDATE","EVENT_RAID_REVIVE_COUNTER_UPDATE","EVENT_RAID_SCORE_NOTIFICATION_ADDED","EVENT_RAID_SCORE_NOTIFICATION_REMOVED","EVENT_RAID_TIMER_STATE_UPDATE","EVENT_RAID_TRIAL_COMPLETE","EVENT_RAID_TRIAL_FAILED","EVENT_RAID_TRIAL_NEW_BEST_SCORE","EVENT_RAID_TRIAL_RESET_BEST_SCORE","EVENT_RAID_TRIAL_SCORE_UPDATE","EVENT_RAID_TRIAL_STARTED","EVENT_RAM_ESCORT_COUNT_UPDATE","EVENT_RANK_POINT_UPDATE","EVENT_REASON_HARDWARE","EVENT_REASON_SOFTWARE","EVENT_RECALL_KEEP_USE_RESULT","EVENT_RECIPE_ALREADY_KNOWN","EVENT_RECIPE_LEARNED","EVENT_RECONSTRUCT_RESPONSE","EVENT_RECONSTRUCT_STARTED","EVENT_REMOTE_SCENE_REQUEST","EVENT_REMOTE_TOP_LEVEL_CHANGE","EVENT_REMOVE_ACTIVE_COMBAT_TIP","EVENT_REMOVE_TUTORIAL","EVENT_REQUEST_ALERT","EVENT_REQUEST_CONFIRM_USE_ITEM","EVENT_REQUEST_CROWN_GEM_TUTORIAL","EVENT_REQUEST_SHOW_GAMEPAD_CHAPTER_UPGRADE","EVENT_REQUEST_SHOW_GIFT_INVENTORY","EVENT_REQUIREMENTS_FAIL","EVENT_RESURRECT_REQUEST_REMOVED","EVENT_RESURRECT_REQUEST","EVENT_RESURRECT_RESULT","EVENT_RETICLE_HIDDEN_UPDATE","EVENT_RETICLE_TARGET_CHANGED","EVENT_RETICLE_TARGET_COMPANION_CHANGED","EVENT_RETICLE_TARGET_PLAYER_CHANGED","EVENT_RETRAIT_RESPONSE","EVENT_RETRAIT_STARTED","EVENT_RETRAIT_STATION_INTERACT_START","EVENT_REVEAL_ANTIQUITY_DIG_SITES_ON_MAP","EVENT_REVENGE_KILL","EVENT_RIDING_SKILL_IMPROVEMENT","EVENT_SAVE_DATA_COMPLETE","EVENT_SAVE_GUILD_RANKS_RESPONSE","EVENT_SCREEN_RESIZED","EVENT_SCREENSHOT_SAVED","EVENT_SCRIPT_ACCESS_VIOLATION","EVENT_SCRIPTED_WORLD_EVENT_INVITE_REMOVED","EVENT_SCRIPTED_WORLD_EVENT_INVITE","EVENT_SCRYING_ACTIVE_SKILL_USE_RESULT","EVENT_SCRYING_EXIT_RESPONSE","EVENT_SECURE_3D_RENDER_MODE_CHANGED","EVENT_SECURE_RENDER_MODE_CHANGED","EVENT_SELL_RECEIPT","EVENT_SET_SUBTITLE","EVENT_SHOW_BOOK","EVENT_SHOW_DAILY_LOGIN_REWARDS_SCENE","EVENT_SHOW_PREGAME_GUI_IN_STATE","EVENT_SHOW_SPECIFIC_HELP_PAGE","EVENT_SHOW_SUBTITLE","EVENT_SHOW_TREASURE_MAP","EVENT_SHOW_WORLD_MAP","EVENT_SHOW_ZONE_STORIES_SCENE","EVENT_SIEGE_BUSY","EVENT_SIEGE_CONTROL_ANOTHER_PLAYER","EVENT_SIEGE_CREATION_FAILED_CLOSEST_DOOR_ALREADY_HAS_RAM","EVENT_SIEGE_CREATION_FAILED_NO_VALID_DOOR","EVENT_SIEGE_FIRE_FAILED_COOLDOWN","EVENT_SIEGE_FIRE_FAILED_RETARGETING","EVENT_SIEGE_PACK_FAILED_INVENTORY_FULL","EVENT_SIEGE_PACK_FAILED_NOT_CREATOR","EVENT_SKILL_BUILD_SELECTION_UPDATED","EVENT_SKILL_LINE_ADDED","EVENT_SKILL_POINTS_CHANGED","EVENT_SKILL_RANK_UPDATE","EVENT_SKILL_RESPEC_RESULT","EVENT_SKILL_XP_UPDATE","EVENT_SKILLS_FULL_UPDATE","EVENT_SKYSHARDS_UPDATED","EVENT_SLOT_IS_LOCKED_FAILURE","EVENT_SMITHING_TRAIT_RESEARCH_CANCELED","EVENT_SMITHING_TRAIT_RESEARCH_COMPLETED","EVENT_SMITHING_TRAIT_RESEARCH_STARTED","EVENT_SMITHING_TRAIT_RESEARCH_TIMES_UPDATED","EVENT_SOCIAL_DATA_LOADED","EVENT_SOCIAL_ERROR","EVENT_SOUL_GEM_ITEM_CHARGE_FAILURE","EVENT_SPAM_WARNING","EVENT_STABLE_INTERACT_END","EVENT_STABLE_INTERACT_START","EVENT_STACKED_ALL_ITEMS_IN_BAG","EVENT_START_FAST_TRAVEL_INTERACTION","EVENT_START_FAST_TRAVEL_KEEP_INTERACTION","EVENT_START_KEEP_GUILD_CLAIM_INTERACTION","EVENT_START_KEEP_GUILD_RELEASE_INTERACTION","EVENT_START_SKILL_RESPEC","EVENT_START_SOUL_GEM_RESURRECTION","EVENT_STATS_UPDATED","EVENT_STEALTH_STATE_CHANGED","EVENT_STORE_FAILURE","EVENT_STUCK_BEGIN","EVENT_STUCK_CANCELED","EVENT_STUCK_COMPLETE","EVENT_STUCK_ERROR_ALREADY_IN_PROGRESS","EVENT_STUCK_ERROR_IN_COMBAT","EVENT_STUCK_ERROR_INVALID_LOCATION","EVENT_STUCK_ERROR_ON_COOLDOWN","EVENT_STYLE_LEARNED","EVENT_SUBSCRIBER_BANK_IS_LOCKED","EVENT_SYNERGY_ABILITY_CHANGED","EVENT_TARGET_CHANGED","EVENT_TELVAR_STONE_UPDATE","EVENT_TIMED_ACTIVITIES_UPDATED","EVENT_TIMED_ACTIVITY_PROGRESS_UPDATED","EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED","EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED","EVENT_TITLE_UPDATE","EVENT_TOGGLE_HELP","EVENT_TRACKED_ZONE_STORY_ACTIVITY_COMPLETED","EVENT_TRACKING_UPDATE","EVENT_TRADE_ACCEPT_FAILED_NOT_ENOUGH_MONEY","EVENT_TRADE_CANCELED","EVENT_TRADE_CONFIRMATION_CHANGED","EVENT_TRADE_ELEVATION_FAILED","EVENT_TRADE_FAILED","EVENT_TRADE_INVITE_ACCEPTED","EVENT_TRADE_INVITE_CANCELED","EVENT_TRADE_INVITE_CONSIDERING","EVENT_TRADE_INVITE_DECLINED","EVENT_TRADE_INVITE_FAILED","EVENT_TRADE_INVITE_REMOVED","EVENT_TRADE_INVITE_WAITING","EVENT_TRADE_ITEM_ADD_FAILED","EVENT_TRADE_ITEM_ADDED","EVENT_TRADE_ITEM_REMOVED","EVENT_TRADE_ITEM_UPDATED","EVENT_TRADE_MONEY_CHANGED","EVENT_TRADE_SUCCEEDED","EVENT_TRADING_HOUSE_AWAITING_RESPONSE","EVENT_TRADING_HOUSE_CONFIRM_ITEM_PURCHASE","EVENT_TRADING_HOUSE_ERROR","EVENT_TRADING_HOUSE_OPERATION_TIME_OUT","EVENT_TRADING_HOUSE_PENDING_ITEM_UPDATE","EVENT_TRADING_HOUSE_RESPONSE_RECEIVED","EVENT_TRADING_HOUSE_RESPONSE_TIMEOUT","EVENT_TRADING_HOUSE_SEARCH_COOLDOWN_UPDATE","EVENT_TRADING_HOUSE_SELECTED_GUILD_CHANGED","EVENT_TRADING_HOUSE_STATUS_RECEIVED","EVENT_TRAIT_LEARNED","EVENT_TRIAL_FEATURE_RESTRICTED","EVENT_TUTORIAL_HIDDEN","EVENT_TUTORIAL_SYSTEM_ENABLED_STATE_CHANGED","EVENT_TUTORIAL_TRIGGER_COMPLETED","EVENT_TUTORIALS_RESET","EVENT_UI_ERROR","EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED","EVENT_UNIT_ATTRIBUTE_VISUAL_REMOVED","EVENT_UNIT_ATTRIBUTE_VISUAL_UPDATED","EVENT_UNIT_CHARACTER_NAME_CHANGED","EVENT_UNIT_CREATED","EVENT_UNIT_DEATH_STATE_CHANGED","EVENT_UNIT_DESTROYED","EVENT_UNLOCKED_DYES_UPDATED","EVENT_UNSPENT_CHAMPION_POINTS_CHANGED","EVENT_UPDATE_BUYBACK","EVENT_UPDATE_GUI_LOADING_PROGRESS","EVENT_VETERAN_DIFFICULTY_CHANGED","EVENT_VIBRATION","EVENT_VIDEO_PLAYBACK_CANCEL_STARTED","EVENT_VIDEO_PLAYBACK_COMPLETE","EVENT_VIDEO_PLAYBACK_CONFIRM_CANCEL","EVENT_VIDEO_PLAYBACK_ERROR","EVENT_VISUAL_LAYER_CHANGED","EVENT_WEAPON_PAIR_LOCK_CHANGED","EVENT_WEAPON_SWAP_LOCKED","EVENT_WEREWOLF_STATE_CHANGED","EVENT_WORLD_EVENT_ACTIVATED","EVENT_WORLD_EVENT_ACTIVE_LOCATION_CHANGED","EVENT_WORLD_EVENT_DEACTIVATED","EVENT_WORLD_EVENT_UNIT_CHANGED_PIN_TYPE","EVENT_WORLD_EVENT_UNIT_CREATED","EVENT_WORLD_EVENT_UNIT_DESTROYED","EVENT_WORLD_EVENTS_INITIALIZED","EVENT_WRIT_VOUCHER_UPDATE","EVENT_ZONE_CHANGED","EVENT_ZONE_CHANNEL_CHANGED","EVENT_ZONE_COLLECTIBLE_REQUIREMENT_FAILED","EVENT_ZONE_SCORING_CHANGED","EVENT_ZONE_STORY_ACTIVITY_TRACKED","EVENT_ZONE_STORY_ACTIVITY_TRACKING_INIT","EVENT_ZONE_STORY_ACTIVITY_UNTRACKED","EVENT_ZONE_STORY_QUEST_ACTIVITY_TRACKED","EVENT_ZONE_UPDATE")
local function LogAnyEvent(eventid, ...)
   local eventname = lstEventNamesByID[eventid] or "eventid:"..tostring(eventid)
   if eventid == EVENT_SYNERGY_ABILITY_CHANGED then
      LogBase(eventname, ...)
      LogBase("SynergyName", GetSynergyInfo())
   elseif eventid == EVENT_LOOT_RECEIVED then
      LogBase(eventname, ...)
      LogBase("LootLinkName", GetItemLinkName(select(2, ...)))
   else
      LogBase(eventname, ...)
   end
end
---

local GetGameCameraInteractableActionInfo = GetGameCameraInteractableActionInfo
local CanInteractWithItem = CanInteractWithItem -- currently called wrong but still works * CanInteractWithItem(*[Bag|#Bag]* _bagId_, *integer* _slotIndex_) ** _Returns:_ *bool* _canInteract_
local IsInteracting = IsInteracting
local prvAction, prvInteractableName, prvInteractBlocked, prvIsOwned, prvAdditionalInfo, prvContextualInfo, prvContextualLink, prvIsCriminalInteract, prvCanInteractWithItem, prvIsInteracting
local curAction, curInteractableName, curInteractBlocked, curIsOwned, curAdditionalInfo, curContextualInfo, curContextualLink, curIsCriminalInteract, curCanInteractWithItem, curIsInteracting
function AnyLogger.OnReticleChange(curAction, curInteractableName, curInteractBlocked, curIsOwned, curAdditionalInfo, curContextualInfo, curContextualLink, curIsCriminalInteract, curCanInteractWithItem, curIsInteracting)
   prvAction, prvInteractableName, prvInteractBlocked, prvIsOwned, prvAdditionalInfo, prvContextualInfo, prvContextualLink, prvIsCriminalInteract, prvCanInteractWithItem, prvIsInteracting = curAction, curInteractableName, curInteractBlocked, curIsOwned, curAdditionalInfo, curContextualInfo, curContextualLink, curIsCriminalInteract, curCanInteractWithItem, curIsInteracting
   LogAnyTxt("OnReticleChange", curAction, curInteractableName, Ternary(curInteractBlocked, "Blocked", "NotBlocked"), Ternary(curIsOwned, "Owned", "NotOwned"), curAdditionalInfo, curContextualInfo, curContextualLink, Ternary(curIsCriminalInteract, "Crime", "Legal"), Ternary(curCanInteractWithItem, "CanInteract", "CanNotInteract"), Ternary(curIsInteracting, "IsInteracting", "IsNotInteracting"))
end
local function OnReticleSet()
	curAction, curInteractableName, curInteractBlocked, curIsOwned, curAdditionalInfo, curContextualInfo, curContextualLink, curIsCriminalInteract = GetGameCameraInteractableActionInfo()
   curCanInteractWithItem = CanInteractWithItem()
   curIsInteracting = IsInteracting()
	if curAction~=prvAction or curInteractableName~=prvInteractableName or curInteractBlocked~=prvInteractBlocked or curIsOwned~=prvIsOwned or curAdditionalInfo~=prvAdditionalInfo or curContextualInfo~=prvContextualInfo or curContextualLink~=prvContextualLink or curIsCriminalInteract~=prvIsCriminalInteract or curCanInteractWithItem~=prvCanInteractWithItem or curIsInteracting~=prvIsInteracting then
      AnyLogger.OnReticleChange(curAction, curInteractableName, curInteractBlocked, curIsOwned, curAdditionalInfo, curContextualInfo, curContextualLink, curIsCriminalInteract, curCanInteractWithItem, curIsInteracting)
	end
end
------------------
local locWorldZoneId, locWorldX, locWorldY, locWorldZ
local locMapX, locMapY, locMapHeading
local function Footprints()
   local locPrvWorldZoneId, locPrvWorldX, locPrvWorldY, locPrvWorldZ = locWorldZoneId, locWorldX, locWorldY, locWorldZ
   local locPrvMapX, locPrvMapY, locPrvMapHeading = locMapX, locMapY, locMapHeading
   locWorldZoneId, locWorldX, locWorldY, locWorldZ = GetUnitRawWorldPosition("player") -- * GetUnitRawWorldPosition(*string* _unitTag_) ** _Returns:_ *integer* _zoneId_, *integer* _worldX_, *integer* _worldY_, *integer* _worldZ_
   locMapX, locMapY, locMapHeading = GetMapPlayerPosition("player") -- * GetMapPlayerPosition(*string* _unitTag_) ** _Returns:_ *number* _normalizedX_, *number* _normalizedZ_, *number* _heading_, *bool* _isShownInCurrentMap_
   if locPrvWorldZoneId ~= locWorldZoneId or locPrvWorldX ~= locWorldX or locPrvWorldY ~= locWorldY or locPrvWorldZ ~= locWorldZ or locPrvMapX ~= locMapX or locPrvMapY ~= locMapY then
      LogBase('OnLocationChange', locWorldZoneId, locWorldX, locWorldY, locWorldZ, locMapX, locMapY, locMapHeading)
   end
end
------------------
function AnyLogger:Initialize()
   AnyLoggerSavedVariablesV2 = {}
   EVENT_MANAGER:RegisterForAllEvents(ADDON_NAME..'Log', LogAnyEvent)
   EVENT_MANAGER:RegisterForUpdate(ADDON_NAME, 10, OnReticleSet)
   EVENT_MANAGER:RegisterForUpdate(ADDON_NAME..'Footprints', 100, Footprints)
end
EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, function(event, addonName) if addonName == ADDON_NAME then AnyLogger:Initialize() end end)
------------------
-- Pre-Hook a variety of functions in CombatAlerts to log the events
EVENT_MANAGER:RegisterForEvent(ADDON_NAME.."CombatAlerts", EVENT_PLAYER_ACTIVATED, function ()
   ZO_PreHook(CombatAlerts,'StartBanner', function(...) AnyLogger:Log("CombatAlerts.StartBanner", ...) end)
   ZO_PreHook(CombatAlerts,'CastAlertsStart', function(...) AnyLogger:Log("CombatAlerts.CastAlertsStart", ...) end)
   ZO_PreHook(CombatAlerts,'Alert', function(...) AnyLogger:Log("CombatAlerts.Alert", ...) end)
   ZO_PreHook(CombatAlerts,'AlertCast', function(...) AnyLogger:Log("CombatAlerts.AlertCast", ...) end)
   ZO_PreHook(CombatAlerts,'ScreenBorderEnable', function(...) AnyLogger:Log("CombatAlerts.ScreenBorderEnable", ...) end)
   ZO_PreHook(CombatAlerts,'AlertBorder', function( enable, duration, color ) if enable then AnyLogger:Log("CombatAlerts.AlertBorder", enable, duration, color) end end)
   ZO_PreHook(CombatAlerts,'AlertChat', function(...) AnyLogger:Log("CombatAlerts.AlertChat", ...) end)
end)
