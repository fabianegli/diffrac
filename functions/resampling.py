import numpy as np

#author: bliebeskind (primary) 
#from protein_complex_maps/protein_complex_maps/features/ExtractFeatures/


class FeatureResampling:

    def __init__(self): pass

    def _poisson_noise(self,df,rep=None):
        '''Return dataframe with poisson noise added'''
        ## bjl: Not sure why we just add, should we randomly subtract as well?? ##
        if rep: print "rep {}".format(rep)
        return df + np.random.poisson(df)
        
    def _bootstrap(self,df,rep=None):
        '''Sample columns with replacement, returning df of same shape'''
        if rep: print "rep {}".format(rep)
        return df.sample(df.shape[1], replace=True, axis=1)
