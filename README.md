# How to run the SMOT code?

 (1) Download the code. It will create a smot directory.
 
 (2) Download the data from [here](http://coe.neu.edu/~cdicle/data/smot_data.zip) and extract it in smot directory. so that you have directory structure like,
 	
 	smot>
 		smot_core
 		smot_data
 		smot_test
 		smot_util
 		 	
 (3) Check if the dataset path is set correctly in file smot/smot_test/test_smot_batch.m
 
 (4) Run test_smot_batch.m

 (5) Please cite to the paper
 	
	@inproceedings{Dicle2013iccv,
 	 author = {Dicle, Caglayan and Camps, Octavia and Sznaier, Mario},
	 title = {The Way They Move: Tracking Targets with Similar Appearance},
	 booktitle = {ICCV},
 	 year = {2013},
 	 pdf = {http://coe.neu.edu/~cdicle/papers/dicle_iccv13.pdf}
 	}
 	
### Prerequisites
The code works on MATLAB R2012a and that is pretty much the only requirement. I did not test the code on other versions, however I expect it to work on newer versions, too, since I did not use obsolete functionality.

Optionaly, if you want to test Interior Points (IP) method and have "patience" to run experiments with IP method, you need to install CVX toolbox from [CVX website](http://www.cvxr.com)

