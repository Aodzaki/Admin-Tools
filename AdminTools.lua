script_author('Kincsmen') 
script_name("moonloader-script-updater-AdminTools")
script_version("17.08.2024") | 
require 'lib.moonloader'
local imgui = require 'imgui'
local encoding = require "encoding"
local memory = require 'memory'
local ffi = require 'ffi'
local imguiad = require 'lib.imgui_addons'
local samp = require 'lib.samp.events'
local rkeys = require 'lib.rkeys'
local inicfg = require 'inicfg'
local GK = require 'game.keys'
local vkeys = require 'vkeys'
local dlstatus = require('moonloader').download_status
local Matrix3X3 = require "matrix3x3"
local Vector3D = require "vector3d"
local fa = require 'fAwesome5' 
encoding.default = 'CP1251'
u8 = encoding.UTF8   

local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Р С›Р В±Р Р…Р В°РЎР‚РЎС“Р В¶Р ВµР Р…Р С• Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ. Р СџРЎвЂ№РЎвЂљР В°РЎР‹РЎРѓРЎРЉ Р С•Р В±Р Р…Р С•Р Р†Р С‘РЎвЂљРЎРЉРЎРѓРЎРЏ c '..thisScript().version..' Р Р…Р В° '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Р вЂ”Р В°Р С–РЎР‚РЎС“Р В¶Р ВµР Р…Р С• %d Р С‘Р В· %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Р вЂ”Р В°Р С–РЎР‚РЎС“Р В·Р С”Р В° Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘РЎРЏ Р В·Р В°Р Р†Р ВµРЎР‚РЎв‚¬Р ВµР Р…Р В°.')sampAddChatMessage(b..'Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р В·Р В°Р Р†Р ВµРЎР‚РЎв‚¬Р ВµР Р…Р С•!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р С—РЎР‚Р С•РЎв‚¬Р В»Р С• Р Р…Р ВµРЎС“Р Т‘Р В°РЎвЂЎР Р…Р С•. Р вЂ”Р В°Р С—РЎС“РЎРѓР С”Р В°РЎР‹ РЎС“РЎРѓРЎвЂљР В°РЎР‚Р ВµР Р†РЎв‚¬РЎС“РЎР‹ Р Р†Р ВµРЎР‚РЎРѓР С‘РЎР‹..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Р С›Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ Р Р…Р Вµ РЎвЂљРЎР‚Р ВµР В±РЎС“Р ВµРЎвЂљРЎРѓРЎРЏ.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Р СњР Вµ Р СР С•Р С–РЎС“ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚Р С‘РЎвЂљРЎРЉ Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘Р Вµ. Р РЋР СР С‘РЎР‚Р С‘РЎвЂљР ВµРЎРѓРЎРЉ Р С‘Р В»Р С‘ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚РЎРЉРЎвЂљР Вµ РЎРѓР В°Р СР С•РЎРѓРЎвЂљР С•РЎРЏРЎвЂљР ВµР В»РЎРЉР Р…Р С• Р Р…Р В° '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, Р Р†РЎвЂ№РЎвЂ¦Р С•Р Т‘Р С‘Р С Р С‘Р В· Р С•Р В¶Р С‘Р Т‘Р В°Р Р…Р С‘РЎРЏ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚Р С”Р С‘ Р С•Р В±Р Р…Р С•Р Р†Р В»Р ВµР Р…Р С‘РЎРЏ. Р РЋР СР С‘РЎР‚Р С‘РЎвЂљР ВµРЎРѓРЎРЉ Р С‘Р В»Р С‘ Р С—РЎР‚Р С•Р Р†Р ВµРЎР‚РЎРЉРЎвЂљР Вµ РЎРѓР В°Р СР С•РЎРѓРЎвЂљР С•РЎРЏРЎвЂљР ВµР В»РЎРЉР Р…Р С• Р Р…Р В° '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://github.com/Aodzaki/Admin-Tools/raw/main/AdminTools.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/Aodzaki/Admin-Tools"
        end
    end
end 

ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]

local tCarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}

local tCarsTypeName = {"Авто", "Мото", "Вертоліт", "Літак", "Прицеп", "Човен", "Інше", "Поїзд", "Велосипед"}

local tCarsSpeed = {43, 40, 51, 30, 36, 45, 30, 41, 27, 43, 36, 61, 46, 30, 29, 53, 42, 30, 32, 41, 40, 42, 38, 27, 37,
54, 48, 45, 43, 55, 51, 36, 26, 30, 46, 0, 41, 43, 39, 46, 37, 21, 38, 35, 30, 45, 60, 35, 30, 52, 0, 53, 43, 16, 33, 43,
29, 26, 43, 37, 48, 43, 30, 29, 14, 13, 40, 39, 40, 34, 43, 30, 34, 29, 41, 48, 69, 51, 32, 38, 51, 20, 43, 34, 18, 27,
17, 47, 40, 38, 43, 41, 39, 49, 59, 49, 45, 48, 29, 34, 39, 8, 58, 59, 48, 38, 49, 46, 29, 21, 27, 40, 36, 45, 33, 39, 43,
43, 45, 75, 75, 43, 48, 41, 36, 44, 43, 41, 48, 41, 16, 19, 30, 46, 46, 43, 47, -1, -1, 27, 41, 56, 45, 41, 41, 40, 41,
39, 37, 42, 40, 43, 33, 64, 39, 43, 30, 30, 43, 49, 46, 42, 49, 39, 24, 45, 44, 49, 40, -1, -1, 25, 22, 30, 30, 43, 43, 75,
36, 43, 42, 42, 37, 23, 0, 42, 38, 45, 29, 45, 0, 0, 75, 52, 17, 32, 48, 48, 48, 44, 41, 30, 47, 47, 40, 41, 0, 0, 0, 29, 0, 0
}

local tCarsType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1,
3, 1, 1, 1, 1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 6, 3, 2, 8, 5, 1, 6, 6, 6, 1,
1, 1, 1, 1, 4, 2, 2, 2, 7, 7, 1, 1, 2, 3, 1, 7, 6, 6, 1, 1, 4, 1, 1, 1, 1, 9, 1, 1, 6, 1,
1, 3, 3, 1, 1, 1, 1, 6, 1, 1, 1, 3, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 9, 9, 4, 4, 4, 1, 1, 1,
1, 1, 4, 4, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 1, 1,
1, 3, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 4,
1, 1, 1, 2, 1, 1, 5, 1, 2, 1, 1, 1, 7, 5, 4, 4, 7, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5
}

local quitReason = {
	"Виліт / краш",
	"Вийшов з гри",
	"Кік / бан"
}

local adminOnlineOffline = {
    u8"Онлайн",
    u8"Оффлайн"
}

local fdCommandsPlayer = {
	[1] = u8'/gzcolor',
	[2] = u8'/ghetto',
	[3] = u8'/makeleader',
	[4] = u8'/offleader',
	[5] = u8'/makeadmin',
	[6] = u8'/avig',
	[7] = u8'/aunvig',
	[8] = u8'/banip',
	[9] = u8'/makehelper',
	[10] = u8'/offhelper'
}

local changedStatis = {
    [1] = u8'[1] Уровень',
	[2] = u8'[2] Законка',
	[3] = u8'[3] Маты',
	[4] = u8'[4] Скин',
	[5] = u8'[5] Убийств',
	[6] = u8'[6] Номер',
	[7] = u8'[7] Exp',
	[8] = u8'[8] Ключ',
	[9] = u8'[9] Номер бизнеса',
	[10] = u8'[10] VIP [1-3]',
	[11] = u8'[11] Работа',
	[12] = u8'[12] Аптечки',
	[13] = u8'[13] Деньги в банке',
	[14] = u8'[14] Мобильный',
	[15] = u8'[15] Деньги',
	[16] = u8'[16] Варны',
	[17] = u8'[17] Аптечки',
	[18] = u8'[18] Член орг.',
	[19] = u8'[19] Скилл бокса',
	[20] = u8'[20] Время бокса',
	[21] = u8'[21] Бокс',
	[22] = u8'[22] Кунг-фу',
	[23] = u8'[23] КикБокс',
	[24] = u8'[24] Уважение',
	[25] = u8'[25] Бег',
	[26] = u8'[26] Машина',
	[27] = u8'[27] Машина[2]',
	[28] = u8'[28] Машина[3]',
	[29] = u8'[29] Машина[4]',
	[30] = u8'[30] Машина[5]',
	[31] = u8'[31] НаркЗавис',
	[32] = u8'[32] Фрак.Скин',
	[33] = u8'[33] Муж/Жена',
	[34] = u8'[34] Процы',
	[35] = u8'[35] Время банка',
	[36] = u8'[36] Доступ к /ban',
	[37] = u8'[37] Доступ к /warn' 
}

local rInfo = {
	state = false,
    id = -1,
    nickname = ''
}

local arrGuns = {
	[1] = 'Fist[0]',
	[2] = 'Brass knuckles[1]',
	[3] = 'Hockey stick[2]',
	[4] = 'Club[3]',
	[5] = 'Knife[4]',
	[6] = 'Bat[5]',
	[7] = 'Shovel[6]',
	[8] = 'Cue[7]',
	[9] = 'Katana[8]',
	[10] = 'Chainsaw[9]',
	[11] = 'Dildo[10]',
	[12] = 'Dildo[11]',
	[13] = 'Dildo[12]',
	[14] = 'Dildo[13]',
	[15] = 'Bouquet[14]',
	[16] = 'Cane[15]',
	[17] = 'Grenade[16]',
	[18] = 'Gas[17]',
	[19] = 'Molotov cocktail[18]',
	[20] = 'Unknown',
	[21] = 'Unknown',
	[22] = 'Unknown',
	[23] = '9MM[22]',
	[24] = '9mm with silencer[23]',
	[25] = 'Desert Eagle[24]',
	[26] = 'Shotgun[25]',
	[27] = 'Sawed-off[26]',
	[28] = 'Fast Shotgun[27]',
	[29] = 'Uzi[28]',
	[30] = 'MP5[29]',
	[31] = 'AK-47[30]',			
	[32] = 'M4[31]',	
	[33] = 'Tec-9[32]',		
	[34] = 'Sniper rifle[33]',			
	[35] = 'Sniper rifle[34]',			
	[36] = 'RPG[35]',			
	[37] = 'RPG[36]',			
	[38] = 'Flamethrower[37]',			
	[39] = 'Minigun[38]',			
	[40] = 'TNT bag[39]',			
	[41] = 'Detonator[40]',			
	[42] = 'Spray can[41]',			
	[43] = 'Fire extinguisher[42]',			
	[44] = 'Camera[43]',		
	[45] = 'Thermal imager[44]',			
	[46] = 'Thermal imager[45]'	,		
	[47] = 'Parachute[46]'			
}
local admTable = [[  
    /invisible - Увімкнути/Вимкнути невидимку
    /gt - Відкрити головне меню скрипту
    /ot - Відкрити Авто-Репорт
    /re - Почати спостерігати за гравцем
    /reoff - Вийти з режиму спостерігача 
    /rmute - Видати мут репорту гравцю
    /mute - Видати мут чату гравцю
    /spawncars - Зареспавнити всі авто

]] 

local pensTable = [[
+++ АВТО:

Mercedes-AMG GT 63 S - 612
Mercedes-AMG G 63 - 613
BMW X5 M Competition - 662
Chevrolet Corvette Z06 - 663
Chevrolet Cruze - 665
Lexus LX570 - 666
Porsche 911 Turbo S - 667
Bentley Continental GT - 699
Mercedes-AMG E 63 S - 794
Volkswagen Touareg - 965
Dodge Challenger SRT Demon - 1196
Volvo V60 T6 - 1198
Lexus IS - 1201
Ford Mustang - 1202
Kia Optima - 1205
Mercedes-Benz S-Class - 3156
BMW X5 - 3157
Nissan Skyline GT-R R34 - 3158
Infiniti FX 50 - 3232
Volkswagen Golf R - 3235
Audi R8 - 3236
Toyota Camry - 3237
BMW M5 E60 - 3239
BMW M5 F90 - 3240
Mercedes-Benz Maybach S650 - 3245
Mercedes-AMG GT Spyder - 3247
Porsche Panamera Turbo GT - 3248
Volkswagen Passat - 3251
Chevrolet Camaro SS - 4543
Mazda RX7 - 4544
Bentley Bentayga - 4777
BMW I8 - 4779
Honda Integra Type R - 4781
Ford F150 Raptor - 4784
Ferrari J50 - 4785
Porsche Taycan Turbo S - 4789
Ferrari Enzo - 4790
Mercedes-Benz X-Class - 4793
Dodge Caravan Ambulance - 4796
Ford Ranger Ambulance - 4798
Lamborghini Aventador Police - 4802
Ferrari F12 Berlinetta Police - 4803
Audi A6 - 6604
Audi Q7 - 6605
BMW M6 - 6606
Mercedes-AMG CLS 63 S - 6609
Toyota Land Cruiser Prado VXR - 6611
Porsche Macan Turbo - 6613
Daewoo Matiz - 6614
Toyota Supra - 6623
Bugatti Veyron - 6673
Mercedes-AMG GT R - 6683
Hummer H2 - 6684
Mercedes-AMG GT R - 6686
Lamborghini Huracan Tecnica - 6714
Toyota Supra MK4 - 6744
Ducati Diavel Carbon - 12713
Ducati Monster Naked - 12714
Kawasaki Ninja ZX-10RR - 12715
Harley-Davidson Fat Boy 114 - 12716
Rolls-Royce Cullinan - 12717
Volkswagen Beetle - 12718
Tesla Model S Turbo - 12719
Bugatti Divo - 12720
Bugatti Chiron - 12721
FIAT 500 - 12722
Lamborghini Aventador SVJ - 12723
Tesla Model X - 12724
Nissan Leaf - 12725
Nissan Silvia S15 - 12726

+++ ПРЕДМЕТИ:
ID	Назва
1	Печериця
2	Зморшок
3	Лисичка
4	Білий гриб
5	Ніж
6	Акула
7	Риба-метелик
8	Риба-ангел
9	Риба-клоун
10	Адун
11	Зебрасома
12	Медуза
13	Використана банка
14	Старе взуття
15	Вудка
16	Наживка
17	Домкрат
18	Ремкомплект
19	Каністра
20	Акумулятор
21	Бинт
22	Аптечка
23	Медична маска
24	Відмичка
25	Букет квітів
26	Тростина
27	Лопата
28	Фотоапарат
29	Шоколадний мілкшейк
30	Карамельний чізкейк
31	Картопля фрі
32	Курячі ніжки в клярі
33	Мексиканське буріто
34	Подвійний чізбургер
35	Коктейль "Текіла Санрайз"
36	Пана-кота з малиною
37	Лазанья
38	Піца Пепероні
39	Стейк з лосося
40	Фланк стейк з овочами
41	Мохіто
42	Куба лібре
43	Блакитна лагуна
44	Піна колада
45	Маргарита
46	Космополітен
47-164	Одяг
165	Ділдо 1
166	Ділдо 2
167	Вібратор 1
168	Вібратор 2
169	Маска
170	Мотузка
171	Кольт з глушником
172	Дезерт Ігл
173	Дробовик
174	MP5
175	АК-47
176	M4
177	Патрон 9 мм
178	Патрон .45 ACP
179	Патрон 12 калібра
180	Патрон 5.56 мм
181	Бойовий дробовик
182	Micro UZI
183	Tec-9
184	Поліцейська дубинка
185	Бейсбольна бита
186	Катана
187	Бронежилет
188	Середній подарунок
189	Малий подарунок
190	Великий подарунок
191	Захисна каска
192	Похідний рюкзак
193	Військова форма
194	Матеріали
195	Наркотики
196	Насіння
197	Рюкзак "Pink Teddy"
198	Рюкзак "Pentagram Pack"
199	Вуха "Devil Ears"
200	Крила "Wings of Darkness"
201	Коса "Scythe of Darkness"
202	Сумка Louis Vuitton
203	Чорна шкіряна сумка
204	Рюкзак Gucci
]]

