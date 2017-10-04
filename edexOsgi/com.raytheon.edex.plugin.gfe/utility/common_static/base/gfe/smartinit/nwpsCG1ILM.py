##
#
# nwpsCG1ILM - Joe Maloney  2016-07-18
#
#   Smart Init for nwpsCG1ILM model.
#
##

from Init import *
from nwpsCG1 import *

##--------------------------------------------------------------------------
## Module that calculates surface weather elements from nwpsCG1 model
## output.
##--------------------------------------------------------------------------
class nwpsCG1ILMForecaster(nwpsCG1Forecaster):
    def __init__(self):
        nwpsCG1Forecaster.__init__(self, "nwpsCG1ILM", "nwpsCG1ILM")

def main():
    forecaster = nwpsCG1ILMForecaster()
    forecaster.run()
    forecaster.notifyGFE('ILM')

if __name__ == "__main__":
    main()