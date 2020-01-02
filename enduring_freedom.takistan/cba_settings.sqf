// ACE Advanced Ballistics
force force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force force ace_advanced_ballistics_bulletTraceEnabled = true;
force force ace_advanced_ballistics_enabled = true;
force force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Advanced Fatigue
force force ace_advanced_fatigue_enabled = true;
force force ace_advanced_fatigue_enableStaminaBar = true;
ace_advanced_fatigue_fadeStaminaBar = true;
force force ace_advanced_fatigue_loadFactor = 0.4;
force force ace_advanced_fatigue_performanceFactor = 1.2;
force force ace_advanced_fatigue_recoveryFactor = 3.5;
force force ace_advanced_fatigue_swayFactor = 0.7;
force force ace_advanced_fatigue_terrainGradientFactor = 0.2;

// ACE Advanced Throwing
ace_advanced_throwing_enabled = true;
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;
ace_advanced_throwing_showMouseControls = true;
ace_advanced_throwing_showThrowArc = true;

// ACE Arsenal
force ace_arsenal_allowDefaultLoadouts = true;
force ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_camInverted = false;
force ace_arsenal_enableIdentityTabs = true;
ace_arsenal_enableModIcons = true;
ace_arsenal_EnableRPTLog = false;
ace_arsenal_fontHeight = 4.5;

// ACE Artillery
force ace_artillerytables_advancedCorrections = false;
force ace_artillerytables_disableArtilleryComputer = false;
force force ace_mk6mortar_airResistanceEnabled = true;
force force ace_mk6mortar_allowCompass = false;
force force ace_mk6mortar_allowComputerRangefinder = false;
force force ace_mk6mortar_useAmmoHandling = true;

// ACE Captives
force force ace_captives_allowHandcuffOwnSide = false;
force force ace_captives_allowSurrender = true;
force force ace_captives_requireSurrender = 1;
force ace_captives_requireSurrenderAi = false;

// ACE Common
force ace_common_allowFadeMusic = true;
force ace_common_checkPBOsAction = 0;
force ace_common_checkPBOsCheckAll = false;
force ace_common_checkPBOsWhitelist = "[]";
ace_common_displayTextColor = [0,0,0,0.1];
ace_common_displayTextFontColor = [1,1,1,1];
ace_common_settingFeedbackIcons = 1;
ace_common_settingProgressBarLocation = 0;
force ace_noradio_enabled = true;
ace_parachute_hideAltimeter = true;

// ACE Cook off
force ace_cookoff_ammoCookoffDuration = 0.822828;
force ace_cookoff_enable = 0;
force ace_cookoff_enableAmmobox = false;
force ace_cookoff_enableAmmoCookoff = false;
force ace_cookoff_probabilityCoef = 0.676937;

// ACE Crew Served Weapons
force ace_csw_ammoHandling = 2;
force ace_csw_defaultAssemblyMode = false;
ace_csw_dragAfterDeploy = false;
force ace_csw_handleExtraMagazines = true;
force ace_csw_progressBarTimeCoefficent = 1;

// ACE Explosives
force force ace_explosives_explodeOnDefuse = false;
force force ace_explosives_punishNonSpecialists = true;
force ace_explosives_requireSpecialist = false;

// ACE Fragmentation Simulation
force force ace_frag_enabled = true;
force force ace_frag_maxTrack = 7;
force force ace_frag_maxTrackPerFrame = 7;
force force ace_frag_reflectionsEnabled = true;
force force ace_frag_spallEnabled = true;

// ACE Goggles
force force ace_goggles_effects = 2;
force force ace_goggles_showClearGlasses = true;
force force ace_goggles_showInThirdPerson = true;

// ACE Hearing
force force ace_hearing_autoAddEarplugsToUnits = true;
force force ace_hearing_disableEarRinging = false;
force force ace_hearing_earplugsVolume = 0.5;
force force ace_hearing_enableCombatDeafness = true;
force force ace_hearing_enabledForZeusUnits = false;
force force ace_hearing_unconsciousnessVolume = 0.4;

// ACE Interaction
force ace_interaction_disableNegativeRating = true;
ace_interaction_enableMagazinePassing = true;
force ace_interaction_enableTeamManagement = true;