local timesTable = [[
Subaru Forester XT - 12727
Subaru Legacy - 12728
Tesla Model X Ambulance - 12729
Tesla Model S Ambulance - 12730
Mitsubishi Lancer Evo X - 12731
Lamborghini Murcielago - 12732
McLaren MP4 - 12736
Rolls-Royce Phantom - 12738
Nissan GT-R - 14124
Mercedes-AMG ONE - 14767
Chevrolet Aveo - 14769
Renault Duster - 14899
Ferrari Monza - 14904
Ferrari LaFerrari - 14908
Trek Top Fuel - 14914
BMC Teammachine - 14915
Trek Procaliber - 14916
BMC Roadmachine - 14917
Lamborghini Countach - 15099
Koenigsegg Gemera - 15101
Kia K7 - 15102
Mercedes-AMG A 45 - 15113
Toyota Trueno AE86 - 15114
Ford Mustang Mach-E - 15116
Audi R8 Spyder - 15118
Mercedes-Benz 1620 - 15326
Volkswagen Transporter - 15861
Mercedes-Benz Vito - 15862
Opel Vivaro - 15863
Mercedes-AMG C 63 - 15903
BMW X5 M F85 - 15906
Mercedes-AMG GLE 63 - 15908
Audi RS6 Quattro - 15910
Mercedes-AMG GT 63 S Brabus - 15960
Mercedes-AMG GLE 63 Brabus - 15961
Mercedes-Benz S500 Brabus - 16893
Ferrari 812 Mansory - 16894
Bentley Bentayga Mansory - 16895
Mercedes-AMG G 63 Brabus - 16896
Mercedes-AMG G 63 Mansory - 16897
Rolls-Royce Cullinan Mansory - 16899
Lamborghini Urus Mansory - 16900
Chevrolet Corvette Classic - 16951
Ferrari F40 - 16955
Chevrolet Tahoe - 16957
Toyota Tundra TRD Pro - 16959

+++ СКІНИ: 

kaineG - 312
koharu - 313
nyotenguut - 314
step - 315
rew - 316
wmen - 317
hoodieanime - 318
nike - 319
sara - 340
mikasa - 398
2bwaifu - 399
bal - 795
lobelia - 797
gang - 908
Ygao - 1206
jelitnyjj - 1326
Naotora - 1699
purpleh - 3136
Mila - 3137
shelby - 3138
Marshmello - 3139
Radmen - 3142
Judyal - 3143
korean - 3145
yukino - 3146
Random3 - 3148
HighLife - 3149
hika - 3154
tamaki - 3159
memka - 3161
thrman - 3162
boroda - 3163
kyrtka - 3164
wolos - 3165
skin5 - 3177
skin2 - 3179


171	Кольт з глушником
172	Дезерт Ігл
173	Дробовик
174	MP5
175	АК-47
176	M4
177	Патрон 9 мм
178	Патрон .45 ACP
179	Патрон 12 калібра
180	Патрон 5.56 мм
181	Бойовий дробовик
182	Micro UZI
183	Tec-9
184	Поліцейська дубинка
185	Бейсбольна бита
186	Катана
187	Бронежилет
188	Середній подарунок
189	Малий подарунок
190	Великий подарунок
191	Захисна каска
192	Похідний рюкзак
193	Військова форма
194	Матеріали
195	Наркотики
196	Насіння
197	Рюкзак "Pink Teddy"
198	Рюкзак "Pentagram Pack"
199	Вуха "Devil Ears"
200	Крила "Wings of Darkness"
201	Коса "Scythe of Darkness"
202	Сумка Louis Vuitton
203	Чорна шкіряна сумка
204	Рюкзак Gucci
]]

local tempLeaders = {
    [1] = u8'ЗМІ',
    [2] = u8'МОЗ',
    [3] = u8'МО',
    [4] = u8'МЮ',
    [5] = u8'Уряд',
    [6] = u8'Grove',
    [7] = u8'Ballas',
    [8] = u8'Vagos',
    [9] = u8'Aztecaz',
    [10] = u8'Cartel',
    [11] = u8'LCN',
    [12] = u8'Yakuza'
}

local colorsImGui = {u8"Синій", u8"Червоний", u8"Коричневий", u8"Пурпуровий", u8"Темно-червоний", u8"Салатовий"}

local allForms = {"kick", "mute", "dm", "unjail", "ban", "warn", "skick", "unban", "unwarn", "banip", "offban", "offwarn", "sban", 'iban', 'rmute', 'sp', 'spawn', 'ptp', 'money', 'setskin', 'sethp', 'makehelper', 'sethelper'}

local directory = getWorkingDirectory()..'\\config\\PlayersChecker.json'

if doesFileExist(directory) then
    local f = io.open(directory, "r")
    if f then
      playersList = decodeJson(f:read("a*"))
      f:close()
    end
else
    playersList = {
      [1] = 'Robert_Kincsmen'
    }
end

local allCarsP = {
    ["6614"] = "Matiz",
    ["12720"] = "Bugatti Divo",
    ["3157"] = "BMW X5",
    ["6606"] = "BMW M6",
    ["16955"] = "Ferrari F40",
    ["12715"] = "Kawasaki",
    ["4777"] = "Bently B.",
    ["6611"] = "Toyota LCP"
}

local allGunsP = {
    ["24"] = "Desert Eagle",
    ["31"] = "M4",
    ["30"] = "AK47",
    ["25"] = "Дробаш"
}

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
  end
  
  filename_settings = getWorkingDirectory().."\\config\\hotKeys.txt"
  
  local Luacfg = {
      _version = "9"
  }
  setmetatable(Luacfg, {
      __call = function(self)
          return self.__init()
      end
  })
  function Luacfg.__init()
      local self = {}
      local lfs = require "lfs"
      local inspect = require "inspect"
      
      
      function self.mkpath(filename)
          local sep, pStr = package.config:sub(1, 1), ""
          local path = filename:match("(.+"..sep..").+$") or filename
          for dir in path:gmatch("[^" .. sep .. "]+") do
              pStr = pStr .. dir .. sep
              lfs.mkdir(pStr)
          end
      end
      
      
      function self.load(filename, tbl)
          local file = io.open(filename, "r")		
          if file then 
              local text = file:read("*all")
              file:close()
              
              local lua_code = loadstring("return "..text)
              if lua_code then
                  loaded_tbl = lua_code()
                  
                  if type(loaded_tbl) == "table" then
                      for key, value in pairs(loaded_tbl) do
                          tbl[key] = value
                      end
                      return true
                  else
                      return false
                  end
              else
                  return false
              end
          else
              return false
          end
    end
      
      function self.save(filename, tbl)
          self.mkpath(filename)
          
          local file = io.open(filename, "w+")
          if file then
              file:write(inspect(tbl))
              file:close()
              return true
          else
              return false
          end
      end
      
    return self
end
  
luacfg = Luacfg()
cfg = {
    whEnabled = {vkeys.VK_F12},
    LeaveReconWindow = {vkeys.VK_M},
    openHomeWindow = {vkeys.VK_NUMPAD1},
    activeChatBubble = {vkeys.VK_NUMPAD2},
    openAutoReport = {vkeys.VK_NUMPAD3},
    enabledTracers = {vkeys.VK_NUMPAD4}
}

luacfg.load(filename_settings, cfg)
luacfg.save(filename_settings, cfg)

local ofHotkeys = {
    whEnabled = {v = deepcopy(cfg.whEnabled)},
    LeaveReconWindow = {v = deepcopy(cfg.LeaveReconWindow)},
    openHomeWindow = {v = deepcopy(cfg.openHomeWindow)},
    activeChatBubble = {v = deepcopy(cfg.activeChatBubble)},
    openAutoReport = {v = deepcopy(cfg.openAutoReport)},
    enabledTracers = {v = deepcopy(cfg.enabledTracers)}
}

local lastVisibleWorld = 0

local HLcfg = inicfg.load({
    config = {
        airBrake = true,
        speedHack = true,
        clickWarp = true,
        gmCar = true,
        noBike = true,
        autoCome = false,
        showKillerId = true,
        renderInfoCars = true,
        bulletTracer = true,
        leaveChecker = false,
        statistics = true,
        formsEnabled = true,
        fullDSuccesfuly = false,
        enableAutoReport = false,
        showMyBullets = true,
        invAdmin = false,
        enableCheckerPlayer = false,
        showAdminPassword = true,
        antiEjectCar = false,
        areportclick = false,
        autoReconnect = true,
        cbEndMy = true,
        cbEnd = true,
        infAmmo = false,
        printDvall = true,
        printSpawnCars = true,
        borderToFont = true,
        secondToCloseTwo = 5,
        timeOutForma = 10,
        intImGui = 0,
        widthRenderLineOne = 1,
        widthRenderLineTwo = 1,
        speed_airbrake = 1,
        intInfoCars = 30,
        sizeBuffer = 10,
        dayReports = 0,
        dayForms = 0,
        intGunCreate = 0,
        posX = 1000,
        posY = 800,
        limitPageSize = 13,
        posBubbleX = 10,
        posBubbleY = 250,
        posCheckerX = 500,
        posCheckerY = 500,
        maxPagesBubble = 500,
        secondToClose = 5,
        sizeOffPolygon = 1,
        sizeOffPolygonTwo = 1,
        polygonNumber = 1,
        polygonNumberTwo = 1,
        rotationPolygonOne = 10,
        rotationPolygonTwo = 10,
        maxMyLines = 50,
        maxNotMyLines = 50,
        carColor1 = 0,
        carColor2 = 0,
        intComboCar = 0,
        numberGunCreate = 0,
        staticObjectMy = 2905604013,
        dinamicObjectMy = 9013962961,
        pedPMy = 1862972872,
        carPMy = 6282572962,
        staticObject = 2905604013,
        dinamicObject = 9013962961,
        pedP = 1862972872,
        carP = 6282572962,
        adminPassword = "",
        fullDPassword = "",
        textFindAutoReport = "",
        answerAutoReport = ""
    },
    statAdmin = {
        showId = true,
        showPing = false,
        showHealth = true,
        showFormDay = false,
        showFormSession = false,
        showReportDay = false,
        showReportSession = false,
        showOnlineDay = true,
        showOnlineSession = true,
        showAfkDay = true,
        showAfkSession = true,
        showTime = true,
        centerText = true,
        showTopDate = true,
        showInterior = true,
        nameStatis = true
    },
    onDay = {
		today = os.date("%a"),
		online = 0,
		afk = 0,
		full = 0
	}
}, "AdminTools.ini")
inicfg.save(HLcfg, "AdminTools.ini")

local elements = {
    checkbox = {
        enableCheckerPlayer = imgui.ImBool(HLcfg.config.enableCheckerPlayer),
        formsEnabled = imgui.ImBool(HLcfg.config.formsEnabled),
        airBrake = imgui.ImBool(HLcfg.config.airBrake),
        speedHack = imgui.ImBool(HLcfg.config.speedHack),
        clickWarp = imgui.ImBool(HLcfg.config.clickWarp),
        gmCar = imgui.ImBool(HLcfg.config.gmCar),
        noBike = imgui.ImBool(HLcfg.config.noBike),
        autoCome = imgui.ImBool(HLcfg.config.autoCome),
        showKillerId = imgui.ImBool(HLcfg.config.showKillerId),
        renderInfoCars = imgui.ImBool(HLcfg.config.renderInfoCars),
        leaveChecker = imgui.ImBool(HLcfg.config.leaveChecker),
        statistics = imgui.ImBool(HLcfg.config.statistics),
        bulletTracer = imgui.ImBool(HLcfg.config.bulletTracer),
        fullDSuccesfuly = imgui.ImBool(HLcfg.config.fullDSuccesfuly),
        enableAutoReport = imgui.ImBool(HLcfg.config.enableAutoReport),
        showMyBullets = imgui.ImBool(HLcfg.config.showMyBullets),
        showAdminPassword = imgui.ImBool(HLcfg.config.showAdminPassword),
        antiEjectCar = imgui.ImBool(HLcfg.config.antiEjectCar),
        areportclick = imgui.ImBool(HLcfg.config.areportclick),
        autoReconnect = imgui.ImBool(HLcfg.config.autoReconnect),
        cbEndMy = imgui.ImBool(HLcfg.config.cbEndMy),
        cbEnd = imgui.ImBool(HLcfg.config.cbEnd),
        infAmmo = imgui.ImBool(HLcfg.config.infAmmo),
        printDvall = imgui.ImBool(HLcfg.config.printDvall),
        printSpawnCars = imgui.ImBool(HLcfg.config.printSpawnCars),
        borderToFont = imgui.ImBool(HLcfg.config.borderToFont)
    },
    int = {
        intImGui = imgui.ImInt(HLcfg.config.intImGui),
        intInfoCars = imgui.ImInt(HLcfg.config.intInfoCars),
        sizeBuffer = imgui.ImInt(HLcfg.config.sizeBuffer),
        timeOutForma = imgui.ImInt(HLcfg.config.timeOutForma),
        limitPageSize = imgui.ImInt(HLcfg.config.limitPageSize),
        maxPagesBubble = imgui.ImInt(HLcfg.config.maxPagesBubble),
        secondToClose = imgui.ImInt(HLcfg.config.secondToClose),
        secondToCloseTwo = imgui.ImInt(HLcfg.config.secondToCloseTwo),
        widthRenderLineOne = imgui.ImInt(HLcfg.config.widthRenderLineOne),
        widthRenderLineTwo = imgui.ImInt(HLcfg.config.widthRenderLineTwo),
        sizeOffPolygon = imgui.ImInt(HLcfg.config.sizeOffPolygon),
        sizeOffPolygonTwo = imgui.ImInt(HLcfg.config.sizeOffPolygonTwo),
        polygonNumber = imgui.ImInt(HLcfg.config.polygonNumber),
        polygonNumberTwo = imgui.ImInt(HLcfg.config.polygonNumberTwo),
        rotationPolygonOne = imgui.ImInt(HLcfg.config.rotationPolygonOne),
        rotationPolygonTwo = imgui.ImInt(HLcfg.config.rotationPolygonTwo),
        maxMyLines = imgui.ImInt(HLcfg.config.maxMyLines),
        maxNotMyLines = imgui.ImInt(HLcfg.config.maxNotMyLines)
    },
    input = {
        adminPassword = imgui.ImBuffer(tostring(HLcfg.config.adminPassword), 50),
        fullDPassword = imgui.ImBuffer(tostring(HLcfg.config.fullDPassword), 7),
        textFindAutoReport = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport), 256),
        answerAutoReport = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport), 256)
    },
    putStatis = {
        nameStatis = imgui.ImBool(HLcfg.statAdmin.nameStatis),
        showId = imgui.ImBool(HLcfg.statAdmin.showId),
        showPing = imgui.ImBool(HLcfg.statAdmin.showPing),
        showHealth = imgui.ImBool(HLcfg.statAdmin.showHealth),
        showFormDay = imgui.ImBool(HLcfg.statAdmin.showFormDay),
        showFormSession = imgui.ImBool(HLcfg.statAdmin.showFormSession),
        showReportDay = imgui.ImBool(HLcfg.statAdmin.showReportDay),
        showReportSession = imgui.ImBool(HLcfg.statAdmin.showReportSession),
        showOnlineDay = imgui.ImBool(HLcfg.statAdmin.showOnlineDay),
        showOnlineSession = imgui.ImBool(HLcfg.statAdmin.showOnlineSession),
        showAfkDay = imgui.ImBool(HLcfg.statAdmin.showAfkDay),
        showAfkSession = imgui.ImBool(HLcfg.statAdmin.showAfkSession),
        showTime = imgui.ImBool(HLcfg.statAdmin.showTime),
        centerText = imgui.ImBool(HLcfg.statAdmin.centerText),
        showTopDate = imgui.ImBool(HLcfg.statAdmin.showTopDate),
        showInterior = imgui.ImBool(HLcfg.statAdmin.showInterior)
    }
}

local ex, ey = getScreenResolution()
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
local font_flag = require('moonloader').font_flag
if elements.checkbox.borderToFont.v then
    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
else
    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
end

local nowTime = os.date("%H:%M:%S", os.time())
local dayFull = imgui.ImInt(HLcfg.onDay.full)
local AdminTools = imgui.ImBool(false)
local tableOfNew = {
    tableRes = imgui.ImBool(false),
    tempLeader = imgui.ImBool(false),
    AutoReport = imgui.ImBool(false),
    commandsAdmins = imgui.ImBool(false),
    addInBuffer = imgui.ImBuffer(128),
    carColor1 = imgui.ImInt(HLcfg.config.carColor1),
    carColor2 = imgui.ImInt(HLcfg.config.carColor2),
    givehp = imgui.ImInt(100),
    selectGun = imgui.ImInt(0),
    numberGunCreate = imgui.ImInt(HLcfg.config.numberGunCreate),
    intComboCar = imgui.ImInt(HLcfg.config.intComboCar),
    findText = imgui.ImBuffer(256),
    intChangedStatis = imgui.ImInt(0),
    inputIntChangedStatis = imgui.ImBuffer(10),
    answer_report = imgui.ImBuffer(526),
    inputAmmoBullets = imgui.ImBuffer(5),
    fdOnlinePlayer = imgui.ImInt(0),
    inputAdminId = imgui.ImBuffer(4)
}
-- int 
local sessionOnline = imgui.ImInt(0)
local sessionAfk = imgui.ImInt(0)
local sessionFull = imgui.ImInt(0)
local numberAmmo = imgui.ImInt(999)
local fdGiveCommand = imgui.ImInt(0)
--int
--buffer
local inputAdminNick = imgui.ImBuffer(50)
local inputIdChangedStatis = imgui.ImBuffer(4)
--buffer

local LsessionForma = 0
local LsessionReport = 0
local menuSelect = 0
local stColor = 0xFFFF0000
local active_forma = false
local allNotTrueBool = false
local stop_forma = false
local changePosition = false
local boolEnabled = false
local ainvisible = false
local pageState = false
local wh = false
local checkerCoords = false
local infoCar = {
    pcar = {
        idLastCar = -1
    }
}
local playersNotCheck = {}
local reports = {
    [0] = {
        nickname = '',
        id = -1,
        textP = ''
    }
}
local addBuffer = {}
local addBox    = {}
local addDelay  = {}
local tLastKeys = {}
local answer_flets = {}
local nickReport, idReport, otherReport = "", "", ""

local blacklist = {
	'SMS',
    'AFK',
    'На паузе:'
}

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

local bulletSyncMy = {lastId = 0, maxLines = elements.int.maxMyLines.v}
for i = 1, bulletSyncMy.maxLines do
    bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
end

local bulletSync = {lastId = 0, maxLines = elements.int.maxNotMyLines.v}
for i = 1, bulletSync.maxLines do
    bulletSync[i] = {other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
end

function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

local staticObject = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.staticObject) ):GetFloat4() )    
local dinamicObject = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.dinamicObject) ):GetFloat4() )   
local pedP = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.pedP) ):GetFloat4() )   
local carP = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.carP) ):GetFloat4() ) 
local staticObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.staticObjectMy) ):GetFloat4() )    
local dinamicObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.dinamicObjectMy) ):GetFloat4() )   
local pedPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.pedPMy) ):GetFloat4() )   
local carPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.carPMy) ):GetFloat4() )  

