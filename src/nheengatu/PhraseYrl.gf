--1 Phrase: Phrases and Utterances

concrete PhraseYrl of Phrase = CatYrl ** open Prelude,ResYrl in {

-- When a phrase is built from an utterance it can be prefixed
-- with a phrasal conjunction (such as "but", "therefore")
-- and suffixing with a vocative (typically a noun phrase).

  lin

    -- PhrUtt   : PConj -> Utt -> Voc -> Phr ; -- but come here, my friend
    PhrUtt = cc3 ;
-- Utterances are formed from sentences, questions, and imperatives.

    -- UttS      : S   -> Utt ;                -- John walks
    UttS = id SS ;
    -- UttQS     : QS  -> Utt ;                -- is it good
    UttQS = id SS ;
    -- UttImpSg  : Pol -> Imp -> Utt ;         -- (don't) love yourself
    UttImpSg = cc2 ;
    -- UttImpPl  : Pol -> Imp -> Utt ;         -- (don't) love yourselves
    UttImpPl = cc2 ;
    -- UttImpPol : Pol -> Imp -> Utt ;         -- (don't) sleep (polite)
    UttImpPol = cc2 ;

-- There are also 'one-word utterances'. A typical use of them is
-- as answers to questions.
-- *Note*. This list is incomplete. More categories could be covered.
-- Moreover, in many languages e.g. noun phrases in different cases
-- can be used.

    -- UttIP     : IP   -> Utt ;               -- who
    UttIP = id SS ;
    -- UttIAdv   : IAdv -> Utt ;               -- why
    UttIAdv = id SS ;
    -- UttNP     : NP   -> Utt ;               -- this man
    UttNP np = {s = np.s ! Full} ;
    -- UttAdv    : Adv  -> Utt ;               -- here
    UttAdv = id SS ;
    -- UttVP     : VP   -> Utt ;               -- to sleep
{-    UttVP = id SS ;
    -- UttCN     : CN   -> Utt ;               -- house
    UttCN = id SS ;
    -- UttCard   : Card -> Utt ;               -- five
    UttCard = id SS ;
    -- UttAP     : AP   -> Utt ;               -- fine
    UttAP = id SS ;
    -- UttInterj : Interj -> Utt ;             -- alas
    UttInterj = id SS ;
-}
-- The phrasal conjunction is optional. A sentence conjunction
-- can also be used to prefix an utterance.

    -- NoPConj   : PConj ;                     -- [plain phrase without conjunction in front]
    NoPConj = ss "" ;
    -- PConjConj : Conj -> PConj ;             -- and
    PConjConj = id SS ;

-- The vocative is optional. Any noun phrase can be made into vocative,
-- which may be overgenerating (e.g. "I").

    -- NoVoc   : Voc ;                         -- [plain phrase without vocative]
    NoVoc = ss "" ;
    -- VocNP   : NP -> Voc ;                   -- my friend
    --VocNP = id SS ;
}