// ACE Interaction Menu
ace_gestures_showOnInteractionMenu = 2;
ace_interact_menu_actionOnKeyRelease = true;
ace_interact_menu_addBuildingActions = false;
ace_interact_menu_alwaysUseCursorInteraction = false;
ace_interact_menu_alwaysUseCursorSelfInteraction = true;
ace_interact_menu_colorShadowMax = [0,0,0,1];
ace_interact_menu_colorShadowMin = [0,0,0,0.25];
ace_interact_menu_colorTextMax = [1,1,1,1];
ace_interact_menu_colorTextMin = [1,1,1,0.25];
ace_interact_menu_cursorKeepCentered = false;
ace_interact_menu_cursorKeepCenteredSelfInteraction = false;
ace_interact_menu_menuAnimationSpeed = 0;
ace_interact_menu_menuBackground = 0;
ace_interact_menu_menuBackgroundSelf = 0;
ace_interact_menu_selectorColor = [1,0,0];
ace_interact_menu_shadowSetting = 2;
ace_interact_menu_textSize = 2;
ace_interact_menu_useListMenu = true;
ace_interact_menu_useListMenuSelf = false;

// ACE Logistics
force ace_cargo_enable = true;
force ace_cargo_loadTimeCoefficient = 5;
force ace_cargo_paradropTimeCoefficent = 2.5;
force ace_rearm_distance = 20;
force ace_rearm_level = 0;
force ace_rearm_supply = 0;
force ace_refuel_hoseLength = 12;
force ace_refuel_rate = 1;
force ace_repair_addSpareParts = true;
force ace_repair_autoShutOffEngineWhenStartingRepair = false;
force ace_repair_consumeItem_toolKit = 0;
ace_repair_displayTextOnRepair = true;
force ace_repair_engineerSetting_fullRepair = 2;
force ace_repair_engineerSetting_repair = 1;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_fullRepairLocation = 2;
force ace_repair_fullRepairRequiredItems = ["ToolKit"];
force ace_repair_miscRepairRequiredItems = ["ToolKit"];
force ace_repair_repairDamageThreshold = 0.6;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_wheelRepairRequiredItems = [];

// ACE Magazine Repack
force force ace_magazinerepack_timePerAmmo = 1.5;
force force ace_magazinerepack_timePerBeltLink = 8;
force force ace_magazinerepack_timePerMagazine = 2;

// ACE Map
force ace_map_BFT_Enabled = false;
force ace_map_BFT_HideAiGroups = false;
force ace_map_BFT_Interval = 1;
force ace_map_BFT_ShowPlayerNames = false;
force ace_map_DefaultChannel = 0;
force ace_map_mapGlow = true;
force ace_map_mapIllumination = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShake = true;
force ace_map_mapShowCursorCoordinates = false;
force force ace_markers_moveRestriction = 0;

// ACE Map Gestures
ace_map_gestures_defaultColor = [1,0.88,0,0.7];
ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
force ace_map_gestures_enabled = true;
force ace_map_gestures_interval = 0.03;
force ace_map_gestures_maxRange = 7;
ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];

// ACE Map Tools
ace_maptools_drawStraightLines = true;
ace_maptools_rotateModifierKey = 1;

