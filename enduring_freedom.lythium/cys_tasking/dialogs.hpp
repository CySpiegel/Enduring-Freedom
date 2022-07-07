class cys_tasking
{
  idd = 9999;
  moveingEnabled = false;

  class controls
  {
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT START (by Spiegel, v1.063, #Gamotu)
    ////////////////////////////////////////////////////////

    class cys_rscFrame_box : RscFrame
    {
      idc = 1800;
      style = 128;

      x = 0.244062 * safezoneW + safezoneX;
      y = 0.164 * safezoneH + safezoneY;
      w = 0.511875 * safezoneW;
      h = 0.672 * safezoneH;
      colorBackground[] = { 0,0,0,0.8 };
    };
    class cys_rscPicture_titlePic : RscPicture
    {
      idc = 1200;

      text = "cys_tasking\images\ts_sat_4.jpg";
      x = 0.257187 * safezoneW + safezoneX;
      y = 0.206 * safezoneH + safezoneY;
      w = 0.242812 * safezoneW;
      h = 0.252 * safezoneH;
    };
    class cys_rscStext_info : RscStructuredText
    {
      idc = 5555;

      text = "Air Strike Operations: The missions in this catagory are designed to be attacked by aircraft.<br/>Combat Operations: designed for combined arms combat, 10+ players needed.<br/>Support Operations: small group missions designed for supporting troops.<br/>Aid Operations: deliver aid to civilian towns to lower hostilities."; //--- ToDo: Localize;
      x = 0.257187 * safezoneW + safezoneX;
      y = 0.472 * safezoneH + safezoneY;
      w = 0.485625 * safezoneW;
      h = 0.238 * safezoneH;
    };
    class cys_rscStext_help : RscStructuredText
    {
      idc = 1104;

      text = "Select a mission type from the buttons on the right, then click the request mission button below."; //--- ToDo: Localize;
      x = 0.513125 * safezoneW + safezoneX;
      y = 0.22 * safezoneH + safezoneY;
      w = 0.105 * safezoneW;
      h = 0.21 * safezoneH;
      colorBackground[] = { 0,0,0,0 };
    };
    class cys_rscButton_combatOps : RscButton
    {
      idc = 1601;
      
      text = "Combat Operations"; //--- ToDo: Localize;
      x = 0.637812 * safezoneW + safezoneX;
      y = 0.276 * safezoneH + safezoneY;
      w = 0.105 * safezoneW;
      h = 0.042 * safezoneH;
      action = "ctrlSetText[1200, ""cys_tasking\images\combatOps.paa""], taskSelection = 1, (findDisplay 9999 displayCtrl 5555) ctrlSetStructuredText parseText ""words and stuff""";
    };
    class cys_rscButton_supportOps : RscButton
    {
      idc = 1602;

      text = "Support Operations"; //--- ToDo: Localize;
      x = 0.637812 * safezoneW + safezoneX;
      y = 0.346 * safezoneH + safezoneY;
      w = 0.105 * safezoneW;
      h = 0.042 * safezoneH;
      action = "taskSelection = 2";
    };
    class cys_rscButton_airOps : RscButton
    {
      idc = 1600;

      text = "Air Strike Operations"; //--- ToDo: Localize;
      x = 0.637812 * safezoneW + safezoneX;
      y = 0.206 * safezoneH + safezoneY;
      w = 0.105 * safezoneW;
      h = 0.042 * safezoneH;
      action = "ctrlSetText[1200, ""cys_tasking\images\airOps.paa""], taskSelection = 0";
    };
    class cys_rscButton_close : RscButton
    {
      idc = 1603;
      action = "closeDialog 0";

      text = "Close"; //--- ToDo: Localize;
      x = 0.644375 * safezoneW + safezoneX;
      y = 0.766 * safezoneH + safezoneY;
      w = 0.0984375 * safezoneW;
      h = 0.042 * safezoneH;
    };
    class cys_rscButton_request : RscButton
    {
      idc = 1604;

      text = "Request Operation"; //--- ToDo: Localize;
      x = 0.532812 * safezoneW + safezoneX;
      y = 0.766 * safezoneH + safezoneY;
      w = 0.0984375 * safezoneW;
      h = 0.042 * safezoneH;
      action = "closeDialog 0, [[[taskSelection],'cys_tasking\selection.sqf'],'BIS_fnc_execVM',false] call BIS_fnc_MP;"
    };
    class cys_rscStext_headder : RscStructuredText
    {
      idc = 1101;

      text = "MISSION SELECTION"; //--- ToDo: Localize;
      x = 0.244062 * safezoneW + safezoneX;
      y = 0.164 * safezoneH + safezoneY;
      w = 0.511875 * safezoneW;
      h = 0.028 * safezoneH;
      colorBackground[] = { 1,0.16,0,0.8 };
    };
    class cys_rcsButton_aidOps : RscButton
    {
      idc = 1602;

      text = "Aid Operations"; //--- ToDo: Localize;
      x = 0.637812 * safezoneW + safezoneX;
      y = 0.416 * safezoneH + safezoneY;
      w = 0.105 * safezoneW;
      h = 0.042 * safezoneH;
      action = "taskSelection = 3";
    };
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT END
    ////////////////////////////////////////////////////////

  };
};