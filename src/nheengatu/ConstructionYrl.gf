concrete ConstructionYrl of Construction = CatYrl ** open Prelude in {

-- started by AR 6/12/2013. (c) Aarne Ranta under LGPL and BSD

-- This module is, in the spirit of construction grammar, "between syntax and lexicon".
-- So is the module Idiom, but the difference is that the constructions in Idiom
-- apply to categories in a general way (e.g. existentials) whereas here they
-- are typically about particular predicates such as "NP is hungry" which are found
-- to work differently in different languages. The purpose of this module is hence
-- not so much to widen the scope of string recognition, but to provide trees that
-- are abstract enough to yield correct translations.


-- The first examples are from the MOLTO Phrasebook
{-

  lin

    --     hungry_VP     : VP ;                 -- x is hungry / x a faim (Fre)
    hungry_VP = ss "" ;
    --     thirsty_VP    : VP ;                 -- x is thirsty / x a soif (Fre)
    thirsty_VP = ss "" ;
    --     tired_VP      : VP ;                 -- x is tired / x estoy cansado (Spa)
    tired_VP = ss "" ;
    --     scared_VP     : VP ;                 -- x is scared
    scared_VP = ss "" ;
    --     ill_VP        : VP ;                 -- x is ill
    ill_VP = ss "" ;
    --     ready_VP      : VP ;                 -- x is ready
    ready_VP = ss "" ;
    --     has_age_VP    : Card -> VP ;         -- x is y years old / x a y ans (Fre)
    has_age_VP = id SS ;
    --     have_name_Cl  : NP -> NP -> Cl ;     -- x's name is y / x s'appelle y (Fre)
    have_name_Cl = cc2 ;
    --     married_Cl    : NP -> NP -> Cl ;     -- x is married to y / x on naimisissa y:n kanssa (Fin)
    married_Cl = cc2 ;
    --     what_name_QCl : NP -> QCl ;          -- what is x's name / wie heisst x (Ger)
    what_name_QCl = id SS ;
    --     how_old_QCl   : NP -> QCl ;          -- how old is x / quanti anni ha x (Ita)
    how_old_QCl = id SS ;
    --     how_far_QCl   : NP -> QCl ;          -- how far is x / quanto dista x (Ita)
    how_far_QCl = id SS ;

-- -- some more things

    --     weather_adjCl : AP -> Cl ;           -- it is warm / il fait chaud (Fre)
    weather_adjCl = id SS ;
    --     is_right_VP   : VP ;                 -- he is right / il a raison (Fre)
    is_right_VP = ss "" ;
--     is_wrong_VP   : VP ;                 -- he is wrong / han har fel (Swe)
    is_wrong_VP = ss "" ;

    --     n_units_AP    : Card -> CN -> A  -> AP ;  -- x inches long
    n_units_AP = cc3 ;
    --     n_units_of_NP : Card -> CN -> NP -> NP ;  -- x ounces of this flour
    n_units_of_NP = cc3 ;
    --     n_unit_CN     : Card -> CN -> CN -> CN ;  -- x gallon bottle
    n_unit_CN = cc3 ;

-- -- containers
    --     bottle_of_CN : NP -> CN ;       --- bottle of beer / flaska öl (Swe)
    bottle_of_CN = id SS ;
    --     cup_of_CN    : NP -> CN ;       --- cup of tea / kupillinen teetä (Fin)
    cup_of_CN = id SS ;
--     glass_of_CN  : NP -> CN ;       --- glass of wine / lasillinen viiniä (Fin)
    glass_of_CN = id SS ;


-- time expressions

  lincat

    Timeunit = SS;
    Hour = SS;
    Weekday = SS;
    Month = SS ;
    Monthday = SS;
    Year = SS;

  lin

    -- timeunitAdv   : Card -> Timeunit -> Adv ; -- (for) three hours
    timeunitAdv = cc2 ;
    -- timeunitRange : Card -> Card -> Timeunit -> Adv ; -- (cats live) ten to twenty years
    timeunitRange = cc3 ;

    -- oneHour : Hour ;
    oneHour = ss "" ;
    -- twoHour : Hour ;
    twoHour = ss "" ;
    -- threeHour : Hour ;
    threeHour = ss "" ;
      -- fourHour : Hour ;
    fourHour = ss "" ;
    -- fiveHour : Hour ;
    fiveHour = ss "" ;
    -- sixHour : Hour ;
    sixHour = ss "" ;
    -- sevenHour : Hour ;
    sevenHour = ss "" ;
    -- eightHour : Hour ;
    eightHour = ss "" ;
    -- nineHour : Hour ;
    nineHour = ss "" ;
    -- tenHour : Hour ;
    tenHour = ss "" ;
    -- elevenHour : Hour ;
    elevenHour = ss "" ;
    -- twelveHour : Hour ;
    twelveHour = ss "" ;
    -- thirteenHour : Hour ;
    thirteenHour = ss "" ;
    -- fourteenHour : Hour ;
    fourteenHour = ss "" ;
    -- fifteenHour : Hour ;
    fifteenHour = ss "" ;
    -- sixteenHour : Hour ;
    sixteenHour = ss "" ;
    -- seventeenHour : Hour ;
    seventeenHour = ss "" ;
    -- eighteenHour : Hour ;
    eighteenHour = ss "" ;
    -- nineteenHour : Hour ;
    nineteenHour = ss "" ;
    -- twentyHour : Hour ;
    twentyHour = ss "" ;
    -- twentyOneHour : Hour ;
    twentyOneHour = ss "" ;
    -- twentyTwoHour : Hour ;
    twentyTwoHour = ss "" ;
    -- twentyThreeHour : Hour ;
    twentyThreeHour = ss "" ;
    -- twentyFourHour : Hour ;
    twentyFourHour = ss "" ;

    -- timeHour : Hour -> Adv ; -- at three a.m./p.m.
    timeHour = id SS ;
    -- timeHourMinute : Hour -> Card -> Adv ; -- at six forty a.m./p.m.
    timeHourMinute = cc2 ;

    -- weekdayPunctualAdv : Weekday -> Adv ;  -- on Monday
    weekdayPunctualAdv = id SS ;
    -- weekdayHabitualAdv : Weekday -> Adv ;  -- on Mondays
    weekdayHabitualAdv = id SS ;
    -- weekdayLastAdv : Weekday -> Adv ;      -- last Monday
    weekdayLastAdv = id SS ;
    -- weekdayNextAdv : Weekday -> Adv ;      -- next Monday
    weekdayNextAdv = id SS ;

    -- monthAdv        : Month -> Adv ;                        -- in June
    monthAdv = id SS ;
    -- yearAdv         : Year -> Adv ;                         -- in 1976
    yearAdv = id SS ;
    -- dayMonthAdv     : Monthday -> Month -> Adv ;            -- on 17 May
    dayMonthAdv = cc2 ;
    -- monthYearAdv    : Month -> Year -> Adv ;                -- in May 2013
    monthYearAdv = cc2 ;
    -- dayMonthYearAdv : Monthday -> Month -> Year -> Adv ;    -- on 17 May 2013
    dayMonthYearAdv = cc3 ;

    -- intYear     : Int -> Year ;  -- (year) 1963
    intYear = id SS ;
    -- intMonthday : Int -> Monthday ; -- 31th (March)
    intMonthday = id SS ;


-- languages

  lincat

    Language = SS;

  lin

    -- InLanguage : Language -> Adv ; -- in English, auf englisch, englanniksi, etc
    InLanguage = id SS ;

-- coercions to RGL categories

    -- weekdayN   : Weekday -> N ; -- (this) Monday
    weekdayN = id SS ;
  -- monthN     : Month -> N ;   -- (this) November
    monthN = id SS ;
    -- weekdayPN  : Weekday -> PN ; -- Monday (is free)
    weekdayPN = id SS ;
  -- monthPN    : Month -> PN ;   -- March (is cold)
    monthPN = id SS ;

    -- languageNP : Language -> NP ;  -- French (is easy)
    languageNP = id SS ;
    -- languageCN : Language -> CN ;  -- (my) French
    languageCN = id SS ;

----------------------------------------------
---- lexicon of special names

    -- second_Timeunit : Timeunit ;
    second_Timeunit = ss "" ;
    -- minute_Timeunit : Timeunit ;
    minute_Timeunit = ss "" ;
    -- hour_Timeunit : Timeunit ;
    hour_Timeunit = ss "";
    -- day_Timeunit : Timeunit ;
    day_Timeunit = ss "" ;
    -- week_Timeunit : Timeunit ;
    week_Timeunit = ss "" ;
    -- month_Timeunit : Timeunit ;
    month_Timeunit = ss "" ;
    -- year_Timeunit : Timeunit ;
    year_Timeunit = ss "" ;

    -- monday_Weekday : Weekday ;
    monday_Weekday = ss "" ;
    -- tuesday_Weekday : Weekday ;
    tuesday_Weekday = ss "" ;
    -- wednesday_Weekday : Weekday ;
    wednesday_Weekday = ss "" ;
    -- thursday_Weekday : Weekday ;
    thursday_Weekday = ss "" ;
    -- friday_Weekday : Weekday ;
    friday_Weekday = ss "" ;
    -- saturday_Weekday : Weekday ;
    saturday_Weekday = ss "" ;
    -- sunday_Weekday : Weekday ;
    sunday_Weekday = ss "" ;

    -- january_Month : Month ;
    january_Month = ss "" ;
    -- february_Month : Month ;
    february_Month = ss "" ;
    -- march_Month : Month ;
    march_Month = ss "" ;
    -- april_Month : Month ;
    april_Month = ss "" ;
    -- may_Month : Month ;
    may_Month = ss "" ;
    -- june_Month : Month ;
    june_Month = ss "" ;
    -- july_Month : Month ;
    july_Month = ss "" ;
    -- august_Month : Month ;
    august_Month = ss "" ;
    -- september_Month : Month ;
    september_Month = ss "" ;
    -- october_Month : Month ;
    october_Month = ss "" ;
    -- november_Month : Month ;
    november_Month = ss "" ;
    -- december_Month : Month ;
    december_Month = ss "" ;


    -- afrikaans_Language : Language ;
    afrikaans_Language = ss "" ;
    -- amharic_Language : Language ;
    amharic_Language = ss "" ;
    -- arabic_Language : Language ;
    arabic_Language = ss "" ;
    -- bulgarian_Language : Language ;
    bulgarian_Language = ss "" ;
    -- catalan_Language : Language ;
    catalan_Language = ss "" ;
    -- chinese_Language : Language ;
    chinese_Language = ss "" ;
    -- danish_Language : Language ;
    danish_Language = ss "" ;
    -- dutch_Language : Language ;
    dutch_Language = ss "" ;
    -- english_Language : Language ;
    english_Language = ss "" ;
    -- estonian_Language : Language ;
    estonian_Language = ss "" ;
    -- finnish_Language : Language ;
    finnish_Language = ss "" ;
    -- french_Language : Language ;
    french_Language = ss "" ;
    -- german_Language : Language ;
    german_Language = ss "" ;
    -- greek_Language : Language ;
    greek_Language = ss "" ;
    -- hebrew_Language : Language ;
    hebrew_Language = ss "" ;
    -- hindi_Language : Language ;
    hindi_Language = ss "" ;
    -- japanese_Language : Language ;
    japanese_Language = ss "" ;
    -- italian_Language : Language ;
    italian_Language = ss "" ;
    -- latin_Language : Language ;
    latin_Language = ss "" ;
    -- latvian_Language : Language ;
    latvian_Language = ss "" ;
    -- maltese_Language : Language ;
    maltese_Language = ss "" ;
    -- nepali_Language : Language ;
    nepali_Language = ss "" ;
    -- norwegian_Language : Language ;
    norwegian_Language = ss "" ;
    -- persian_Language : Language ;
    persian_Language = ss "" ;
    -- polish_Language : Language ;
    polish_Language = ss "" ;
    -- punjabi_Language : Language ;
    punjabi_Language = ss "" ;
    -- romanian_Language : Language ;
    romanian_Language = ss "" ;
    -- russian_Language : Language ;
    russian_Language = ss "" ;
    -- sindhi_Language : Language ;
    sindhi_Language = ss "" ;
    -- spanish_Language : Language ;
    spanish_Language = ss "" ;
    -- swahili_Language : Language ;
    swahili_Language = ss "" ;
    -- swedish_Language : Language ;
    swedish_Language = ss "" ;
    -- thai_Language : Language ;
    thai_Language = ss "" ;
    -- turkish_Language : Language ;
    turkish_Language = ss "" ;
    -- urdu_Language : Language ;
    urdu_Language = ss "" ;
 -}
}