// ACE Medical
force force ace_medical_ai_enabledFor = 2;
force force ace_medical_AIDamageThreshold = 1;
force force ace_medical_bleedingCoefficient = 0.5;
force force ace_medical_blood_bloodLifetime = 120;
force force ace_medical_blood_enabledFor = 2;
force force ace_medical_blood_maxBloodObjects = 200;
force force ace_medical_fatalDamageSource = 0;
ace_medical_feedback_painEffectType = 2;
force force ace_medical_fractures = 2;
force force ace_medical_gui_enableActions = 2;
force force ace_medical_gui_enableMedicalMenu = 1;
force force ace_medical_gui_enableSelfActions = true;
force force ace_medical_gui_maxDistance = 3;
force force ace_medical_gui_openAfterTreatment = true;
force force ace_medical_ivFlowRate = 2.25;
force force ace_medical_limping = 1;
force force ace_medical_painCoefficient = 0.3;
force force ace_medical_playerDamageThreshold = 3;
force force ace_medical_spontaneousWakeUpChance = 0.1;
force force ace_medical_spontaneousWakeUpEpinephrineBoost = 1.3;
force force ace_medical_statemachine_AIUnconsciousness = true;
force force ace_medical_statemachine_cardiacArrestTime = 300;
force force ace_medical_statemachine_fatalInjuriesAI = 0;
force force ace_medical_statemachine_fatalInjuriesPlayer = 0;
force force ace_medical_treatment_advancedBandages = true;
force force ace_medical_treatment_advancedDiagnose = true;
force force ace_medical_treatment_advancedMedication = true;
force force ace_medical_treatment_allowLitterCreation = false;
force force ace_medical_treatment_allowSelfIV = 1;
force force ace_medical_treatment_allowSelfStitch = 1;
force force ace_medical_treatment_allowSharedEquipment = 0;
force force ace_medical_treatment_clearTraumaAfterBandage = false;
force force ace_medical_treatment_consumePAK = 0;
force force ace_medical_treatment_consumeSurgicalKit = 0;
force force ace_medical_treatment_convertItems = 0;
force force ace_medical_treatment_cprSuccessChance = 0.4;
force force ace_medical_treatment_holsterRequired = 0;
force force ace_medical_treatment_litterCleanupDelay = 120;
force force ace_medical_treatment_locationEpinephrine = 0;
force force ace_medical_treatment_locationPAK = 4;
force force ace_medical_treatment_locationsBoostTraining = true;
force force ace_medical_treatment_locationSurgicalKit = 0;
force force ace_medical_treatment_maxLitterObjects = 200;
force force ace_medical_treatment_medicEpinephrine = 0;
force force ace_medical_treatment_medicPAK = 2;
force force ace_medical_treatment_medicSurgicalKit = 2;
force force ace_medical_treatment_timeCoefficientPAK = 0.5;
force force ace_medical_treatment_woundReopening = true;


// ACE Name Tags
ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
ace_nametags_nametagColorBlue = [0.67,0.67,1,1];
ace_nametags_nametagColorGreen = [0.67,1,0.67,1];
ace_nametags_nametagColorMain = [1,1,1,1];
ace_nametags_nametagColorRed = [1,0.67,0.67,1];
ace_nametags_nametagColorYellow = [1,1,0.67,1];
force ace_nametags_playerNamesMaxAlpha = 0.8;
force ace_nametags_playerNamesViewDistance = 5;
force ace_nametags_showCursorTagForVehicles = false;
ace_nametags_showNamesForAI = false;
ace_nametags_showPlayerNames = 0;
ace_nametags_showPlayerRanks = false;
ace_nametags_showSoundWaves = 0;
ace_nametags_showVehicleCrewInfo = false;
ace_nametags_tagSize = 2;

// ACE Nightvision
force force ace_nightvision_aimDownSightsBlur = 0.165733;
force ace_nightvision_disableNVGsWithSights = false;
force force ace_nightvision_effectScaling = 0.714286;
force force ace_nightvision_fogScaling = 0.1;
force force ace_nightvision_noiseScaling = 0;
force force ace_nightvision_shutterEffects = true;

// ACE Overheating
force force ace_overheating_displayTextOnJam = true;
force force ace_overheating_enabled = true;
force force ace_overheating_overheatingDispersion = true;
force force ace_overheating_showParticleEffects = true;
ace_overheating_showParticleEffectsForEveryone = false;
force ace_overheating_unJamFailChance = 0.1;
force ace_overheating_unJamOnreload = false;

// ACE Pointing
force force ace_finger_enabled = true;
force force ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
force force ace_finger_indicatorForSelf = true;
force force ace_finger_maxRange = 4;

// ACE Pylons
force force ace_pylons_enabledForZeus = true;
force force ace_pylons_enabledFromAmmoTrucks = true;
force force ace_pylons_rearmNewPylons = true;
force force ace_pylons_requireEngineer = false;
force force ace_pylons_requireToolkit = false;
force force ace_pylons_searchDistance = 50;
force force ace_pylons_timePerPylon = 3.05882;

