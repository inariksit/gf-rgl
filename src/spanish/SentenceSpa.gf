concrete SentenceSpa of Sentence = CatSpa ** SentenceRomance - [PredVP] with
  (ResRomance = ResSpa) ** {

  lin
    PredVP np vp =
      let subj : Str = case vp.s.vtyp of {
            VDat => (np.s ! dative).comp ;
            _    => (np.s ! Nom).comp }
      in  mkClausePol np.isNeg subj np.hasClit np.isPol np.a vp ;
};
