# GFCC-feature
A novel feature to do speech anti-spoofing/playback speech detection

Objective
--------------------------------------------
Literature shows that graph signal processing (GSP) shows a better correlation between speech samples and explore more hidden information from speech than the traditional digital signal processing methods. With this motivation, we propose a novel feature based on GSP, namely, graph frequency cepstral coefficient
(GFCC) to detect playback speech. 

Basic Algorithm
-------------------------------------------------
Schematic diagram of proposed GFCC feature extraction
![image](https://user-images.githubusercontent.com/104196800/164699194-bc6bec16-5341-4688-9d83-ffe9ee16e712.png)

Citation
-----------------------------------------------
Please cite the following if our paper or code is helpful to your research.

@inproceedings{GFCC_odyssey,
  title={A Novel Feature Based on Graph Signal Processing for Detection of Physical Access Attacks},
  author={Longting Xu and Mianxin Tian and Xing Guo and Zhiyong Shan and Jie Jia and Yiyuan Peng and Jichen Yang and Rohan Kumar Das},
  booktitle = {Proceedings of the Speaker Odyssey 2022},
  pages = {XX-XX},
  year={2022}
}

Notes
----------------------------------
Run Run_GFCC.m to obtain the features. We use voicebox toolbox to do enframe work, readers can download this toolbox from: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html