// ACE Quick Mount
force force ace_quickmount_distance = 3;
force force ace_quickmount_enabled = true;
ace_quickmount_enableMenu = 3;
force force ace_quickmount_priority = 0;
force force ace_quickmount_speed = 18;

// ACE Respawn
force force ace_respawn_removeDeadBodiesDisconnected = true;
force force ace_respawn_savePreDeathGear = true;

// ACE Scopes
force ace_scopes_correctZeroing = true;
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = true;
force ace_scopes_defaultZeroRange = 100;
force force ace_scopes_enabled = true;
force ace_scopes_forceUseOfAdjustmentTurrets = false;
force ace_scopes_overwriteZeroRange = false;
force ace_scopes_simplifiedZeroing = false;
ace_scopes_useLegacyUI = false;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force ace_scopes_zeroReferenceHumidity = 0;
force ace_scopes_zeroReferenceTemperature = 15;

// ACE Spectator
force ace_spectator_enableAI = false;
ace_spectator_maxFollowDistance = 5;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;

// ACE Switch Units
force ace_switchunits_enableSafeZone = true;
force ace_switchunits_enableSwitchUnits = false;
force ace_switchunits_safeZoneRadius = 100;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToWest = false;

// ACE Uncategorized
force ace_fastroping_requireRopeItems = false;
force force ace_gforces_enabledFor = 0;
force force ace_hitreactions_minDamageToTrigger = 0.1;
force force ace_inventory_inventoryDisplaySize = 0;
force force ace_laser_dispersionCount = 2;
force force ace_microdagr_mapDataAvailable = 1;
force ace_microdagr_waypointPrecision = 3;
force force ace_optionsmenu_showNewsOnMainMenu = true;
force force ace_overpressure_distanceCoefficient = 1;
ace_tagging_quickTag = 1;

// ACE User Interface
force ace_ui_allowSelectiveUI = true;
ace_ui_ammoCount = false;
ace_ui_ammoType = true;
ace_ui_commandMenu = true;
ace_ui_firingMode = true;
ace_ui_groupBar = false;
ace_ui_gunnerAmmoCount = true;
ace_ui_gunnerAmmoType = true;
ace_ui_gunnerFiringMode = true;
ace_ui_gunnerLaunchableCount = true;
ace_ui_gunnerLaunchableName = true;
ace_ui_gunnerMagCount = true;
ace_ui_gunnerWeaponLowerInfoBackground = true;
ace_ui_gunnerWeaponName = true;
ace_ui_gunnerWeaponNameBackground = true;
ace_ui_gunnerZeroing = true;
ace_ui_magCount = true;
ace_ui_soldierVehicleWeaponInfo = true;
ace_ui_staminaBar = true;
ace_ui_stance = true;
ace_ui_throwableCount = true;
ace_ui_throwableName = true;
ace_ui_vehicleAltitude = true;
ace_ui_vehicleCompass = true;
ace_ui_vehicleDamage = true;
ace_ui_vehicleFuelBar = true;
ace_ui_vehicleInfoBackground = true;
ace_ui_vehicleName = true;
ace_ui_vehicleNameBackground = true;
ace_ui_vehicleRadar = true;
ace_ui_vehicleSpeed = true;
ace_ui_weaponLowerInfoBackground = true;
ace_ui_weaponName = true;
ace_ui_weaponNameBackground = true;
ace_ui_zeroing = true;

// ACE Vehicle Lock
force ace_vehiclelock_defaultLockpickStrength = 10;
force ace_vehiclelock_lockVehicleInventory = true;
force ace_vehiclelock_vehicleStartingLockState = -1;

// ACE Vehicles
ace_vehicles_hideEjectAction = true;
force ace_vehicles_keepEngineRunning = false;

// ACE View Distance Limiter
force force ace_viewdistance_enabled = true;
force force ace_viewdistance_limitViewDistance = 12000;
ace_viewdistance_objectViewDistanceCoeff = 6;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceOnFoot = 0;

// ACE Weapons
force force ace_common_persistentLaserEnabled = true;
force force ace_laserpointer_enabled = true;
force force ace_reload_displayText = true;
ace_reload_showCheckAmmoSelf = false;
force force ace_weaponselect_displayText = true;