function main()
    while not isSampAvailable() do wait(100) end 
    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Скрипт був успішно завантажений.', stColor)
    repeat
        wait(0)
    until sampIsLocalPlayerSpawned()
    fixChatCoursor()
    if not doesDirectoryExist(isDirrectory) then
        createDirectory(isDirrectory)
    end
    lua_thread.create(time)
    lua_thread.create(autoSave) 
    if HLcfg.onDay.today ~= os.date("%a") then 
		HLcfg.onDay.today = os.date("%a")
		HLcfg.onDay.online = 0
        HLcfg.onDay.full = 0
		HLcfg.onDay.afk = 0
		HLcfg.config.dayReports = 0
		HLcfg.config.dayForms = 0
	  	dayFull.v = 0
		save()
    end
    BindenabledTracers = rkeys.registerHotKey(ofHotkeys.enabledTracers.v, 1, false, function()
        if not sampIsChatInputActive() and not sampIsDialogActive() then 
            elements.checkbox.bulletTracer.v = not elements.checkbox.bulletTracer.v
            HLcfg.config.bulletTracer = elements.checkbox.bulletTracer.v
            save()
        end
    end)
    BindopenAutoReport = rkeys.registerHotKey(ofHotkeys.openAutoReport.v, 1, false, function()
        if not sampIsChatInputActive() and not sampIsDialogActive() then 
            tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
        end
    end)
    BindLeaveReconWindow = rkeys.registerHotKey(ofHotkeys.LeaveReconWindow.v, 1, false, function()
		if not sampIsChatInputActive() and not sampIsDialogActive() and not AdminTools.v and not tableOfNew.AutoReport.v and rInfo.state and rInfo.id ~= -1 then
			sampSendChat('/reoff')
            rInfo.id = -1
            rInfo.state = false
		end
    end)
    BindwhEnabled = rkeys.registerHotKey(ofHotkeys.whEnabled.v, 1, false, function()
		if not sampIsChatInputActive() and not sampIsDialogActive() then
			wh = not wh
			if wh then
				printStyledString('WH Enabled', 1000, 4)
				nameTagOn()
			else
				printStyledString('WH Disabled', 1000, 4)
				nameTagOff()
			end
		end
    end)
    BindopenHomeWindow = rkeys.registerHotKey(ofHotkeys.openHomeWindow.v, 1, false, function()
		if not sampIsChatInputActive() and not sampIsDialogActive() then
			AdminTools.v = not AdminTools.v
		end
    end)
    BindactiveChatBubble = rkeys.registerHotKey(ofHotkeys.activeChatBubble.v, 1, false, function()
        if not sampIsChatInputActive() and not sampIsDialogActive() then
            bubbleBox:toggle(not bubbleBox.active)
        end
    end)
    sampRegisterChatCommand('invisible', function()
        ainvisible = not ainvisible
        sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Невидимка '..(ainvisible and 'увімкнена' or 'вимкнена'), stColor)
    end)  
    sampRegisterChatCommand('gt', function()
        AdminTools.v = not AdminTools.v
    end)
    sampRegisterChatCommand('ot', function()
        tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
    end)
    sampRegisterChatCommand('reoff', function()
		sampSendChat('/reoff')
	end)
    sampRegisterChatCommand('unrmute', function(id)
        if id ~= '' then
            if id:find('%d+') then
                sampSendChat('/rmute '..id..' 0 0')
            else
                sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви вказали некоректний [ID]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви не ввели [ID]', stColor)
        end
    end)
    sampRegisterChatCommand('unmute', function(id)
        if id ~= '' then
            if id:find('%d+') then
                sampSendChat('/mute '..id..' 0 0')
            else
                sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви вказали некоректний [ID]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви не ввели [ID]', stColor)
        end
    end)    
    sampRegisterChatCommand('spawncars', function(value)
        if value ~= '' then
            if value:find('%d+') then
                local value = tonumber(value)
                if value == 0 then
                    sampSendChat('/spawncars')
                end
                if value > 9 and value < 61 then
                    lua_thread.create(function()
                        if elements.checkbox.printSpawnCars.v then
                            isSpawnerFor(value)
                        end
                        sampSendChat(string.format('/o [SPAWNCARS] Доброго часу доби, через %s секунд будуть спати все незайняте т/з.', value))
                        wait(1000)
                        sampSendChat('/o [SPAWNCARS] Переконливе прохання, якщо вам потрібна ваша машина, сядьте в неї і чекайте...')
                        wait(1000)
                        sampSendChat('/o [SPAWNCARS] Закінчення спавна, інакше вона пропаде.')
                        wait(value*1000)
                        sampSendChat('/spawncars')
                        wait(1000)
                        sampSendChat('/o [SPAWNCARS] Всі незайняті машини були засповнені, приємної гри!')
                    end)
                else
                    sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Секунди не можуть бути меншими за 10 і більше 60.', stColor)
                end
            else
                sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви ввели некоректне значення.', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви не запровадили секунди.', stColor)
        end
    end)
    setPlayerNeverGetsTired(playerHandle, true)
    kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
    pm_timer = os.clock()
    bubbleBox = ChatBox(elements.int.limitPageSize.v, blacklist)
    while true do
		if bubbleBox.active then
			bubbleBox:draw(HLcfg.config.posBubbleX, HLcfg.config.posBubbleY)
			if is_key_check_available() and isKeyDown(VK_B) then
				if getMousewheelDelta() ~= 0 then
					bubbleBox:scroll(getMousewheelDelta() * -1)
				end
			end
		end
        if #answer_flets > 0 and os.clock() - pm_timer > 1 then
            pm_timer = os.clock()
            sampSendChat(answer_flets[1])
            table.remove(answer_flets, 1)
        end
        wait(0)
        imgui.Process = true
        if not AdminTools.v and rInfo.id == -1 and not changePosition and not tableOfNew.AutoReport.v then
            imgui.ShowCursor = false
        end
        if not AdminTools.v then
            tableOfNew.tempLeader.v = false
            tableOfNew.tableRes.v = false
            tableOfNew.commandsAdmins.v = false
        end
        local createId = sampGetPlayerIdByNickname('Robert_Kincsmen')
        if createId then
            local my_cords = {getCharCoordinates(playerPed)}
            local result, handle = sampGetCharHandleBySampPlayerId(createId)
            if result then
                local this_cords = {getCharCoordinates(handle)}
                if isCharOnScreen(handle) then
                    if getDistanceBetweenCoords3d(my_cords[1], my_cords[2], my_cords[3], this_cords[1], this_cords[2], this_cords[3]) < 30 then 
                        local wX, wY = convert3DCoordsToScreen(this_cords[1], this_cords[2], this_cords[3])
                        renderFontDrawText(font, 'Creator GhostTools', wX, wY, 0xFFFF8C00, true)
                    end 
                end 
            end
        end 
        isPos()
        if elements.checkbox.autoReconnect.v then
            if sampGetChatString(99) == "Server closed the connection." or sampGetChatString(99) == "You are banned from this server." then
				cleanStreamMemory()
				sampDisconnectWithReason(quit)
				wait(1000)
				sampSetGamestate(1)
			end
        end
        if elements.checkbox.clickWarp.v then
            while isPauseMenuActive() do
                if cursorEnabled then
                    showCursor(false)
                end
                wait(100)
            end
            if isKeyDown(VK_MBUTTON) then
                cursorEnabled = not cursorEnabled
                click_warp()
                showCursor(cursorEnabled)
                while isKeyDown(VK_MBUTTON) do wait(80) end
            end
        end
        if elements.checkbox.airBrake.v then 
            if isKeyJustPressed(VK_RSHIFT) and not sampIsChatInputActive() then
                enAirBrake = not enAirBrake
                if enAirBrake then
                    local posX, posY, posZ = getCharCoordinates(playerPed)
                    airBrkCoords = {posX, posY, posZ, 0.0, 0.0, getCharHeading(playerPed)}
                end
            end
        end
        if enAirBrake then
            if isCharInAnyCar(playerPed) then heading = getCarHeading(storeCarCharIsInNoSave(playerPed))
            else heading = getCharHeading(playerPed) end
            local camCoordX, camCoordY, camCoordZ = getActiveCameraCoordinates()
            local targetCamX, targetCamY, targetCamZ = getActiveCameraPointAt()
            local angle = getHeadingFromVector2d(targetCamX - camCoordX, targetCamY - camCoordY)
            if isCharInAnyCar(playerPed) then difference = 0.79 else difference = 1.0 end
            setCharCoordinates(playerPed, airBrkCoords[1], airBrkCoords[2], airBrkCoords[3] - difference)
            if not isSampfuncsConsoleActive() and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() then
                if isKeyDown(VK_W) then
                airBrkCoords[1] = airBrkCoords[1] + HLcfg.config.speed_airbrake * math.sin(-math.rad(angle))
                airBrkCoords[2] = airBrkCoords[2] + HLcfg.config.speed_airbrake * math.cos(-math.rad(angle))
                if not isCharInAnyCar(playerPed) then setCharHeading(playerPed, angle)
                else setCarHeading(storeCarCharIsInNoSave(playerPed), angle) end
                elseif isKeyDown(VK_S) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading))
                end
                if isKeyDown(VK_A) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading - 90))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading - 90))
                elseif isKeyDown(VK_D) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading + 90))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading + 90))
                end
                if isKeyDown(VK_SPACE) then airBrkCoords[3] = airBrkCoords[3] + HLcfg.config.speed_airbrake / 2.0 end
                if isKeyDown(VK_LSHIFT) and airBrkCoords[3] > -95.0 then airBrkCoords[3] = airBrkCoords[3] - HLcfg.config.speed_airbrake / 2.0 end
                if isKeyJustPressed(VK_OEM_PLUS) then
                    HLcfg.config.speed_airbrake = HLcfg.config.speed_airbrake + 0.2
                    printStyledString('Speed increased by 0.2', 1000, 4) save()
                end
                if isKeyJustPressed(VK_OEM_MINUS) then
                    HLcfg.config.speed_airbrake = HLcfg.config.speed_airbrake - 0.2
                    printStyledString('Speed reduced by 0.2', 1000, 4) save()
                end
            end
        end	
        if elements.checkbox.infAmmo.v then
            memory.write(0x969178, 1, 1, true)
        else
            memory.write(0x969178, 0, 1, true)
        end
        local oTime = os.time()
        if elements.checkbox.bulletTracer.v then
            for i = 1, bulletSync.maxLines do
                if bulletSync[i].other.time >= oTime then
                    local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSync[i].other.o.x, bulletSync[i].other.o.y, bulletSync[i].other.o.z, true, true)
                    local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSync[i].other.t.x, bulletSync[i].other.t.y, bulletSync[i].other.t.z, true, true)
                    if result and resulti then
                        local xResolution = memory.getuint32(0x00C17044)
                        if wZ < 1 then
                            wX = xResolution - wX
                        end
                        if pZ < 1 then
                            pZ = xResolution - pZ
                        end 
                        renderDrawLine(wX, wY, pX, pY, elements.int.widthRenderLineOne.v, bulletSync[i].other.color)
                        if elements.checkbox.cbEnd.v then
                            renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffPolygonTwo.v, 3 + elements.int.sizeOffPolygonTwo.v, 1 + elements.int.polygonNumberTwo.v, elements.int.rotationPolygonTwo.v, bulletSync[i].other.color)
                        end
                    end
                end
            end
        end
        if elements.checkbox.showMyBullets.v then
            for i = 1, bulletSyncMy.maxLines do
                if bulletSyncMy[i].my.time >= oTime then
                    local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.o.x, bulletSyncMy[i].my.o.y, bulletSyncMy[i].my.o.z, true, true)
                    local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.t.x, bulletSyncMy[i].my.t.y, bulletSyncMy[i].my.t.z, true, true)
                    if result and resulti then
                        local xResolution = memory.getuint32(0x00C17044)
                        if wZ < 1 then
                            wX = xResolution - wX
                        end
                        if pZ < 1 then
                            pZ = xResolution - pZ
                        end 
                        renderDrawLine(wX, wY, pX, pY, elements.int.widthRenderLineTwo.v, bulletSyncMy[i].my.color)
                        if elements.checkbox.cbEndMy.v then
                            renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffPolygon.v, 3 + elements.int.sizeOffPolygon.v, 1 + elements.int.polygonNumber.v, elements.int.rotationPolygonOne.v, bulletSyncMy[i].my.color)
                        end
                    end
                end
            end
        end 
        if elements.checkbox.enableCheckerPlayer.v then
            local xSave, ySave = HLcfg.config.posCheckerX, HLcfg.config.posCheckerY
            renderFontDrawText(font, '{FFFFFF}Players online:', xSave, ySave - 20, -1)
            for k,v in ipairs(playersList) do
                local createId = sampGetPlayerIdByNickname(v)
                if createId then
                    if sampIsPlayerConnected(createId) then
                        isStreamed, isPed = sampGetCharHandleBySampPlayerId(createId)
                        if isStreamed then
                            friendX, friendY, friendZ = getCharCoordinates(isPed)
                            myX, myY, myZ = getCharCoordinates(playerPed)
                            distance = getDistanceBetweenCoords3d(friendX, friendY, friendZ, myX, myY, myZ)
                            distanceInteger = math.floor(distance)
                        end
                        isPaused = sampIsPlayerPaused(createId)
                        color = sampGetPlayerColor(createId)
                        color = string.format("%X", color)
                        if isPaused then color = string.gsub(color, "..(......)", "66%1") else color = string.gsub(color, "..(......)", "%1")
                        end
                        if isStreamed then isText = string.format('{%s}%s[%d] (%dm)', color, v, createId, distanceInteger)
                        else isText = string.format('{%s}%s[%d]', color, v, createId) end
                        renderFontDrawText(font, isText, xSave, ySave, stColor)
                        ySave = ySave + 20
                    end
                end 
            end
        end
        if elements.checkbox.renderInfoCars.v then
            for k,v in ipairs(getAllVehicles()) do
                local pos = {getCarCoordinates(v)}
                local my_pos = {getCharCoordinates(playerPed)}
                local result, id = sampGetVehicleIdByCarHandle(v)
                local hp = getCarHealth(v)
                local x, y = convert3DCoordsToScreen(pos[1], pos[2], pos[3])
                if result then
                    if isCarOnScreen(v) then
                        if getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], pos[1], pos[2], pos[3]) < elements.int.intInfoCars.v then
                            renderFontDrawText(font, 'ID: '..id..' HP: '..hp, x, y, 0xFFFFFFFF, true)
                        end
                    end
                end
            end
        end
        if isCharInAnyCar(playerPed) then
            if elements.checkbox.speedHack.v then
                if isKeyDown(VK_LMENU) then
                    if getCarSpeed(storeCarCharIsInNoSave(playerPed)) * 2.01 <= 500 then
                        local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(playerPed))
                        local heading = getCarHeading(storeCarCharIsInNoSave(playerPed))
                        local turbo = fps_correction() / 85
                        local xforce, yforce, zforce = turbo, turbo, turbo
                        local Sin, Cos = math.sin(-math.rad(heading)), math.cos(-math.rad(heading))
                        if cVecX > -0.01 and cVecX < 0.01 then xforce = 0.0 end
                        if cVecY > -0.01 and cVecY < 0.01 then yforce = 0.0 end
                        if cVecZ < 0 then zforce = -zforce end
                        if cVecZ > -2 and cVecZ < 15 then zforce = 0.0 end
                        if Sin > 0 and cVecX < 0 then xforce = -xforce end
                        if Sin < 0 and cVecX > 0 then xforce = -xforce end
                        if Cos > 0 and cVecY < 0 then yforce = -yforce end
                        if Cos < 0 and cVecY > 0 then yforce = -yforce end
                        applyForceToCar(storeCarCharIsInNoSave(playerPed), xforce * Sin, yforce * Cos, zforce / 2, 0.0, 0.0, 0.0)
                    end
                end
            end
            if elements.checkbox.noBike.v then
            	setCharCanBeKnockedOffBike(playerPed, true)
            else
                setCharCanBeKnockedOffBike(playerPed, false)
            end	
            if elements.checkbox.gmCar.v then
                setCanBurstCarTires(storeCarCharIsInNoSave(playerPed), false)
                setCarProofs(storeCarCharIsInNoSave(playerPed), true, true, true, true, true)
                setCarHeavy(storeCarCharIsInNoSave(playerPed), true)
                function samp.onSetVehicleHealth(vehicleId, health)
                    if not boolEnabled then
                        return false
                    end
                end
            else
                setCanBurstCarTires(storeCarCharIsInNoSave(playerPed), false)
                setCarProofs(storeCarCharIsInNoSave(playerPed), false, false, false, false, false)
                setCarHeavy(storeCarCharIsInNoSave(playerPed), false)
            end
        end
        clearAnimka()
        dialogHiderText()
    end
end

function isPos()
    if checkerCoords then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posCheckerX, HLcfg.config.posCheckerY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Збережено.', stColor)
            checkerCoords = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            checkerCoords = false
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Ви скасували зміну позиції статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePosition then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX, HLcfg.config.posY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Збережено.', stColor)
            changePosition = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePosition = false
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Ви скасували зміну позиції статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changeBubbleCoordinates then
        showCursor(true, false)
        bubbleBox:toggle(true)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posBubbleX, HLcfg.config.posBubbleY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Збережено, перезавантаження скрипту.', stColor)
            changeBubbleCoordinates = false
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changeBubbleCoordinates = false
            bubbleBox:toggle(false)
            imgui.ShowCursor = false
            sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Ви скасували зміну позиції далекого чату.', stColor)
            AdminTools.v = true
        end
    end
end

