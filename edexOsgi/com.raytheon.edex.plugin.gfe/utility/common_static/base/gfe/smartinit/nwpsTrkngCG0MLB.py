##
#
# nwpsTrkngCG0MLB - Joe Maloney  2016-07-08
#
#   Smart Init for nwpsTrkngCG0MLB model.
#
##

from Init import *
from nwpsTrkngCG0 import *

##--------------------------------------------------------------------------
## Module that calculates surface weather elements from nwpsTrkngCG0 model
## output.
##--------------------------------------------------------------------------
class nwpsTrkngCG0MLBForecaster(nwpsTrkngCG0Forecaster):
    def __init__(self):
        nwpsTrkngCG0Forecaster.__init__(self, "nwpsTrkngCG0MLB", "nwpsTrkngCG0MLB")

def main():
    forecaster = nwpsTrkngCG0MLBForecaster()
    forecaster.run()
    forecaster.notifyGFE('MLB')


if __name__ == "__main__":
    main()