// ACE Weather
force ace_weather_enabled = true;
ace_weather_showCheckAirTemperature = true;
force ace_weather_updateInterval = 300;
force ace_weather_windSimulation = true;

// ACE Wind Deflection
force ace_winddeflection_enabled = true;
force ace_winddeflection_simulationInterval = 0.05;
force ace_winddeflection_vehicleEnabled = true;

// ACE Zeus
force force ace_zeus_autoAddObjects = true;
force ace_zeus_canCreateZeus = -1;
force force ace_zeus_radioOrdnance = false;
force force ace_zeus_remoteWind = false;
force force ace_zeus_revealMines = 0;
force force ace_zeus_zeusAscension = false;
force force ace_zeus_zeusBird = true;

// ACEX Field Rations
force acex_field_rations_affectAdvancedFatigue = true;
force force acex_field_rations_enabled = false;
acex_field_rations_hudShowLevel = 30;
acex_field_rations_hudTransparency = -1;
acex_field_rations_hudType = 0;
force acex_field_rations_hungerSatiated = 1;
force acex_field_rations_thirstQuenched = 1;
force force acex_field_rations_timeWithoutFood = 36;
force force acex_field_rations_timeWithoutWater = 6;

// ACEX Fortify
acex_fortify_settingHint = 2;

// ACEX Headless
force force acex_headless_delay = 9.94399;
force force acex_headless_enabled = true;
force force acex_headless_endMission = 0;
force force acex_headless_log = false;
force acex_headless_transferLoadout = 0;

// ACEX Sitting
force force acex_sitting_enable = true;

// ACEX View Restriction
force acex_viewrestriction_mode = 0;
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveSea = 0;
acex_viewrestriction_preserveView = false;

// ACEX Volume
acex_volume_enabled = false;
acex_volume_fadeDelay = 1;
acex_volume_lowerInVehicles = false;
acex_volume_reduction = 5;
acex_volume_remindIfLowered = false;
acex_volume_showNotification = true;

// ACRE2
acre_sys_core_automaticAntennaDirection = false;
acre_sys_core_defaultRadioVolume = 0.8;
force acre_sys_core_fullDuplex = false;
force force acre_sys_core_ignoreAntennaDirection = true;
force force acre_sys_core_interference = true;
acre_sys_core_postmixGlobalVolume = 1;
acre_sys_core_premixGlobalVolume = 1;
force acre_sys_core_revealToAI = 1;
acre_sys_core_spectatorVolume = 1;
force force acre_sys_core_terrainLoss = 0.227964;
force force acre_sys_core_ts3ChannelName = "Operations Room 3";
force force acre_sys_core_ts3ChannelPassword = "Acre";
force force acre_sys_core_ts3ChannelSwitch = true;
acre_sys_core_unmuteClients = true;
force acre_sys_signal_signalModel = 3;

// ACRE2 UI
acre_sys_gui_volumeColorScale = [[1,1,0,0.5],[1,0.83,0,0.5],[1,0.65,0,0.5],[1,0.44,0,0.5],[1,0,0,0.5]];
acre_sys_list_CycleRadiosColor = [0.66,0.05,1,1];
acre_sys_list_DefaultPTTColor = [1,0.8,0,1];
acre_sys_list_HintBackgroundColor = [0,0,0,0.8];
acre_sys_list_HintTextFont = "RobotoCondensed";
acre_sys_list_LanguageColor = [1,0.29,0.16,1];
acre_sys_list_PTT1Color = [1,0.8,0,1];
acre_sys_list_PTT2Color = [1,0.8,0,1];
acre_sys_list_PTT3Color = [1,0.8,0,1];
acre_sys_list_SwitchChannelColor = [0.66,0.05,1,1];
acre_sys_list_ToggleHeadsetColor = [0.66,0.05,1,1];

// ACRE2 Zeus
acre_sys_zeus_zeusCanSpectate = true;
acre_sys_zeus_zeusCommunicateViaCamera = true;
acre_sys_zeus_zeusDefaultVoiceSource = false;

// AI
force cfp_autoEquipNVG = true;

