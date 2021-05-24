--1 Text: Texts

-- Texts are built from an empty text by adding $Phr$ases,
-- using as constructors the punctuation marks ".", "?", and "!".
-- Any punctuation mark can be attached to any kind of phrase.
-- For most languages [``TextX`` ../common/TextX.gf] can be used:
concrete TextYrl of Text = TextX ;
-- If that is not possible implement the following module:
{-
concrete TextYrl of Text = CommonX ** open Prelude in {

  lin
    
    -- TEmpty     : Text ;                 -- [empty text, no sentences]
    TEmpty = ss "" ;
    -- TFullStop  : Phr -> Text -> Text ;  -- John walks. ...
    TFullStop = cc2 ;
    -- TQuestMark : Phr -> Text -> Text ;  -- Are they here? ...
    TQuestMark = cc2 ;
    -- TExclMark  : Phr -> Text -> Text ;  -- Let's go! ...
    TExclMark = cc2 ;
}
-}
