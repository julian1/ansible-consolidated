
# change name of this... find cached stuff, that can be removed for backups
# eg. like this 

A=$( find ./haskell/ -type d -iname '\.cabal-sandbox' )
du -hs $A

A=$( find ./firefox_/ -iname cache2 )
du -hs $A



