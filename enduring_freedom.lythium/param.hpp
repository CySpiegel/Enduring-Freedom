class Params {
	class Daytime
	{
		title = "Mission Start Time";
		texts[] = {"Morning","Day","Evening","Night"};
		values[] = {6,12,18,0};
		default = 6;
		function = "BIS_fnc_paramDaytime";
	};
	class cys_budget_group {
		title = "Budget System Settings";
		texts[] = {""};
		values[] = {1};
		default = 0;
	};
	class cys_budget_start {
		title = "			Initial Budget";
		texts[] = {"0", "100","500","1000","5000","10000","50000"};
		values[] = {1,100,500,1000,5000,10000,50000};
		default = 10000;
	};
	class cys_vechile_cost {
		title = "			Vehicle Cost";
		texts[] = {"100","200","300","400","500","1000"};
		values[] = {100,200,300,400,500,1000};
		default = 100;
	};
	class cys_vechile_refund_allowed {
		title = "			Allowed Vehicle Refund Worth";
		texts[] = {"100","200","300","400","500","1000"};
		values[] = {100,200,300,400,500,1000};
		default = 100;
	};
	class cys_vechile_refund_scrap {
		title = "			Scrap Vehicle Worth (Vehicles not in approved refund list)";
		texts[] = {"100","200","300","400","500","1000"};
		values[] = {100,200,300,400,500,1000};
		default = 100;
	};

	class cys_playerCap_systems {
		title = "Player Cap Setting, if player server population goes above player cap that service is shut off";
		texts[] = {""};
		values[] = {1};
		default = 0;
	};
	class cys_brs_limit {
		title = "			Battlefield Respawn System";
		texts[] = {"Disabled","5 Players","10 Players", "15 Players", "20 Players", "No Player Cap"};
		values[] = {0,5,10,15,20,100};
		default = 15;
	};
	class cys_ai_recruitment {
		title = "			AI Recruitment";
		texts[] = {"Disabeld","5 Players","10 Players", "15 Players", "20 Players", "No Player Cap"};
		values[] = {0,5,10,15,20,100};
		default = 5;
	};
	class cys_guilt_chance {
		title = "Guilt & Remembrance Mission Probability";
		texts[] = {"Disabeld","10%","20%", "30%", "40%", "50%","60%","70%", "80%", "90%", "100%"};
		values[] = {0,10,20,30,40,50,60,70,80,90,100};
		default = 30;
	};
};