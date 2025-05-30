concrete PhraseBen of Phrase = CatBen ** open Prelude, ResBen, NounBen in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttAdv adv = adv ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Nom} ; -- chooses whichever article the NP has
    UttCN cn = UttNP (MassNP cn) ; -- choose NoArticle as default
{-
    UttQS qs = qs ;
    UttIP ip =
    UttImpSg pol imp = { s = pol.s ++ imp.s ! Sg ! pol.p } ;
    UttImpPl pol imp =
    UttImpPol pol imp = {s = pol.s ++ imp.s ! Sg ! pol.p} ;
    UttVP vp = {s = linVP vp} ;
    UttAP ap = { s = ap.s } ;
    UttCard n = {s = } ;
    UttInterj i = i ; -}
    NoPConj = {s = []} ;
--    PConjConj conj = {s = conj.s1 ++ conj.s2 ! …} ;

    NoVoc = {s = []} ;
--    VocNP np = { s = "," ++ np.s ! … } ;

}