// Boxloader
force boxloader_allrepair_height = 5;
force boxloader_allrepair_load = true;
force boxloader_allrepair_push = 10000;
force boxloader_allrepair_weight = 10000;
force boxloader_allrepair_work = true;
force boxloader_fort_allow_floating = false;
boxloader_fort_snap_editor = false;
force boxloader_hidecargo_enabled = true;
force boxloader_maxload_enabled = false;
force boxloader_maxload_lift = 50;
force boxloader_maxload_minpush = 10;
force boxloader_maxload_overhead = 30;
force boxloader_maxload_push = 200;
force boxloader_maxunload_enabled = false;
force boxloader_preciseunload_enabled = false;
force boxloader_push_enabled = true;
force boxloader_retrofit_enabled = true;
force boxloader_tractor_bulldoze = false;
force boxloader_tractor_bulldoze_fence = false;
force boxloader_tractor_bulldoze_hide = false;
force boxloader_tractor_bulldoze_ruins = false;
force boxloader_tractor_bulldoze_wall = false;

// CBA UI
cba_ui_notifyLifetime = 4;
cba_ui_StorePasswords = 1;

// CBA Weapons
cba_disposable_dropUsedLauncher = 2;
force cba_disposable_replaceDisposableLauncher = true;
cba_events_repetitionMode = 1;
cba_optics_usePipOptics = true;

// CUP
force CUP_Vehicles_PreventBarrelClip = false;

// F/A-18
force force js_jc_fa18_advancedStart = true;
js_jc_fa18_atflirRequire = false;
force force js_jc_fa18_canopyLoss = true;
js_jc_fa18_cursorSensitivity = 2.5;
js_jc_fa18_interactCursor = false;
js_jc_fa18_interactionRadiusMod = 1;
js_jc_fa18_showLabels = true;

// ITC Air
itc_air_drop_force = false;
itc_air_paveway_realism = false;

// ITC Land
ITC_LAND_CIWS = true;

// STUI Settings
STGI_Settings_Enabled = true;
STGI_Settings_UnconsciousFadeEnabled = true;
STHud_Settings_ColourBlindMode = "Normal";
STHud_Settings_Font = "PuristaSemibold";
STHud_Settings_HUDMode = 3;
STHud_Settings_Occlusion = true;
STHud_Settings_RemoveDeadViaProximity = true;
STHud_Settings_SquadBar = false;
STHud_Settings_TextShadow = 1;
STHud_Settings_UnconsciousFadeEnabled = true;

// TacSalmon Buttstroke
force Salmon_bs_ff = false;
force Salmon_bs_rd = true;

// VCOM SETTINGS
force VCM_ActivateAI = true;
force VCM_ADVANCEDMOVEMENT = true;
force VCM_AIDISTANCEVEHPATH = 100;
force VCM_AIMagLimit = 5;
force VCM_AISNIPERS = true;
force VCM_AISUPPRESS = true;
force VCM_ARTYDELAY = 30;
force VCM_ARTYENABLE = true;
force VCM_ARTYSIDES = [WEST,EAST,GUER];
force VCM_CARGOCHNG = true;
force VCM_ClassSteal = true;
force VCM_Debug = false;
force VCM_DISEMBARKRANGE = 200;
force Vcm_DrivingActivated = false;
force VCM_ForceSpeed = true;
force VCM_FRMCHANGE = true;
force VCM_HEARINGDISTANCE = 1200;
force VCM_MINECHANCE = 75;
force Vcm_PlayerAISkills = true;
force VCM_RAGDOLL = true;
force VCM_RAGDOLLCHC = 50;
force VCM_SIDEENABLED = [WEST,EAST,GUER];
force VCM_SKILLCHANGE = true;
force VCM_STATICARMT = 300;
force VCM_StealVeh = true;
force VCM_TURRETUNLOAD = true;
force VCM_USECBASETTINGS = true;
force VCM_WARNDELAY = 30;
force VCM_WARNDIST = 1000;

// VET_Unflipping
force vet_unflipping_require_serviceVehicle = false;
force vet_unflipping_require_toolkit = false;
force vet_unflipping_time = 5;
force vet_unflipping_unit_man_limit = 7;
force vet_unflipping_unit_mass_limit = 3000;
force vet_unflipping_vehicle_mass_limit = 100000;
