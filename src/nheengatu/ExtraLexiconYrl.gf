concrete ExtraLexiconYrl of ExtraLexiconYrlAbs = CatYrl ** open LexiconYrl, ParadigmsYrl in {

lin

  Alive_A = mkA "rikué" c2_ncs ;
  Beautiful_A = beautiful_A ; -- from LexiconYrl
  Cheap_A = mkA "sepiasuíma" ;
  Delicious_A = mkA "sé" ;
  Dirty_A = dirty_A ;
  Expensive_A = mkA "sepiasu" ;
  Good_A = good_A ;
  Happy_A = mkA "ruri" c2_ncs ;
  Hard_A = mkA "santá" ;
  Heavy_A = heavy_A ;
  Hot_A = hot_A ;
  New_A = new_A ;
  Red_A = red_A ;
  Round_A = round_A ;
  Strong_A = mkA "kirimbaua" ;

  Ant_N = mkN "tukandira";
  Beak_N = mkN "tĩ";
  Bird_N = mkN "uirá";
  Blood_N = RelPrefNoun "tuí" "tuí";
  Boy_N = mkN "kurumĩ";
  Branch_N = mkN "sakanga" ncs ;
  Brother_Of_Woman_N = mkN "kiuíra";
  Canoe_N = mkN "igara";
  Child_N = mkN "taína";
  City_N = mkN "taua";
  Community_N = mkN "tendaua" ncs ;
  Door_N = mkN "ukena" ncs ;
  Dove_N = mkN "pikasu";
  Egg_N = mkN "supiá" ncs ;
  Fish_N = mkN "pirá";
  Food_N = RelPrefNoun "timbiú" "ximbiú";
  Grandfather_N = mkN "samunha" ncs ;
  Hog_Plum_N = mkN "tapereiuá";
  Hook_N = mkN "pindá";
  House_N = mkN "uka" ncs ;
  Husband_N = mkN "mena";
  Knife_N = mkN "kisé";
  Language_N = mkN "nheenga";
  Life_N = mkN "sikué" ncs ;
  Man_N = mkN "apigaua";
  Milk_N = mkN "kambi";
  Nest_N = mkN "taiti" ncs ;
  Path_N = mkN "pé" ncs ;

  Picture_N = mkN "sangaua" ncs ;
  Pit_N = mkN "tainha" ncs ;
  Pumpkin_N = mkN "ierimũ";
  River_N = mkN ("paranã"|"paraná");
  Seed_N = mkN "tainha" ncs ;
  Son_Of_Woman_N = mkN ("mimbira"|"mbira");
  Son_Of_Man_N = RelPrefNoun "taíra" "taíra";
  Daughter_Of_Woman_N = mkN ("mimbira"|"mbira");
  Daughter_Of_Man_N = RelPrefNoun "taiera" "taiera";
  Stone_N = mkN "itá";
  Street_N = mkN "pé" ncs ;
  Tapioca_Cake_N = mkN "meiú";
  Toucan_N = mkN "tukana";
  Tree_N = mkN "mirá";
  Water_N = mkN "ií";
  Wife_N = RelPrefNoun "simiriku" ("simiriku"|"ximiriku");
  Woman_N = mkN "kunhã";
  Word_N = mkN "nheenga";

  Antonio_PN = mkPN "Antônio";
  Joanna_PN = mkPN "Joana";
  Maria_PN = mkPN "Maria";
  Pedro_PN = mkPN "Pedro";

oper
  -- From the old grammar
	RelPrefNoun : Str -> Str -> N = \taiti,saiti ->
    let stem: Str = ExtractStem	taiti ;
        raiti: Str = "r" + stem
    in mkN taiti raiti saiti ncs ;

  ExtractStem : Str -> Str = \lemma -> case lemma of {
        "t"|"s"|"r" + stem => stem ;
        _ => lemma
        };
}