function onExitScript(booleanTrue)
    if bubbleBox then bubbleBox:free() end
    if booleanTrue then
        if HLcfg.config.invAdmin then
            HLcfg.config.invAdmin = false
            save()
        end 
    end
end 

function imgui.centeredText(text)
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(text).x) / 2);
    imgui.Text(tostring(text));
end

local testArr = {}

function samp.onServerMessage(color, text)
    if not HLcfg.config.invAdmin then
        if text:find('%{%x%x%x%x%x%x%}%[%a%]%{%x%x%x%x%x%x%} '..getMyNick()..' авторизувався як адмін %d рівня.') then
            HLcfg.config.invAdmin = true
            save()
        end 
    end 
    if text:find("Не флуди!") then
        return false
    end  
    if text:find('%{%x%x%x%x%x%x%}%[Admin%-Answer%] %{%x%x%x%x%x%x%}'..getMyNick()..' > (.-)%[(%d+)%]:%{%x%x%x%x%x%x%} (.*)') then
		HLcfg.config.dayReports = HLcfg.config.dayReports + 1
		LsessionReport = LsessionReport + 1
		save()
    end
	if text:find("%{%x%x%x%x%x%x%}%[%a%]%{%x%x%x%x%x%x%} Неправильний ID!") then
		rInfo.id = -1
    end  
    if text:find('%{00aaff%}%[A%]%{FFFFFF%} Надійшла нова скарга/запитання вiд: %{ff002f%}(.-)%[(%d+)%]: %{FFFFFF%}(.*)') then
        local Rnickname, Rid, RtextP = text:match('%{00aaff%}%[A%]%{FFFFFF%} Надійшла нова скарга/запитання вiд: %{ff002f%}(.-)%[(%d+)%]: %{FFFFFF%}(.*)')
        reports[#reports + 1] = {nickname = Rnickname, id = Rid, textP = RtextP}
    end  
    if #reports > 0 then
        for k, v in pairs(reports) do
            if k == 1 then
                if not tableOfNew.AutoReport.v then
                    if text:find('%{%x%x%x%x%x%x%}%[Admin%-Answer%] %{%x%x%x%x%x%x%}(.+)%s*>%s*(.-)%[(%d+)%]:%{%x%x%x%x%x%x%} (.*)') then
                        refresh_current_report()
                    end
                end
            elseif #reports > 1 then
                if text:find('%{%x%x%x%x%x%x%}%[Admin%-Answer%] %{%x%x%x%x%x%x%}(.+)%s*>%s*(.-)%[(%d+)%]:%{%x%x%x%x%x%x%} (.*)') then
                    table.remove(reports, k)
                end
            end
        end
    end
    if elements.checkbox.enableAutoReport.v then
        if text:find('%{00aaff%}%[A%]%{FFFFFF%} Надійшла нова скарга/запитання вiд: %{ff002f%}(.-)%[(%d+)%]: %{FFFFFF%}(.*)'..u8:decode(elements.input.textFindAutoReport.v)) then
            if elements.input.textFindAutoReport.v ~= '' and elements.input.answerAutoReport.v ~= '' then
                local nickRep, idRep = text:match('%{00aaff%}%[A%]%{FFFFFF%} Надійшла нова скарга/запитання вiд: %{ff002f%}(.-)%[(%d+)%]: %{FFFFFF%}(.*)'..u8:decode(elements.input.textFindAutoReport.v))
                answer_flets[#answer_flets + 1] = ('/ans '..idRep..' '..u8:decode(elements.input.answerAutoReport.v))
            else
                sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Ви не вказали відповідь/пошуковий текст в авто-відповідачу.', stColor)
            end 
        end
    end
    if elements.checkbox.formsEnabled.v then
        for k, v in ipairs(allForms) do
            if text:match("{00aaff}%[A%]%{ffffff%} (%w+_?%w+) %: /"..v.." (%d+) ([%d:]+) (.+)") then
                local admin_nick, admin_id, timestamp, reason = text:match("{00aaff}%[A%]%{ffffff%} (%w+_?%w+) %: /"..v.." (%d+) ([%d:]+) (.+)")
                sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Прийшла форма, щоб прийняти її натисніть >> K <<', stColor)
                sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Щоб відхилити її, натисніть >> P <<', stColor)                    
                active_forma = true
                lua_thread.create(function()
                    lasttime = os.time()
                    lasttimes = 0
                    time_out = elements.int.timeOutForma.v
                    while lasttimes < time_out do
                        lasttimes = os.time() - lasttime
                        wait(0)
                        printStyledString("ADMIN FORM " .. time_out - lasttimes .. " WAIT", 1000, 4)
                        if stop_forma then
                            printStyledString('Form already accepted', 1000, 4)
                            stop_forma = false
                            break
                        end
                        if lasttimes == time_out then
                            printStyledString("Forma skipped", 1000, 4)
                        end
                        if isKeyJustPressed(VK_K) and not sampIsChatInputActive() and not sampIsDialogActive() then
                            printStyledString("Admin form accepted", 1000, 4)
                            sampSendChat("/"..v.." "..reason.." || "..admin_nick)
                            wait(1000)
                            sampSendChat('/a [Forma] +')
                            LsessionForma = LsessionForma + 1
                            HLcfg.config.dayForms = HLcfg.config.dayForms + 1
                            save()
                            active_forma = false
                            break
                        elseif isKeyJustPressed(VK_P) and not sampIsChatInputActive() and not sampIsDialogActive() then
                            printStyledString('You missed the form', 1000, 4)
                            active_forma = false
                            break
                        end
                    end
                end)
            end
        end
    end
    if active_forma then
        if text:find('%[.*%] (%w+_?%w+)%[(%d+)%]%: %[Forma%] +') then
            active_forma = false
            stop_forma = true
        end
    end
end

function clearAnimka()
    animid = sampGetPlayerAnimationId(getMyId())
    if animid == 1168 then
        clearCharTasksImmediately(playerPed)
    end
end

function rkeys.onHotKey(id, data)
    if sampIsChatInputActive() or sampIsDialogActive() then
      return false
    end
end 

function _sampSendChat(message, length) 
    length = length or #message
    repeat
        sampSendChat('/a << Репорт >> '..message:sub(1, length))
        message = message:sub(length + 1, #message)
        if #message > 0 then wait(1000) end
    until #message <= 0
end

local helloText = [[
===================================================================
Я не являюсь автором данного скрипта, я только его доработал/переработал.
Автор: Anonim 
Фиксер: Kincsmen
===================================================================
Последние нововведения которые я добавил:
- Фулл фикс скрипта
- Убраны все краши скрипта  
- Переделана система рекона
- Был сделан авто-вход в админ панель при вводе команды /alogin 
- Было пофикшено быстрое меню 
- Был проработан интерфейс 
- Были добавлены команды скрипта 
- Было доработано статистику/переработана фулл под Гост 
- Было оптимизировано меню Авто-репорта, но пока он не берет репорт,
а только отвечает в /ans
- Был переделан Авто-Відповідач, работает корректно теперь  
- Переделано быструю выдачу наказаний  
- Был полностью подогнан скрипт под Гост

Планы: 
- Посмотрим 
- Переписать систему выдачи формы
]]

function imgui.OnDrawFrame()
    if elements.int.intImGui.v == 0 then
        blue()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 1 then
        red()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 2 then
        brown()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 3 then
        violet()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 4 then
        blackred()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 5 then
        salat()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    end
    if AdminTools.v then
        imgui.ShowCursor = true
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(650, 400), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.ICON_FA_TOOLBOX..(u8(' Ghost Tools | 01')), AdminTools, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild("##menuSecond", imgui.ImVec2(140, 362), true)
        if imgui.Button(fa.ICON_FA_COGS..(u8' Налаштування'), imgui.ImVec2(123, 0)) then
            menuSelect = 1
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_KEYBOARD..(u8' Спец. Клавіши'), imgui.ImVec2(123, 0)) then
            menuSelect = 2
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_CROSSHAIRS..(u8' Трейсер пуль'), imgui.ImVec2(123, 0)) then
            menuSelect = 3
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_LIST..(u8' Чекер'), imgui.ImVec2(123, 0)) then
            menuSelect = 4
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_INFO..(u8' Статистика'), imgui.ImVec2(123, 0)) then
            menuSelect = 5
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_TEXT_HEIGHT..(u8' Авто-відповідач'), imgui.ImVec2(123, 0)) then
            menuSelect = 6
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_COMMENTS..(u8' Далекий чат'), imgui.ImVec2(123, 0)) then
            menuSelect = 7
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_RADIATION_ALT..(u8' Зброя'), imgui.ImVec2(123, 0)) then
            menuSelect = 8
        end 
        imgui.Separator()
        if imgui.Button(fa.ICON_FA_CAR..(u8' Авто'), imgui.ImVec2(123, 0)) then
            menuSelect = 9
        end 
        imgui.Separator()
        if imgui.Button(u8"Вступ у організацію", imgui.ImVec2(123, 0)) then
            tableOfNew.tempLeader.v = not tableOfNew.tempLeader.v
        end 
        imgui.Separator()
        if imgui.Button(u8"Адм-довідка", imgui.ImVec2(123, 0)) then
            tableOfNew.tableRes.v = not tableOfNew.tableRes.v 
        end  
        imgui.Separator()
        if imgui.Button(u8"Команди скрипту", imgui.ImVec2(123, 0)) then
            tableOfNew.commandsAdmins.v = not tableOfNew.commandsAdmins.v 
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild("##menuSelectable", imgui.ImVec2(486, 362), true)
        if menuSelect == 0 then
            imgui.Text(u8(helloText))
        end
        if menuSelect == 1 then
            imgui.Text(u8"Виберіть стиль імгуї >> ") imgui.SameLine() imgui.PushItemWidth(125) imgui.Combo("##imguiStyle", elements.int.intImGui, colorsImGui) imgui.PopItemWidth()
            if elements.checkbox.statistics.v then
                if imgui.Button(u8"Змінити координати статистики", imgui.ImVec2(464, 0)) then
                    changePosition = true
                    AdminTools.v = false
                    sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Щоб підтвердити збереження – натисніть 1, щоб скасувати збереження – натисніть 2.', stColor)
                end
            end
            if imgui.Button(u8"Налаштувати команди для спавна машин", imgui.ImVec2(464, 0)) then
                imgui.OpenPopup(u8"Налаштування команд для спавна машин")
            end
            if imgui.BeginPopup(u8"Налаштування команд для спавна машин") then
                if imgui.Checkbox(u8"[Увм/вим] Відображення секунд до закінчення спавна машин [ /dvall ]", elements.checkbox.printDvall) then
                    HLcfg.config.printDvall = elements.checkbox.printDvall.v 
                    save()
                end
                if imgui.Checkbox(u8"[Увм/вим] Відображення секунд до закінчення спавна машин [ /spawncars ]", elements.checkbox.printSpawnCars) then
                    HLcfg.config.printSpawnCars = elements.checkbox.printSpawnCars.v 
                    save()
                end
                imgui.EndPopup()
            end
            imgui.Separator()
            if imgui.Checkbox(u8"[Увм/вим] Статистика", elements.checkbox.statistics) then
                HLcfg.config.statistics = elements.checkbox.statistics.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Показує ваш онлайн/ІД і т.д;\nРегулюється в меню")
            if imgui.Checkbox(u8"[Увм/вим] Трейсер пуль", elements.checkbox.bulletTracer) then
                HLcfg.config.bulletTracer = elements.checkbox.bulletTracer.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Рендерит траєкторію кулі")
            if imgui.Checkbox(u8"[Увм/вим] AirBrake", elements.checkbox.airBrake) then
                HLcfg.config.airBrake = elements.checkbox.airBrake.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Швидке переміщення, яке активується на натискання клавіша RSHIFT, регулюється за допомогою + та -")
            if imgui.Checkbox(u8"[Увм/вим] Speed Hack", elements.checkbox.speedHack) then
                HLcfg.config.speedHack = elements.checkbox.speedHack.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Прискорює ваш автомобіль при натисканні на Alt")
            if imgui.Checkbox(u8"[Увм/вим] Infinity Ammo", elements.checkbox.infAmmo) then
                HLcfg.config.infAmmo = elements.checkbox.infAmmo.v 
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Робить ваші патрони нескінченними")
            if imgui.Checkbox(u8"[Увм/вим] Click Warp", elements.checkbox.clickWarp) then
                HLcfg.config.clickWarp = elements.checkbox.clickWarp.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"При натисканні коліщатка миші - ви можете телепортуватися по різних місцях, за допомогою комбінації клавіш ПКМ + ЛКМ ви можете сісти в машину")
            if imgui.Checkbox(u8"[Увм/вим] Auto Reconnect", elements.checkbox.autoReconnect) then
                HLcfg.config.autoReconnect = elements.checkbox.autoReconnect.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Якщо сервер закриє з'єднання, скрипт за вас перейде на сервер")
            if imgui.Checkbox(u8"[Увм/вим] GM Car", elements.checkbox.gmCar) then
                HLcfg.config.gmCar = elements.checkbox.gmCar.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Не дасть вашому транспорту зламатися")
            if imgui.Checkbox(u8"[Увм/вим] No Bike", elements.checkbox.noBike) then 
                HLcfg.config.noBike = elements.checkbox.noBike.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Не дасть вам впасти з мотоцикла")
            if imgui.Checkbox(u8"[Увм/вим] AntiEjectCar", elements.checkbox.antiEjectCar) then
                HLcfg.config.antiEjectCar = elements.checkbox.antiEjectCar.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Не дасть іншим гравцям викинути вас із вашого транспорту")
            if imgui.Checkbox(u8"[Увм/вим] Показувати ІД при вбивстві гравця", elements.checkbox.showKillerId) then
                HLcfg.config.showKillerId = elements.checkbox.showKillerId.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"У Кілл-Листі буде показаний ІД.")
            if imgui.Checkbox(u8"[Увм/вим] Чекер відключень", elements.checkbox.leaveChecker) then
                HLcfg.config.leaveChecker = elements.checkbox.leaveChecker.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Показує, який гравець вийшов із гри та з якої причини")
            if imgui.Checkbox(u8"[Увм/вим] Курсор Авто-репорт", elements.checkbox.areportclick) then
                HLcfg.config.areportclick = elements.checkbox.areportclick.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Налаштовує, показуватиметься миша відразу після активації цього вікна, або при натисканні клавіші U.")
            if imgui.Checkbox(u8"[Увм/вим] Форми", elements.checkbox.formsEnabled) then
                HLcfg.config.formsEnabled = elements.checkbox.formsEnabled.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Приймає прохання видачі покарання іншого адміністратора")
            if imgui.Checkbox(u8"[Увм/вим] Кордон у шрифту", elements.checkbox.borderToFont) then
                if elements.checkbox.borderToFont.v then
                    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
                else
                    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
                end
                HLcfg.config.borderToFont = elements.checkbox.borderToFont.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Додає кордон тексту [ рендера ] на екрані.")
            if imgui.Checkbox(u8"[Увм/вим] Авто-вхід", elements.checkbox.autoCome) then
                HLcfg.config.autoCome = elements.checkbox.autoCome.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Не треба вводити адмін-пароль самому, скрипт зробить це за вас, коли відкриється вікно /alogin")
            if elements.checkbox.autoCome.v then
                imgui.Text(u8"Введіть адмін-пароль: ") imgui.SameLine() imgui.PushItemWidth(100)
                if imgui.InputText("##adminPassword", elements.input.adminPassword, (elements.checkbox.showAdminPassword.v and imgui.InputTextFlags.Password or nil)) then
                    HLcfg.config.adminPassword = elements.input.adminPassword.v
                    save()
                end imgui.PopItemWidth() imgui.SameLine() if imgui.ToggleButton('Адмін Пароль', elements.checkbox.showAdminPassword) then
                    HLcfg.config.showAdminPassword = elements.checkbox.showAdminPassword.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8"Налаштування, яке буде показувати, відобразиться ваш адмін-пароль, чи ні")
            end
            imgui.Separator()
            if imgui.Checkbox(u8"[Увм/вим] Додає рендер Інформації про авто", elements.checkbox.renderInfoCars) then
                HLcfg.config.renderInfoCars = elements.checkbox.renderInfoCars.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"На вказаній дистанції ви бачитимете ХП та ВД машини.")
            if elements.checkbox.renderInfoCars.v then
                imgui.Text(u8"Налаштуйте дальність промальовування інформації про автомобіль:")
                if imgui.SliderInt("##longInfoCar", elements.int.intInfoCars, 30, 100) then
                    HLcfg.config.intInfoCars = elements.int.intInfoCars.v
                    save()
                end
            end
            imgui.Separator()
            imgui.Text(u8"Змінити кількість секунд очікування форми >>")
            if imgui.SliderInt("##pForm", elements.int.timeOutForma, 5, 20) then
                HLcfg.config.timeOutForma = elements.int.timeOutForma.v
                save()
            end
            imgui.Text(u8"Змінити розмір шрифту >>")
            if imgui.SliderInt("##sizeFont", elements.int.sizeBuffer, 10, 15) then
                if elements.checkbox.borderToFont.v then
                    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
                else
                    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
                end
                HLcfg.config.sizeBuffer = elements.int.sizeBuffer.v
                save()
            end
            imgui.Separator()
            if imgui.Button(u8"Перезавантажити скрипт", imgui.ImVec2(464, 0)) then
                thisScript():reload()
            end 
            if imgui.Button(u8"Очистити стрим-пам'ять", imgui.ImVec2(464, 0)) then
                cleanStreamMemory()
            end
        end
        if menuSelect == 2 then
            local tLastOne = {}
			if imguiad.HotKey("##ActiveOne", ofHotkeys.LeaveReconWindow, tLastOne, 100) then
                rkeys.changeHotKey(BindLeaveReconWindow, ofHotkeys.LeaveReconWindow.v)					
				cfg.LeaveReconWindow = deepcopy(ofHotkeys.LeaveReconWindow.v)
				luasave()
            end imgui.SameLine() imgui.Text(u8" Вийти з рекона [/reoff]")
			local tLastTwo = {}
			if imguiad.HotKey("##ActiveTwo", ofHotkeys.whEnabled, tLastTwo, 100) then
                rkeys.changeHotKey(BindwhEnabled, ofHotkeys.whEnabled.v)					
				cfg.whEnabled = deepcopy(ofHotkeys.whEnabled.v)
				luasave()
			end imgui.SameLine() imgui.Text(u8'Активація WallHack')
            local tLastThree = {}
            if imguiad.HotKey("##ActiveThree", ofHotkeys.openHomeWindow, tLastThree, 100) then
                rkeys.changeHotKey(BindopenHomeWindow, ofHotkeys.openHomeWindow.v)					
				cfg.openHomeWindow = deepcopy(ofHotkeys.openHomeWindow.v)
				luasave()
			end  imgui.SameLine() imgui.Text(u8'Відкрити основне вікно')
            local tLastFour = {}
            if imguiad.HotKey("##ActiveFour", ofHotkeys.openAutoReport, tLastFour, 100) then
				rkeys.changeHotKey(BindopenAutoReport, ofHotkeys.openAutoReport.v)					
				cfg.openAutoReport = deepcopy(ofHotkeys.openAutoReport.v)
				luasave()
			end imgui.SameLine() imgui.Text(u8'Відкрити авто-репорт')
            local tLastFive = {}
            if imguiad.HotKey("##ActiveFive", ofHotkeys.enabledTracers, tLastFive, 100) then
				rkeys.changeHotKey(BindenabledTracers, ofHotkeys.enabledTracers.v)					
				cfg.enabledTracers = deepcopy(ofHotkeys.enabledTracers.v)
				luasave()
            end imgui.SameLine() imgui.Text(u8'Увм/вим трейсери куль')
        end
        if menuSelect == 3 then
            if imgui.Checkbox(u8"Відображати/Не відображати свої кулі", elements.checkbox.showMyBullets) then
                HLcfg.config.showMyBullets = elements.checkbox.showMyBullets.v
                save()
            end 
            imgui.Separator()
            if elements.checkbox.showMyBullets.v then
                if imgui.CollapsingHeader(u8"Налаштувати трейсер своїх куль") then


                    imgui.Separator()
                    imgui.PushItemWidth(175)
                    if imgui.SliderInt("##bulletsMyTime", elements.int.secondToCloseTwo, 5, 15) then
                        HLcfg.config.secondToCloseTwo = elements.int.secondToCloseTwo.v
                        save()
                    end imgui.SameLine() imgui.Text(u8"Час затримки трейсера")
                    if imgui.SliderInt("##renderWidthLinesTwo", elements.int.widthRenderLineTwo, 1, 10) then
                        HLcfg.config.widthRenderLineTwo = elements.int.widthRenderLineTwo.v
                        save()
                    end imgui.SameLine() imgui.Text(u8"Товщина ліній")
                    if imgui.SliderInt('##maxMyBullets', elements.int.maxMyLines, 10, 300) then
                        bulletSyncMy.maxLines = elements.int.maxMyLines.v
                        bulletSyncMy = {lastId = 0, maxLines = elements.int.maxMyLines.v}
                        for i = 1, bulletSyncMy.maxLines do
                            bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
                        end
                        HLcfg.config.maxMyLines = elements.int.maxMyLines.v
                        save()
                    end imgui.SameLine() imgui.Text(u8"Максимальна кількість ліній")

                    imgui.Separator()

                    if imgui.Checkbox(u8"[Увм/вим] Закінчення у трейсерів##1", elements.checkbox.cbEndMy) then
                        HLcfg.config.cbEndMy = elements.checkbox.cbEndMy.v
                        save()
                    end

                    if imgui.SliderInt('##sizeTraicerEnd', elements.int.sizeOffPolygon, 1, 10) then
                        HLcfg.config.sizeOffPolygon = elements.int.sizeOffPolygon.v
                        save()
                    end  imgui.SameLine() imgui.Text(u8"Розмір закінчення трейсера")
                    if imgui.SliderInt('##endNumbers', elements.int.polygonNumber, 2, 10) then
                        HLcfg.config.polygonNumber = elements.int.polygonNumber.v 
                        save()
                    end imgui.SameLine() imgui.Text(u8"Кількість кутів на закінчення")
                    if imgui.SliderInt('##rotationOne', elements.int.rotationPolygonOne, 0, 360) then
                        HLcfg.config.rotationPolygonOne = elements.int.rotationPolygonOne.v
                        save()
                    end imgui.SameLine() imgui.Text(u8"Градус повороту закінчення")


                    imgui.PopItemWidth()
                    imgui.Separator()
                    imgui.Text(u8"Вкажіть колір трейсера, якщо ви попали у: ")
                    if imgui.ColorEdit4("##dinamicObjectMy", dinamicObjectMy) then
                        HLcfg.config.dinamicObjectMy = join_argb(dinamicObjectMy.v[1] * 255, dinamicObjectMy.v[2] * 255, dinamicObjectMy.v[3] * 255, dinamicObjectMy.v[4] * 255)
                        save()
                    end imgui.SameLine() imgui.Text(u8"Динамічний об'єкт")
                    if imgui.ColorEdit4("##staticObjectMy", staticObjectMy) then
                        HLcfg.config.staticObjectMy = join_argb(staticObjectMy.v[1] * 255, staticObjectMy.v[2] * 255, staticObjectMy.v[3] * 255, staticObjectMy.v[4] * 255)
                        save()
                    end imgui.SameLine() imgui.Text(u8"Статичний об'єкт")
                    if imgui.ColorEdit4("##pedMy", pedPMy) then
                        HLcfg.config.pedPMy = join_argb(pedPMy.v[1] * 255, pedPMy.v[2] * 255, pedPMy.v[3] * 255, pedPMy.v[4] * 255)
                        save()
                    end imgui.SameLine() imgui.Text(u8"Гравця")
                    if imgui.ColorEdit4("##carMy", carPMy) then
                        HLcfg.config.carPMy = join_argb(carPMy.v[1] * 255, carPMy.v[2] * 255, carPMy.v[3] * 255, carPMy.v[4] * 255)
                        save()
                    end imgui.SameLine() imgui.Text(u8"Автівку")
                    imgui.PopItemWidth()
                    imgui.Separator()
                end
            end 
            if imgui.CollapsingHeader(u8"Налаштувати трейсер чужих куль") then
                imgui.Separator()
                imgui.PushItemWidth(175)
                if imgui.SliderInt("##secondsBullets", elements.int.secondToClose, 5, 15) then
                    HLcfg.config.secondToClose = elements.int.secondToClose.v
                    save()
                end imgui.SameLine() imgui.Text(u8"Час затримки трейсера")
                if imgui.SliderInt("##renderWidthLinesOne", elements.int.widthRenderLineOne, 1, 10) then
                    HLcfg.config.widthRenderLineOne = elements.int.widthRenderLineOne.v
                    save()
                end imgui.SameLine() imgui.Text(u8"Товщина ліній")
                if imgui.SliderInt('##numberNotMyBullet', elements.int.maxNotMyLines, 10, 300) then
                    bulletSync.maxNotMyLines = elements.int.maxNotMyLines.v
                    bulletSync = {lastId = 0, maxLines = elements.int.maxNotMyLines.v}
                    for i = 1, bulletSync.maxLines do
                        bulletSync[i] = { other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
                    end
                    HLcfg.config.maxNotMyLines = elements.int.maxNotMyLines.v
                    save()
                end imgui.SameLine() imgui.Text(u8"Максимальна кількість ліній")

                imgui.Separator()

                if imgui.Checkbox(u8"[Увм/вим] Закінчення у трейсерів##2", elements.checkbox.cbEnd) then
                    HLcfg.config.cbEnd = elements.checkbox.cbEnd.v
                    save()
                end

                if imgui.SliderInt('##sizeTraicerEndTwo', elements.int.sizeOffPolygonTwo, 1, 10) then
                    HLcfg.config.sizeOffPolygonTwo = elements.int.sizeOffPolygonTwo.v
                    save()
                end imgui.SameLine() imgui.Text(u8"Розмір закінчення трейсера")

                if imgui.SliderInt('##endNumbersTwo', elements.int.polygonNumberTwo, 2, 10) then
                    HLcfg.config.polygonNumberTwo = elements.int.polygonNumberTwo.v 
                    save()
                end imgui.SameLine() imgui.Text(u8"Кількість кутів на закінчення")

                if imgui.SliderInt('##rotationTwo', elements.int.rotationPolygonTwo, 0, 360) then
                    HLcfg.config.rotationPolygonTwo = elements.int.rotationPolygonTwo.v
                    save() 
                end imgui.SameLine() imgui.Text(u8"Градус повороту закінчення")

                imgui.PopItemWidth()
                imgui.Separator()
                imgui.Text(u8"Укажіть колір трейсера, якщо гравець попав у: ")
                imgui.PushItemWidth(325)
                if imgui.ColorEdit4("##dinamicObject", dinamicObject) then
                    HLcfg.config.dinamicObject = join_argb(dinamicObject.v[1] * 255, dinamicObject.v[2] * 255, dinamicObject.v[3] * 255, dinamicObject.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Динамічний об'єкт")
                if imgui.ColorEdit4("##staticObject", staticObject) then
                    HLcfg.config.staticObject = join_argb(staticObject.v[1] * 255, staticObject.v[2] * 255, staticObject.v[3] * 255, staticObject.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Статичний об'єкт")
                if imgui.ColorEdit4("##ped", pedP) then
                    HLcfg.config.pedP = join_argb(pedP.v[1] * 255, pedP.v[2] * 255, pedP.v[3] * 255, pedP.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Гравця")
                if imgui.ColorEdit4("##car", carP) then
                    HLcfg.config.carP = join_argb(carP.v[1] * 255, carP.v[2] * 255, carP.v[3] * 255, carP.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Автівку")
                imgui.PopItemWidth()
                imgui.Separator()
            end 
        end
        if menuSelect == 4 then
            if elements.checkbox.enableCheckerPlayer.v then
                if imgui.Button(u8"Встановити нові координати чекеру", imgui.ImVec2(452, 0)) then
                    AdminTools.v = false
                    checkerCoords = true
                    sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Щоб підтвердити збереження – натисніть 1, щоб скасувати збереження – натисніть 2.', stColor)
                end
            end
            if imgui.Checkbox(u8"[Увм/вим] Чекер", elements.checkbox.enableCheckerPlayer) then
                HLcfg.config.enableCheckerPlayer = elements.checkbox.enableCheckerPlayer.v
                save()
            end
            for k, v in ipairs(playersList) do
                imgui.Text(u8(v))
                imgui.SameLine()
                if imgui.Button(u8"Видалити##"..k) then
                  table.remove(playersList, k)
                end
            end
            imgui.PushItemWidth(130)
            imgui.InputText(u8"Введіть нік", tableOfNew.addInBuffer)
            imgui.PopItemWidth()
            imgui.SameLine()
            if imgui.Button(u8"Добавити") then
                table.insert(playersList, u8:decode(tableOfNew.addInBuffer.v))
            end
        end
        if menuSelect == 5 then
            if imgui.Checkbox(u8'[Увм/вим] Назва', elements.putStatis.nameStatis) then
                HLcfg.statAdmin.nameStatis = elements.putStatis.nameStatis.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Центрування тексту', elements.putStatis.centerText) then
                HLcfg.statAdmin.centerText = elements.putStatis.centerText.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати ІД', elements.putStatis.showId) then
                HLcfg.statAdmin.showId = elements.putStatis.showId.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати пінга', elements.putStatis.showPing) then
                HLcfg.statAdmin.showPing = elements.putStatis.showPing.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати ХП', elements.putStatis.showHealth) then
                HLcfg.statAdmin.showHealth = elements.putStatis.showHealth.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати форми за день', elements.putStatis.showFormDay) then
                HLcfg.statAdmin.showFormDay = elements.putStatis.showFormDay.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати форми за сеанс', elements.putStatis.showFormSession) then
                HLcfg.statAdmin.showFormSession = elements.putStatis.showFormSession.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати репорти за день', elements.putStatis.showReportDay) then
                HLcfg.statAdmin.showReportDay = elements.putStatis.showReportDay.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати репорти за сеанс', elements.putStatis.showReportSession) then
                HLcfg.statAdmin.showReportSession = elements.putStatis.showReportSession.v 
                save()
            end
            if imgui.Checkbox(u8"[Увм/вим] Показувати інтер'єр", elements.putStatis.showInterior) then
               HLcfg.statAdmin.showInterior = elements.putStatis.showInterior.v
               save() 
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати відіграний час за день', elements.putStatis.showOnlineDay) then
                HLcfg.statAdmin.showOnlineDay = elements.putStatis.showOnlineDay.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати відіграний час за сеанс', elements.putStatis.showOnlineSession) then
                HLcfg.statAdmin.showOnlineSession = elements.putStatis.showOnlineSession.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати АФК за день', elements.putStatis.showAfkDay) then
                HLcfg.statAdmin.showAfkDay = elements.putStatis.showAfkDay.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати АФК за сеанс', elements.putStatis.showAfkSession) then
                HLcfg.statAdmin.showAfkSession = elements.putStatis.showAfkSession.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показувати час', elements.putStatis.showTime) then
                HLcfg.statAdmin.showTime = elements.putStatis.showTime.v
                save()
            end
            if imgui.Checkbox(u8'[Увм/вим] Показати дату', elements.putStatis.showTopDate) then
                HLcfg.statAdmin.showTopDate = elements.putStatis.showTopDate.v
                save()
            end
        end
        if menuSelect == 6 then
            if imgui.Checkbox(u8"[Увм/вим] Авто-відповідач", elements.checkbox.enableAutoReport) then
                HLcfg.config.enableAutoReport = elements.checkbox.enableAutoReport.v
                save() 
            end
            imgui.Text(u8"Не врубайте авто-відповідач коли не уввели текст!!!")
            imgui.Text(u8"Введіть текст, який потрібно шукати в репорті:")
            imgui.PushItemWidth(400)
            if imgui.NewInputText(u8'##SearchText', elements.input.textFindAutoReport, 455, u8"Сюди необхідно ввести текст, який шукатиметься.", 2) then
                HLcfg.config.textFindAutoReport = elements.input.textFindAutoReport.v
                save()
            end
            imgui.PopItemWidth()
            imgui.Text(u8"Введіть текст для відповіді:")
            imgui.PushItemWidth(400)
            if imgui.NewInputText(u8'##SearchBar', elements.input.answerAutoReport, 455, u8"Сюди потрібно ввести текст для відповіді.", 2) then
                HLcfg.config.answerAutoReport = elements.input.answerAutoReport.v
                save()
            end
            imgui.PopItemWidth()
        end
        if menuSelect == 7 then
            imgui.Text(u8"Щоб перегортати чат, натисніть клавішу B, а потім крутіть коліщатко миші..")
            local buttonActivBubbleChat = {}
			if imguiad.HotKey("##ofOne", ofHotkeys.activeChatBubble, buttonActivBubbleChat, 100) then
				rkeys.changeHotKey(BindactiveChatBubble, ofHotkeys.activeChatBubble.v)
                HLcfg.config.activeChatBubble = encodeJson(ofHotkeys.activeChatBubble.v)
                save()
            end imgui.SameLine() imgui.Text(u8"Виберіть клавішу для активації далекого адмінського чату.")
            if imgui.Button(u8"Змінити розташування далекого чату", imgui.ImVec2(482, 0)) then
                changeBubbleCoordinates = true
                AdminTools.v = false
                sampAddChatMessage('{FF0000}[GhostTools] {FF8C00}Щоб зберегти місце - натисніть "1", щоб скасувати зміну - "2".', stColor)
            end
            imgui.Separator()
            imgui.Text(u8"Вкажіть максимальну кількість рядків у сторінці:")
            if imgui.SliderInt("##PrintInt", elements.int.limitPageSize, 5, 30) then
                HLcfg.config.limitPageSize = elements.int.limitPageSize.v
                save()
            end
            imgui.Text(u8"Вкажіть максимальну кількість рядків:")
            if imgui.SliderInt("##maxPages", elements.int.maxPagesBubble, 100, 1000) then
                HLcfg.config.maxPagesBubble = elements.int.maxPagesBubble.v
                save()
            end
            imgui.Separator()
        end
        if menuSelect == 8 then
            imgui.SetWindowFontScale(1.0)
            imgui.Text(u8"Створити зброю:")
            imgui.SetWindowFontScale(1.0)
            imgui.Separator()
            imgui.Text(u8'Виберіть зброю:')
            imgui.PushItemWidth(142)
            if imgui.Combo("##gunCreateFov", tableOfNew.numberGunCreate, arrGuns) then
                HLcfg.config.numberGunCreate = tableOfNew.numberGunCreate.v 
                save()
            end
            imgui.PopItemWidth()
            imgui.Text(u8'Виберіть кількість патронів:')
            imgui.SliderInt('##numberAmmo', numberAmmo, 1, 999)
            if imgui.Button(u8'Створити', imgui.ImVec2(100, 22)) then
                sampSendChat('/givegun '..getMyId()..' '..tableOfNew.numberGunCreate.v..' '..numberAmmo.v)
            end
            imgui.Separator()
            imgui.SetWindowFontScale(1.0)
            imgui.Text(u8"Частовживана зброя:")
            imgui.SetWindowFontScale(1.0)
            for k,v in pairs(allGunsP) do
                if imgui.Button(u8(v), imgui.ImVec2(100, 0)) then
                    sampSendChat('/givegun '..getMyId()..' '..k..' '..numberAmmo.v)
                end imgui.SameLine()
            end
            imgui.NewLine()
            imgui.Separator()
        end
        if menuSelect == 9 then
            local tt = 0
            imgui.SetWindowFontScale(1.1)
            imgui.Text(u8"Створити авто:")
            imgui.SetWindowFontScale(1.0)
            imgui.Separator()
            imgui.Columns(3, _, false)
            imgui.Text(u8"Виберіть авто:")
            imgui.PushItemWidth(142)
            if imgui.Combo("##car", tableOfNew.intComboCar, tCarsName) then
                HLcfg.config.intComboCar = tableOfNew.intComboCar.v
                save()
            end
            imgui.PopItemWidth()
            if imgui.Button(u8"Створити", imgui.ImVec2(141, 22)) then
                sampSendChat("/veh " .. tableOfNew.intComboCar.v + 400 .. " 1 1")
            end
            imgui.NextColumn()
            imgui.Text(u8"Виберіть колір:")
            imgui.AlignTextToFramePadding()
            imgui.Text("#1"); imgui.SameLine();
            imgui.PushItemWidth(80)
            if imgui.InputInt("##carColor1", tableOfNew.carColor1) then
                HLcfg.config.carColor1 = tableOfNew.carColor1.v 
                save() 
            end
            imgui.PopItemWidth()
            imgui.AlignTextToFramePadding()
            imgui.Text("#2"); imgui.SameLine();
            imgui.PushItemWidth(80)
            if imgui.InputInt("##carColor2", tableOfNew.carColor2) then 
                HLcfg.config.carColor2 = tableOfNew.carColor2.v 
                save() 
            end
            imgui.PopItemWidth()
            imgui.NextColumn()
            imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1.0, 3.1))
            imgui.Text(u8("ID: " .. tableOfNew.intComboCar.v + 400))
            imgui.Text(u8("Авто: " .. tCarsName[tableOfNew.intComboCar.v + 1]))
            local carId = tableOfNew.intComboCar.v + 1
            local type = tCarsType[carId]
            imgui.Text(u8("Тип: " .. tCarsTypeName[type]))
            imgui.PopStyleVar()
            imgui.Columns(1)
            imgui.Separator()
            imgui.SetWindowFontScale(1.1)
            imgui.Text(u8"Частиковживані авто:")
            imgui.SetWindowFontScale(1.0)
            imgui.Separator()
            for k, v in pairs(allCarsP) do
                tt = tt + 1
                if imgui.Button(u8(v), imgui.ImVec2(100, 0)) then
                    sampSendChat('/veh '..k..' '..tableOfNew.carColor1.v..' '..tableOfNew.carColor2.v)
                end imgui.SameLine()
                if tt == 4 then
                    imgui.NewLine()
                end
            end
            imgui.NewLine()
			imgui.BeginChild('##createCar', imgui.ImVec2(463, 300), true)
			imgui.PushItemWidth(250)
			imgui.NewInputText(u8'##SearchBar', tableOfNew.findText, 444, u8"Пошук за списком", 2)
			imgui.PopItemWidth()
			imgui.Separator()
			for k,v in pairs(tCarsName) do
				if tableOfNew.findText.v ~= '' then
					if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then 
						if imgui.Button(u8(v)) then
							sampSendChat('/veh '.. k + 400 - 1 ..' '..tableOfNew.carColor1.v..' '..tableOfNew.carColor2.v)
						end
					end
				end
            end
			imgui.EndChild()
			imgui.Separator()
        end
        imgui.EndChild()
        imgui.End()
    end
    if tableOfNew.tableRes.v then
        local x, y = ToScreen(440, 0)
		local w, h = ToScreen(640, 448)
		imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(w-x, h), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"##pensBar", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
		imgui.SetWindowFontScale(1.1)
		imgui.Text(u8"Адм-довідка:")
		imgui.SetWindowFontScale(1.0)
		imgui.Separator()
		local _, hb = ToScreen(_, 416)
		imgui.BeginChild("##pens", imgui.ImVec2(w-x-2, hb))
		imgui.Columns(2, _, false)
		imgui.SetColumnWidth(-1, 255)
		imgui.Text(u8(pensTable))
		imgui.NextColumn()
		imgui.Text(u8(timesTable))
		imgui.Columns(1)
		imgui.EndChild()
		imgui.End()
    end 
    if tableOfNew.commandsAdmins.v then    
        imgui.SetNextWindowSize(imgui.ImVec2(250, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(ex / 2 - 600, ey / 2 - 50), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"##admBar", _, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.SetWindowFontScale(1.0)
        imgui.Text(u8"Команди:")
        imgui.Separator() 
        imgui.Text(u8(admTable))  
        imgui.Separator()
        imgui.End()
    end
    if tableOfNew.tempLeader.v then
        imgui.SetNextWindowSize(imgui.ImVec2(250, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(ex / 2 - 600, ey / 2 - 50), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Тимчасово вступ у організацію', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8'Покинути організацію', imgui.ImVec2(225, 0)) then
			sampSendChat('/temporg 0')
		end
		for k,v in ipairs(tempLeaders) do
			if imgui.Button(v..'['..k..']', imgui.ImVec2(225, 0)) then
				sampSendChat('/temporg '..k)
			end
		end
		imgui.End()
    end
    if elements.checkbox.statistics.v then
        if not elements.putStatis.showId.v and not
        elements.putStatis.showPing.v and not
        elements.putStatis.showHealth.v and not
        elements.putStatis.showFormDay.v and not
        elements.putStatis.showFormSession.v and not
        elements.putStatis.showReportDay.v and not
        elements.putStatis.showReportSession.v and not
        elements.putStatis.showOnlineSession.v and not
        elements.putStatis.showOnlineDay.v and not
        elements.putStatis.showAfkSession.v and not
        elements.putStatis.showAfkDay.v and not
        elements.putStatis.showTime.v and not 
        elements.putStatis.showTopDate.v and not
        elements.putStatis.showInterior.v then
            allNotTrueBool = true
        else
            allNotTrueBool = false
        end
        if elements.putStatis.showTopDate.v and elements.putStatis.showTime.v then
            pageState = true
        else
            pageState = false
        end
        imgui.SetNextWindowPos(imgui.ImVec2(HLcfg.config.posX, HLcfg.config.posY), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
        if elements.putStatis.nameStatis.v then
		    imgui.Begin(u8'Статистика', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
        else
            imgui.Begin(u8'Статистика', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
        end
        if not allNotTrueBool then --[[Если все выключено то]]
            if elements.putStatis.showId.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'ІД: '..getMyId()) else imgui.Text(u8"ІД: "..getMyId()) end end
            if elements.putStatis.showPing.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Пінг: '..sampGetPlayerPing(getMyId())) else imgui.Text(u8"Пінг: "..sampGetPlayerPing(getMyId())) end end
            if elements.putStatis.showHealth.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'ХП: '..sampGetPlayerHealth(getMyId())) else imgui.Text(u8'ХП: '..sampGetPlayerHealth(getMyId())) end end 
            if elements.putStatis.showFormDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Форм за день: '..HLcfg.config.dayForms) else imgui.Text(u8"Форм за день: "..HLcfg.config.dayForms) end end
            if elements.putStatis.showFormSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Форм за сеанс: '..LsessionForma) else imgui.Text(u8'Форм за сеанс: '..LsessionForma) end end 
            if elements.putStatis.showReportDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Репортів за день: '..HLcfg.config.dayReports) else imgui.Text(u8'Репортів за день: '..HLcfg.config.dayReports) end end 
            if elements.putStatis.showReportSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Репортів за сеанс: '..LsessionReport) else imgui.Text(u8'Репортів за сеанс: '..LsessionReport) end end
            if elements.putStatis.showInterior.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(getCharActiveInterior(playerPed) == 0 and 'Ви не в інті' or 'Інта: '..getCharActiveInterior(playerPed))) else imgui.Text(u8(getCharActiveInterior(playerPed) == 0 and 'Ви не в інті' or 'Інта: '..getCharActiveInterior(playerPed))) end end
            if elements.putStatis.showOnlineSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Онлайн за сеанс: '..get_clock(sessionOnline.v)) else imgui.Text(u8'Онлайн за сеанс: '..get_clock(sessionOnline.v)) end end
            if elements.putStatis.showOnlineDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Онлайн за день: '..get_clock(HLcfg.onDay.online)) else imgui.Text(u8'Онлайн за день: '..get_clock(HLcfg.onDay.online)) end end
            if elements.putStatis.showAfkSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'АФК за сеанс: '..get_clock(sessionAfk.v)) else imgui.Text(u8'АФК за сеанс: '..get_clock(sessionAfk.v)) end end
            if elements.putStatis.showAfkDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'АФК за день: '..get_clock(HLcfg.onDay.afk)) else imgui.Text(u8'АФК за день: '..get_clock(HLcfg.onDay.afk)) end end
            if not pageState then
                if elements.putStatis.showTime.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(string.format(os.date("Час: %H:%M:%S", os.time())))) else imgui.Text(u8(string.format(os.date("Час: %H:%M:%S", os.time())))) end end
                if elements.putStatis.showTopDate.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(string.format(os.date("Дата: %d.%m.%y")))) else imgui.Text(u8(string.format(os.date("Дата: %d.%m.%y")))) end end
            else
                if elements.putStatis.centerText.v then
                    imgui.centeredText(u8(os.date("%d.%m.%y | %H:%M:%S", os.time()))) else 
                        imgui.Text(u8(os.date("%d.%m.%y | %H:%M:%S", os.time()))) end
            end
        else
            imgui.Text(u8"Жодна функція не увімкнена.")
        end
		imgui.End()
    end
    if tableOfNew.AutoReport.v then
        if elements.checkbox.areportclick.v then
            if isKeyJustPressed(VK_U) and is_key_check_available() then
                imgui.ShowCursor = not imgui.ShowCursor
            end
        else
            imgui.ShowCursor = true
        end
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(537, 450), imgui.Cond.FirstUseEver)	
        imgui.Begin(u8'Авто-Репорт', tableOfNew.AutoReport, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##i_report', imgui.ImVec2(520, 30), true)		
        if #reports > 0 then
            imgui.PushTextWrapPos(500)
            imgui.TextUnformatted(u8(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP))
            imgui.PopTextWrapPos()
        end
        imgui.EndChild()
        imgui.Separator()
        imgui.PushItemWidth(520)
        imgui.InputText(u8'##answer_input_report', tableOfNew.answer_report)
        imgui.PopItemWidth()
        imgui.Text(u8'                                                          Введіть відповідь')
        imgui.Separator()
        if imgui.Button(u8'Працювати по ID', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                if reports[1].textP:find('%d+') then
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    lua_thread.create(function()
                        local id = reports[1].textP:match('(%d+)')
                        sampSendChat('/ans '..reports[1].id..' Вітаю, починаю роботу за вашою скаргою!')
                        wait(1000)
                        sampSendChat('/re '..id)
                        refresh_current_report()
                    end)
                else
                    sampAddChatMessage('{FF0000}[Помилка] {FF8C00}У репорті відсутній ІД.', stColor)
                end
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Допомогти гравцю', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/goto '..reports[1].id)
                    wait(1000)
                    sampSendChat('/ans '..reports[1].id..' Вітаю, зараз спробую вам допомогти!')		
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Слідкувати', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/re '..reports[1].id)
                    local pID = reports[1].id
                    wait(1000)
                    sampSendChat('/ans '..pID..' Вітаю, починаю роботу за вашою скаргою!')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Передати', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    local bool = _sampSendChat(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP, 80)
                    wait(1000)
                    sampSendChat('/ans '..reports[1].id..' Вітаю, передам вашу запит.')
                    refresh_current_report()
                end)
            end
        end
        imgui.Separator()
        local clr = imgui.Col
        imgui.PushStyleColor(clr.Button, imgui.ImVec4(0.86, 0.09, 0.09, 0.65))
        imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0.74, 0.04, 0.04, 0.65))
        imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0.96, 0.15, 0.15, 0.50))
        if imgui.Button(u8'//offtop', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'//offtop')
            end
        end
        imgui.PopStyleColor(3)
        imgui.Separator()
        if imgui.Button(u8'ЖБ на ФО', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ans '..reports[1].id..' Вітаю, ви можете залишити свою скаргу на оф. форумі проєкту.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Не володіємо', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ans '..reports[1].id..' Вітаю, не володіємо даною інформацією.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'РП шляхом', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ans '..reports[1].id..' Вітаю, ви повинні дізнатися самостійно. РП шляхом.') 
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Приємної гри', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ans '..reports[1].id..' Вітаю, приємної гри на нашому сервері :).')
                refresh_current_report()
            end
        end imgui.SameLine()
        imgui.Separator()
        if imgui.Button(u8'Відповісти', imgui.ImVec2(100, 0)) then
            if tableOfNew.answer_report.v == '' then
                sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Введіть коректну відповідь.', stColor)
            else
                if #reports > 0 then
                    sampSendChat('/pm '..reports[1].id..' '..u8:decode(tableOfNew.answer_report.v))
                    refresh_current_report()
                    tableOfNew.answer_report.v = ''
                end
            end
        end imgui.SameLine() 
        if imgui.Button(u8'СП', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/ans '..reports[1].id..' Вітаю, зараз спробую вам допомогти!')
                    wait(1000)
                    sampSendChat('/spawn '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()
        if imgui.Button(u8'DReports', imgui.ImVec2(100, 0)) then
            reports = {
                [0] = {
                    nickname = '',
                    id = -1,
                    textP = ''
                }
            }
        end imgui.SameLine()
        if imgui.Button(u8'Пропустити', imgui.ImVec2(100, 0)) then
            refresh_current_report()
        end
        imgui.Separator()
        if imgui.BeginPopupModal(u8"Оффтоп", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            if imgui.Button(u8"Зробити попередження", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/ans "..reports[1].id.." Вітаю, у разі подальшого здійснення оффтопу - буде бан репорту.")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end
            if imgui.Button(u8"Наказати", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/rmute "..reports[1].id.." 10 Оффтоп")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end 
            if imgui.Button(u8'Зачинити', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
    end
    if sampIsPlayerConnected(rInfo.id) and rInfo.id ~= -1 and rInfo.state then
        local x, y = ToScreen(552, 230)
        local w, h = ToScreen(638, 330)
        if imgui.IsMouseClicked(1) then
            imgui.ShowCursor = not imgui.ShowCursor
        end	
        local m, a = ToScreen(200, 410)
        imgui.SetNextWindowPos(imgui.ImVec2(m, a), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(537, 60), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"##DownPanel", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        local bet = imgui.ImVec2(70, 0)
        if imgui.Button(u8'<< BACK', bet) then
            if rInfo.id == 0 then
                local onMaxId = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(onMaxId) or sampGetPlayerScore(onMaxId) == 0 or sampGetPlayerColor(onMaxId) == 16510045 then 
                    for i = sampGetMaxPlayerId(false), 0, -1 do
                        if sampIsPlayerConnected(i) and not sampIsPlayerNpc(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id then
                            rInfo.id = i
                            sampSendChat('/re '..rInfo.id)
                            break
                        end
                    end
                else 
                    sampSendChat('/re '..sampGetMaxPlayerId(false))
                end
            else 
                for i = rInfo.id, 0, -1 do
					if sampIsPlayerConnected(i) and sampGetPlayerScore(i) ~= 0 and sampGetPlayerColor(i) ~= 16510045 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
						sampSendChat('/re '..i)
						break
					end
				end
            end
        end imgui.SameLine()
        if imgui.Button(u8'Stats', bet) then
            sampSendChat('/stats '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'Spawn', bet) then
            sampSendChat('/spawn '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'Slap', bet) then
            sampSendChat('/slap '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'UPDown', bet) then
            sampSendChat('/updown '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'GoodGame', bet) then
            sampSendChat('/gg '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'NEXT >>', bet) then
            if rInfo.id == sampGetMaxPlayerId(false) then
                if not sampIsPlayerConnected(0) or sampGetPlayerScore(0) == 0 or sampGetPlayerColor(0) == 16510045 then
                    for i = rInfo.id, sampGetMaxPlayerId(false) do 
                        if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
                            rInfo.id = i
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else
                    sampSendChat('/re 0')
                end 
            else 
                for i = rInfo.id, sampGetMaxPlayerId(false) do 
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
                        rInfo.id = i
                        sampSendChat('/re '..i)
                        break
                    end
                end
            end
        end
        if imgui.Button(u8'History', bet) then
                sampSendChat('/apenalty '..getNick(rInfo.id))
        end	imgui.SameLine()
        if imgui.Button(u8'До гравця', bet) then 
            lua_thread.create(function()
                tpaid = rInfo.id
                sampSendChat('/reoff')
                wait(1000)
                sampSendChat('/tpa '..tpaid)
            end)
        end imgui.SameLine()
        if imgui.Button(u8'До себе', bet) then
            lua_thread.create(function()
                gethereId = rInfo.id
                sampSendChat('/reoff')
                wait(1000)
                sampSendChat('/gethere '..rInfo.id)
            end)
        end imgui.SameLine()
        if imgui.Button(u8'Звільнити', bet) then 
            sampSendChat('/auninvite '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'Авто', bet) then
            imgui.OpenPopup(u8"Видати авто")
        end imgui.SameLine()
        if imgui.Button(u8'Зброя', bet) then
            imgui.OpenPopup(u8'Виберіть зброю')
        end imgui.SameLine()
        if imgui.Button(u8'Вихід', bet) then
            sampSendChat('/reoff')
        end
        if imgui.BeginPopupModal(u8"Видати авто", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8"Виберіть транспорт:")
            imgui.PushItemWidth(142)
            imgui.Combo("##createiscarrecon", tableOfNew.intComboCar, tCarsName)
            imgui.PopItemWidth()
            if imgui.Button(u8"Створити", imgui.ImVec2(175, 0)) then
                sampSendChat("/veh " .. tableOfNew.intComboCar.v + 400 .. " 1 1")
            end
            if imgui.Button(u8"Зачинити", imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Виберіть зброю", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8'Введіть кол-во пт.')
            imgui.InputText('##numbersAmmo', tableOfNew.inputAmmoBullets)
            imgui.Text(u8'Виберіть зброю') 
            imgui.Combo('##selecting', tableOfNew.selectGun, arrGuns)
            if imgui.Button(u8'Выдать', imgui.ImVec2(175, 0)) then
                if tableOfNew.inputAmmoBullets.v ~= '' then
                    sampSendChat('/givegun '..rInfo.id..' '..tonumber(tableOfNew.selectGun.v)..' '..tableOfNew.inputAmmoBullets.v)
                    imgui.CloseCurrentPopup()
                else
                    sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Введіть кол-во пт.', stColor)
                end
            end
            if imgui.Button(u8'Зачинити', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
        imgui.SetNextWindowPos(imgui.ImVec2(x, y - 150), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(137, 152), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"Покарання", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize)
        if imgui.Button(u8'Видати kick', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Видати kick')
        end
        if imgui.Button(u8'Видати dm', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Видати dm')
        end
        if imgui.Button(u8'Видати warn', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Видати warn')
        end
        if imgui.Button(u8'Видати mute', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Видати mute')
        end
        if imgui.Button(u8'Видати ban', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Видати ban')
        end	        
        if imgui.BeginPopupModal(u8"Видати kick", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(130, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/kick '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'AFK w/o esc', bsize) then
                sampSendChat('/kick '..rInfo.id..' AFK w/o esc')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Завада', bsize) then
                sampSendChat('/kick '..rInfo.id..' Завада')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Зачинити', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Видати dm", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(125, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/dm '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДМ', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 ДМ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДБ', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 ДБ')
                imgui.CloseCurrentPopup()
            end  
            if imgui.Button(u8'РК', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 РК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ПГ', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 ПГ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'СК', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 СК')
                imgui.CloseCurrentPopup()
            end 
            if imgui.Button(u8'ТК', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 ТК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'NRP-дія', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 NRP-дія')
                imgui.CloseCurrentPopup()
            end 
            if imgui.Button(u8'NRP-їзда', bsize) then
                sampSendChat('/dm '..rInfo.id..' 20 NRP-їзда')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'NRP-коп', bsize) then
                sampSendChat('/dm '..rInfo.id..' 60 NRP-коп')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Ухід від РП', bsize) then
                sampSendChat('/dm '..rInfo.id..' 90 Відхід від RP')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Зачинити', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Видати mute", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(150, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/mute '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'МГ', bsize) then
                sampSendChat('/mute '..rInfo.id..' 30 МГ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Caps', bsize) then
                sampSendChat('/mute '..rInfo.id..' 30 Caps')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Flood', bsize) then
                sampSendChat('/mute '..rInfo.id..' 20 Flood')
                imgui.CloseCurrentPopup()
            end 
            if imgui.Button(u8'Translit', bsize) then
                sampSendChat('/mute '..rInfo.id..' 30 Translit')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Образа Гравців', bsize) then
                sampSendChat('/mute '..rInfo.id..' 45 Образа Гравців')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Обгов.дій адм', bsize) then
                sampSendChat('/mute '..rInfo.id..' 60 Обговорення дій адміністрації')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Згадка родичів', bsize) then
                sampSendChat('/mute '..rInfo.id..' 90 Згадка родичів')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Зачинити', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Видати warn", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(175, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/warn '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДМ', bsize) then
                sampSendChat('/warn '..rInfo.id..' ДМ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДБ', bsize) then
                sampSendChat('/warn '..rInfo.id..' ДБ')
                imgui.CloseCurrentPopup()
            end  
            if imgui.Button(u8'РК', bsize) then
                sampSendChat('/warn '..rInfo.id..' РК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ПГ', bsize) then
                sampSendChat('/warn '..rInfo.id..' ПГ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'СК', bsize) then
                sampSendChat('/warn '..rInfo.id..' СК')
                imgui.CloseCurrentPopup()
            end 
            if imgui.Button(u8'ТК', bsize) then
                sampSendChat('/warn '..rInfo.id..' ТК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'NRP-коп', bsize) then
                sampSendChat('/warn '..rInfo.id..' NRP-коп')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Ухід від РП', bsize) then
                sampSendChat('/warn '..rInfo.id..' Відхід від RP')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Зачинити', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Видати ban", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(125, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/ban '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ППВ', bsize) then
                sampSendChat('/ban '..rInfo.id..' 30 ППВ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Об.рідних', bsize) then
                sampSendChat('/ban '..rInfo.id..' 30 Образа Рідних')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Багоюз', bsize) then
                sampSendChat('/ban '..rInfo.id..' 15 Багоюз')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Нацизм', bsize) then
                sampSendChat('/ban '..rInfo.id..' 30 Нацизм')
                imgui.CloseCurrentPopup()
            end   
            if imgui.Button(u8'Обман адм', bsize) then
                sampSendChat('/ban '..rInfo.id..' 30 Обман адміністрації')
                imgui.CloseCurrentPopup()
            end  
            if imgui.Button(u8'Перешкода RP', bsize) then
                sampSendChat('/ban '..rInfo.id..' 3 Перешкода RP-процесу')
                imgui.CloseCurrentPopup()
            end 
            if imgui.Button(u8'Зачинити', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
        imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(w-x, 198), imgui.Cond.FirstUseEver)
    end
end

function samp.onShowDialog(id, style, title, button1, button2, text)
    if elements.checkbox.autoCome.v then
        if elements.input.adminPassword ~= '' then
            lua_thread.create(function()
                while true do
                    wait(0)
                    if title:match("Пароль") then
                        sampSendDialogResponse(sampGetCurrentDialogId(), 1, _, elements.input.adminPassword.v)
                        sampCloseCurrentDialogWithButton(0)
                        break
                    end
                end
            end)
        else
            sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Авто-вхід не буде зроблено, оскільки ви не вказали адмін-пароль.', stColor)
            elements.checkbox.autoCome.v = false
            HLcfg.config.autoCome = elements.checkbox.autoCome.v
            save()
        end
	end
end

function samp.onPlayerDeathNotification(killerId, killedId, reason)
	if elements.checkbox.showKillerId.v then
		local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
		local _, myid = sampGetPlayerIdByCharHandle(playerPed)

		local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
		local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
		lua_thread.create(function()
			wait(0)
			if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
			if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
		end)
	end
end

function imgui.HelpMarker(text)
	imgui.TextDisabled('(?)')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function getActiveOrganization(id)
	local color = sampGetPlayerColor(id)
	if color == 553648127 then
		organization = u8'Нет[0]'
	elseif color == 2854633982 then
		organization = u8'LSPD[1]'
	elseif color == 2855350577 then
		organization = u8'FBI[2]'
	elseif color == 2855512627 then
		organization = u8'Армия[3]'
	elseif color == 4289014314 then
		organization = u8'МЧС[4]'
	elseif color == 4292716289 then
		organization = u8'LCN[5]'
	elseif color == 2868838400 then
		organization = u8'Якудза[6]'
	elseif color == 4279324017 then
		organization = u8'Мэрия[7]'
	elseif color == 2854633982 then
		organization = u8'SFPD[10]'
	elseif color == 4279475180 then
		organization = u8'Инструкторы[11]'
	elseif color == 4287108071 then
		organization = u8'Баллас[12]'
	elseif color == 2866533892 then
		organization = u8'Вагос[13]'
	elseif color == 4290033079 then
		organization = u8'Мафия[14]'
	elseif color == 2852167424 then
		organization = u8'Грув[15]'
	elseif color == 2856354955 then
		organization = u8'Sa News[16]'
	elseif color == 3355573503 then
		organization = u8'Ацтеки[17]'
	elseif color == 2860761023 then
		organization = u8'Рифа[18]'
	elseif color == 2854633982 then
		organization = u8'LVPD[21]'
	elseif color == 4285563024 then
		organization = u8'Хитманы[22]'
	elseif color == 4294201344 then
		organization = u8'Стритрейсеры[23]'
	elseif color == 4281240407 then
		organization = u8'SWAT[24]'
	elseif color == 2859499664 then
		organization = u8'АП[25]'
	elseif color == 2868838400 then
		organization = u8'Казино[26]'
	elseif color == 2863280947 then
		organization = u8'ПБ Red[()]'
	elseif color == 4281576191 then
		organization = u8'ПБ Blue[()]'
	elseif color == 8025703 then
		organization = u8'В маске[()]'
	end
	return organization
end

function nameTagOn()
	local pStSet = sampGetServerSettingsPtr()
	memory.setfloat(pStSet + 39, 1488.0)
	memory.setint8(pStSet + 47, 0)
	memory.setint8(pStSet + 56, 1)
end

function nameTagOff()
	local pStSet = sampGetServerSettingsPtr()
	memory.setfloat(pStSet + 39, 50.0)
	memory.setint8(pStSet + 47, 0)
	memory.setint8(pStSet + 56, 1)
end

function save()
    inicfg.save(HLcfg, "AdminTools.ini")
end

function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..' ' or '')..'%H:%M:%S', time + timezone_offset)
end

function samp.onShowMenu()
	if rInfo.id ~= -1 then
		return false
	end
end
function samp.onHideMenu()
	if rInfo.id ~= -1 then
		return false
	end
end

function getAmmoRecon()
	local result, recon_handle = sampGetCharHandleBySampPlayerId(rInfo.id)
	if result then
		local weapon = getCurrentCharWeapon(recon_handle)
		local struct = getCharPointer(recon_handle) + 0x5A0 + getWeapontypeSlot(weapon) * 0x1C
		return getStructElement(struct, 0x8, 4)
	end
end

function samp.onTogglePlayerSpectating(state)
	rInfo.state = state
	if not state then
		rInfo.id = -1
    end
end

function isSpawnerFor(number)
    local lasttime = os.time()
    local lasttimes = 0
    local time_out = number
    lua_thread.create(function()
        while lasttimes < time_out do
            local lasttimes = os.time() - lasttime
            wait(0)
            printStyledString("Cars will be spawned in >> "..time_out - lasttimes, 1000, 4)
            if lasttimes == time_out then
                break
            end
        end
    end)
end 

function refresh_current_report()
	table.remove(reports, 1)
end

function samp.onShowTextDraw(id, data)
	if rInfo.id ~= -1 then
		lua_thread.create(function()
			while true do 
				wait(0)
				if data.text:find('.*') then
					sampTextdrawDelete(id)
				end
			end
		end)
	end
end

function samp.onSendCommand(cmd)
    rID = cmd:match('/re%s+(%d+)')
    rGoto = cmd:match('/goto%s+(%d+)')
	if rID then
		if rID:len() > -1 and rID:len() < 4 then
            rInfo.id = tonumber(rID)
		else
			sampAddChatMessage('{FF0000}[Помилка] {FF8C00}Вкажіть коректний ІД.', stColor)
		end
    end
    if rGoto or rID then 
        enAirBrake = false
    end
end

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end

ChatBox = function(pagesize, blacklist)
    local obj = {
      pagesize = elements.int.limitPageSize.v,
          active = false,
          font = nil,
          messages = {},
          blacklist = blacklist,
          firstMessage = 0,
          currentMessage = 0,
    }
  
      function obj:initialize()
          if self.font == nil then
              self.font = renderCreateFont('Verdana', 8, FCR_BORDER + FCR_BOLD)
          end
      end
  
      function obj:free()
          if self.font ~= nil then
              renderReleaseFont(self.font)
              self.font = nil
          end
      end
  
      function obj:toggle(show)
          self:initialize()
          self.active = show
      end
  
    function obj:draw(x, y)
          local add_text_draw = function(text, color)
              renderFontDrawText(self.font, text, x, y, color)
              y = y + renderGetFontDrawHeight(self.font)
          end
  
          -- draw caption
      add_text_draw("Admin Chat", 0xFFE4D8CC)
  
          -- draw page indicator
          if #self.messages == 0 then return end
          local cur = self.currentMessage
          local to = cur + math.min(self.pagesize, #self.messages) - 1
          add_text_draw(string.format("%d/%d", to, #self.messages), 0xFFE4D8CC)
  
          -- draw messages
          x = x + 4
          for i = cur, to do
              local it = self.messages[i]
              add_text_draw(
                  string.format("{E4E4E4}[%s] (%.1fm) {%06X}%s{D4D4D4}({EEEEEE}%d{D4D4D4}): {%06X}%s",
                      it.time,
                      it.dist,
                      argb_to_rgb(it.playerColor),
                      it.nickname,
                      it.playerId,
                      argb_to_rgb(it.color),
                      it.text),
                  it.color)
          end
    end
  
      function obj:add_message(playerId, color, distance, text)
          -- ignore blacklisted messages
          if self:is_text_blacklisted(text) then return end
  
          -- process only streamed in players
          local dist = get_distance_to_player(playerId)
          if dist ~= nil then
              color = bgra_to_argb(color)
              if dist > distance then color = set_argb_alpha(color, 0xA0)
              else color = set_argb_alpha(color, 0xF0)
              end
              table.insert(self.messages, {
                  playerId = playerId,
                  nickname = sampGetPlayerNickname(playerId),
                  color = color,
                  playerColor = sampGetPlayerColor(playerId),
                  dist = dist,
                  distLimit = distance,
                  text = text,
                  time = os.date('%X')})
  
              -- limit message list
              if #self.messages > elements.int.maxPagesBubble.v then
                  self.messages[self.firstMessage] = nil
                  self.firstMessage = #self.messages - elements.int.maxPagesBubble.v
              else
                  self.firstMessage = 1
              end
              self:scroll(1)
          end
      end
  
      function obj:is_text_blacklisted(text)
          for _, t in pairs(self.blacklist) do
              if string.match(text, t) then
                  return true
              end
          end
          return false
      end
  
      function obj:scroll(n)
          self.currentMessage = self.currentMessage + n
          if self.currentMessage < self.firstMessage then
              self.currentMessage = self.firstMessage
          else
              local max = math.max(#self.messages, self.pagesize) + 1 - self.pagesize
              if self.currentMessage > max then
                  self.currentMessage = max
              end
          end
      end
  
    setmetatable(obj, {})
    return obj
end

function take_vehicle_back(vehicleId)
	sampSendExitVehicle(vehicleId)
	wait(0)
	sampForceOnfootSync()
	wait(0)
	sampSendEnterVehicle(vehicleId, false)
	wait(15)
	sampForceVehicleSync(vehicleId)
end

function samp.onVehicleSync(playerId, vehicleId, data)
    if elements.checkbox.antiEjectCar.v and is_player_stealing_my_vehicle(playerId, vehicleId) then
		if not warningMsgTick or gameClock() - warningMsgTick > 3 then
			warningMsgTick = gameClock()
		end
		lua_thread.create(take_vehicle_back, vehicleId)
		return false
    end
    infoCar.pcar.idLastCar = vehicleId
end

function samp.onPlayerEnterVehicle(playerId, vehicleId, passenger)
    if elements.checkbox.antiEjectCar.v and is_player_stealing_my_vehicle(playerId, vehicleId) then
		return false
    end
end

function is_player_stealing_my_vehicle(playerId, vehicleId)
	if isCharInAnyCar(playerPed) and sampIsPlayerConnected(playerId) then
		local _, myVehId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed))
		return myVehId == vehicleId
	end
	return false
end
  
function get_distance_to_player(playerId)
      if sampIsPlayerConnected(playerId) then
          local result, ped = sampGetCharHandleBySampPlayerId(playerId)
          if result and doesCharExist(ped) then
              local myX, myY, myZ = getCharCoordinates(playerPed)
              local playerX, playerY, playerZ = getCharCoordinates(ped)
              return getDistanceBetweenCoords3d(myX, myY, myZ, playerX, playerY, playerZ)
          end
      end
      return nil
end

function cleanStreamMemory()
	local huy = callFunction(0x53C500, 2, 2, true, true)
	local huy1 = callFunction(0x53C810, 1, 1, true)
	local huy2 = callFunction(0x40CF80, 0, 0)
	local huy3 = callFunction(0x4090A0, 0, 0)
	local huy4 = callFunction(0x5A18B0, 0, 0)
	local huy5 = callFunction(0x707770, 0, 0)
	
	local pX, pY, pZ = getCharCoordinates(PLAYER_PED)
	requestCollision(pX, pY)
	loadScene(pX, pY, pZ)
end
  
function is_key_check_available()
    if not isSampfuncsLoaded() then
      return not isPauseMenuActive()
    end
    local result = not isSampfuncsConsoleActive() and not isPauseMenuActive()
    if isSampLoaded() and isSampAvailable() then
      result = result and not sampIsChatInputActive() and not sampIsDialogActive()
    end
    return result
end
  
function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end
  
function bgra_to_argb(bgra)
    local b, g, r, a = explode_argb(bgra)
    return join_argb(a, r, g, b)
end
  
function set_argb_alpha(color, alpha)
        local _, r, g, b = explode_argb(color)
          return join_argb(alpha, r, g, b)
end
  
function get_argb_alpha(color)
      local alpha = explode_argb(color)
      return alpha
end
  
function argb_to_rgb(argb)
      return bit.band(argb, 0xFFFFFF)
end

function onScriptTerminate(script)
    if script == thisScript() then
      if doesFileExist(directory) then
        os.remove(directory)
      end
      local f = io.open(directory, "w")
      if f then
        f:write(encodeJson(playersList))
        f:close()
      end
      if doesFileExist(fpath) then
        local f = io.open(fpath, 'w+')
        if f then
          f:write(encodeJson(defTable)):close()
        end
      end
    end
end

function samp.onPlayerChatBubble(playerId, color, distance, duration, message)
	if sampIsPlayerConnected(playerId) and bubbleBox then
		bubbleBox:add_message(playerId, color, distance, message)
	end
end

function luasave()
    luacfg.save(filename_settings, cfg)
end 

function click_warp()
    lua_thread.create(function()
        while true do
        if cursorEnabled and not AdminTools.v and not changePosition and rInfo.id == -1 and not tableOfNew.AutoReport.v then
          local mode = sampGetCursorMode()
          if mode == 0 then
            showCursor(true)
          end
          local sx, sy = getCursorPos()
          local sw, sh = getScreenResolution()
          if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
            local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
            local camX, camY, camZ = getActiveCameraCoordinates()
            local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ,
            true, true, false, true, false, false, false)
            if result and colpoint.entity ~= 0 then
              local normal = colpoint.normal
              local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
              local zOffset = 300
              if normal[3] >= 0.5 then zOffset = 1 end
              local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
                true, true, false, true, false, false, false)
              if result then
                pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

                local curX, curY, curZ  = getCharCoordinates(playerPed)
                local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
                local hoffs             = renderGetFontDrawHeight(font)

                sy = sy - 2
                sx = sx - 2
                renderFontDrawText(font, string.format("{FFFFFF}%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)

                local tpIntoCar = nil
                if colpoint.entityType == 2 then
                  local car = getVehiclePointerHandle(colpoint.entity)
                  if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
                    displayVehicleName(sx, sy - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
                    local color = 0xFFFFFFFF
                    if isKeyDown(VK_RBUTTON) then
                      tpIntoCar = car
                      color = 0xFFFFFFFF
                    end
                    renderFontDrawText(font, "{FFFFFF}Hold right mouse button to teleport into the car", sx, sy - hoffs * 3, color)
                  end
                end

                createPointMarker(pos.x, pos.y, pos.z)

                if isKeyDown(VK_LBUTTON) then
                  if tpIntoCar then
                    if not jumpIntoCar(tpIntoCar) then
                      teleportPlayer(pos.x, pos.y, pos.z)
                      local veh = storeCarCharIsInNoSave(playerPed)
                      local cordsVeh = {getCarCoordinates(veh)}
                      setCarCoordinates(veh, cordsVeh[1], cordsVeh[2], cordsVeh[3])
                    end
                  else
                    if isCharInAnyCar(playerPed) then
                      local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
                      local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
                      rotateCarAroundUpAxis(storeCarCharIsInNoSave(playerPed), norm2)
                      pos = pos - norm * 1.8
                      pos.z = pos.z - 1.1
                    end
                    teleportPlayer(pos.x, pos.y, pos.z)
                  end
                  removePointMarker()

                  while isKeyDown(VK_LBUTTON) do wait(0) end
                  showCursor(false)
                end
              end
            end
          end
        end
        wait(0)
        removePointMarker()
        end
    end)
end

function imgui.ToggleButton(str_id, bool)
    local rBool = false

	if LastActiveTime == nil then
		LastActiveTime = {}
	end
	if LastActive == nil then
		LastActive = {}
	end

	local function ImSaturate(f)
		return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end
	
	local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList()

	local height = imgui.GetTextLineHeightWithSpacing()
	local width = height * 1.55
	local radius = height * 0.50
	local ANIM_SPEED = 0.15

	if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
		bool.v = not bool.v
		rBool = true
		LastActiveTime[tostring(str_id)] = os.clock()
		LastActive[tostring(str_id)] = true
	end

	local t = bool.v and 1.0 or 0.0

	if LastActive[tostring(str_id)] then
		local time = os.clock() - LastActiveTime[tostring(str_id)]
		if time <= ANIM_SPEED then
			local t_anim = ImSaturate(time / ANIM_SPEED)
			t = bool.v and t_anim or 1.0 - t_anim
		else
			LastActive[tostring(str_id)] = false
		end
	end

	local col_bg
	if bool.v then
		col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
	else
		col_bg = imgui.ImColor(100, 100, 100, 180):GetU32()
	end

	draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y + (height / 6)), imgui.ImVec2(p.x + width - 1.0, p.y + (height - (height / 6))), col_bg, 5.0)
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 0.75, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.ImColor(150, 150, 150, 255):GetVec4()))

	return rBool
end

local russian_characters = {
    [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then -- Ё
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end

function time()
	startTime = os.time()
    while true do
        wait(1000)
        if sampGetGamestate() == 3 then 								
	        nowTime = os.date("%H:%M:%S", os.time()) 			

	        sessionOnline.v = sessionOnline.v + 1 							
	        sessionFull.v = os.time() - startTime 					
	        sessionAfk.v = sessionFull.v - sessionOnline.v						

	        HLcfg.onDay.online = HLcfg.onDay.online + 1 				
	        HLcfg.onDay.full = dayFull.v + sessionFull.v 						
			HLcfg.onDay.afk = HLcfg.onDay.full - HLcfg.onDay.online
			
	    else
	    	startTime = startTime + 1
	    end
    end
end

function autoSave()
	while true do 
		wait(60000)
		save()
	end
end

function fixChatCoursor()
    lua_thread.create(function()
        sampSetChatInputEnabled(true)
        wait(100)
        sampSetChatInputEnabled(false)
    end)
end

function samp.onSendPlayerSync(data)
    if ainvisible then data.surfingVehicleId = 2001 end
end

function dialogHiderText()
    lua_thread.create(function()
    local result, button, list, input = sampHasDialogRespond(3910)
	if result then
		if list == 0 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, бігати не за призначенням, стріляти без команди.')
			wait(1000)
			sampSendChat('/s Я викликаю 2-ох гравців, вони стають спиною до спини на будь-якій дистанції..')
			wait(1000)
			sampSendChat('/s І на рахунок 1-2-3 починають ПВП.')
		elseif list == 1 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, бігати не за призначенням, тікати.')
			wait(1000)
			sampSendChat('/s Через /try ми знайдемо переможця.')
		elseif list == 2 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, змінювати машину.')
			wait(1000)
			sampSendChat('/s Останній, хто залишився поза підірваною машиною, - переміг.')
		elseif list == 3 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, стріляти по гравцях.')
			wait(1000)
			sampSendChat('/s Хто перший пройде паркур - переміг.')
		elseif list == 4 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, стріляти по гравцях.')
			wait(1000)
			sampSendChat('/s Хто перший залишиться на поверхні - переміг.')
		elseif list == 5 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, стріляти по гравцях.')
			wait(1000)
			sampSendChat('/s Хто останній залишиться в живих - переміг.')
		elseif list == 6 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід, стріляти по гравцях.')
			wait(1000)
			sampSendChat('/s Хто краще за всіх сховається - переміг.')
		elseif list == 7 and button == 1 then
			sampSendChat('/s Увага, озвучую правила!')
			wait(1000)
			sampSendChat('/s Заборонено: Зривати захід.')
			wait(1000)
			sampSendChat('/s Ви повинні будете вбити один одного. Хто останній залишиться в живих - переміг.')
		end
    end
    end)
end

function rotateCarAroundUpAxis(car, vec)
    local mat = Matrix3X3(getVehicleRotationMatrix(car))
    local rotAxis = Vector3D(mat.up:get())
    vec:normalize()
    rotAxis:normalize()
    local theta = math.acos(rotAxis:dotProduct(vec))
    if theta ~= 0 then
      rotAxis:crossProduct(vec)
      rotAxis:normalize()
      rotAxis:zeroNearZero()
      mat = mat:rotate(rotAxis, -theta)
    end
    setVehicleRotationMatrix(car, mat:get())
end
  
function readFloatArray(ptr, idx)
    return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end
  
function writeFloatArray(ptr, idx, value)
    writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end

function samp.onPlayerQuit(id, reason)
	if elements.checkbox.leaveChecker.v then
		sampAddChatMessage(string.format("{FF0000}[GhostTools] {FF8C00}%s[%d] від'єднався. Причина: %s", getNick(id), id, quitReason[reason+1]), stColor)
    end
end
  
function getVehicleRotationMatrix(car)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
      local mat = readMemory(entityPtr + 0x14, 4, false)
      if mat ~= 0 then
        local rx, ry, rz, fx, fy, fz, ux, uy, uz
        rx = readFloatArray(mat, 0)
        ry = readFloatArray(mat, 1)
        rz = readFloatArray(mat, 2)
  
        fx = readFloatArray(mat, 4)
        fy = readFloatArray(mat, 5)
        fz = readFloatArray(mat, 6)
  
        ux = readFloatArray(mat, 8)
        uy = readFloatArray(mat, 9)
        uz = readFloatArray(mat, 10)
        return rx, ry, rz, fx, fy, fz, ux, uy, uz
      end
    end
end

function getNick(id)
    local nick = sampGetPlayerNickname(id)
    return nick
end

function getMyNick()
    local result, id = sampGetPlayerIdByCharHandle(playerPed)
    if result then
        local nick = sampGetPlayerNickname(id)
        return nick
    end
end

function getMyId()
    local result, id = sampGetPlayerIdByCharHandle(playerPed)
    if result then
        return id
    end
end
  
function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
      local mat = readMemory(entityPtr + 0x14, 4, false)
      if mat ~= 0 then
        writeFloatArray(mat, 0, rx)
        writeFloatArray(mat, 1, ry)
        writeFloatArray(mat, 2, rz)
  
        writeFloatArray(mat, 4, fx)
        writeFloatArray(mat, 5, fy)
        writeFloatArray(mat, 6, fz)
  
        writeFloatArray(mat, 8, ux)
        writeFloatArray(mat, 9, uy)
        writeFloatArray(mat, 10, uz)
      end
    end
end
  
function displayVehicleName(x, y, gxt)
    x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
    useRenderCommands(true)
    setTextWrapx(640.0)
    setTextProportional(true)
    setTextJustify(false)
    setTextScale(0.33, 0.8)
    setTextDropshadow(0, 0, 0, 0, 0)
    setTextColour(255, 255, 255, 230)
    setTextEdge(1, 0, 0, 0, 100)
    setTextFont(1)
    displayText(x, y, gxt)
end
  
function createPointMarker(x, y, z)
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
  
function removePointMarker()
    if pointMarker then
      removeUser3dMarker(pointMarker)
      pointMarker = nil
    end
end

function samp.onSendBulletSync(data)
    if elements.checkbox.showMyBullets.v and elements.checkbox.bulletTracer.v then
        if data.center.x ~= 0 then
            if data.center.y ~= 0 then
                if data.center.z ~= 0 then
                    bulletSyncMy.lastId = bulletSyncMy.lastId + 1
                    if bulletSyncMy.lastId < 1 or bulletSyncMy.lastId > bulletSyncMy.maxLines then
                        bulletSyncMy.lastId = 1
                    end
                    bulletSyncMy[bulletSyncMy.lastId].my.time = os.time() + elements.int.secondToCloseTwo.v
                    bulletSyncMy[bulletSyncMy.lastId].my.o.x, bulletSyncMy[bulletSyncMy.lastId].my.o.y, bulletSyncMy[bulletSyncMy.lastId].my.o.z = data.origin.x, data.origin.y, data.origin.z
                    bulletSyncMy[bulletSyncMy.lastId].my.t.x, bulletSyncMy[bulletSyncMy.lastId].my.t.y, bulletSyncMy[bulletSyncMy.lastId].my.t.z = data.target.x, data.target.y, data.target.z
                    if data.targetType == 0 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, staticObjectMy.v[1]*255, staticObjectMy.v[2]*255, staticObjectMy.v[3]*255)
                    elseif data.targetType == 1 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, pedPMy.v[1]*255, pedPMy.v[2]*255, pedPMy.v[3]*255)
                    elseif data.targetType == 2 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, carPMy.v[1]*255, carPMy.v[2]*255, carPMy.v[3]*255)
                    elseif data.targetType == 3 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, dinamicObjectMy.v[1]*255, dinamicObjectMy.v[2]*255, dinamicObjectMy.v[3]*255)
                    end
                end
            end 
        end
    end
end 

function samp.onBulletSync(playerid, data)
    if elements.checkbox.bulletTracer.v then
        if data.center.x ~= 0 then
            if data.center.y ~= 0 then
                if data.center.z ~= 0 then
                    bulletSync.lastId = bulletSync.lastId + 1
                    if bulletSync.lastId < 1 or bulletSync.lastId > bulletSync.maxLines then
                        bulletSync.lastId = 1
                    end
                    bulletSync[bulletSync.lastId].other.time = os.time() + elements.int.secondToClose.v
                    bulletSync[bulletSync.lastId].other.o.x, bulletSync[bulletSync.lastId].other.o.y, bulletSync[bulletSync.lastId].other.o.z = data.origin.x, data.origin.y, data.origin.z
                    bulletSync[bulletSync.lastId].other.t.x, bulletSync[bulletSync.lastId].other.t.y, bulletSync[bulletSync.lastId].other.t.z = data.target.x, data.target.y, data.target.z
                    if data.targetType == 0 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, staticObject.v[1]*255, staticObject.v[2]*255, staticObject.v[3]*255)
                    elseif data.targetType == 1 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, pedP.v[1]*255, pedP.v[2]*255, pedP.v[3]*255)
                    elseif data.targetType == 2 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, carP.v[1]*255, carP.v[2]*255, carP.v[3]*255)
                    elseif data.targetType == 3 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, dinamicObject.v[1]*255, dinamicObject.v[2]*255, dinamicObject.v[3]*255)
                    end
                end
            end
        end
    end
end
function getCarFreeSeat(car)
    if doesCharExist(getDriverOfCar(car)) then
      local maxPassengers = getMaximumNumberOfPassengers(car)
      for i = 0, maxPassengers do
        if isCarPassengerSeatFree(car, i) then
          return i + 1
        end
      end
      return nil -- no free seats
    else
      return 0 -- driver seat
    end
end
  
function jumpIntoCar(car)
    local seat = getCarFreeSeat(car)
    if not seat then return false end                         -- no free seats
    if seat == 0 then warpCharIntoCar(playerPed, car)         -- driver seat
    else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) -- passenger seat
    end
    restoreCameraJumpcut()
    return true
end

function fps_correction()
	return representIntAsFloat(readMemory(0xB7CB5C, 4, false))
end
  
function teleportPlayer(x, y, z)
    if isCharInAnyCar(playerPed) then
      setCharCoordinates(playerPed, x, y, z)
    end
    setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end

function isKeysDown(keycombo_or_keyId)
    keycombo_or_keyId = table.concat(keycombo_or_keyId, ", ")
    for w in string.gmatch(keycombo_or_keyId, "%d+") do
      if isKeyDown(w) then
        return true
      end
    end
end
  
function savesettings()
    if doesFileExist(fpath) then
      local f = io.open(fpath, 'w+')
      if f then
        f:write(encodeJson(defTable)):close()
      end
    end
end
  
function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
      local ptr = getCharPointer(char)
      setEntityCoordinates(ptr, x, y, z)
    end
end
  
function setEntityCoordinates(entityPtr, x, y, z)
    if entityPtr ~= 0 then
      local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
      if matrixPtr ~= 0 then
        local posPtr = matrixPtr + 0x30
        writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
        writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
        writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
      end
    end
end
  
function showCursor(toggle)
    if toggle then
      sampSetCursorMode(CMODE_LOCKCAM)
    else
      sampToggleCursor(false)
    end
    cursorEnabled = toggle
end

function salat()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function blackred()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

function violet()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.442, 0.115, 0.718, 0.540)
    colors[clr.FrameBgHovered]         = ImVec4(0.389, 0.190, 0.718, 0.400)
    colors[clr.FrameBgActive]          = ImVec4(0.441, 0.125, 0.840, 0.670)
    colors[clr.TitleBg]                = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgActive]          = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.CheckMark]              = ImVec4(0.643, 0.190, 0.862, 1.000)
    colors[clr.SliderGrab]             = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.SliderGrabActive]       = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.Button]                 = ImVec4(0.423, 0.142, 0.829, 1.000)
    colors[clr.ButtonHovered]          = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.ButtonActive]           = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.Header]                 = ImVec4(0.628, 0.098, 0.884, 0.310)
    colors[clr.HeaderHovered]          = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.HeaderActive]           = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripHovered]      = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripActive]       = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function blue()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function brown()
   imgui.SwitchContext()
   local style = imgui.GetStyle()
   local colors = style.Colors
   local clr = imgui.Col
   local ImVec4 = imgui.ImVec4

   style.WindowRounding = 2.0
   style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
   style.ChildWindowRounding = 2.0
   style.FrameRounding = 2.0
   style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
   style.ScrollbarSize = 9.0
   style.ScrollbarRounding = 0
   style.GrabMinSize = 8.0
   style.GrabRounding = 1.0

   colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
   colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
   colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.TitleBg]                = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
   colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Button]                 = ImVec4(0.98, 0.43, 0.26, 0.40)
   colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
   colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
   colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
   colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Separator]              = colors[clr.Border]
   colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
   colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
   colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
   colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
   colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
   colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
   colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
   colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
   colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
   colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
   colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
   colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
   colors[clr.ComboBg]                = colors[clr.PopupBg]
   colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
   colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
   colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
   colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
   colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
   colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
   colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
   colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
   colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
   colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
   colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function red()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end