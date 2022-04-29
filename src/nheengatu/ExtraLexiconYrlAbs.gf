abstract ExtraLexiconYrlAbs =
  Cat - [Ant] -- Need to exclude Ant_PN, because that's a name of a RGL cat, and here it is a name of a fun
  ** {

fun
  -- Lexicon from the original small grammar
  -- Some words are already in LexiconYrl.gf, in the standard RGL naming format, e.g. water_N, beautiful_A
  -- Here I've kept the naming as it was previously, but changed the types into RGL types (A, N, PN).
  -- Feel free to change the naming scheme or keep as is, it doesn't matter—this is all outside the common core and the API anyway.

  Alive_A, Beautiful_A, Cheap_A, Delicious_A, Dirty_A, Expensive_A, Good_A, Happy_A, Hard_A, Heavy_A, Hot_A, New_A, Red_A, Round_A, Strong_A : A ;

  Ant_N, Beak_N, Bird_N, Blood_N, Boy_N, Branch_N, Brother_Of_Woman_N, Canoe_N, Child_N, City_N, Community_N, Door_N, Dove_N,
  Egg_N, Fish_N, Food_N, Grandfather_N, Hog_Plum_N, Hook_N, House_N, Husband_N,  Knife_N, Language_N, Life_N, Man_N, Milk_N, Nest_N,
  Path_N, Picture_N, Pit_N, Pumpkin_N, River_N, Seed_N, Daughter_Of_Man_N, Son_Of_Man_N, Son_Of_Woman_N, Daughter_Of_Woman_N,
  Stone_N, Street_N, Tapioca_Cake_N, Toucan_N, Tree_N, Water_N, Wife_N, Woman_N, Word_N : N ;

  Antonio_PN, Joanna_PN, Maria_PN, Pedro_PN : PN ;

}