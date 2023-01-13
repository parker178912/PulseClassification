Pulse classification algorithm
===============================

This set of Matlab scripts and functions implements the Shahi and Baker (2014) pulse classification algorithm.
將Shahi and Baker(2014)的單脈衝分類算法實現，用以判斷單一地震是否具有近斷層效應。

Contents
========

classify_record_main : This scripts is the one that calls other functions to classify a ground motion as a pulse/non-pulse and then compute the Ipulse and Tp values.

classification_algo.m : This defines the function that selects the prospective pulses for classification

analyze_record.m : This defines the main classification function that classified each prospective pulse

find_Ipulse.m : Defines the function to find if the ground motion is classified as pulse-like or non-pulse-like

find_Tp.m : Defines the function to compute the pulse period. Outputs -999 if the ground motion is non-pulse.

make_plot.m : Defines the function to make a plot showing the velocity time-history of the original ground motion (in the orientation from which pulse was extracted), the extracted pulse and the residual ground-motion.

cont_wavelet_trans.m : This funtion is used to perform the continuous wavelet transform

parseAT2.m : This function parses the NGA West2 AT2 files.


Other Information
===========

Example classification results are available at https://web.stanford.edu/~bakerjw/pulse_classification_v2/Pulse-like-records.html

The NGA-West2 data used for this analysis is available at https://ngawest2.berkeley.edu/


References
===========

Shahi S.K., and  Baker J.W. (2014). "An efficient algorithm to identify strong velocity pulses in multi-component ground-motions". Bulletin of the Seismological Society of America, 104(5), 2456–2466.
